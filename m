Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C855BD8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiITA4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiITA4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:56:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC891156
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 673C2B81DF8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF58C433C1;
        Tue, 20 Sep 2022 00:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663635407;
        bh=3bqIncGQwuSUvaM97RMErCT63FB5S2Jz7uQPJg5tEhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okg9K9OIIjb/0dAJrs8Dy+QRQl6/8RlnvFVNBg3+bXeQ/kXEhx92/MJXcfa8ipHYC
         KY5XPVIxd5Z4FfYpagbLHt4J+qGVxKGUKFj/nD+gp5KrdUflRb8eFhH7PxjtOpfx2t
         n4AnUYSFT2+9ykX7AhXI0ykmb3HG4vkScfp5wJU6CZO3k1n69U29Df9DvnMVGJHy2r
         sMToYHTSUQ5IyHCpjHFHV5AAatua4eapar8mSY6qMOocvLgI4KMGm93x+EQhiVT7/Y
         D4QsPw8QT8FD76pG2h0jOCKaV2U+VQxTrecG9/wk4Xhhz6rpZhOHFjODYsFSH78v7J
         lHhLuy0T9Nq9Q==
Date:   Mon, 19 Sep 2022 17:56:45 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] f2fs: record need_fsck in super_block
Message-ID: <YykPzeC4lk+F/U/2@google.com>
References: <20220913135919.2445544-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913135919.2445544-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13, Chao Yu wrote:
> Once CP_ERROR_FLAG is set, checkpoint is disallowed to be triggered to
> persist CP_FSCK_FLAG, fsck won't repair the image due to lack of
> CP_FSCK_FLAG.
> 
> This patch proposes to persist newly introduced SB_NEED_FSCK flag into
> super block if CP_ERROR_FLAG and SBI_NEED_FSCK is set, later, once fsck
> detect this flag, it can check and repair corrupted image in time.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - remove unneeded codes.
>  fs/f2fs/checkpoint.c    |  6 +++++-
>  fs/f2fs/f2fs.h          |  1 +
>  fs/f2fs/super.c         | 26 ++++++++++++++++++++++++++
>  include/linux/f2fs_fs.h |  5 ++++-
>  4 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index c3119e4c890c..0836fce40394 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -30,8 +30,12 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>  {
>  	f2fs_build_fault_attr(sbi, 0, 0);
>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> -	if (!end_io)
> +	if (!end_io) {
>  		f2fs_flush_merged_writes(sbi);
> +
> +		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> +			f2fs_update_sb_flags(sbi, SB_NEED_FSCK);

Let's think of putting some more context in superblock, if we want to overwrite
it. E.g., a reason to stop checkpoint?

> +	}
>  }
>  
>  /*
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dee7b67a17a6..1960a98c7555 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3556,6 +3556,7 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
>  int f2fs_quota_sync(struct super_block *sb, int type);
>  loff_t max_file_blocks(struct inode *inode);
>  void f2fs_quota_off_umount(struct super_block *sb);
> +void f2fs_update_sb_flags(struct f2fs_sb_info *sbi, unsigned int flag);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
>  int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b8e5fe244596..c99ba840593d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3846,6 +3846,32 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  	return err;
>  }
>  
> +void f2fs_update_sb_flags(struct f2fs_sb_info *sbi, unsigned int flag)
> +{
> +	unsigned short s_flags;
> +	int err;
> +
> +	if (le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_flags) & SB_NEED_FSCK)
> +		return;
> +
> +	f2fs_down_write(&sbi->sb_lock);
> +
> +	s_flags = le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_flags);
> +
> +	if (s_flags & SB_NEED_FSCK)
> +		goto out_unlock;
> +
> +	F2FS_RAW_SUPER(sbi)->s_flags = cpu_to_le16(s_flags | SB_NEED_FSCK);
> +
> +	err = f2fs_commit_super(sbi, false);
> +	if (err) {
> +		f2fs_warn(sbi, "f2fs_commit_super fails to persist flag: %u, err:%d", flag, err);
> +		F2FS_RAW_SUPER(sbi)->s_flags = s_flags;
> +	}
> +out_unlock:
> +	f2fs_up_write(&sbi->sb_lock);
> +}
> +
>  static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index d445150c5350..124176e2a42c 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -73,6 +73,8 @@ struct f2fs_device {
>  	__le32 total_segments;
>  } __packed;
>  
> +#define SB_NEED_FSCK			0x00000001	/* need fsck */
> +
>  struct f2fs_super_block {
>  	__le32 magic;			/* Magic Number */
>  	__le16 major_ver;		/* Major Version */
> @@ -116,7 +118,8 @@ struct f2fs_super_block {
>  	__u8 hot_ext_count;		/* # of hot file extension */
>  	__le16  s_encoding;		/* Filename charset encoding */
>  	__le16  s_encoding_flags;	/* Filename charset encoding flags */
> -	__u8 reserved[306];		/* valid reserved region */
> +	__le16 s_flags;			/* super block flags */
> +	__u8 reserved[304];		/* valid reserved region */
>  	__le32 crc;			/* checksum of superblock */
>  } __packed;
>  
> -- 
> 2.25.1
