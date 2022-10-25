Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122160C37C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJYFum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJYFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:50:38 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3254363D;
        Mon, 24 Oct 2022 22:50:35 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BE13B422E9;
        Tue, 25 Oct 2022 05:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666677033;
        bh=yox8mjyeuZlCoe/FoMjeIoTMqW4Nu1lv1zq+lpqENys=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bOP5ODNofoLpiN90yOa5ZIYdre4m98omJkmb5CqBMof7eru93HNKqcqDx/3bHmaxN
         LOZjuoDo1LufW1N16Ie0yYhhOuBwh0jAHenT3AwWMMGW0JJxXmNg8DWqDhL5jCGrZn
         X5V20W99N7art5dqJj/nTxu8vitQNTOHwHxvWtPBfqOjEGEWkSMxMKxIoZJbVH64rY
         vQqRy8rK/fbDddbsGTYTqM0cm9a+RKowAPoHy1VKt0Bu//v2B5/qzLsZFPeCloAaf1
         JSbeJHuesjfreZ5asnqe2jj+E3ZlnGtNjkC1Od+hePHLwWFMH6dlTel3ZSEc6GOsRH
         MnJUbo1Y0kxEg==
Message-ID: <4ad67bac-bae1-dd3f-bdcb-a2f5bfdfa2b6@canonical.com>
Date:   Mon, 24 Oct 2022 22:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] apparmor: Fix memleak issue in unpack_profile()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221021093602.102839-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221021093602.102839-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 02:36, Xiu Jianfeng wrote:
> Before aa_alloc_profile(), it has allocated string for @*ns_name if @tmpns
> is not NULL, so directly return -ENOMEM if aa_alloc_profile() failed will
> cause a memleak issue, and even if aa_alloc_profile() succeed, in the
> @fail_profile tag of aa_unpack(), it need to free @ns_name as well, this
> patch fixes them.
> 
> Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
> Fixes: 04dc715e24d0 ("apparmor: audit policy ns specified in policy load")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

yep thanks I have pulled this into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/policy_unpack.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 2e028d540c6b..1bf8cfb8700a 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -858,8 +858,11 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>   	}
>   
>   	profile = aa_alloc_profile(name, NULL, GFP_KERNEL);
> -	if (!profile)
> -		return ERR_PTR(-ENOMEM);
> +	if (!profile) {
> +		info = "out of memory";
> +		error = -ENOMEM;
> +		goto fail;
> +	}
>   	rules = list_first_entry(&profile->rules, typeof(*rules), list);
>   
>   	/* profile renaming is optional */
> @@ -1090,6 +1093,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>   	if (error == 0)
>   		/* default error covers most cases */
>   		error = -EPROTO;
> +	if (*ns_name) {
> +		kfree(*ns_name);
> +		*ns_name = NULL;
> +	}
>   	if (profile)
>   		name = NULL;
>   	else if (!name)
> @@ -1392,6 +1399,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>   {
>   	struct aa_load_ent *tmp, *ent;
>   	struct aa_profile *profile = NULL;
> +	char *ns_name = NULL;
>   	int error;
>   	struct aa_ext e = {
>   		.start = udata->data,
> @@ -1401,7 +1409,6 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>   
>   	*ns = NULL;
>   	while (e.pos < e.end) {
> -		char *ns_name = NULL;
>   		void *start;
>   		error = verify_header(&e, e.pos == e.start, ns);
>   		if (error)
> @@ -1432,6 +1439,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>   
>   		ent->new = profile;
>   		ent->ns_name = ns_name;
> +		ns_name = NULL;
>   		list_add_tail(&ent->list, lh);
>   	}
>   	udata->abi = e.version & K_ABI_MASK;
> @@ -1452,6 +1460,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>   	return 0;
>   
>   fail_profile:
> +	kfree(ns_name);
>   	aa_put_profile(profile);
>   
>   fail:

