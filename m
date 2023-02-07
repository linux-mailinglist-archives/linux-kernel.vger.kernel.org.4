Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8C68E03A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBGSkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjBGSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:39:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30D12868
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57A58B81AB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E58C433D2;
        Tue,  7 Feb 2023 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675795187;
        bh=kuFm3PbCYEBSCb27li2FWOvTczSe7QfhNjRsq9s9KRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8B1Zv37Xdg0TxhLX3aJcZ3+LFa6VoSQcwAcmjQvXOtLcgCX8wQVwlsCsnUEwJ2ok
         gyBeoVvVRv26t3LT3P6c9OUaSAwEu29y0aphppjxZW/0Wodtvx/vIQm0EFr+W2N3PM
         fb7tGE70guZfFo2D1NDdqNeOu2GrXNx+MmPyvHFIEN0w1MoZysvAWpdKmO6GYnhRML
         76AtlqyTa+ZZT0TM7hcdQuzxj/AMrmH+RaLu9PFIJ4pU2QeNBx+Lq3xTufyLXA987J
         yAtE2kdjyKLdkdAFk7Hvii9GCLp+0DFXd0MMnvFM+Ph5GdZaN/PHgMZm2oBOb2v/MN
         Huu/lNP+tIy7w==
Date:   Tue, 7 Feb 2023 10:39:45 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     qixiaoyu1 <qxy65535@gmail.com>, Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2 v4] f2fs: add sysfs nodes to set last_age_weight
Message-ID: <Y+Ka8cbf0j+/NzJv@google.com>
References: <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
 <20230204094345.591407-1-qixiaoyu1@xiaomi.com>
 <ecce441d-845f-caf1-d7a8-e3c30a21ae60@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecce441d-845f-caf1-d7a8-e3c30a21ae60@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07, Chao Yu wrote:
> On 2023/2/4 17:43, qixiaoyu1 wrote:
> > Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> > Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> > ---
> > change log v3 -> v4:
> >    - allow 0 and 100 to a valid value
> > 
> >   Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
> >   fs/f2fs/extent_cache.c                  | 15 +++++++++------
> >   fs/f2fs/f2fs.h                          |  1 +
> >   fs/f2fs/sysfs.c                         | 11 +++++++++++
> >   4 files changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 9e3756625a81..11af7dbb6bc9 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -669,3 +669,8 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
> >   Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> >   		the data blocks as warm. By default it was initialized as 2621440 blocks
> >   		(equals to 10GB).
> > +
> > +What:           /sys/fs/f2fs/<disk>/last_age_weight
> > +Date:           January 2023
> > +Contact:        "Ping Xiong" <xiongping1@xiaomi.com>
> > +Description:    When DATA SEPARATION is on, it controls the weight of last data block age.
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index d9f12f404beb..ce99882ba81c 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -871,19 +871,21 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
> >   }
> >   #endif
> > -static unsigned long long __calculate_block_age(unsigned long long new,
> > +static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
> > +						unsigned long long new,
> >   						unsigned long long old)
> >   {
> >   	unsigned int rem_old, rem_new;
> >   	unsigned long long res;
> > +	unsigned int weight = sbi->last_age_weight;
> > -	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
> > -		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
> > +	res = div_u64_rem(new, 100, &rem_new) * (100 - weight)
> > +		+ div_u64_rem(old, 100, &rem_old) * weight;
> >   	if (rem_new)
> > -		res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
> > +		res += rem_new * (100 - weight) / 100;
> >   	if (rem_old)
> > -		res += rem_old * LAST_AGE_WEIGHT / 100;
> > +		res += rem_old * weight / 100;
> >   	return res;
> >   }
> > @@ -917,7 +919,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
> >   			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
> >   		if (tei.age)
> > -			ei->age = __calculate_block_age(cur_age, tei.age);
> > +			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
> >   		else
> >   			ei->age = cur_age;
> >   		ei->last_blocks = cur_blocks;
> > @@ -1233,6 +1235,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
> >   	atomic64_set(&sbi->allocated_data_blocks, 0);
> >   	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
> >   	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
> > +	sbi->last_age_weight = LAST_AGE_WEIGHT;
> >   }
> >   int __init f2fs_create_extent_cache(void)
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e8953c3dc81a..c3609cbc28c7 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
> >   	/* The threshold used for hot and warm data seperation*/
> >   	unsigned int hot_data_age_threshold;
> >   	unsigned int warm_data_age_threshold;
> > +	unsigned int last_age_weight;
> >   	/* basic filesystem units */
> >   	unsigned int log_sectors_per_block;	/* log2 sectors per block */
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 83a366f3ee80..cd2fb52d1f3c 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -686,6 +686,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >   		return count;
> >   	}
> > +	if (!strcmp(a->attr.name, "last_age_weight")) {
> > +		if (t < 0 || t > 100)
> 
> t is unsigned long variable, should never be less than 0.
> 
> Otherwise, it looks good to me, maybe Jaegeuk could fix it manually.

Ok, applied.

> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
> > +			return -EINVAL;
> > +		if (t == *ui)
> > +			return count;
> > +		*ui = (unsigned int)t;
> > +		return count;
> > +	}
> > +
> >   	*ui = (unsigned int)t;
> >   	return count;
> > @@ -944,6 +953,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block)
> >   /* For block age extent cache */
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, last_age_weight, last_age_weight);
> >   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> >   static struct attribute *f2fs_attrs[] = {
> > @@ -1042,6 +1052,7 @@ static struct attribute *f2fs_attrs[] = {
> >   	ATTR_LIST(revoked_atomic_block),
> >   	ATTR_LIST(hot_data_age_threshold),
> >   	ATTR_LIST(warm_data_age_threshold),
> > +	ATTR_LIST(last_age_weight),
> >   	NULL,
> >   };
> >   ATTRIBUTE_GROUPS(f2fs);
