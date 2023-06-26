Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E173D570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 02:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFZA5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 20:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZA5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 20:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B8126
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687741016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+GNj4TY3QwgXdJ5hTL9eDQCES/7GGtcAIghkSXdKKs=;
        b=GRMGRzZ2hsgeGdj73XmcuC+NY+geMWXtHTLelJ8N9GBFN+fsivsnksi8Tsl5RUUKRv9B2Y
        LjjbpHe7Rfje7A1Xap0m8vFQOu4pA2fOd7vk7JA4Z8sR8EF7K6MM+nqHCUlx5uVFcNHdpl
        odNb6iHsT3MFVZTaZPnhZImQWeY/TEI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-SYa4wrF3MQeXXksAxLVFmQ-1; Sun, 25 Jun 2023 20:56:55 -0400
X-MC-Unique: SYa4wrF3MQeXXksAxLVFmQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a034580aafso2782674b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687741014; x=1690333014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+GNj4TY3QwgXdJ5hTL9eDQCES/7GGtcAIghkSXdKKs=;
        b=Sk4iS9NWjgvQg3YplSaBLfFLfa496bPHmtadahC7mhXzg28hPAElS/bEe/5t9LExq1
         KYLtrPY42xHYzr5OG6DNKeDg6CYQ7CaD8GFhf8uFaJxuGNpquqAyjZhxRJ+5PtIMaues
         nrrgoCk9xa3lhtGYzYTVweeYgHbPIyP/A1TwJteqRIyRUDQOewHrrJbVIeuLzuXcVM9s
         AQrqTf1AjW0Xr3YaktxK2O1i7K6a9qurTXnnXP+ji3LthQIQDBUbFZHKxeWEZ2PNNdbH
         c+ImAsNJKXQyDz9Z7Nd3kCiWKIrjjyiNxDh86K0iO1NqO5+dp+ekCRYvyTICF/x//VxX
         db9Q==
X-Gm-Message-State: AC+VfDwgqyOxWsGgPtgMoEdL7UZS0fCR1yNSy4pJMDz0omKbat+cuSKl
        bS9coGoNQIBtCrfQKduAB32gs0frtsFTZKfopOAicec7eL/MYaTgS6q9wUS2egiaivhCyxVcb66
        9Ka5pFS+PhzOKF1Nvmk0R5/st
X-Received: by 2002:a05:6808:2225:b0:39e:e0f0:55ed with SMTP id bd37-20020a056808222500b0039ee0f055edmr24476166oib.53.1687741014410;
        Sun, 25 Jun 2023 17:56:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XDniU9mbkgJ37UJtuTdyxmQIbAWI8IOgZqvx0Xti7VIZL2IM75RJA5T57izCX7z8untYfCA==
X-Received: by 2002:a05:6808:2225:b0:39e:e0f0:55ed with SMTP id bd37-20020a056808222500b0039ee0f055edmr24476144oib.53.1687741014173;
        Sun, 25 Jun 2023 17:56:54 -0700 (PDT)
Received: from [10.72.13.91] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709028c8400b001b3c7e5ed8csm2927536plo.74.2023.06.25.17.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 17:56:53 -0700 (PDT)
Message-ID: <244c7527-2708-6a27-537b-a32cf9d37129@redhat.com>
Date:   Mon, 26 Jun 2023 08:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 17/79] ceph: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-16-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230621144735.55953-16-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/23 22:45, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/acl.c   |  2 +-
>   fs/ceph/caps.c  |  2 +-
>   fs/ceph/inode.c | 17 ++++++++++-------
>   fs/ceph/snap.c  |  2 +-
>   fs/ceph/xattr.c |  2 +-
>   5 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 6945a938d396..a3de2b9c3a68 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -93,7 +93,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   	char *value = NULL;
>   	struct iattr newattrs;
>   	struct inode *inode = d_inode(dentry);
> -	struct timespec64 old_ctime = inode->i_ctime;
> +	struct timespec64 old_ctime = inode_ctime_peek(inode);
>   	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
>   
>   	if (ceph_snap(inode) != CEPH_NOSNAP) {
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 2321e5ddb664..c144a07e334e 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1400,7 +1400,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>   
>   	arg->mtime = inode->i_mtime;
>   	arg->atime = inode->i_atime;
> -	arg->ctime = inode->i_ctime;
> +	arg->ctime = inode_ctime_peek(inode);
>   	arg->btime = ci->i_btime;
>   	arg->change_attr = inode_peek_iversion_raw(inode);
>   
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8e5f41d45283..f0b3b11d695e 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -100,7 +100,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	inode->i_uid = parent->i_uid;
>   	inode->i_gid = parent->i_gid;
>   	inode->i_mtime = parent->i_mtime;
> -	inode->i_ctime = parent->i_ctime;
> +	inode_ctime_set(inode, inode_ctime_peek(parent));
>   	inode->i_atime = parent->i_atime;
>   	ci->i_rbytes = 0;
>   	ci->i_btime = ceph_inode(parent)->i_btime;
> @@ -695,12 +695,14 @@ void ceph_fill_file_time(struct inode *inode, int issued,
>   		      CEPH_CAP_FILE_BUFFER|
>   		      CEPH_CAP_AUTH_EXCL|
>   		      CEPH_CAP_XATTR_EXCL)) {
> +		struct timespec64 ictime = inode_ctime_peek(inode);
> +
>   		if (ci->i_version == 0 ||
> -		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
> +		    timespec64_compare(ctime, &ictime) > 0) {
>   			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
> -			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
> +			     ictime.tv_sec, ictime.tv_nsec,
>   			     ctime->tv_sec, ctime->tv_nsec);
> -			inode->i_ctime = *ctime;
> +			inode_ctime_set(inode, *ctime);
>   		}
>   		if (ci->i_version == 0 ||
>   		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
> @@ -738,7 +740,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
>   	} else {
>   		/* we have no write|excl caps; whatever the MDS says is true */
>   		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
> -			inode->i_ctime = *ctime;
> +			inode_ctime_set(inode, *ctime);
>   			inode->i_mtime = *mtime;
>   			inode->i_atime = *atime;
>   			ci->i_time_warp_seq = time_warp_seq;
> @@ -2166,7 +2168,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
>   					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
>   		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
> -		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
> +		     inode_ctime_peek(inode).tv_sec,
> +		     inode_ctime_peek(inode).tv_nsec,
>   		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
>   		     only ? "ctime only" : "ignored");
>   		if (only) {
> @@ -2191,7 +2194,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   	if (dirtied) {
>   		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
>   							   &prealloc_cf);
> -		inode->i_ctime = attr->ia_ctime;
> +		inode_ctime_set(inode, attr->ia_ctime);
>   		inode_inc_iversion_raw(inode);
>   	}
>   
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 2e73ba62bd7a..f02df070fa84 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -660,7 +660,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>   	capsnap->size = i_size_read(inode);
>   	capsnap->mtime = inode->i_mtime;
>   	capsnap->atime = inode->i_atime;
> -	capsnap->ctime = inode->i_ctime;
> +	capsnap->ctime = inode_ctime_peek(inode);
>   	capsnap->btime = ci->i_btime;
>   	capsnap->change_attr = inode_peek_iversion_raw(inode);
>   	capsnap->time_warp_seq = ci->i_time_warp_seq;
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 806183959c47..8e217f7f58bd 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1238,7 +1238,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
>   					       &prealloc_cf);
>   		ci->i_xattrs.dirty = true;
> -		inode->i_ctime = current_time(inode);
> +		inode_ctime_set_current(inode);
>   	}
>   
>   	spin_unlock(&ci->i_ceph_lock);

Just back from PTO.

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>


