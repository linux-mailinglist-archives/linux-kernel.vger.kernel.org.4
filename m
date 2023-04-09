Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BA6DC1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDIXQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 19:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIXQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 19:16:07 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08C2694;
        Sun,  9 Apr 2023 16:16:04 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 43E3D3F373;
        Sun,  9 Apr 2023 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681082161;
        bh=VzZtUugz5Z6wG4Nk2gp8O0xbsEGnMTB9pV/EotnGfmo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SCNIsjnDSDqBX2UE3SsBX1YgQF+fLFVKC3LFmoNlZGeg4Kbzwh2BePsQv5PnqkrXm
         bIDjex7IKcHuVN+2hfu00qjiet4r93pZHBGJvLzWsqYeLSsfJs+jh14YkYAR4ieJeT
         RAR8fh7ox7Ty9pPjkNrHDZ1q3a7kvUVOKWWwXXq4JguwkgzqCukaKpR/NT4m4s1sda
         U8KpH4TuNxruw3dYPdbb5MUVwFf0mw/ojLYxbd5hZxqyydhZJHHbe7r0wJcPJcPgMR
         PG9/GBeSULITEJlzLWI2tDXOsnGETECAdfzxKdIgflz9VJsExiFRLVXdmCjScGJ6v+
         roOdJg95kvUnw==
Message-ID: <763073bf-44db-701e-c100-c392cb11e958@canonical.com>
Date:   Sun, 9 Apr 2023 16:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] apparmor: Return directly after a failed kzalloc() in two
 functions
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <d33ebeca-0900-8c6c-ac44-f301daf24a5b@web.de>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <d33ebeca-0900-8c6c-ac44-f301daf24a5b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 03:12, Markus Elfring wrote:
> Date: Wed, 29 Mar 2023 11:50:44 +0200
> 
> 1. Return directly after a call of the function “kzalloc” failed
>     at the beginning in these function implementations.
> 
> 2. Omit extra initialisations (for a few local variables)
>     which became unnecessary with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: John Johansen <john.johansen@canonical.com>

thanks, I have pulled this into the apparmor tree

> ---
>   security/apparmor/crypto.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index b498ed302461..6724e2ff6da8 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -28,15 +28,15 @@ unsigned int aa_hash_size(void)
>   char *aa_calc_hash(void *data, size_t len)
>   {
>   	SHASH_DESC_ON_STACK(desc, apparmor_tfm);
> -	char *hash = NULL;
> -	int error = -ENOMEM;
> +	char *hash;
> +	int error;
> 
>   	if (!apparmor_tfm)
>   		return NULL;
> 
>   	hash = kzalloc(apparmor_hash_size, GFP_KERNEL);
>   	if (!hash)
> -		goto fail;
> +		return ERR_PTR(-ENOMEM);
> 
>   	desc->tfm = apparmor_tfm;
> 
> @@ -62,7 +62,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>   			 size_t len)
>   {
>   	SHASH_DESC_ON_STACK(desc, apparmor_tfm);
> -	int error = -ENOMEM;
> +	int error;
>   	__le32 le32_version = cpu_to_le32(version);
> 
>   	if (!aa_g_hash_policy)
> @@ -73,7 +73,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
> 
>   	profile->hash = kzalloc(apparmor_hash_size, GFP_KERNEL);
>   	if (!profile->hash)
> -		goto fail;
> +		return -ENOMEM;
> 
>   	desc->tfm = apparmor_tfm;
> 
> --
> 2.40.0
> 

