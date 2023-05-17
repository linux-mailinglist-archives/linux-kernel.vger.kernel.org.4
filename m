Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB9705FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjEQG1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjEQG1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:27:00 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E730C1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:26:59 -0700 (PDT)
Message-ID: <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684304817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sVnlYP3YZccsqBEdnCkLE37zXE9pD2X7xSWYEtmSXKE=;
        b=mThxKSNwNdBOPjJ0ImrDC0PaIwgOOtmH4LzSNUNBtaMeIdQC2xC89I9PyZzxEzJVeD78fA
        xePPQRrVzwdmn5RtRgjC+IXOoWfrusOvdunA6ctle0WcIGmxcIW8Ug8c4feGqaXrV7qdeW
        H7WBN9ekGxgPxK2ZwIzAe11G6ZUcrSw=
Date:   Tue, 16 May 2023 23:26:50 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230515121521.30569-1-lmb@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230515121521.30569-1-lmb@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 5:15 AM, Lorenz Bauer wrote:
> In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR")
> I fixed a bug that occurred during resolving of a DATASEC by strategically resetting
> resolve_mode. This fixes the immediate bug but leaves us open to future bugs where
> nested types have to be resolved.

hmm... future bugs like when adding new BTF_KIND in the future?

> 
> The problem is that env_stack_pop_resolved never restores the previously active
> resolve mode when discarding a stack item. Fix this by adding the previous resolve
> mode to each resolve_vertex and updating env->resolve_mode during pop.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>   kernel/bpf/btf.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6b682b8e4b50..4d6c1d0e8b7c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -264,10 +264,19 @@ enum verifier_phase {
>   	CHECK_TYPE,
>   };
>   
> +enum resolve_mode {
> +	RESOLVE_TBD,	/* To Be Determined */
> +	RESOLVE_PTR,	/* Resolving for Pointer */
> +	RESOLVE_STRUCT_OR_ARRAY,	/* Resolving for struct/union
> +					 * or array
> +					 */
> +};
> +
>   struct resolve_vertex {
>   	const struct btf_type *t;
>   	u32 type_id;
>   	u16 next_member;
> +	enum resolve_mode parent_mode;
>   };
>   
>   enum visit_state {
> @@ -276,13 +285,6 @@ enum visit_state {
>   	RESOLVED,
>   };
>   
> -enum resolve_mode {
> -	RESOLVE_TBD,	/* To Be Determined */
> -	RESOLVE_PTR,	/* Resolving for Pointer */
> -	RESOLVE_STRUCT_OR_ARRAY,	/* Resolving for struct/union
> -					 * or array
> -					 */
> -};
>   
>   #define MAX_RESOLVE_DEPTH 32
>   
> @@ -1811,6 +1813,7 @@ static int env_stack_push(struct btf_verifier_env *env,
>   	v->t = t;
>   	v->type_id = type_id;
>   	v->next_member = 0;
> +	v->parent_mode = env->resolve_mode;
>   
>   	if (env->resolve_mode == RESOLVE_TBD) {
>   		if (btf_type_is_ptr(t))
> @@ -1832,13 +1835,15 @@ static void env_stack_pop_resolved(struct btf_verifier_env *env,
>   				   u32 resolved_type_id,
>   				   u32 resolved_size)
>   {
> -	u32 type_id = env->stack[--(env->top_stack)].type_id;
> +	struct resolve_vertex *v = &env->stack[--(env->top_stack)];
> +	u32 type_id = v->type_id;
>   	struct btf *btf = env->btf;
>   
>   	type_id -= btf->start_id; /* adjust to local type id */
>   	btf->resolved_sizes[type_id] = resolved_size;
>   	btf->resolved_ids[type_id] = resolved_type_id;
>   	env->visit_states[type_id] = RESOLVED;
> +	env->resolve_mode = v->parent_mode;

Other than datasec, could v->parent_mode and env->resolve_mode be different 
while resolving? I would prefer to keep the 'env->resolve_mode = RESOLVE_TBD' in 
btf_datasec_resolve() to make this special case clear.

>   }
>   
>   static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
> @@ -4541,7 +4546,6 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
>   	struct btf *btf = env->btf;
>   	u16 i;
>   
> -	env->resolve_mode = RESOLVE_TBD;
>   	for_each_vsi_from(i, v->next_member, v->t, vsi) {
>   		u32 var_type_id = vsi->type, type_id, type_size = 0;
>   		const struct btf_type *var_type = btf_type_by_id(env->btf,

