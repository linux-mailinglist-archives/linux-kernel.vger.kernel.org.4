Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8B606DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJUCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJUCa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:30:28 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6798B10CFBC;
        Thu, 20 Oct 2022 19:30:26 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6AF8943229;
        Fri, 21 Oct 2022 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666319425;
        bh=jNTxHcCRkTxNoqJLJsvQxenlL7PnWwOhV15q92jjblM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LYz+TqjysExvZoiTIeAT/VncajyzxX/c4V2k9BanyFDpb74BJzqwnJYD4zilW7WqD
         Is5sKqEAS7slWyk65Ru2NHS+UK5ctjT3S84gOex2pPqN51xDT3GBXiC0s5CWID10Yy
         pnNUF01xpZDrgha6BTz4rqHYQRARd0XNkhC/y6PeVYgL95XNBVQsbFVp4TGMlRIRVS
         rcDYZlHIg6Ft1M8jEdClaDLfbFscBb+YO+1vvHQ+8uQrvff+Zcp5YsWAe6qJUDztgM
         x6rbnQG9TRJiXQU//8yVSfzyNe68xRUpg+u0gEHxiiPg5Kl6OP/i/PR4R6d56cCqt1
         2sGIxoSGVfLAA==
Message-ID: <e321b2a4-210e-7b36-8894-1eb0e97159ca@canonical.com>
Date:   Thu, 20 Oct 2022 19:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] apparmor: Use pointer to struct aa_label for lbs_cred
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221021004604.188986-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221021004604.188986-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 17:46, Xiu Jianfeng wrote:
> According to the implementations of cred_label() and set_cred_label(),
> we should use pointer to struct aa_label for lbs_cred instead of struct
> aa_task_ctx, this patch fixes it.
> 
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
yep, thanks I will pull this into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
> V2: fixes the comment too
> ---
>   security/apparmor/lsm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f56070270c69..1e2f40db15c5 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1194,10 +1194,10 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
>   #endif
>   
>   /*
> - * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
> + * The cred blob is a pointer to, not an instance of, an aa_label.
>    */
>   struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
> -	.lbs_cred = sizeof(struct aa_task_ctx *),
> +	.lbs_cred = sizeof(struct aa_label *),
>   	.lbs_file = sizeof(struct aa_file_ctx),
>   	.lbs_task = sizeof(struct aa_task_ctx),
>   };

