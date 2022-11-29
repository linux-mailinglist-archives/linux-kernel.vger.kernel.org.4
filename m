Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE063BD38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiK2JrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK2JrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:47:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2025A6C9;
        Tue, 29 Nov 2022 01:47:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C0D91FDDE;
        Tue, 29 Nov 2022 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669715235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9X9FAYl83rh5wTfTutnQPBzaeLzntb0xipY1V7sU+k=;
        b=1v0ZFI2mUtQjV1kLZyo8OCVLNILkHtRASyVtdCZomNrQqGaRO0JJB3ZSiug9pxl6nFZD7p
        2EV7pamuxwiGDAT3x5fTJoRqoWQ43DTr45+GydYjG9P0hMY07vRGyVBmZBjg3BJhMKvbvq
        cVCksmXCKiPCUQ+1mg2CHgjodDuKJv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669715235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9X9FAYl83rh5wTfTutnQPBzaeLzntb0xipY1V7sU+k=;
        b=Sm8DD0NAY0t83hMMC06nbTlte5HCkA5uCk813d9xoqGFRFHYD6662FjnPPovtxc7qmkOjW
        7YklchuGITpXh+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B990F13428;
        Tue, 29 Nov 2022 09:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Ph0KiLVhWMjLgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 29 Nov 2022 09:47:14 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e117ce9f;
        Tue, 29 Nov 2022 09:48:19 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ceph: mark directory as non-complete complete after
 loading key
References: <20221122145920.17025-1-lhenriques@suse.de>
        <dd36f5c2-5eab-760c-0fb2-eae6764a8222@redhat.com>
Date:   Tue, 29 Nov 2022 09:48:19 +0000
In-Reply-To: <dd36f5c2-5eab-760c-0fb2-eae6764a8222@redhat.com> (Xiubo Li's
        message of "Tue, 29 Nov 2022 16:47:04 +0800")
Message-ID: <877cze147w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> Hi Luis,
>
> BTW, which branch are you using to generate this patch ?
>
> Could you rebase to the testing branch ?

Hmmm, I think I've used the wip-fscrypt branch.  OK, I'll resend this
after running a few tests just to make sure.

Cheers,
--=20
Lu=C3=ADs

>
> Thanks
>
> - Xiubo
>
>
> On 22/11/2022 22:59, Lu=C3=ADs Henriques wrote:
>> When setting a directory's crypt context, ceph_dir_clear_complete() need=
s to
>> be called otherwise if it was complete before, any existing (old) dentry=
 will
>> still be valid.
>>
>> This patch adds a wrapper around __fscrypt_prepare_readdir() which will
>> ensure a directory is marked as non-complete if key status changes.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>> Hi!
>>
>> Hopefully I'm not breaking anything else.  I've run a bunch of fstests a=
nd
>> didn't saw any (new) failures.
>>
>> Changes since v2:
>> - Created helper wrapper for __fscrypt_prepare_readdir()
>> - Added calls to the new helper
>>
>> Changes since v1:
>> - Moved the __ceph_dir_clear_complete() call from ceph_crypt_get_context=
()
>>    to ceph_lookup().
>> - Added an __fscrypt_prepare_readdir() wrapper to check key status chang=
es
>>
>>   fs/ceph/crypto.c     | 35 +++++++++++++++++++++++++++++++++--
>>   fs/ceph/crypto.h     |  6 ++++++
>>   fs/ceph/dir.c        |  8 ++++----
>>   fs/ceph/mds_client.c |  6 +++---
>>   4 files changed, 46 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index 35a2ccfe6899..5ef65a06af98 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -397,8 +397,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname=
, struct fscrypt_str *tname,
>>   		goto out_inode;
>>   	}
>>   -	ret =3D __fscrypt_prepare_readdir(dir);
>> -	if (ret)
>> +	ret =3D ceph_fscrypt_prepare_readdir(dir);
>> +	if (ret < 0)
>>   		goto out_inode;
>>     	/*
>> @@ -636,3 +636,34 @@ int ceph_fscrypt_encrypt_pages(struct inode *inode,=
 struct page **page, u64 off,
>>   	}
>>   	return ret;
>>   }
>> +
>> +/**
>> + * ceph_fscrypt_prepare_readdir - simple __fscrypt_prepare_readdir() wr=
apper
>> + * @dir: directory inode for readdir prep
>> + *
>> + * Simple wrapper around __fscrypt_prepare_readdir() that will mark dir=
ectory as
>> + * non-complete if this call results in having the directory unlocked.
>> + *
>> + * Returns:
>> + *     1 - if directory was locked and key is now loaded (i.e. dir is u=
nlocked)
>> + *     0 - if directory is still locked
>> + *   < 0 - if __fscrypt_prepare_readdir() fails
>> + */
>> +int ceph_fscrypt_prepare_readdir(struct inode *dir)
>> +{
>> +	bool had_key =3D fscrypt_has_encryption_key(dir);
>> +	int err;
>> +
>> +	if (!IS_ENCRYPTED(dir))
>> +		return 0;
>> +
>> +	err =3D __fscrypt_prepare_readdir(dir);
>> +	if (err)
>> +		return err;
>> +	if (!had_key && fscrypt_has_encryption_key(dir)) {
>> +		/* directory just got unlocked, mark it as not complete */
>> +		ceph_dir_clear_complete(dir);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index c6ee993f4ec8..cad53ec916fd 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -154,6 +154,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode=
, struct page **page, u64 of
>>   				 struct ceph_sparse_extent *map, u32 ext_cnt);
>>   int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page=
, u64 off,
>>   				int len, gfp_t gfp);
>> +int ceph_fscrypt_prepare_readdir(struct inode *dir);
>>     static inline struct page *ceph_fscrypt_pagecache_page(struct page *=
page)
>>   {
>> @@ -254,6 +255,11 @@ static inline struct page *ceph_fscrypt_pagecache_p=
age(struct page *page)
>>   {
>>   	return page;
>>   }
>> +
>> +static inline int ceph_fscrypt_prepare_readdir(struct inode *dir)
>> +{
>> +	return 0;
>> +}
>>   #endif /* CONFIG_FS_ENCRYPTION */
>>     static inline loff_t ceph_fscrypt_page_offset(struct page *page)
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index edc2bf0aab83..5829f27d058d 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -343,8 +343,8 @@ static int ceph_readdir(struct file *file, struct di=
r_context *ctx)
>>   		ctx->pos =3D 2;
>>   	}
>>   -	err =3D fscrypt_prepare_readdir(inode);
>> -	if (err)
>> +	err =3D ceph_fscrypt_prepare_readdir(inode);
>> +	if (err < 0)
>>   		return err;
>>     	spin_lock(&ci->i_ceph_lock);
>> @@ -784,8 +784,8 @@ static struct dentry *ceph_lookup(struct inode *dir,=
 struct dentry *dentry,
>>   		return ERR_PTR(-ENAMETOOLONG);
>>     	if (IS_ENCRYPTED(dir)) {
>> -		err =3D __fscrypt_prepare_readdir(dir);
>> -		if (err)
>> +		err =3D ceph_fscrypt_prepare_readdir(dir);
>> +		if (err < 0)
>>   			return ERR_PTR(err);
>>   		if (!fscrypt_has_encryption_key(dir)) {
>>   			spin_lock(&dentry->d_lock);
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 9518ac8e407d..4becc9eada4b 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -2551,8 +2551,8 @@ static u8 *get_fscrypt_altname(const struct ceph_m=
ds_request *req, u32 *plen)
>>   	if (!IS_ENCRYPTED(dir))
>>   		goto success;
>>   -	ret =3D __fscrypt_prepare_readdir(dir);
>> -	if (ret)
>> +	ret =3D ceph_fscrypt_prepare_readdir(dir);
>> +	if (ret < 0)
>>   		return ERR_PTR(ret);
>>     	/* No key? Just ignore it. */
>> @@ -2668,7 +2668,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, =
int *plen, u64 *pbase, int for
>>   			spin_unlock(&cur->d_lock);
>>   			parent =3D dget_parent(cur);
>>   -			ret =3D __fscrypt_prepare_readdir(d_inode(parent));
>> +			ret =3D ceph_fscrypt_prepare_readdir(d_inode(parent));
>>   			if (ret < 0) {
>>   				dput(parent);
>>   				dput(cur);
>>
>

