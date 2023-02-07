Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA268D6C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjBGMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBGMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:32:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127AEB74
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065FA61375
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1792C433EF;
        Tue,  7 Feb 2023 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675773120;
        bh=oSZiPGKtKOkw8DR/wvKdxIyPICc+g7tTmBYbOSxusD0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hStQ3By0QeN35nFjP8sPONwsYctqYe4lWmg3OGKbuJbTU99z3WlgslVIZUSBcrA0Y
         4GHjSgDVah/o0LWF5VnIyphyWZqwGCAYUN3gE9FlX1aI8AibTe/T/j5smSn1nRAahm
         KDYMXqDnkN4+YP95vksKrxhYGISET4YWMNOA8gsfLlIR7r4vIW92Fgj/Z38tw57U1D
         pJ1ai/HAsA6QcIoulT4UwzqGU8sQa+QtGKRfTIhpx2NzdjEyjMwoZ0OgcwzsBeYXwh
         +X0OsIct1aXfeEfsex4eUJmOXAXzxlU7YykKUjwXT54Htx/vpdvaWSbtYIqL0eDhJU
         aAN/AZoYqedFQ==
Message-ID: <ecce441d-845f-caf1-d7a8-e3c30a21ae60@kernel.org>
Date:   Tue, 7 Feb 2023 20:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2 v4] f2fs: add sysfs nodes to set last_age_weight
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
 <20230204094345.591407-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204094345.591407-1-qixiaoyu1@xiaomi.com>
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

On 2023/2/4 17:43, qixiaoyu1 wrote:
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> ---
> change log v3 -> v4:
>    - allow 0 and 100 to a valid value
> 
>   Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
>   fs/f2fs/extent_cache.c                  | 15 +++++++++------
>   fs/f2fs/f2fs.h                          |  1 +
>   fs/f2fs/sysfs.c                         | 11 +++++++++++
>   4 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 9e3756625a81..11af7dbb6bc9 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -669,3 +669,8 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>   Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
>   		the data blocks as warm. By default it was initialized as 2621440 blocks
>   		(equals to 10GB).
> +
> +What:           /sys/fs/f2fs/<disk>/last_age_weight
> +Date:           January 2023
> +Contact:        "Ping Xiong" <xiongping1@xiaomi.com>
> +Description:    When DATA SEPARATION is on, it controls the weight of last data block age.
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index d9f12f404beb..ce99882ba81c 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -871,19 +871,21 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>   }
>   #endif
>   
> -static unsigned long long __calculate_block_age(unsigned long long new,
> +static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
> +						unsigned long long new,
>   						unsigned long long old)
>   {
>   	unsigned int rem_old, rem_new;
>   	unsigned long long res;
> +	unsigned int weight = sbi->last_age_weight;
>   
> -	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
> -		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
> +	res = div_u64_rem(new, 100, &rem_new) * (100 - weight)
> +		+ div_u64_rem(old, 100, &rem_old) * weight;
>   
>   	if (rem_new)
> -		res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
> +		res += rem_new * (100 - weight) / 100;
>   	if (rem_old)
> -		res += rem_old * LAST_AGE_WEIGHT / 100;
> +		res += rem_old * weight / 100;
>   
>   	return res;
>   }
> @@ -917,7 +919,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>   			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
>   
>   		if (tei.age)
> -			ei->age = __calculate_block_age(cur_age, tei.age);
> +			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
>   		else
>   			ei->age = cur_age;
>   		ei->last_blocks = cur_blocks;
> @@ -1233,6 +1235,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
>   	atomic64_set(&sbi->allocated_data_blocks, 0);
>   	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
>   	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
> +	sbi->last_age_weight = LAST_AGE_WEIGHT;
>   }
>   
>   int __init f2fs_create_extent_cache(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e8953c3dc81a..c3609cbc28c7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
>   	/* The threshold used for hot and warm data seperation*/
>   	unsigned int hot_data_age_threshold;
>   	unsigned int warm_data_age_threshold;
> +	unsigned int last_age_weight;
>   
>   	/* basic filesystem units */
>   	unsigned int log_sectors_per_block;	/* log2 sectors per block */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 83a366f3ee80..cd2fb52d1f3c 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -686,6 +686,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "last_age_weight")) {
> +		if (t < 0 || t > 100)

t is unsigned long variable, should never be less than 0.

Otherwise, it looks good to me, maybe Jaegeuk could fix it manually.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> +			return -EINVAL;
> +		if (t == *ui)
> +			return count;
> +		*ui = (unsigned int)t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
> @@ -944,6 +953,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block)
>   /* For block age extent cache */
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, last_age_weight, last_age_weight);
>   
>   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>   static struct attribute *f2fs_attrs[] = {
> @@ -1042,6 +1052,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(revoked_atomic_block),
>   	ATTR_LIST(hot_data_age_threshold),
>   	ATTR_LIST(warm_data_age_threshold),
> +	ATTR_LIST(last_age_weight),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(f2fs);
