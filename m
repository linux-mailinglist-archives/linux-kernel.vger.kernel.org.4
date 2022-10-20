Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D325605918
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJTHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJTHy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6DA5208A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B1E61A4F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64638C433C1;
        Thu, 20 Oct 2022 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666252491;
        bh=BHDB8Kd2xEmYB76BxmchxxWXe2Rxre5+Q3z//+IATxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RmPb5jXraHNVcGs3bWrEwLwWQxMI2xFF0PYDQxUBeE52LtwpoMwskD3IdNTQiBaS5
         U5oWoHCoaWCuHJAbG+cLOsG1HPEoH2Jz5qkkqizAxbiTW5VOh9ZIa5Svh2BjsjIkOs
         g2Nt41VefC5X5Neiwi2SS7lwytvROIwriLziB15lIKihmHbe2lXRt7Xode56jMc9Xn
         2wAO00k3nC8bHHUIx/u9iNjXfBbpuKVkCAGZh7b2hksECEvalEQNuGoE8dZZH4DJma
         bJqV8WYO5aljyl0iG4S5iXa8di44fsO7d7FPM0rIUaoIH5XJe0JLVJ+2hNZj5xyqeB
         5aysrbVT6g4Sg==
Message-ID: <3ed1c3a5-e299-4915-a339-e2b6360635e5@kernel.org>
Date:   Thu, 20 Oct 2022 15:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: introduce gc_urgent_mid_remaining sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221018074621.16019-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221018074621.16019-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yangtao,

On 2022/10/18 15:46, Yangtao Li wrote:
> Added a new sysfs node called gc_urgent_mid_remaining. The user can
> set the trial count limit for GC urgent mid mode with this value. If
> GC thread gets to the limit, the mode will turn back to GC normal mode.

Not sure, we will add gc_urgent_low_remaining later...

Can we share the same interface for all gc_mode? since each mode is
exclusive.

Thoughts?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
>   fs/f2fs/f2fs.h                          |  2 ++
>   fs/f2fs/gc.c                            |  8 ++++++++
>   fs/f2fs/super.c                         |  1 +
>   fs/f2fs/sysfs.c                         | 10 ++++++++++
>   5 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 483639fb727b..11ce4a8bdacd 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -599,6 +599,13 @@ Description:	You can set the trial count limit for GC urgent high mode with this
>   		If GC thread gets to the limit, the mode will turn back to GC normal mode.
>   		By default, the value is zero, which means there is no limit like before.
>   
> +What:		/sys/fs/f2fs/<disk>/gc_urgent_mid_remaining
> +Date:		October 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	You can set the trial count limit for GC urgent mid mode with this value.
> +		If GC thread gets to the limit, the mode will turn back to GC normal mode.
> +		By default, the value is zero.
> +
>   What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
>   Date:		January 2022
>   Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..2f33d6f23a26 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1736,6 +1736,8 @@ struct f2fs_sb_info {
>   	unsigned int next_victim_seg[2];	/* next segment in victim section */
>   	spinlock_t gc_urgent_high_lock;
>   	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
> +	spinlock_t gc_urgent_mid_lock;
> +	unsigned int gc_urgent_mid_remaining;	/* remaining trial count for GC_URGENT_MID */
>   
>   	/* for skip statistic */
>   	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4546e01b2ee0..39d794b33d27 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -104,6 +104,14 @@ static int gc_thread_func(void *data)
>   					sbi->gc_mode = GC_NORMAL;
>   			}
>   			spin_unlock(&sbi->gc_urgent_high_lock);
> +		} else if (sbi->gc_mode == GC_URGENT_MID) {
> +			spin_lock(&sbi->gc_urgent_mid_lock);
> +			if (sbi->gc_urgent_mid_remaining) {
> +				sbi->gc_urgent_mid_remaining--;
> +				if (!sbi->gc_urgent_mid_remaining)
> +					sbi->gc_mode = GC_NORMAL;
> +			}
> +			spin_unlock(&sbi->gc_urgent_mid_lock);
>   		}
>   
>   		if (sbi->gc_mode == GC_URGENT_HIGH ||
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3834ead04620..13919ad152b7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3617,6 +3617,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
>   	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
>   	spin_lock_init(&sbi->gc_urgent_high_lock);
> +	spin_lock_init(&sbi->gc_urgent_mid_lock);
>   	atomic64_set(&sbi->current_atomic_write, 0);
>   
>   	sbi->dir_level = DEF_DIR_LEVEL;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index df27afd71ef4..b4476adea776 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -539,6 +539,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "gc_urgent_mid_remaining")) {
> +		spin_lock(&sbi->gc_urgent_mid_lock);
> +		sbi->gc_urgent_mid_remaining = t;
> +		spin_unlock(&sbi->gc_urgent_mid_lock);
> +
> +		return count;
> +	}
> +
>   #ifdef CONFIG_F2FS_IOSTAT
>   	if (!strcmp(a->attr.name, "iostat_enable")) {
>   		sbi->iostat_enable = !!t;
> @@ -826,6 +834,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_mid_remaining, gc_urgent_mid_remaining);
>   F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
>   F2FS_GENERAL_RO_ATTR(dirty_segments);
>   F2FS_GENERAL_RO_ATTR(free_segments);
> @@ -953,6 +962,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(data_io_flag),
>   	ATTR_LIST(node_io_flag),
>   	ATTR_LIST(gc_urgent_high_remaining),
> +	ATTR_LIST(gc_urgent_mid_remaining),
>   	ATTR_LIST(ckpt_thread_ioprio),
>   	ATTR_LIST(dirty_segments),
>   	ATTR_LIST(free_segments),
