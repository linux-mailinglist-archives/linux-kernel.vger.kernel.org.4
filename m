Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AA614ACC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKAMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:35:38 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB862175B0;
        Tue,  1 Nov 2022 05:35:37 -0700 (PDT)
Received: from [172.20.1.180] (unknown [62.168.35.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 30E2B4322C;
        Tue,  1 Nov 2022 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667306120;
        bh=ZXI2ubxMWRqToeMfWY1GdaoOA0OwOCd4/sdNwpaxdIw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Gq7nJwNhOCIAR4rWNdC8tVTW2oqOl1flYeWFfW77dJHI+pQSRKdWybzBEWWlmKFUG
         2SPqIi61ZFZwthtZzCRKW7j6utaAaBe42rtGbGl0Qhj6wotq52KqsW+nuy7zmDVuqK
         xmvbzFYG6wy4C8h/iPCa2rqQDgkw277NZObKotQj6chzhApK5l53c2wXERy2xc2Xie
         6veWct20Gyvf1dTtUhlVzUbv3L1zBoIUIsk0AcCRFYF23OzlFSSnvRdle1x9/JiOOi
         iZDuNjH1LBNuX77+aK3XbcLX8zaje05cTMedorv4XzctvaAcynfQAogwg7giRu4vCR
         g/ehro9QSM/fw==
Message-ID: <635c91c3-4adb-01ff-1491-fe5188bb38a6@canonical.com>
Date:   Tue, 1 Nov 2022 05:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] apparmor: Fix memleak in alloc_ns()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028123320.88132-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221028123320.88132-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 05:33, Xiu Jianfeng wrote:
> After changes in commit a1bd627b46d1 ("apparmor: share profile name on
> replacement"), the hname member of struct aa_policy is not valid slab
> object, but a subset of that, it can not be freed by kfree_sensitive(),
> use aa_policy_destroy() to fix it.
> 
> Fixes: a1bd627b46d1 ("apparmor: share profile name on replacement")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/policy_ns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index 5c38563a6dcf..fd5b7afbcb48 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -132,7 +132,7 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
>   	return ns;
>   
>   fail_unconfined:
> -	kfree_sensitive(ns->base.hname);
> +	aa_policy_destroy(&ns->base);
>   fail_ns:
>   	kfree_sensitive(ns);
>   	return NULL;

