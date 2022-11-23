Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536463627B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbiKWOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiKWOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:54:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA27108A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EABFB8206C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F5C433D6;
        Wed, 23 Nov 2022 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215290;
        bh=x8TRCD15W8raBCtLcxy0LC3XaF3FUYthewCmjatw1NE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uXGi9Z2E/2/XGPTfQTdBT0v89ZymcF/nTkEmXTbQBVBwwTdtTfySexfIxdfxdyRCb
         4Anb8sNTbUmwBR31shc1lleAyBVgwteUpi1xI4/HhLgwgAxuBpiZhNPavVfEIXzd9m
         DO2V136tK+c1Wd/k/NSKRIRIUfY0or7hef/6ZLxa3gGEajzRf0OFKOvTJX9hmkgw5I
         y/pfGG6Ii5JIpKGsEPM3soNcxb10y3DgVaNAGw/cT89zZeSYreOFnB0nrzfmN4wTZ9
         F1MOuY9XXG1XgJh5Fpa8lhCbHiRUaVytQ403JdyW1AvqPZ9Yw5X4JECAetV33NsUZD
         +4wD++hfSiucg==
Message-ID: <cc76bc01-b1c8-e52d-02f0-daaae81306f1@kernel.org>
Date:   Wed, 23 Nov 2022 22:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] f2fs: fix to enable compress for newly created file if
 extension matches
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com> <Y3WKmvpz61K9pwqO@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y3WKmvpz61K9pwqO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/17 9:12, Jaegeuk Kim wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> This patch moves set_compress_inode(), which do extension check, in
> f2fs_should_compress() to check extensions before setting inline
> data flag.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/f2fs.h  |   2 +-
>   fs/f2fs/namei.c | 325 +++++++++++++++++++++++-------------------------
>   2 files changed, 160 insertions(+), 167 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b89b5d755ce0..dedac413bf64 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2980,7 +2980,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>   /* Flags that should be inherited by new inodes from their parent. */
>   #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
>   			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> -			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL)
> +			   F2FS_CASEFOLD_FL)
>   
>   /* Flags that are appropriate for regular files (all but dir-specific ones). */
>   #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e104409c3a0e..c25009bb72f2 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -22,8 +22,158 @@
>   #include "acl.h"
>   #include <trace/events/f2fs.h>
>   
> +static inline int is_extension_exist(const unsigned char *s, const char *sub,
> +						bool tmp_ext)
> +{
> +	size_t slen = strlen(s);
> +	size_t sublen = strlen(sub);
> +	int i;
> +
> +	if (sublen == 1 && *sub == '*')
> +		return 1;
> +
> +	/*
> +	 * filename format of multimedia file should be defined as:
> +	 * "filename + '.' + extension + (optional: '.' + temp extension)".
> +	 */
> +	if (slen < sublen + 2)
> +		return 0;
> +
> +	if (!tmp_ext) {
> +		/* file has no temp extension */
> +		if (s[slen - sublen - 1] != '.')
> +			return 0;
> +		return !strncasecmp(s + slen - sublen, sub, sublen);
> +	}
> +
> +	for (i = 1; i < slen - sublen; i++) {
> +		if (s[i] != '.')
> +			continue;
> +		if (!strncasecmp(s + i + 1, sub, sublen))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> +							bool hot, bool set)
> +{
> +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> +	int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> +	int hot_count = sbi->raw_super->hot_ext_count;
> +	int total_count = cold_count + hot_count;
> +	int start, count;
> +	int i;
> +
> +	if (set) {
> +		if (total_count == F2FS_MAX_EXTENSION)
> +			return -EINVAL;
> +	} else {
> +		if (!hot && !cold_count)
> +			return -EINVAL;
> +		if (hot && !hot_count)
> +			return -EINVAL;
> +	}
> +
> +	if (hot) {
> +		start = cold_count;
> +		count = total_count;
> +	} else {
> +		start = 0;
> +		count = cold_count;
> +	}
> +
> +	for (i = start; i < count; i++) {
> +		if (strcmp(name, extlist[i]))
> +			continue;
> +
> +		if (set)
> +			return -EINVAL;
> +
> +		memcpy(extlist[i], extlist[i + 1],
> +				F2FS_EXTENSION_LEN * (total_count - i - 1));
> +		memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
> +		if (hot)
> +			sbi->raw_super->hot_ext_count = hot_count - 1;
> +		else
> +			sbi->raw_super->extension_count =
> +						cpu_to_le32(cold_count - 1);
> +		return 0;
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	if (hot) {
> +		memcpy(extlist[count], name, strlen(name));
> +		sbi->raw_super->hot_ext_count = hot_count + 1;
> +	} else {
> +		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
> +
> +		memcpy(buf, &extlist[cold_count],
> +				F2FS_EXTENSION_LEN * hot_count);
> +		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
> +		memcpy(extlist[cold_count], name, strlen(name));
> +		memcpy(&extlist[cold_count + 1], buf,
> +				F2FS_EXTENSION_LEN * hot_count);
> +		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
> +	}
> +	return 0;
> +}
> +
> +static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
> +				struct inode *inode, const unsigned char *name)
> +{
> +	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> +	unsigned char (*noext)[F2FS_EXTENSION_LEN] =
> +						F2FS_OPTION(sbi).noextensions;
> +	unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
> +	unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> +	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> +	int i, cold_count, hot_count;
> +
> +	/* Caller should give the name of regular file or directory. */
> +	if (!f2fs_sb_has_compression(sbi) || !name)
> +		return;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		goto inherit_comp;

Documentation/filesystems/f2fs.rst

- Priority in between FS_COMPR_FL, FS_NOCOMP_FS, extensions:

   * compress_extension=so; nocompress_extension=zip; chattr +c dir; touch
     dir/foo.so; touch dir/bar.zip; touch dir/baz.txt; then foo.so and baz.txt
     should be compresse, bar.zip should be non-compressed. chattr +c dir/bar.zip
     can enable compress on bar.zip.

It looks nocompress_extension has higher priority than flag inheriting?

> +
> +	/* Don't compress hot files. */
> +	f2fs_down_read(&sbi->sb_lock);
> +	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> +	hot_count = sbi->raw_super->hot_ext_count;
> +	for (i = cold_count; i < cold_count + hot_count; i++)
> +		if (is_extension_exist(name, extlist[i], false))
> +			break;
> +	f2fs_up_read(&sbi->sb_lock);
> +	if (i < (cold_count + hot_count))
> +		return;
> +
> +	/* Don't compress unallowed extension. */
> +	for (i = 0; i < noext_cnt; i++)
> +		if (is_extension_exist(name, noext[i], false))
> +			return;
> +
> +	/* Compress wanting extension. */
> +	for (i = 0; i < ext_cnt; i++) {
> +		if (is_extension_exist(name, ext[i], false)) {
> +			set_compress_context(inode);
> +			return;
> +		}
> +	}
> +inherit_comp:
> +	/* Inherit the {no-}compression flag in directory */
> +	if (F2FS_I(dir)->i_flags & F2FS_NOCOMP_FL)
> +		F2FS_I(inode)->i_flags |= F2FS_NOCOMP_FL;

f2fs_mark_inode_dirty_sync(, true)?

> +	else if (F2FS_I(dir)->i_flags & F2FS_COMPR_FL)
> +		set_compress_context(inode);
> +}
> +
>   static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
> -						struct inode *dir, umode_t mode)
> +						struct inode *dir, umode_t mode,
> +						const char *name)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>   	nid_t ino;
> @@ -114,12 +264,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>   	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
>   		set_inode_flag(inode, FI_PROJ_INHERIT);
>   
> -	if (f2fs_sb_has_compression(sbi)) {
> -		/* Inherit the compression flag in directory */
> -		if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
> -					f2fs_may_compress(inode))
> -			set_compress_context(inode);
> -	}
> +	/* Check compression first. */
> +	set_compress_new_inode(sbi, dir, inode, name);
>   
>   	/* Should enable inline_data after compression set */
>   	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
> @@ -153,40 +299,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>   	return ERR_PTR(err);
>   }
>   
> -static inline int is_extension_exist(const unsigned char *s, const char *sub,
> -						bool tmp_ext)
> -{
> -	size_t slen = strlen(s);
> -	size_t sublen = strlen(sub);
> -	int i;
> -
> -	if (sublen == 1 && *sub == '*')
> -		return 1;
> -
> -	/*
> -	 * filename format of multimedia file should be defined as:
> -	 * "filename + '.' + extension + (optional: '.' + temp extension)".
> -	 */
> -	if (slen < sublen + 2)
> -		return 0;
> -
> -	if (!tmp_ext) {
> -		/* file has no temp extension */
> -		if (s[slen - sublen - 1] != '.')
> -			return 0;
> -		return !strncasecmp(s + slen - sublen, sub, sublen);
> -	}
> -
> -	for (i = 1; i < slen - sublen; i++) {
> -		if (s[i] != '.')
> -			continue;
> -		if (!strncasecmp(s + i + 1, sub, sublen))
> -			return 1;
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * Set file's temperature for hot/cold data separation
>    */
> @@ -217,124 +329,6 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
>   		file_set_hot(inode);
>   }
>   
> -int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> -							bool hot, bool set)
> -{
> -	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> -	int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> -	int hot_count = sbi->raw_super->hot_ext_count;
> -	int total_count = cold_count + hot_count;
> -	int start, count;
> -	int i;
> -
> -	if (set) {
> -		if (total_count == F2FS_MAX_EXTENSION)
> -			return -EINVAL;
> -	} else {
> -		if (!hot && !cold_count)
> -			return -EINVAL;
> -		if (hot && !hot_count)
> -			return -EINVAL;
> -	}
> -
> -	if (hot) {
> -		start = cold_count;
> -		count = total_count;
> -	} else {
> -		start = 0;
> -		count = cold_count;
> -	}
> -
> -	for (i = start; i < count; i++) {
> -		if (strcmp(name, extlist[i]))
> -			continue;
> -
> -		if (set)
> -			return -EINVAL;
> -
> -		memcpy(extlist[i], extlist[i + 1],
> -				F2FS_EXTENSION_LEN * (total_count - i - 1));
> -		memset(extlist[total_count - 1], 0, F2FS_EXTENSION_LEN);
> -		if (hot)
> -			sbi->raw_super->hot_ext_count = hot_count - 1;
> -		else
> -			sbi->raw_super->extension_count =
> -						cpu_to_le32(cold_count - 1);
> -		return 0;
> -	}
> -
> -	if (!set)
> -		return -EINVAL;
> -
> -	if (hot) {
> -		memcpy(extlist[count], name, strlen(name));
> -		sbi->raw_super->hot_ext_count = hot_count + 1;
> -	} else {
> -		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
> -
> -		memcpy(buf, &extlist[cold_count],
> -				F2FS_EXTENSION_LEN * hot_count);
> -		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
> -		memcpy(extlist[cold_count], name, strlen(name));
> -		memcpy(&extlist[cold_count + 1], buf,
> -				F2FS_EXTENSION_LEN * hot_count);
> -		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
> -	}
> -	return 0;
> -}
> -
> -static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
> -						const unsigned char *name)
> -{
> -	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
> -	unsigned char (*noext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).noextensions;
> -	unsigned char (*ext)[F2FS_EXTENSION_LEN] = F2FS_OPTION(sbi).extensions;
> -	unsigned char ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> -	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> -	int i, cold_count, hot_count;
> -
> -	if (!f2fs_sb_has_compression(sbi) ||
> -			F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
> -			!f2fs_may_compress(inode) ||
> -			(!ext_cnt && !noext_cnt))
> -		return;
> -
> -	f2fs_down_read(&sbi->sb_lock);
> -
> -	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> -	hot_count = sbi->raw_super->hot_ext_count;
> -
> -	for (i = cold_count; i < cold_count + hot_count; i++) {
> -		if (is_extension_exist(name, extlist[i], false)) {
> -			f2fs_up_read(&sbi->sb_lock);
> -			return;
> -		}
> -	}
> -
> -	f2fs_up_read(&sbi->sb_lock);
> -
> -	for (i = 0; i < noext_cnt; i++) {
> -		if (is_extension_exist(name, noext[i], false)) {
> -			f2fs_disable_compressed_file(inode);
> -			return;
> -		}
> -	}
> -
> -	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
> -		return;
> -
> -	for (i = 0; i < ext_cnt; i++) {
> -		if (!is_extension_exist(name, ext[i], false))
> -			continue;
> -
> -		/* Do not use inline_data with compression */
> -		stat_dec_inline_inode(inode);
> -		clear_inode_flag(inode, FI_INLINE_DATA);
> -		set_compress_context(inode);
> -		return;
> -	}
> -}
> -
>   static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>   		       struct dentry *dentry, umode_t mode, bool excl)
>   {
> @@ -352,15 +346,13 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>   	if (err)
>   		return err;
>   
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
>   	if (IS_ERR(inode))
>   		return PTR_ERR(inode);
>   
>   	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
>   		set_file_temperature(sbi, inode, dentry->d_name.name);
>   
> -	set_compress_inode(sbi, inode, dentry->d_name.name);
> -
>   	inode->i_op = &f2fs_file_inode_operations;
>   	inode->i_fop = &f2fs_file_operations;
>   	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> @@ -689,7 +681,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>   	if (err)
>   		return err;
>   
> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
>   	if (IS_ERR(inode))
>   		return PTR_ERR(inode);
>   
> @@ -760,7 +752,8 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   	if (err)
>   		return err;
>   
> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode,
> +						dentry->d_name.name);

Why we need to pass directory's name to set_compress_new_inode()?

Could we just check S_IFDIR in child inode?

Thanks,

>   	if (IS_ERR(inode))
>   		return PTR_ERR(inode);
>   
> @@ -817,7 +810,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>   	if (err)
>   		return err;
>   
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>   	if (IS_ERR(inode))
>   		return PTR_ERR(inode);
>   
> @@ -856,7 +849,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>   	if (err)
>   		return err;
>   
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>   	if (IS_ERR(inode))
>   		return PTR_ERR(inode);
>   
