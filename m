Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF2634C06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiKWBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiKWBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA2EDAD37
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669165592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyYINtqzF72Kns7qgybI+twwvQdBg3XXrT8LgryTOaI=;
        b=iqi5muAJ/gtk+VHOSm4wnJXh95cuihPkZ+RkXh/im75+JFTlqx4ES+XGxEXXGPnQcUuy2L
        v6/+sMeqt6LcvkFfWnWTtwr6RIqdDrlpT+amDmECB5IKMZzgI4T1BPSCTPwHHcmeQPJIFw
        bjmepm/NYxff2sQ4y0H1hkG40UsHnzY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-HK_Kj-ftMA--LFD21iSoUg-1; Tue, 22 Nov 2022 20:06:31 -0500
X-MC-Unique: HK_Kj-ftMA--LFD21iSoUg-1
Received: by mail-pg1-f200.google.com with SMTP id 38-20020a630b26000000b004773803dda1so6707748pgl.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyYINtqzF72Kns7qgybI+twwvQdBg3XXrT8LgryTOaI=;
        b=iimqGc0CcnLuNgX1qdxSidGevSu4m04G7ZSUBsd58YLbPre+PMlec4B7QJ5OVCgRYk
         TnHuPXm+JOYyZjiFrL7L8dQ7UnagmimPyWcBk+WRIFGaR7UNcE4wAve/23DHUY4CtQaI
         jNkrY2l2orqvEujMuWs9WsUifTHLvNVYnj4wFKZEU6pVoyaJCXvpyCiq+D0n2bLXOnyv
         JH4OShiMoQSo4Tz6vCuQcuy8r8agRPwormx8J8CCOemG9RA6g8j7Y13ZXxHwt3PYEUq0
         ty42shuzFYnHeiHdN1qh6KLTw0vpjeShTryZlYW0ajjjXPNRoB9ftSpYiM37ctgKVt9O
         C27w==
X-Gm-Message-State: ANoB5pldNRFHXmghtfYhJCouXnY9sSyBGpvmQ+EkrMu7qtgnOmN3BYaA
        m4C12p1QxrhgC3azWZM8i9d+2vQLIbi8XaBAfp/sc9k6fVMC2msm3mFt3rEQAJ3+z5qC8XHXwvr
        hPqNAxaynrY3Z98crrBK68J/RcrFJZsKE8YDAlsRYQXi1EvgdB89WdKguzfCo2iMl66Gs/ytxXw
        ==
X-Received: by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id k11-20020a63ff0b000000b00477362d85d3mr5408209pgi.395.1669165590566;
        Tue, 22 Nov 2022 17:06:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7b8YPbxw4zRs/8wlALGX3snl3V/lh54wAjXzHomgUAE3UAkArxQOYKLGZBV0+ULD6JEAo5yw==
X-Received: by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id k11-20020a63ff0b000000b00477362d85d3mr5408181pgi.395.1669165590230;
        Tue, 22 Nov 2022 17:06:30 -0800 (PST)
Received: from [10.72.12.64] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902b94300b00183c6784704sm5283766pls.291.2022.11.22.17.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 17:06:29 -0800 (PST)
Subject: Re: [PATCH v3] ceph: mark directory as non-complete complete after
 loading key
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221122145920.17025-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e736d5ab-9876-187f-b24a-27461c09656b@redhat.com>
Date:   Wed, 23 Nov 2022 09:06:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221122145920.17025-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/2022 22:59, Luís Henriques wrote:
> When setting a directory's crypt context, ceph_dir_clear_complete() needs to
> be called otherwise if it was complete before, any existing (old) dentry will
> still be valid.
>
> This patch adds a wrapper around __fscrypt_prepare_readdir() which will
> ensure a directory is marked as non-complete if key status changes.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> Hopefully I'm not breaking anything else.  I've run a bunch of fstests and
> didn't saw any (new) failures.
>
> Changes since v2:
> - Created helper wrapper for __fscrypt_prepare_readdir()
> - Added calls to the new helper
>
> Changes since v1:
> - Moved the __ceph_dir_clear_complete() call from ceph_crypt_get_context()
>    to ceph_lookup().
> - Added an __fscrypt_prepare_readdir() wrapper to check key status changes
>
>   fs/ceph/crypto.c     | 35 +++++++++++++++++++++++++++++++++--
>   fs/ceph/crypto.h     |  6 ++++++
>   fs/ceph/dir.c        |  8 ++++----
>   fs/ceph/mds_client.c |  6 +++---
>   4 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 35a2ccfe6899..5ef65a06af98 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -397,8 +397,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		goto out_inode;
>   	}
>   
> -	ret = __fscrypt_prepare_readdir(dir);
> -	if (ret)
> +	ret = ceph_fscrypt_prepare_readdir(dir);
> +	if (ret < 0)
>   		goto out_inode;
>   
>   	/*
> @@ -636,3 +636,34 @@ int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
>   	}
>   	return ret;
>   }
> +
> +/**
> + * ceph_fscrypt_prepare_readdir - simple __fscrypt_prepare_readdir() wrapper
> + * @dir: directory inode for readdir prep
> + *
> + * Simple wrapper around __fscrypt_prepare_readdir() that will mark directory as
> + * non-complete if this call results in having the directory unlocked.
> + *
> + * Returns:
> + *     1 - if directory was locked and key is now loaded (i.e. dir is unlocked)
> + *     0 - if directory is still locked
> + *   < 0 - if __fscrypt_prepare_readdir() fails
> + */
> +int ceph_fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	bool had_key = fscrypt_has_encryption_key(dir);
> +	int err;
> +
> +	if (!IS_ENCRYPTED(dir))
> +		return 0;
> +
> +	err = __fscrypt_prepare_readdir(dir);
> +	if (err)
> +		return err;
> +	if (!had_key && fscrypt_has_encryption_key(dir)) {
> +		/* directory just got unlocked, mark it as not complete */
> +		ceph_dir_clear_complete(dir);
> +		return 1;
> +	}
> +	return 0;
> +}
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index c6ee993f4ec8..cad53ec916fd 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -154,6 +154,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page, u64 of
>   				 struct ceph_sparse_extent *map, u32 ext_cnt);
>   int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
>   				int len, gfp_t gfp);
> +int ceph_fscrypt_prepare_readdir(struct inode *dir);
>   
>   static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
>   {
> @@ -254,6 +255,11 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
>   {
>   	return page;
>   }
> +
> +static inline int ceph_fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_FS_ENCRYPTION */
>   
>   static inline loff_t ceph_fscrypt_page_offset(struct page *page)
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index edc2bf0aab83..5829f27d058d 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -343,8 +343,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>   		ctx->pos = 2;
>   	}
>   
> -	err = fscrypt_prepare_readdir(inode);
> -	if (err)
> +	err = ceph_fscrypt_prepare_readdir(inode);
> +	if (err < 0)
>   		return err;
>   
>   	spin_lock(&ci->i_ceph_lock);
> @@ -784,8 +784,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>   		return ERR_PTR(-ENAMETOOLONG);
>   
>   	if (IS_ENCRYPTED(dir)) {
> -		err = __fscrypt_prepare_readdir(dir);
> -		if (err)
> +		err = ceph_fscrypt_prepare_readdir(dir);
> +		if (err < 0)
>   			return ERR_PTR(err);
>   		if (!fscrypt_has_encryption_key(dir)) {
>   			spin_lock(&dentry->d_lock);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 9518ac8e407d..4becc9eada4b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2551,8 +2551,8 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
>   	if (!IS_ENCRYPTED(dir))
>   		goto success;
>   
> -	ret = __fscrypt_prepare_readdir(dir);
> -	if (ret)
> +	ret = ceph_fscrypt_prepare_readdir(dir);
> +	if (ret < 0)
>   		return ERR_PTR(ret);
>   
>   	/* No key? Just ignore it. */
> @@ -2668,7 +2668,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for
>   			spin_unlock(&cur->d_lock);
>   			parent = dget_parent(cur);
>   
> -			ret = __fscrypt_prepare_readdir(d_inode(parent));
> +			ret = ceph_fscrypt_prepare_readdir(d_inode(parent));
>   			if (ret < 0) {
>   				dput(parent);
>   				dput(cur);

Hi Luis,

This version LGTM.

Just one nit. I think the following:

if (fscrypt_has_encryption_key(d_inode(parent))) {

is no needed any more.

We can just switch to:

if (ret) {

And also other places ?

Thanks!

- Xiubo

>

