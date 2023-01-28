Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1B67F6D8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjA1JyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjA1JyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:54:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39F1E2A0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45AEB60B65
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D0C433D2;
        Sat, 28 Jan 2023 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674899658;
        bh=sxJtaZxPq2MZjUNksG2MAR/7m8EWH47yu/4vwO5FWK0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gh6AVtgaOY2bKtLsXBuOqlptXuP5Y/2uBDo9RjlgUndqyT/TQ0DbDFpD1mMVOQ/c+
         yZrgwPGdb0O5KTAqKZidpIf1oqRzC0BmkmG0UX30o4n5R+O8TJm3N0Q1039NpnIZCw
         4uom45/ylSWWmK22DLvH60IRkM0SaOUks9xBNyJkal7Po4BWy4jZkJvOW4NxIWRfJO
         BBxMdFMHTa1+J531COcjQ5Rail/L1xot/BN0BeCdMm4U/a6Y5oNGW6TYOGFhp0ONRJ
         d5L1EBQYfvh7HnZKstYfRNoANTQZshxfF8qmfvjzYNQbrYnYnxvag8sbRCD06sbAES
         02tzXpjPP8mCg==
Message-ID: <989046e3-b288-d966-1d21-2fccabdcb72d@kernel.org>
Date:   Sat, 28 Jan 2023 17:54:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] f2fs: move ipu_policy definitions to separated file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230120134029.69200-1-frank.li@vivo.com>
 <20230120134029.69200-4-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230120134029.69200-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 21:40, Yangtao Li wrote:
> User can control f2fs ipu policy through /sys/fs/f2fs/<disk>/ipu_policy,
> export related definitions and introduce new macro to make it more
> convenient for users to use.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 25 ++++++------
>   fs/f2fs/segment.c                       |  2 +-
>   fs/f2fs/segment.h                       | 37 ++---------------
>   fs/f2fs/super.c                         |  2 +-
>   fs/f2fs/sysfs.c                         |  2 +-
>   include/uapi/linux/f2fs.h               | 54 +++++++++++++++++++++++++
>   6 files changed, 73 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 64b15a28fe30..d05ad2bc56d1 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -49,18 +49,19 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>   Description:	Controls the in-place-update policy.
>   		updates in f2fs. User can set:
>   
> -		====  =================
> -		0x01  F2FS_IPU_FORCE
> -		0x02  F2FS_IPU_SSR
> -		0x04  F2FS_IPU_UTIL
> -		0x08  F2FS_IPU_SSR_UTIL
> -		0x10  F2FS_IPU_FSYNC
> -		0x20  F2FS_IPU_ASYNC
> -		0x40  F2FS_IPU_NOCACHE
> -		0x80  F2FS_IPU_HONOR_OPU_WRITE
> -		====  =================
> -
> -		Refer segment.h for details.
> +		====  ============================
> +		0x00  SET_F2FS_IPU_DISABLE
> +		0x01  SET_F2FS_IPU_FORCE
> +		0x02  SET_F2FS_IPU_SSR
> +		0x04  SET_F2FS_IPU_UTIL
> +		0x08  SET_F2FS_IPU_SSR_UTIL
> +		0x10  SET_F2FS_IPU_FSYNC
> +		0x20  SET_F2FS_IPU_ASYNC
> +		0x40  SET_F2FS_IPU_NOCACHE
> +		0x80  SET_F2FS_IPU_HONOR_OPU_WRITE
> +		====  ============================
> +
> +		Refer include/uapi/linux/f2fs.h for details.
>   
>   What:		/sys/fs/f2fs/<disk>/min_ipu_util
>   Date:		November 2013
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a007f5084e84..c56f5a80d3a6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -5138,7 +5138,7 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
>   		sm_info->rec_prefree_segments = DEF_MAX_RECLAIM_PREFREE_SEGMENTS;
>   
>   	if (!f2fs_lfs_mode(sbi))
> -		sm_info->ipu_policy = BIT(F2FS_IPU_FSYNC);
> +		sm_info->ipu_policy = SET_F2FS_IPU_FSYNC;
>   	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
>   	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
>   	sm_info->min_seq_blocks = sbi->blocks_per_seg;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 50c63155ad56..c064ddffe91b 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -7,6 +7,7 @@
>    */
>   #include <linux/blkdev.h>
>   #include <linux/backing-dev.h>
> +#include <uapi/linux/f2fs.h>
>   
>   /* constant macro */
>   #define NULL_SEGNO			((unsigned int)(~0))
> @@ -646,51 +647,19 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>   					sbi->user_block_count);
>   }
>   
> -/*
> - * Sometimes f2fs may be better to drop out-of-place update policy.
> - * And, users can control the policy through sysfs entries.
> - * There are five policies with triggering conditions as follows.
> - * F2FS_IPU_FORCE - all the time,
> - * F2FS_IPU_SSR - if SSR mode is activated,
> - * F2FS_IPU_UTIL - if FS utilization is over threashold,
> - * F2FS_IPU_SSR_UTIL - if SSR mode is activated and FS utilization is over
> - *                     threashold,
> - * F2FS_IPU_FSYNC - activated in fsync path only for high performance flash
> - *                     storages. IPU will be triggered only if the # of dirty
> - *                     pages over min_fsync_blocks. (=default option)
> - * F2FS_IPU_ASYNC - do IPU given by asynchronous write requests.
> - * F2FS_IPU_NOCACHE - disable IPU bio cache.
> - * F2FS_IPU_HONOR_OPU_WRITE - use OPU write prior to IPU write if inode has
> - *                            FI_OPU_WRITE flag.
> - * F2FS_IPU_DISABLE - disable IPU. (=default option in LFS mode)
> - */

IMO, we'd better to move these comments into sysfs-fs-f2fs as ipu_policy
interface's documents.

>   #define DEF_MIN_IPU_UTIL	70
>   #define DEF_MIN_FSYNC_BLOCKS	8
>   #define DEF_MIN_HOT_BLOCKS	16
>   
>   #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
>   
> -#define F2FS_IPU_DISABLE	0
> -
> -/* Modification on enum should be synchronized with ipu_mode_names array */
> -enum {
> -	F2FS_IPU_FORCE,
> -	F2FS_IPU_SSR,
> -	F2FS_IPU_UTIL,
> -	F2FS_IPU_SSR_UTIL,
> -	F2FS_IPU_FSYNC,
> -	F2FS_IPU_ASYNC,
> -	F2FS_IPU_NOCACHE,
> -	F2FS_IPU_HONOR_OPU_WRITE,
> -	F2FS_IPU_MAX,
> -};
> -
>   #define F2FS_IPU_POLICY(name)					\
>   static inline int IS_##name(struct f2fs_sb_info *sbi)		\
>   {								\
> -	return SM_I(sbi)->ipu_policy & BIT(name);		\
> +	return TEST_##name(SM_I(sbi)->ipu_policy);		\
>   }
>   
> +F2FS_IPU_POLICY(F2FS_IPU_DISABLE);
>   F2FS_IPU_POLICY(F2FS_IPU_FORCE);
>   F2FS_IPU_POLICY(F2FS_IPU_SSR);
>   F2FS_IPU_POLICY(F2FS_IPU_UTIL);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ebc76683f05d..b19085fa335a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4085,7 +4085,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   		if (f2fs_block_unit_discard(sbi))
>   			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
>   		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS)
> -			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
> +			SM_I(sbi)->ipu_policy = SET_F2FS_IPU_FORCE | SET_F2FS_IPU_HONOR_OPU_WRITE;
>   	}
>   
>   	sbi->readdir_ra = true;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index aaf5d8650518..375ace5f330d 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -165,7 +165,7 @@ static ssize_t ipu_mode_show(struct f2fs_attr *a,
>   {
>   	int len = 0, i = 0;
>   
> -	if (SM_I(sbi)->ipu_policy == F2FS_IPU_DISABLE)
> +	if (IS_F2FS_IPU_DISABLE(sbi))
>   		return sysfs_emit(buf, "DISABLE\n");
>   
>   	for_each_set_bit(i, &SM_I(sbi)->ipu_policy, F2FS_IPU_MAX)
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 955d440be104..1b672fb6af91 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -5,6 +5,60 @@
>   #include <linux/types.h>
>   #include <linux/ioctl.h>
>   
> +/*
> + * For /sys/fs/f2fs/<disk>/ipu_policy entry
> + *
> + * Sometimes f2fs may be better to drop out-of-place update policy.
> + * And, users can control the policy through sysfs entries.
> + * There are five policies with triggering conditions as follows.
> + * F2FS_IPU_FORCE - all the time,
> + * F2FS_IPU_SSR - if SSR mode is activated,
> + * F2FS_IPU_UTIL - if FS utilization is over threashold,
> + * F2FS_IPU_SSR_UTIL - if SSR mode is activated and FS utilization is over
> + *                     threashold,
> + * F2FS_IPU_FSYNC - activated in fsync path only for high performance flash
> + *                     storages. IPU will be triggered only if the # of dirty
> + *                     pages over min_fsync_blocks. (=default option)
> + * F2FS_IPU_ASYNC - do IPU given by asynchronous write requests.
> + * F2FS_IPU_NOCACHE - disable IPU bio cache.
> + * F2FS_IPU_HONOR_OPU_WRITE - use OPU write prior to IPU write if inode has
> + *                            FI_OPU_WRITE flag.
> + * F2FS_IPU_DISABLE - disable IPU. (=default option in LFS mode)
> + */
> +#define F2FS_IPU_DISABLE	0
> +/* Modification on enum should be synchronized with ipu_mode_names array */
> +enum {
> +	F2FS_IPU_FORCE,
> +	F2FS_IPU_SSR,
> +	F2FS_IPU_UTIL,
> +	F2FS_IPU_SSR_UTIL,
> +	F2FS_IPU_FSYNC,
> +	F2FS_IPU_ASYNC,
> +	F2FS_IPU_NOCACHE,
> +	F2FS_IPU_HONOR_OPU_WRITE,
> +	F2FS_IPU_MAX,
> +};
> +
> +#define SET_F2FS_IPU_DISABLE				F2FS_IPU_DISABLE
> +#define SET_F2FS_IPU_FORCE					BIT(F2FS_IPU_FORCE)
> +#define SET_F2FS_IPU_SSR					BIT(F2FS_IPU_SSR)
> +#define SET_F2FS_IPU_UTIL					BIT(F2FS_IPU_UTIL)
> +#define SET_F2FS_IPU_SSR_UTIL				BIT(F2FS_IPU_SSR_UTIL)
> +#define SET_F2FS_IPU_FSYNC					BIT(F2FS_IPU_FSYNC)
> +#define SET_F2FS_IPU_ASYNC					BIT(F2FS_IPU_ASYNC)
> +#define SET_F2FS_IPU_NOCACHE				BIT(F2FS_IPU_NOCACHE)
> +#define SET_F2FS_IPU_HONOR_OPU_WRITE		BIT(F2FS_IPU_HONOR_OPU_WRITE)
> +
> +#define TEST_F2FS_IPU_DISABLE(val)			((val) == F2FS_IPU_DISABLE)
> +#define TEST_F2FS_IPU_FORCE(val)			((val) & BIT(F2FS_IPU_FORCE))
> +#define TEST_F2FS_IPU_SSR(val)				((val) & BIT(F2FS_IPU_SSR))
> +#define TEST_F2FS_IPU_UTIL(val)				((val) & BIT(F2FS_IPU_UTIL))
> +#define TEST_F2FS_IPU_SSR_UTIL(val)			((val) & BIT(F2FS_IPU_SSR_UTIL))
> +#define TEST_F2FS_IPU_FSYNC(val)			((val) & BIT(F2FS_IPU_FSYNC))
> +#define TEST_F2FS_IPU_ASYNC(val)			((val) & BIT(F2FS_IPU_ASYNC))
> +#define TEST_F2FS_IPU_NOCACHE(val)			((val) & BIT(F2FS_IPU_NOCACHE))
> +#define TEST_F2FS_IPU_HONOR_OPU_WRITE(val)	((val) & BIT(F2FS_IPU_HONOR_OPU_WRITE))

I don't see any strong reason to add these sysfs related definition to uapi,
according to other filesystems' implementation, I guess describing the usage
of ipu_policy clearly is enough.

Thanks,

> +
>   /*
>    * f2fs-specific ioctl commands
>    */
