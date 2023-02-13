Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58342694131
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBMJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBMJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AB14EB0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD83DB80EAD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D6DC433D2;
        Mon, 13 Feb 2023 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676280552;
        bh=BwYOX5bxqbd258lx4NZjPicBhmu6sXCQeAs5cOJ/RAs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DPuR0pXUJsvRAIRKYBYWq5uzSILPiXAjOqXDj/2UESWojUEl5bm/EmuQ5WBXLW5ZG
         nocTb2nQ3odFxYI07+mTWk3Vg5WQkiUIgh50SP4of1BNNQ/cnpz59wpsbs3Y+fMrto
         6/bjMZWqaBwU1l4Ko1FghnZi0g0Zc638k/sJqP1GDGpmFRFmm/rURWzKuWEOB5yV0R
         nYjSyNuys9JLASpeZQqKg0KWu8vUjyPUrB4Z2hSMmjrOguWR5yHWoy79ZhGFR5sX93
         QJatKMbkQNkANglQv/ZTcsJYDD0nb4cQ81RpMxXoOAK6thNfH/6YqZpjPX9Cksx4Ca
         TArpFV4tRdlXg==
Message-ID: <30af506c-8c4e-bb8a-6f4b-634f30632fb3@kernel.org>
Date:   Mon, 13 Feb 2023 17:29:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] f2fs: export ipu policy in debugfs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230209034044.22072-1-frank.li@vivo.com>
 <Y+UswNp5NrDWjpGX@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y+UswNp5NrDWjpGX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/10 1:26, Jaegeuk Kim wrote:
> On 02/09, Yangtao Li wrote:
>> Export ipu_policy as a string in debugfs for better readability and
>> it can help us better understand some strategies of the file system.
>>
>> Since we use ipu_policy as a bitmap, and the bitmap API parameter is
>> unsigned long type data, let's change ipu_policy to unsigned long type.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/f2fs/debug.c   | 64 ++++++++++++++++++++++++++++++++---------------
>>   fs/f2fs/f2fs.h    |  4 +--
>>   fs/f2fs/segment.h |  1 +
>>   fs/f2fs/sysfs.c   |  2 +-
>>   4 files changed, 48 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>> index 32af4f0c5735..d50dc8e6abfd 100644
>> --- a/fs/f2fs/debug.c
>> +++ b/fs/f2fs/debug.c
>> @@ -354,6 +354,17 @@ static char *s_flag[] = {
>>   	[SBI_IS_FREEZING]	= " freezefs",
>>   };
>>   
>> +static const char *ipu_mode_names[F2FS_IPU_MAX] = {
>> +	[F2FS_IPU_FORCE]	= "FORCE",
>> +	[F2FS_IPU_SSR]		= "SSR",
>> +	[F2FS_IPU_UTIL]		= "UTIL",
>> +	[F2FS_IPU_SSR_UTIL]	= "SSR_UTIL",
>> +	[F2FS_IPU_FSYNC]	= "FSYNC",
>> +	[F2FS_IPU_ASYNC]	= "ASYNC",
>> +	[F2FS_IPU_NOCACHE]	= "NOCACHE",
>> +	[F2FS_IPU_HONOR_OPU_WRITE]	= "HONOR_OPU_WRITE",
>> +};
>> +
>>   static int stat_show(struct seq_file *s, void *v)
>>   {
>>   	struct f2fs_stat_info *si;
>> @@ -362,18 +373,20 @@ static int stat_show(struct seq_file *s, void *v)
>>   
>>   	raw_spin_lock_irqsave(&f2fs_stat_lock, flags);
>>   	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
>> -		update_general_status(si->sbi);
>> +		struct f2fs_sb_info *sbi = si->sbi;
>> +
>> +		update_general_status(sbi);
>>   
>>   		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
>> -			si->sbi->sb->s_bdev, i++,
>> -			f2fs_readonly(si->sbi->sb) ? "RO" : "RW",
>> -			is_set_ckpt_flags(si->sbi, CP_DISABLED_FLAG) ?
>> -			"Disabled" : (f2fs_cp_error(si->sbi) ? "Error" : "Good"));
>> -		if (si->sbi->s_flag) {
>> +			sbi->sb->s_bdev, i++,
>> +			f2fs_readonly(sbi->sb) ? "RO" : "RW",
>> +			is_set_ckpt_flags(sbi, CP_DISABLED_FLAG) ?
>> +			"Disabled" : (f2fs_cp_error(sbi) ? "Error" : "Good"));

How about making another patch to replace si->sbi w/ sbi?

Thanks,

>> +		if (sbi->s_flag) {
>>   			seq_puts(s, "[SBI:");
>> -			for_each_set_bit(j, &si->sbi->s_flag, 32)
>> +			for_each_set_bit(j, &sbi->s_flag, 32)
>>   				seq_puts(s, s_flag[j]);
>> -			seq_puts(s, "]\n");
>> +			seq_puts(s, "]\n\n");
>>   		}
>>   		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
>>   			   si->sit_area_segs, si->nat_area_segs);
>> @@ -383,8 +396,19 @@ static int stat_show(struct seq_file *s, void *v)
>>   			   si->overp_segs, si->rsvd_segs);
>>   		seq_printf(s, "Current Time Sec: %llu / Mounted Time Sec: %llu\n\n",
>>   					ktime_get_boottime_seconds(),
>> -					SIT_I(si->sbi)->mounted_time);
>> -		if (test_opt(si->sbi, DISCARD))
>> +					SIT_I(sbi)->mounted_time);
>> +
>> +		seq_puts(s, "Policy:\n");
>> +		seq_puts(s, "  - IPU: [");
>> +		if (IS_F2FS_IPU_DISABLE(sbi)) {
>> +			seq_puts(s, " DISABLE\n");
>> +		} else {
>> +			for_each_set_bit(j, &SM_I(sbi)->ipu_policy, F2FS_IPU_MAX)
>> +				seq_printf(s, " %s", ipu_mode_names[j]);
>> +		}
>> +		seq_puts(s, " ]\n");
>> +
>> +		if (test_opt(sbi, DISCARD))
>>   			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
>>   				si->utilization, si->valid_count, si->discard_blks);
>>   		else
>> @@ -491,15 +515,15 @@ static int stat_show(struct seq_file *s, void *v)
>>   		seq_printf(s, "  - node segments : %d (%d)\n",
>>   				si->node_segs, si->bg_node_segs);
>>   		seq_puts(s, "  - Reclaimed segs :\n");
>> -		seq_printf(s, "    - Normal : %d\n", si->sbi->gc_reclaimed_segs[GC_NORMAL]);
>> -		seq_printf(s, "    - Idle CB : %d\n", si->sbi->gc_reclaimed_segs[GC_IDLE_CB]);
>> +		seq_printf(s, "    - Normal : %d\n", sbi->gc_reclaimed_segs[GC_NORMAL]);
>> +		seq_printf(s, "    - Idle CB : %d\n", sbi->gc_reclaimed_segs[GC_IDLE_CB]);
>>   		seq_printf(s, "    - Idle Greedy : %d\n",
>> -				si->sbi->gc_reclaimed_segs[GC_IDLE_GREEDY]);
>> -		seq_printf(s, "    - Idle AT : %d\n", si->sbi->gc_reclaimed_segs[GC_IDLE_AT]);
>> +				sbi->gc_reclaimed_segs[GC_IDLE_GREEDY]);
>> +		seq_printf(s, "    - Idle AT : %d\n", sbi->gc_reclaimed_segs[GC_IDLE_AT]);
>>   		seq_printf(s, "    - Urgent High : %d\n",
>> -				si->sbi->gc_reclaimed_segs[GC_URGENT_HIGH]);
>> -		seq_printf(s, "    - Urgent Mid : %d\n", si->sbi->gc_reclaimed_segs[GC_URGENT_MID]);
>> -		seq_printf(s, "    - Urgent Low : %d\n", si->sbi->gc_reclaimed_segs[GC_URGENT_LOW]);
>> +				sbi->gc_reclaimed_segs[GC_URGENT_HIGH]);
>> +		seq_printf(s, "    - Urgent Mid : %d\n", sbi->gc_reclaimed_segs[GC_URGENT_MID]);
>> +		seq_printf(s, "    - Urgent Low : %d\n", sbi->gc_reclaimed_segs[GC_URGENT_LOW]);
>>   		seq_printf(s, "Try to move %d blocks (BG: %d)\n", si->tot_blks,
>>   				si->bg_data_blks + si->bg_node_blks);
>>   		seq_printf(s, "  - data blocks : %d (%d)\n", si->data_blks,
>> @@ -565,7 +589,7 @@ static int stat_show(struct seq_file *s, void *v)
>>   			   si->ndirty_imeta);
>>   		seq_printf(s, "  - fsync mark: %4lld\n",
>>   			   percpu_counter_sum_positive(
>> -					&si->sbi->rf_node_block_count));
>> +					&sbi->rf_node_block_count));
>>   		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
>>   			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
>>   		seq_printf(s, "  - free_nids: %9d/%9d\n  - alloc_nids: %9d\n",
>> @@ -592,12 +616,12 @@ static int stat_show(struct seq_file *s, void *v)
>>   			   si->block_count[LFS], si->segment_count[LFS]);
>>   
>>   		/* segment usage info */
>> -		f2fs_update_sit_info(si->sbi);
>> +		f2fs_update_sit_info(sbi);
>>   		seq_printf(s, "\nBDF: %u, avg. vblocks: %u\n",
>>   			   si->bimodal, si->avg_vblocks);
>>   
>>   		/* memory footprint */
>> -		update_mem_info(si->sbi);
>> +		update_mem_info(sbi);
>>   		seq_printf(s, "\nMemory: %llu KB\n",
>>   			(si->base_mem + si->cache_mem + si->page_mem) >> 10);
>>   		seq_printf(s, "  - static: %llu KB\n",
> 
> I don't think we need the changes below.
> 
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 44f2d76525bf..b699ed74f438 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1070,7 +1070,7 @@ struct f2fs_sm_info {
>>   
>>   	struct list_head sit_entry_set;	/* sit entry set list */
>>   
>> -	unsigned int ipu_policy;	/* in-place-update policy */
>> +	unsigned long ipu_policy;	/* in-place-update policy */
>>   	unsigned int min_ipu_util;	/* in-place-update threshold */
>>   	unsigned int min_fsync_blocks;	/* threshold for fsync */
>>   	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
>> @@ -1322,7 +1322,7 @@ enum {
>>   	MAX_TIME,
>>   };
>>   
>> -/* Note that you need to keep synchronization with this gc_mode_names array */
>> +/* Modification on enum should be synchronized with gc_mode_names array */
>>   enum {
>>   	GC_NORMAL,
>>   	GC_IDLE_CB,
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 8ee5e5db9287..92c8be00d396 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>>   
>>   #define F2FS_IPU_DISABLE	0
>>   
>> +/* Modification on enum should be synchronized with ipu_mode_names array */
>>   enum {
>>   	F2FS_IPU_FORCE,
>>   	F2FS_IPU_SSR,
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 6082e132257a..228df201f6d4 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -711,7 +711,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>   			return -EINVAL;
>>   		if (t && f2fs_lfs_mode(sbi))
>>   			return -EINVAL;
>> -		SM_I(sbi)->ipu_policy = (unsigned int)t;
>> +		SM_I(sbi)->ipu_policy = t;
>>   		return count;
>>   	}
>>   
>> -- 
>> 2.25.1
