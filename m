Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4477E62D07B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiKQBNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiKQBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:13:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A9EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D097E61F9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E33DC433C1;
        Thu, 17 Nov 2022 01:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668647602;
        bh=xrYFQTBRincEisQpqGWY9rArKXZeD0BrfQ2nhgkK7m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVuFM8F5eD5SV5Y+zI+YsJk7Kn/eyIoLkwWwr+T1P2YlYcfcdbF/vGoSU8VSUFVAc
         9ih104bO6k/mBV0Itn2m4MhgUTwPSo1nI0SJPcIiv/oICg6iPJZ4VioZL8fjs2dPGr
         9VTsA4UJs1kDWEHz1OCEtxL5YdqRI639XaD2t/IhOgsjhpmFjz7Y7JPlaR7DvZnNmS
         YFWLoYRlDULDqCUy/8EAMUYMp4oKpSs3vjM57CQFsLTpVFSynq2Xgl/8rX7xtRRJuC
         ry4CN9fb1nNeMnMQMzoznumUjYYl1ogrf2BkgnsA/6s4ZOiTsEwgkBYSiDWPT1DcsS
         /AKiJOjv5+YnA==
Date:   Wed, 16 Nov 2022 17:13:20 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] f2fs: fix to enable compress for newly created file
 if extension matches
Message-ID: <Y3WKsDGshDGxYUxr@google.com>
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com>
 <Y3QaDU2n34nmPaiD@google.com>
 <07dfc677-eecf-ed92-5f82-4753b1f2ba6b@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dfc677-eecf-ed92-5f82-4753b1f2ba6b@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16, Sheng Yong wrote:
> 
> 
> On 2022/11/16 7:00, Jaegeuk Kim wrote:
> > If compress_extension is set, and a newly created file matches the
> > extension, the file could be marked as compression file. However,
> > if inline_data is also enabled, there is no chance to check its
> > extension since f2fs_should_compress() always returns false.
> > 
> > This patch moves set_compress_inode(), which do extension check, in
> > f2fs_should_compress() to check extensions before setting inline
> > data flag.
> > 
> > Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> > Signed-off-by: Sheng Yong <shengyong@oppo.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > 
> >   Checking this version.
> > 
> >   fs/f2fs/f2fs.h  |   2 +-
> >   fs/f2fs/namei.c | 328 ++++++++++++++++++++++++------------------------
> >   2 files changed, 163 insertions(+), 167 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index b89b5d755ce0..dedac413bf64 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2980,7 +2980,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
> >   /* Flags that should be inherited by new inodes from their parent. */
> >   #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
> >   			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> > -			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL)
> > +			   F2FS_CASEFOLD_FL)
> >   /* Flags that are appropriate for regular files (all but dir-specific ones). */
> >   #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index e104409c3a0e..cb7441a19d22 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -22,8 +22,161 @@
> >   #include "acl.h"
> >   #include <trace/events/f2fs.h>
> > +static inline int is_extension_exist(const unsigned char *s, const char *sub,
> > +						bool tmp_ext)
> > +{
> > +	size_t slen = strlen(s);
> > +	size_t sublen = strlen(sub);
> > +	int i;
> > +
> > +	if (sublen == 1 && *sub == '*')
> > +		return 1;
> > +
> > +	/*
> > +	 * filename format of multimedia file should be defined as:
> > +	 * "filename + '.' + extension + (optional: '.' + temp extension)".
> > +	 */
> > +	if (slen < sublen + 2)
> > +		return 0;
> > +
> > +	if (!tmp_ext) {
> > +		/* file has no temp extension */
> > +		if (s[slen - sublen - 1] != '.')
> > +			return 0;
> > +		return !strncasecmp(s + slen - sublen, sub, sublen);
> > +	}
> > +
> > +	for (i = 1; i < slen - sublen; i++) {
> > +		if (s[i] != '.')
> > +			continue;
> > +		if (!strncasecmp(s + i + 1, sub, sublen))
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> > +							bool hot, bool set)
> > +{
> > +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> > +	int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> > +	int hot_count = sbi->raw_super->hot_ext_count;
> > +	int total_count = cold_count + hot_count;
> > +	int start, count;
> > +	int i;
> > +
> > +	if (set) {
> > +		if (total_count == F2FS_MAX_EXTENSION)
> > +			return -EINVAL;
> > +	} else {
> > +		if (!hot && !cold_count)
> > +			return -EINVAL;
> > +		if (hot && !hot_count)
> > +			return -EINVAL;
> > +	}
> > +
> > +	if (hot) {
> > +		start = cold_count;
> > +		count = total_count;
> > +	} else {
> > +		start = 0;
> > +		count = cold_count;
> > +	}
> > +
> > +	for (i = start; i < count; i++) {
> > +		if (strcmp(name, extlist[i]))
> > +			continue;
> > +
> > +		if (set)
> > +			return -EINVAL;
> > +
> > +		memcpy(extlist[i], extlist[i + 1],
> > +				F2FS_EXTENSION_LEN * (total_count - i - 1));
> > +		memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
> > +		if (hot)
> > +			sbi->raw_super->hot_ext_count = hot_count - 1;
> > +		else
> > +			sbi->raw_super->extension_count =
> > +						cpu_to_le32(cold_count - 1);
> > +		return 0;
> > +	}
> > +
> > +	if (!set)
> > +		return -EINVAL;
> > +
> > +	if (hot) {
> > +		memcpy(extlist[count], name, strlen(name));
> > +		sbi->raw_super->hot_ext_count = hot_count + 1;
> > +	} else {
> > +		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
> > +
> > +		memcpy(buf, &extlist[cold_count],
> > +				F2FS_EXTENSION_LEN * hot_count);
> > +		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
> > +		memcpy(extlist[cold_count], name, strlen(name));
> > +		memcpy(&extlist[cold_count + 1], buf,
> > +				F2FS_EXTENSION_LEN * hot_count);
> > +		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
> > +				struct inode *inode, const unsigned char *name)
> > +{
> > +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> > +	unsigned char (*noext)[F2FS_EXTENSION_LEN] =
> > +						F2FS_OPTION(sbi).noextensions;
> > +	unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
> > +	unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> > +	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> > +	int i, cold_count, hot_count;
> > +
> > +	/* Caller should give the name of regular file or directory. */
> > +	if (!f2fs_sb_has_compression(sbi) || !name)
> > +		return;
> > +
> > +	if (S_ISDIR(inode->i_mode))
> > +		goto inherit_comp;
> > +
> > +	/* Don't compress hot files. */
> > +	f2fs_down_read(&sbi->sb_lock);
> > +	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> > +	hot_count = sbi->raw_super->hot_ext_count;
> > +	for (i = cold_count; i < cold_count + hot_count; i++)
> > +		if (is_extension_exist(name, extlist[i], false))
> > +			break;
> > +	f2fs_up_read(&sbi->sb_lock);
> > +	if (i < (cold_count + hot_count))
> > +		return;
> > +
> > +	/* Don't compress unallowed extension. */
> > +	for (i = 0; i < noext_cnt; i++)
> > +		if (is_extension_exist(name, noext[i], false))
> > +			return;
> > +inherit_comp:
> > +	/* Inherit the {no-}compression flag in directory */
> > +	if (F2FS_I(dir)->i_flags & F2FS_NOCOMP_FL) {
> > +		F2FS_I(inode)->i_flags |= F2FS_NOCOMP_FL;
> > +		return;
> 
> Hi, Jaegeuk,
> It should not return immediately here. The scenario here is:
> 
>   mount -o compress_extension=txt,compress_mode=user
>   mkdir dir
>   f2fs_io setflags nocompression dir # set dir nocompression
>   touch dir/file.txt
>   f2fs_io getflags compression dir/file.txt # file.txt should have
> compression flag

I see. Sent out v4.

> 
> According to f2fs.rst, if dir is set as nocompression, but file's
> extension hit compress_extension, then the file should be compressed.
> And before set_compress_context later, F2FS_NOCOMP_FL should be
> cleared first.
> 
> thanks,
> shengyong
> 
> > +	} else if (F2FS_I(dir)->i_flags & F2FS_COMPR_FL) {
> > +		set_compress_context(inode);
> > +		return;
> > +	}
> > +
> > +	/* Compress wanting extension. */
> > +	for (i = 0; i < ext_cnt; i++) {
> > +		if (is_extension_exist(name, ext[i], false)) {
> > +			set_compress_context(inode);
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> >   static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
> > -						struct inode *dir, umode_t mode)
> > +						struct inode *dir, umode_t mode,
> > +						const char *name)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> >   	nid_t ino;
> > @@ -114,12 +267,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
> >   	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
> >   		set_inode_flag(inode, FI_PROJ_INHERIT);
> > -	if (f2fs_sb_has_compression(sbi)) {
> > -		/* Inherit the compression flag in directory */
> > -		if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
> > -					f2fs_may_compress(inode))
> > -			set_compress_context(inode);
> > -	}
> > +	/* Check compression first. */
> > +	set_compress_new_inode(sbi, dir, inode, name);
> >   	/* Should enable inline_data after compression set */
> >   	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
> > @@ -153,40 +302,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
> >   	return ERR_PTR(err);
> >   }
> > -static inline int is_extension_exist(const unsigned char *s, const char *sub,
> > -						bool tmp_ext)
> > -{
> > -	size_t slen = strlen(s);
> > -	size_t sublen = strlen(sub);
> > -	int i;
> > -
> > -	if (sublen == 1 && *sub == '*')
> > -		return 1;
> > -
> > -	/*
> > -	 * filename format of multimedia file should be defined as:
> > -	 * "filename + '.' + extension + (optional: '.' + temp extension)".
> > -	 */
> > -	if (slen < sublen + 2)
> > -		return 0;
> > -
> > -	if (!tmp_ext) {
> > -		/* file has no temp extension */
> > -		if (s[slen - sublen - 1] != '.')
> > -			return 0;
> > -		return !strncasecmp(s + slen - sublen, sub, sublen);
> > -	}
> > -
> > -	for (i = 1; i < slen - sublen; i++) {
> > -		if (s[i] != '.')
> > -			continue;
> > -		if (!strncasecmp(s + i + 1, sub, sublen))
> > -			return 1;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >   /*
> >    * Set file's temperature for hot/cold data separation
> >    */
> > @@ -217,124 +332,6 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
> >   		file_set_hot(inode);
> >   }
> > -int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> > -							bool hot, bool set)
> > -{
> > -	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> > -	int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> > -	int hot_count = sbi->raw_super->hot_ext_count;
> > -	int total_count = cold_count + hot_count;
> > -	int start, count;
> > -	int i;
> > -
> > -	if (set) {
> > -		if (total_count == F2FS_MAX_EXTENSION)
> > -			return -EINVAL;
> > -	} else {
> > -		if (!hot && !cold_count)
> > -			return -EINVAL;
> > -		if (hot && !hot_count)
> > -			return -EINVAL;
> > -	}
> > -
> > -	if (hot) {
> > -		start = cold_count;
> > -		count = total_count;
> > -	} else {
> > -		start = 0;
> > -		count = cold_count;
> > -	}
> > -
> > -	for (i = start; i < count; i++) {
> > -		if (strcmp(name, extlist[i]))
> > -			continue;
> > -
> > -		if (set)
> > -			return -EINVAL;
> > -
> > -		memcpy(extlist[i], extlist[i + 1],
> > -				F2FS_EXTENSION_LEN * (total_count - i - 1));
> > -		memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
> > -		if (hot)
> > -			sbi->raw_super->hot_ext_count = hot_count - 1;
> > -		else
> > -			sbi->raw_super->extension_count =
> > -						cpu_to_le32(cold_count - 1);
> > -		return 0;
> > -	}
> > -
> > -	if (!set)
> > -		return -EINVAL;
> > -
> > -	if (hot) {
> > -		memcpy(extlist[count], name, strlen(name));
> > -		sbi->raw_super->hot_ext_count = hot_count + 1;
> > -	} else {
> > -		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
> > -
> > -		memcpy(buf, &extlist[cold_count],
> > -				F2FS_EXTENSION_LEN * hot_count);
> > -		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
> > -		memcpy(extlist[cold_count], name, strlen(name));
> > -		memcpy(&extlist[cold_count + 1], buf,
> > -				F2FS_EXTENSION_LEN * hot_count);
> > -		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
> > -	}
> > -	return 0;
> > -}
> > -
> > -static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
> > -						const unsigned char *name)
> > -{
> > -	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> > -	unsigned char (*noext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).noextensions;
> > -	unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
> > -	unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> > -	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> > -	int i, cold_count, hot_count;
> > -
> > -	if (!f2fs_sb_has_compression(sbi) ||
> > -			F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
> > -			!f2fs_may_compress(inode) ||
> > -			(!ext_cnt && !noext_cnt))
> > -		return;
> > -
> > -	f2fs_down_read(&sbi->sb_lock);
> > -
> > -	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> > -	hot_count = sbi->raw_super->hot_ext_count;
> > -
> > -	for (i = cold_count; i < cold_count + hot_count; i++) {
> > -		if (is_extension_exist(name, extlist[i], false)) {
> > -			f2fs_up_read(&sbi->sb_lock);
> > -			return;
> > -		}
> > -	}
> > -
> > -	f2fs_up_read(&sbi->sb_lock);
> > -
> > -	for (i = 0; i < noext_cnt; i++) {
> > -		if (is_extension_exist(name, noext[i], false)) {
> > -			f2fs_disable_compressed_file(inode);
> > -			return;
> > -		}
> > -	}
> > -
> > -	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
> > -		return;
> > -
> > -	for (i = 0; i < ext_cnt; i++) {
> > -		if (!is_extension_exist(name, ext[i], false))
> > -			continue;
> > -
> > -		/* Do not use inline_data with compression */
> > -		stat_dec_inline_inode(inode);
> > -		clear_inode_flag(inode, FI_INLINE_DATA);
> > -		set_compress_context(inode);
> > -		return;
> > -	}
> > -}
> > -
> >   static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
> >   		       struct dentry *dentry, umode_t mode, bool excl)
> >   {
> > @@ -352,15 +349,13 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (err)
> >   		return err;
> > -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> > +	inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
> >   	if (IS_ERR(inode))
> >   		return PTR_ERR(inode);
> >   	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
> >   		set_file_temperature(sbi, inode, dentry->d_name.name);
> > -	set_compress_inode(sbi, inode, dentry->d_name.name);
> > -
> >   	inode->i_op = &f2fs_file_inode_operations;
> >   	inode->i_fop = &f2fs_file_operations;
> >   	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> > @@ -689,7 +684,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (err)
> >   		return err;
> > -	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
> > +	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
> >   	if (IS_ERR(inode))
> >   		return PTR_ERR(inode);
> > @@ -760,7 +755,8 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (err)
> >   		return err;
> > -	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
> > +	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode,
> > +						dentry->d_name.name);
> >   	if (IS_ERR(inode))
> >   		return PTR_ERR(inode);
> > @@ -817,7 +813,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (err)
> >   		return err;
> > -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> > +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
> >   	if (IS_ERR(inode))
> >   		return PTR_ERR(inode);
> > @@ -856,7 +852,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (err)
> >   		return err;
> > -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> > +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
> >   	if (IS_ERR(inode))
> >   		return PTR_ERR(inode);
