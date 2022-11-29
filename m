Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875063C24D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiK2OUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK2OTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D9B855
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669731341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsFKFC3tYSrPqD4PFpGmgaAbwONzIKX+xgDNkpcJwsg=;
        b=Za9jEHL4q8aoLEdJ3qacn8Lm0beVAIX2njpMDy5VMxVVOB0EvTYUYI0Zm1Gp2fq6T+anoc
        +8B/kQzv31FZuOmtBrP0bFdBOn3oVDCLRnCURZQTdAW9UxhQR6oP4llqKYHsXHjwueMWbp
        eU+BPoHr2n9VhcIXTG1WGC/ax+n5jcg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-P48UmCKtO7q5gTzJzxzF7Q-1; Tue, 29 Nov 2022 09:15:40 -0500
X-MC-Unique: P48UmCKtO7q5gTzJzxzF7Q-1
Received: by mail-pf1-f198.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso11278710pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsFKFC3tYSrPqD4PFpGmgaAbwONzIKX+xgDNkpcJwsg=;
        b=sDFpDP7hWEyQEgpPK61md4uAY0xVMmHflGCGj7XLIPJbX0BAOgjZqexG6H3sEIoOJV
         YFkaAf8p77BBUTRJxdZHSrt3oAS+/xR6AUhmRf9eQFpfORg0nI3vfZS4JhCALkZ8Adcm
         605bSRkob9y2dbRV9bWNUE6K5ayVnjyxrsbgwxfioz9ub9aW8LZUuVM7p2JWasgp9J3x
         y1RtGEdzIf9b+U6Idwr47JESEhM8l6zet69j6aCZ1AJIR7XximemSZp9Y9oTbZkZX5Gk
         apusuK7wGtDYqOjdogaPJ5u9v0xh0TBj+RPDsgM4wmg0C7FeAyYQbG48v3Yms4y5ZDk/
         sCyw==
X-Gm-Message-State: ANoB5pmZQ7khp/SNvdSAX7Gm2ouYKOK1HPi5+slwfFFD/Ku2WwxkYIjs
        XAQNIOLpAQMHPZ3j/1KIfkjY7m3O53l3JWfTYv1d+Vj8L8ZjII/h+2AkHngjZCUKc/00yIjsTSq
        TXdS3dds/a5pwQAyxM/Reqs70AY3uXIxL/Rt8l2a7le6kkVFIzL/JYR48+Z0X6hp0mmXZLmuyoQ
        ==
X-Received: by 2002:a17:90a:a003:b0:214:1a8a:a415 with SMTP id q3-20020a17090aa00300b002141a8aa415mr58827826pjp.197.1669731338550;
        Tue, 29 Nov 2022 06:15:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5iIK89tM4I6dquO3B8lcGmZSrBHc+AFTGCgwNJ8a/KMszQxfiYPI9wTYBtKOtctQ0uZC6YEA==
X-Received: by 2002:a17:90a:a003:b0:214:1a8a:a415 with SMTP id q3-20020a17090aa00300b002141a8aa415mr58827779pjp.197.1669731338103;
        Tue, 29 Nov 2022 06:15:38 -0800 (PST)
Received: from [10.72.12.126] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902968100b00186616b8fbasm4284485plp.10.2022.11.29.06.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:15:37 -0800 (PST)
Subject: Re: [PATCH v4] ceph: mark directory as non-complete complete after
 loading key
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221129103949.19737-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4914a195-edc0-747b-6598-9ac9868593a1@redhat.com>
Date:   Tue, 29 Nov 2022 22:15:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221129103949.19737-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/11/2022 18:39, Luís Henriques wrote:
> When setting a directory's crypt context, ceph_dir_clear_complete() needs to
> be called otherwise if it was complete before, any existing (old) dentry will
> still be valid.
>
> This patch adds a wrapper around __fscrypt_prepare_readdir() which will
> ensure a directory is marked as non-complete if key status changes.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi Xiubo,
>
> Here's a rebase of this patch.  I did some testing but since this branch
> doesn't really have full fscrypt support, I couldn't even reproduce the
> bug.  So, my testing was limited.

I'm planing not to update the wip-fscrypt branch any more, except the IO 
path related fixes, which may introduce potential bugs each time as before.

Since the qa tests PR has finished and the tests have passed, so we are 
planing to merge the first none IO part, around 27 patches. And then 
pull the reset patches from wip-fscrypt branch.

Applied this to the testing branch and now testing it.

Thanks Luis.

- Xiubo

> Changes since v3:
> - Rebased patch to 'testing' branch
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
>
>   fs/ceph/crypto.c     | 35 +++++++++++++++++++++++++++++++++--
>   fs/ceph/crypto.h     |  6 ++++++
>   fs/ceph/dir.c        |  8 ++++----
>   fs/ceph/mds_client.c |  6 +++---
>   4 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 5b807f8f4c69..fe47fbdaead9 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -277,8 +277,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>   		return -EIO;
>   
> -	ret = __fscrypt_prepare_readdir(fname->dir);
> -	if (ret)
> +	ret = ceph_fscrypt_prepare_readdir(fname->dir);
> +	if (ret < 0)
>   		return ret;
>   
>   	/*
> @@ -323,3 +323,34 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   	fscrypt_fname_free_buffer(&_tname);
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
> index 05db33f1a421..f8d5f33f708a 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -94,6 +94,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_s
>   
>   int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   			struct fscrypt_str *oname, bool *is_nokey);
> +int ceph_fscrypt_prepare_readdir(struct inode *dir);
>   
>   #else /* CONFIG_FS_ENCRYPTION */
>   
> @@ -147,6 +148,11 @@ static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry
>   	oname->len = fname->name_len;
>   	return 0;
>   }
> +
> +static inline int ceph_fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_FS_ENCRYPTION */
>   
>   #endif
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index b136fb923b7a..bc908d0dd224 100644
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
> index e3683305445c..cbbaf334b6b8 100644
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
>

