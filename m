Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F468E08D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjBGSux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBGSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:50:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732719A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5971B61126
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED6EC433D2;
        Tue,  7 Feb 2023 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675795847;
        bh=whAMKutKdWNSLqWJkr0gpWWdShFqVu3W6CJ6+y2xTAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCv7eUm8BxTMs9bMdUFM7LzTmWdMf24VmaVMOkNpIIjA3eg7VTsJ/7lLfLsPCbge+
         5gtesn0TS5eKfID5QIV3G87APRIz8QhMAGP06ZbCT9sxyeGlX52prCf9lwRsRHRSBN
         gmv8XFr4juG9zhJvyfLrParuotjltgXO/FyJCT+68FPYPSYsaua1IkjHhQrcWIoCQe
         l1H60mcEJ/cR1otKblOiQj0YW49X/Wt9aCHL8YKizYtfrLpa0O41PBVzN0hPHdwb3y
         g9TcT3/VjmvUJqkG3t5w3YHtgnSX7Sop6T5slcHCp8tjxouTg/Sin18YfVilIxhuUL
         Yv+/XhzM90pUA==
Date:   Tue, 7 Feb 2023 10:50:46 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] f2fs: introduce ipu_mode sysfs node
Message-ID: <Y+Kdhh6b1TAl0ntT@google.com>
References: <20230206144310.2344-1-frank.li@vivo.com>
 <20230206144310.2344-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206144310.2344-3-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06, Yangtao Li wrote:
> Add a ipu_mode sysfs node to show the current ipu policy as a string
> for readability, like we do in commit a3951cd199a5 ("f2fs: introduce
> gc_mode sysfs node").
> 
> Since we use ipu_policy as a bitmap, and the bitmap API parameter is
> unsigned long type data, let's change ipu_policy to unsigned long type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v4:
> -rebase, no code change
>  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>  fs/f2fs/f2fs.h                          |  4 ++--
>  fs/f2fs/segment.h                       |  1 +
>  fs/f2fs/sysfs.c                         | 28 ++++++++++++++++++++++++-
>  4 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 94132745ecbe..b2d8c1e84073 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -729,3 +729,9 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
>  Date:		January 2023
>  Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>  Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
> +
> +What:		/sys/fs/f2fs/<disk>/ipu_mode
> +Date:		February 2023
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Show the current ipu policy as a string.
> +		This is a read-only entry.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 44f2d76525bf..b699ed74f438 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1070,7 +1070,7 @@ struct f2fs_sm_info {
>  
>  	struct list_head sit_entry_set;	/* sit entry set list */
>  
> -	unsigned int ipu_policy;	/* in-place-update policy */
> +	unsigned long ipu_policy;	/* in-place-update policy */
>  	unsigned int min_ipu_util;	/* in-place-update threshold */
>  	unsigned int min_fsync_blocks;	/* threshold for fsync */
>  	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
> @@ -1322,7 +1322,7 @@ enum {
>  	MAX_TIME,
>  };
>  
> -/* Note that you need to keep synchronization with this gc_mode_names array */
> +/* Modification on enum should be synchronized with gc_mode_names array */
>  enum {
>  	GC_NORMAL,
>  	GC_IDLE_CB,
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 8ee5e5db9287..92c8be00d396 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>  
>  #define F2FS_IPU_DISABLE	0
>  
> +/* Modification on enum should be synchronized with ipu_mode_names array */
>  enum {
>  	F2FS_IPU_FORCE,
>  	F2FS_IPU_SSR,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 3c3dae3ce84e..4a2d895cd52c 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -51,6 +51,17 @@ static const char *gc_mode_names[MAX_GC_MODE] = {
>  	"GC_URGENT_MID"
>  };
>  
> +static const char *ipu_mode_names[F2FS_IPU_MAX] = {
> +	"FORCE",
> +	"SSR",
> +	"UTIL",
> +	"SSR_UTIL",
> +	"FSYNC",
> +	"ASYNC",
> +	"NOCACHE",
> +	"HONOR_OPU_WRITE",
> +};
> +
>  struct f2fs_attr {
>  	struct attribute attr;
>  	ssize_t (*show)(struct f2fs_attr *a, struct f2fs_sb_info *sbi, char *buf);
> @@ -149,6 +160,19 @@ static ssize_t gc_mode_show(struct f2fs_attr *a,
>  	return sysfs_emit(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
>  }
>  
> +static ssize_t ipu_mode_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	int len = 0, i = 0;
> +
> +	if (SM_I(sbi)->ipu_policy == F2FS_IPU_DISABLE)
> +		return sysfs_emit(buf, "DISABLE\n");
> +
> +	for_each_set_bit(i, &SM_I(sbi)->ipu_policy, F2FS_IPU_MAX)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n", ipu_mode_names[i]);

I believe this would not be a good usecase for the sysfs entry. How about
putting the info in debugfs?

> +	return len;
> +}
> +
>  static ssize_t features_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -711,7 +735,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  			return -EINVAL;
>  		if (t && f2fs_lfs_mode(sbi))
>  			return -EINVAL;
> -		SM_I(sbi)->ipu_policy = (unsigned int)t;
> +		SM_I(sbi)->ipu_policy = t;
>  		return count;
>  	}
>  
> @@ -907,6 +931,7 @@ F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>  F2FS_GENERAL_RO_ATTR(main_blkaddr);
>  F2FS_GENERAL_RO_ATTR(pending_discard);
>  F2FS_GENERAL_RO_ATTR(gc_mode);
> +F2FS_GENERAL_RO_ATTR(ipu_mode);
>  #ifdef CONFIG_F2FS_STAT_FS
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -997,6 +1022,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(max_ordered_discard),
>  	ATTR_LIST(pending_discard),
>  	ATTR_LIST(gc_mode),
> +	ATTR_LIST(ipu_mode),
>  	ATTR_LIST(ipu_policy),
>  	ATTR_LIST(min_ipu_util),
>  	ATTR_LIST(min_fsync_blocks),
> -- 
> 2.25.1
