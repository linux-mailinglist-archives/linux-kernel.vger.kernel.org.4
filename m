Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B325B3DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIIRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIIRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:19:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2425C53
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:19:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x25-20020aa79199000000b005358eeebf49so1382956pfa.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=y+S5AbIHCrepBfZ2rw1p2j+yX8LnWjY6X4hW/K5B26E=;
        b=FBPCZrVg3A5xkX2OTUS/Lt5/hDbXEhiQzndmF1GMlIGtCP4Bd8a13tQ+23xzbZ0ced
         v4ss1uefZSpho+Io18qZ+Q7r9x2x9Ef9TtZDBqgdSJT71TiOHKxQ/E5cuNX5/e0ytcrZ
         6hVEESy8F2bpVXFdLh9X3uCCGCdxvW6hZeK58BRWrYrlp/4dEwNxq/KN+sUvaAEY/pXI
         CaDnNMgVJzv6jcv674hbQp69SmAcCHSU4Wg615K+yZaI3vOsYdNVNtZGFstnWjB2YnFF
         wrg7EdS6+aH++GFOG0YRUFiWMFi48S1xF1bfJ9aIvTpirymw0rb4fI/mwkCtE1SNIS8U
         JMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=y+S5AbIHCrepBfZ2rw1p2j+yX8LnWjY6X4hW/K5B26E=;
        b=Cxh5N6YUP3X/lXGa8tgpRYsJgXV5akHGDb54PbbSiBytif2g48xhzj3eaLQN0Ti2pZ
         NyXksDLjL5H4wzKB6hZoNIMEDuQv9SgrK4jyNXw8ZAokfZhuMOLnVN5n2wgTmK3q05zL
         s/pDKK0Q48LMblI2xMRaKsDuJ/+HTrFseEwFtDcfCY5rs82xmwL5ujwNAKu3UHuvbSvJ
         sj1rDFmxuaDeRvJ0u552aj0eLgFH3Mrk4mP/kd+Zs8eUHVOpf1pD3btSMHDw+QqXF0u0
         yvHDo5ft/UeqdyFXXhtS1ZxNWwYzvglIdIzpaeCfmKwWtXtoQpTUjbqDyo09LL4uWBS5
         +I8g==
X-Gm-Message-State: ACgBeo0nxNj/OfJqC0uu9G58jNqTZB1M/uPwVAek2s9liC6BNXuEnyXc
        MWopM6JbF4EOn2WwklE9gDOFo6g=
X-Google-Smtp-Source: AA6agR6QPX7Uuhl63LLM4hwCHcUgMnHrqQo6D5F1r53w/VYF+DHyPdIuNsRFMuyb9aQzk4M/e7lw57I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr202016pjz.1.1662743980876; Fri, 09 Sep
 2022 10:19:40 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:19:39 -0700
In-Reply-To: <20220909092107.3035-1-oss@lmb.io>
Mime-Version: 1.0
References: <20220909092107.3035-1-oss@lmb.io>
Message-ID: <Yxt1q1DZtTklML3l@google.com>
Subject: Re: [PATCH bpf] bpf: btf: fix truncated last_member_type_id in btf_struct_resolve
From:   sdf@google.com
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Lorenz Bauer wrote:
> When trying to finish resolving a struct member, btf_struct_resolve
> saves the member type id in a u16 temporary variable. This truncates
> the 32 bit type id value if it exceeds UINT16_MAX.

> As a result, structs that have members with type ids > UINT16_MAX and
> which need resolution will fail with a message like this:

>      [67414] STRUCT ff_device size=120 vlen=12
>          effect_owners type_id=67434 bits_offset=960 Member exceeds  
> struct_size

> Fix this by changing the type of last_member_type_id to u32.

Makes sense to me; I'm surprised the compiler isn't raising a warning on  
line:
last_member_type_id = last_member->type;

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
> Signed-off-by: Lorenz Bauer <oss@lmb.io>
> ---
>   kernel/bpf/btf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7e64447659f3..36fd4b509294 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3128,7 +3128,7 @@ static int btf_struct_resolve(struct  
> btf_verifier_env *env,
>   	if (v->next_member) {
>   		const struct btf_type *last_member_type;
>   		const struct btf_member *last_member;
> -		u16 last_member_type_id;
> +		u32 last_member_type_id;

>   		last_member = btf_type_member(v->t) + v->next_member - 1;
>   		last_member_type_id = last_member->type;
> --
> 2.34.1

