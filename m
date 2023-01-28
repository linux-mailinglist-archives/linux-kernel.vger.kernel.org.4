Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782367F6BC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjA1Jho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1Jhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:37:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BF9EED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:37:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A283E60B34
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB81C433EF;
        Sat, 28 Jan 2023 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674898660;
        bh=9TsTbB0N9axfkPVtPBxJoBCVnXYTjCOlRMczvecOdbc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gjH06AtuEqSGhEy5aD+WoBaW50IY106QVEygA13TCxCYovS6OW8xPwVn3Cuo6NGG9
         kfojbRhEh3vfmdXtTm2E8SYqP397yfKPa4FjgcnsyNp/uP8Gcs+Q3Oln5NF2Qdvyw7
         knTIo8C6XvmPOexOYCeO4ppBu3DOLaL12VjEl3HzfFRmrB+KplfOy9xoAD3tWFjUDj
         l9kMrp9XadgRwJRN1dbzRYFUszC4KAtMZvuryrnTuttJumIZCAg2N0ZytssStEN2nE
         cXjjmAjKMVKaYjW5kuVAOf0KebOnQcj7ir14Sj5LfdNZeOxWbrune+H8SCoBXWATjM
         B3oQ87AHmDTTg==
Message-ID: <fe663b7c-2aa3-c15c-5ce7-942a47310742@kernel.org>
Date:   Sat, 28 Jan 2023 17:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] f2fs: introduce ipu_mode sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230120134029.69200-1-frank.li@vivo.com>
 <20230120134029.69200-3-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230120134029.69200-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 21:40, Yangtao Li wrote:
> Add a ipu_mode sysfs node to show the current ipu policy as a string.

Why do we need to add another sysfs entry for ipu_policy? we can check
the description of ipu_policy bits in below sysfs document.

What:           /sys/fs/f2fs/<disk>/ipu_policy
Date:           November 2013
Contact:        "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
Description:    Controls the in-place-update policy.
                 updates in f2fs. User can set:

                 ====  =================
                 0x01  F2FS_IPU_FORCE
                 0x02  F2FS_IPU_SSR
                 0x04  F2FS_IPU_UTIL
                 0x08  F2FS_IPU_SSR_UTIL
                 0x10  F2FS_IPU_FSYNC
                 0x20  F2FS_IPU_ASYNC
                 0x40  F2FS_IPU_NOCACHE
                 0x80  F2FS_IPU_HONOR_OPU_WRITE
                 ====  =================

                 Refer segment.h for details.

Thanks,

> Since we use ipu_policy as a bitmap, and the bitmap API parameter is
> unsigned long type data, let's change ipu_policy to unsigned long type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>   fs/f2fs/f2fs.h                          |  4 ++--
>   fs/f2fs/segment.h                       |  1 +
>   fs/f2fs/sysfs.c                         | 26 +++++++++++++++++++++++++
>   4 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 0f17adc80488..64b15a28fe30 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -722,3 +722,9 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
>   Date:		January 2023
>   Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>   Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
> +
> +What:		/sys/fs/f2fs/<disk>/ipu_mode
> +Date:		January 2023
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Show the current ipu policy as a string.
> +		This is a read-only entry.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9edad9ccc2cd..b221a3bdb3fe 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1071,7 +1071,7 @@ struct f2fs_sm_info {
>   
>   	struct list_head sit_entry_set;	/* sit entry set list */
>   
> -	unsigned int ipu_policy;	/* in-place-update policy */
> +	unsigned long ipu_policy;	/* in-place-update policy */
>   	unsigned int min_ipu_util;	/* in-place-update threshold */
>   	unsigned int min_fsync_blocks;	/* threshold for fsync */
>   	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
> @@ -1323,7 +1323,7 @@ enum {
>   	MAX_TIME,
>   };
>   
> -/* Note that you need to keep synchronization with this gc_mode_names array */
> +/* Modification on enum should be synchronized with gc_mode_names array */
>   enum {
>   	GC_NORMAL,
>   	GC_IDLE_CB,
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index d73e988566a5..50c63155ad56 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>   
>   #define F2FS_IPU_DISABLE	0
>   
> +/* Modification on enum should be synchronized with ipu_mode_names array */
>   enum {
>   	F2FS_IPU_FORCE,
>   	F2FS_IPU_SSR,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 576e6416ffb9..aaf5d8650518 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -51,6 +51,17 @@ static const char *gc_mode_names[MAX_GC_MODE] = {
>   	"GC_URGENT_MID"
>   };
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
>   struct f2fs_attr {
>   	struct attribute attr;
>   	ssize_t (*show)(struct f2fs_attr *a, struct f2fs_sb_info *sbi, char *buf);
> @@ -149,6 +160,19 @@ static ssize_t gc_mode_show(struct f2fs_attr *a,
>   	return sysfs_emit(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
>   }
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
> +	return len;
> +}
> +
>   static ssize_t features_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -907,6 +931,7 @@ F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
>   F2FS_GENERAL_RO_ATTR(pending_discard);
>   F2FS_GENERAL_RO_ATTR(gc_mode);
> +F2FS_GENERAL_RO_ATTR(ipu_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -997,6 +1022,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(pending_discard),
>   	ATTR_LIST(gc_mode),
> +	ATTR_LIST(ipu_mode),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),
>   	ATTR_LIST(min_fsync_blocks),
