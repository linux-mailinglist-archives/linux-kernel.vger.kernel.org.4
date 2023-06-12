Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49172CA94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjFLPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFLPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6DCA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A8D61E99
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC85C433D2;
        Mon, 12 Jun 2023 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686584825;
        bh=ng4NcAv7Bg3W3tmF1h5jtSAaleUESGi5n+V3tZwTWEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo+iMwMFzqnknsT6HcnYRjvEGXEYWlvF+x2bv6cuzX88g4K2GbTE1mP7NGI8KdbdZ
         RBsd5ZalxQDYYUs7cqCb/dLNuwMLggb3L64mLygYdCgjUJ4qsxP3UGsFuNTKZIs9fA
         u0yFlfb8dNx9WsJpsTj4vmARvgeqGphcIkgeuJOZ3O8hUoidPzWd09gK06l4+hOL8q
         kedrKQj8v0bV8reN2wlCaYfZX0tkOQUm44H0RMmlfR4rudqFNBsMZVQ95s035pCGCy
         HOkdcirQzZJxS21/scJryJWuHWqiJ9epaNrciI1Fa54gf4ezTGO1rghVzxRs2uANgZ
         1/JQ0JWu4rS1A==
Date:   Mon, 12 Jun 2023 08:47:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 5/6] f2fs: add f2fs_ioc_[get|set]_extra_attr
Message-ID: <ZIc9+N2GIQepZcCq@google.com>
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-6-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612030121.2393541-6-shengyong@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12, Sheng Yong wrote:
> This patch introduces two ioctls:
>   * f2fs_ioc_get_extra_attr
>   * f2fs_ioc_set_extra_attr
> to get or modify values in f2fs_inode's extra attribute area.

What'd be the main purpose of this new ioctl? Use-cases or examples?

> 
> The argument of these two ioctls is `struct f2fs_extra_attr', which has
> three members:
>   * field: indicates which field in extra attribute area is handled
>   * attr: value or userspace pointer
>   * attr_size: size of `attr'
> 
> The `field' member could help extend functionality of these two ioctls
> without modify or add new interfaces, if more fields are added into
> extra attributes ares in the feture.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>  fs/f2fs/file.c            | 205 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/f2fs.h |  25 +++++
>  2 files changed, 230 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f8aa842b5d233..39d04f8f0bb6b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4179,6 +4179,207 @@ static int f2fs_ioc_compress_file(struct file *filp)
>  	return ret;
>  }
>  
> +static bool extra_attr_fits_in_inode(struct inode *inode, int field)
> +{
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_inode *ri;
> +
> +	switch (field) {
> +	case F2FS_EXTRA_ATTR_TOTAL_SIZE:
> +	case F2FS_EXTRA_ATTR_ISIZE:
> +	case F2FS_EXTRA_ATTR_INLINE_XATTR_SIZE:
> +		return true;
> +	case F2FS_EXTRA_ATTR_PROJID:
> +		if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_projid))
> +			return false;
> +		return true;
> +	case F2FS_EXTRA_ATTR_INODE_CHKSUM:
> +		if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_inode_checksum))
> +			return false;
> +		return true;
> +	case F2FS_EXTRA_ATTR_CRTIME:
> +		if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime))
> +			return false;
> +		return true;
> +	case F2FS_EXTRA_ATTR_COMPR_BLOCKS:
> +	case F2FS_EXTRA_ATTR_COMPR_OPTION:
> +		if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_compr_blocks))
> +			return false;
> +		return true;
> +	default:
> +		BUG_ON(1);
> +		return false;
> +	}
> +}
> +
> +static int f2fs_ioc_get_extra_attr(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_extra_attr attr;
> +	u32 chksum;
> +	int ret = 0;
> +
> +	if (!f2fs_has_extra_attr(inode))
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
> +		return -EFAULT;
> +
> +	if (attr.field >= F2FS_EXTRA_ATTR_MAX)
> +		return -EINVAL;
> +
> +	if (!extra_attr_fits_in_inode(inode, attr.field))
> +		return -EOPNOTSUPP;
> +
> +	switch (attr.field) {
> +	case F2FS_EXTRA_ATTR_TOTAL_SIZE:
> +		attr.attr = F2FS_TOTAL_EXTRA_ATTR_SIZE;
> +		break;
> +	case F2FS_EXTRA_ATTR_ISIZE:
> +		attr.attr = fi->i_extra_isize;
> +		break;
> +	case F2FS_EXTRA_ATTR_INLINE_XATTR_SIZE:
> +		if (!f2fs_has_inline_xattr(inode))
> +			return -EOPNOTSUPP;
> +		attr.attr = get_inline_xattr_addrs(inode);
> +		break;
> +	case F2FS_EXTRA_ATTR_PROJID:
> +		if (!f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
> +			return -EOPNOTSUPP;
> +		attr.attr = from_kprojid(&init_user_ns, fi->i_projid);
> +		break;
> +	case F2FS_EXTRA_ATTR_INODE_CHKSUM:
> +		ret = f2fs_inode_chksum_get(sbi, inode, &chksum);
> +		if (ret)
> +			return ret;
> +		attr.attr = chksum;
> +		break;
> +	case F2FS_EXTRA_ATTR_CRTIME:
> +		if (!f2fs_sb_has_inode_crtime(sbi))
> +			return -EOPNOTSUPP;
> +		if (attr.attr_size == sizeof(struct timespec64)) {
> +			if (put_timespec64(&fi->i_crtime,
> +					(void __user *)(uintptr_t)attr.attr))
> +				return -EFAULT;
> +		} else if (attr.attr_size == sizeof(struct old_timespec32)) {
> +			if (put_old_timespec32(&fi->i_crtime,
> +					(void __user *)(uintptr_t)attr.attr))
> +				return -EFAULT;
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
> +	case F2FS_EXTRA_ATTR_COMPR_BLOCKS:
> +		if (attr.attr_size != sizeof(__u64))
> +			return -EINVAL;
> +		ret = f2fs_get_compress_blocks(inode, &attr.attr);
> +		break;
> +	case F2FS_EXTRA_ATTR_COMPR_OPTION:
> +		ret = f2fs_ioc_get_compress_option(filp, attr.attr);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_to_user((void __user *)arg, &attr, sizeof(attr)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int f2fs_ioc_set_extra_attr(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_extra_attr attr;
> +	struct page *ipage;
> +	void *inline_addr;
> +	int ret;
> +
> +	if (!f2fs_has_extra_attr(inode))
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
> +		return -EFAULT;
> +
> +	if (attr.field >= F2FS_EXTRA_ATTR_MAX)
> +		return -EINVAL;
> +
> +	if (!extra_attr_fits_in_inode(inode, attr.field))
> +		return -EOPNOTSUPP;
> +
> +	switch (attr.field) {
> +	case F2FS_EXTRA_ATTR_TOTAL_SIZE:
> +	case F2FS_EXTRA_ATTR_ISIZE:
> +	case F2FS_EXTRA_ATTR_PROJID:
> +	case F2FS_EXTRA_ATTR_INODE_CHKSUM:
> +	case F2FS_EXTRA_ATTR_CRTIME:
> +	case F2FS_EXTRA_ATTR_COMPR_BLOCKS:
> +		/* read only attribtues */
> +		return -EOPNOTSUPP;
> +	case F2FS_EXTRA_ATTR_INLINE_XATTR_SIZE:
> +		if (!f2fs_sb_has_flexible_inline_xattr(sbi) ||
> +		    !f2fs_has_inline_xattr(inode))
> +			return -EOPNOTSUPP;
> +		if (attr.attr < MIN_INLINE_XATTR_SIZE ||
> +		    attr.attr > MAX_INLINE_XATTR_SIZE)
> +			return -EINVAL;
> +		inode_lock(inode);
> +		f2fs_lock_op(sbi);
> +		f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);
> +		if (i_size_read(inode) || F2FS_I(inode)->i_xattr_nid) {
> +			/*
> +			 * it is not allowed to set this field if the inode
> +			 * has data or xattr node
> +			 */
> +			ret = -EFBIG;
> +			goto xattr_out_unlock;
> +		}
> +		ipage = f2fs_get_node_page(sbi, inode->i_ino);
> +		if (IS_ERR(ipage)) {
> +			ret = PTR_ERR(ipage);
> +			goto xattr_out_unlock;
> +		}
> +		inline_addr = inline_xattr_addr(inode, ipage);
> +		if (!IS_XATTR_LAST_ENTRY(XATTR_FIRST_ENTRY(inline_addr))) {
> +			ret = -EFBIG;
> +		} else {
> +			struct f2fs_xattr_header *hdr;
> +			struct f2fs_xattr_entry *ent;
> +
> +			F2FS_I(inode)->i_inline_xattr_size = (int)attr.attr;
> +			inline_addr = inline_xattr_addr(inode, ipage);
> +			hdr = XATTR_HDR(inline_addr);
> +			ent = XATTR_FIRST_ENTRY(inline_addr);
> +			hdr->h_magic = cpu_to_le32(F2FS_XATTR_MAGIC);
> +			hdr->h_refcount = cpu_to_le32(1);
> +			memset(ent, 0, attr.attr - sizeof(*hdr));
> +			set_page_dirty(ipage);
> +			ret = 0;
> +		}
> +		f2fs_put_page(ipage, 1);
> +xattr_out_unlock:
> +		f2fs_up_write(&F2FS_I(inode)->i_xattr_sem);
> +		f2fs_unlock_op(sbi);
> +		inode_unlock(inode);
> +		if (!ret)
> +			f2fs_balance_fs(sbi, true);
> +		break;
> +	case F2FS_EXTRA_ATTR_COMPR_OPTION:
> +		ret = f2fs_ioc_set_compress_option(filp, attr.attr);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	switch (cmd) {
> @@ -4265,6 +4466,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_decompress_file(filp);
>  	case F2FS_IOC_COMPRESS_FILE:
>  		return f2fs_ioc_compress_file(filp);
> +	case F2FS_IOC_GET_EXTRA_ATTR:
> +		return f2fs_ioc_get_extra_attr(filp, arg);
> +	case F2FS_IOC_SET_EXTRA_ATTR:
> +		return f2fs_ioc_set_extra_attr(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 955d440be1046..2b53e90421bfc 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -43,6 +43,10 @@
>  #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
>  #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
>  #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
> +#define F2FS_IOC_GET_EXTRA_ATTR		_IOR(F2FS_IOCTL_MAGIC, 26,	\
> +						struct f2fs_extra_attr)
> +#define F2FS_IOC_SET_EXTRA_ATTR		_IOW(F2FS_IOCTL_MAGIC, 27,	\
> +						struct f2fs_extra_attr)
>  
>  /*
>   * should be same as XFS_IOC_GOINGDOWN.
> @@ -96,4 +100,25 @@ struct f2fs_comp_option {
>  	__u8 log_cluster_size;
>  };
>  
> +enum {
> +	F2FS_EXTRA_ATTR_TOTAL_SIZE,		/* ro, size of extra attr area */
> +	F2FS_EXTRA_ATTR_ISIZE,			/* ro, i_extra_isize */
> +	F2FS_EXTRA_ATTR_INLINE_XATTR_SIZE,	/* rw, i_inline_xattr_size */
> +	F2FS_EXTRA_ATTR_PROJID,			/* ro, i_projid */
> +	F2FS_EXTRA_ATTR_INODE_CHKSUM,		/* ro, i_inode_chksum */
> +	F2FS_EXTRA_ATTR_CRTIME,			/* ro, i_crtime, i_crtime_nsec */
> +	F2FS_EXTRA_ATTR_COMPR_BLOCKS,		/* ro, i_compr_blocks */
> +	F2FS_EXTRA_ATTR_COMPR_OPTION,		/* rw, i_compress_algorithm,
> +						 *     i_log_cluster_size
> +						 */
> +	F2FS_EXTRA_ATTR_MAX,
> +};
> +
> +struct f2fs_extra_attr {
> +	__u8 field;		/* F2FS_EXTRA_ATTR_* */
> +	__u8 rsvd1;
> +	__u16 attr_size;	/* size of @attr */
> +	__u32 rsvd2;
> +	__u64 attr;		/* attr value or pointer */
> +};
>  #endif /* _UAPI_LINUX_F2FS_H */
> -- 
> 2.40.1
