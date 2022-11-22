Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BDE6331C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiKVBDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiKVBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EECAEA48
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669078943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCliI++SK2VwVV/mu+efqGEn8wYMsS23lZMFREzOpN0=;
        b=BSwQtWjKyOJegHRiB1FVNg5+j4jxWlYhN0lq4FfqA4MewWDycq8hMSH1ofI/V3gkrsp1fi
        w+HPEvv9TXxKTs5PBbYz0Zon5Qef9k4Vwm/F0m3ZmOSHYQ7mRb/CnG9S9inbFx/HneBIZ9
        tcTld50RHYYiWBBD5ZlustumT3+zoeI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-i3jr5StxOiaVgXUvqvKDLg-1; Mon, 21 Nov 2022 20:02:22 -0500
X-MC-Unique: i3jr5StxOiaVgXUvqvKDLg-1
Received: by mail-pf1-f199.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso8440524pfu.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCliI++SK2VwVV/mu+efqGEn8wYMsS23lZMFREzOpN0=;
        b=AFyko6ye48v/q51cVT9iE+IkOuLOGJlvbOW3VawxtZK+vxpJDaVVYiKMFg4bXmDlZ0
         fF8zoJyhGzfkXXu6bLqchil70FFMD3PYb6l8DurLpp/lxon7NUSS31CacpiAFJBoVeM0
         pi0RKFE2cEAMFkblolBE16/bIZI1436eZVn/1ZWVffHVtNQDekPrFP0h1kywDCmRhxm1
         eBVnlE/00dCJi3xitmicuyYbgktB43y0Q70B1w0rF+GaKJaudFEQ7ck5loWD4rCETgsR
         WKOhiAqmf+5dq0V2zwzfBagl9ln1TJrqXTdGid9+JqXAFVQEN9c6qMYYl2OYe4bGY75Z
         Cgwg==
X-Gm-Message-State: ANoB5pky3SOwtjcZ6DqL7IIQX9ox3aIa6yEkla3j5euN6FZ8pHmWeIQR
        6S+lRWd4OnHhy8pbj5RE/XYtVXBVOEyMM1xVtp6x7381Hi0Vz/trBDgwSK7f4WK/c9DDZWsXhH4
        Hdx2u0F0MMHlZx3JpotJNzFj9rM2lfi5yY1CwMZ8BOfDqeY83Ojei82Pi5tcy69lDsnO7C/f+lw
        ==
X-Received: by 2002:a17:902:aa44:b0:189:fdf:a3d9 with SMTP id c4-20020a170902aa4400b001890fdfa3d9mr12342230plr.9.1669078940935;
        Mon, 21 Nov 2022 17:02:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5O6IFyyfSw7LoXbfb4uwV76C9iA2jeH6mN+OGq5TnncolVxXSYhHP5kr4vQZ22bw1Qb6nxaQ==
X-Received: by 2002:a17:902:aa44:b0:189:fdf:a3d9 with SMTP id c4-20020a170902aa4400b001890fdfa3d9mr12342192plr.9.1669078940509;
        Mon, 21 Nov 2022 17:02:20 -0800 (PST)
Received: from [10.72.12.200] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b001fde655225fsm521612pjb.2.2022.11.21.17.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 17:02:19 -0800 (PST)
Subject: Re: [PATCH v2] ceph: make sure directories aren't complete after
 setting crypt context
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121180004.8038-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <fbce8a0b-340b-0d82-ffbc-1245e30876f9@redhat.com>
Date:   Tue, 22 Nov 2022 09:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221121180004.8038-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/2022 02:00, Luís Henriques wrote:
> When setting a directory's crypt context, __ceph_dir_clear_complete() needs
> to be used otherwise, if it was complete before, any old dentry that's still
> around will be valid.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi Xiubo!
>
> I've added the __fscrypt_prepare_readdir() wrapper as you suggested, but I
> had to change it slightly because we also need to handle the error cases.
>
> Changes since v1:
> - Moved the __ceph_dir_clear_complete() call from ceph_crypt_get_context()
>    to ceph_lookup().
> - Added an __fscrypt_prepare_readdir() wrapper to check key status changes
>
>   fs/ceph/dir.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index edc2bf0aab83..2cac7e3ab352 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -763,6 +763,27 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
>   		strncmp(dentry->d_name.name, ".ceph", 5) == 0;
>   }
>   
> +/*
> + * Simple wrapper around __fscrypt_prepare_readdir() that will return:
> + *
> + * - '1' if directory was locked and key is now loaded (i.e. dir is unlocked),
> + * - '0' if directory is still locked, or
> + * - an error (< 0) if __fscrypt_prepare_readdir() fails.
> + */
> +static int ceph_fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	bool had_key = fscrypt_has_encryption_key(dir);
> +	int err;
> +
> +	err = __fscrypt_prepare_readdir(dir);
> +	if (err)
> +		return err;
> +	/* is directory now unlocked? */
> +	if (!had_key && fscrypt_has_encryption_key(dir))
> +		return 1;
> +	return 0;
> +}
> +
>   /*
>    * Look up a single dir entry.  If there is a lookup intent, inform
>    * the MDS so that it gets our 'caps wanted' value in a single op.
> @@ -784,10 +805,14 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>   		return ERR_PTR(-ENAMETOOLONG);
>   
>   	if (IS_ENCRYPTED(dir)) {
> -		err = __fscrypt_prepare_readdir(dir);
> -		if (err)
> +		err = ceph_fscrypt_prepare_readdir(dir);
> +		if (err < 0)
>   			return ERR_PTR(err);
> -		if (!fscrypt_has_encryption_key(dir)) {
> +		if (err) {
> +			/* directory just got unlocked */
> +			__ceph_dir_clear_complete(ceph_inode(dir));

Luis,

Could we just move this into ceph_fscrypt_prepare_readdir() ? IMO we 
should always clear the complete flag always whenever the key is first 
loaded.

> +		} else {
> +			/* no encryption key */

I think you also need to fix all the other places, which are calling the 
__fscrypt_prepare_readdir() or fscrypt_prepare_readdir() in ceph. 
Because we don't know the ceph_lookup() will always be the first caller 
to trigger __fscrypt_prepare_readdir() for a dir.

Thanks!

- Xiubo

>   			spin_lock(&dentry->d_lock);
>   			dentry->d_flags |= DCACHE_NOKEY_NAME;
>   			spin_unlock(&dentry->d_lock);
>

