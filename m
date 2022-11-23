Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D06363C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiKWPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiKWPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:32:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345A6541
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED5861DA2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D9EC433C1;
        Wed, 23 Nov 2022 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217547;
        bh=EQbFmhmMMXuH6+6uZrIYcXutlZ6F7K3p17xIjSCufVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q8bl9v2SWSU5sMUrkleHxm6qMCL+U3sGzp3Lq+Y40c4jGsE5ELYfaQg1RpRmCcnEp
         AqnZsjW8Y4dkO58IKb1kAUmA1GRgMasBKrJhFeBqHOWDcAutLSg7sXTbjFji24BzzB
         La9z+xkr/2vzptMQnZci/CzqjqkA4bjmMjUD8ZLLrl0KV47BAzmcexPsjy5YKLio2p
         vACG6Wmob8kdI+wUYU9fyfKxXlqU1Rr63sjZGt3I2T5LXEzNMNCEbWDND2xC6f0To8
         kWx2SiOhMQmZqaoWeLrOPGh5dp6ER1iQy39Bul1eUq2urmdosgCyVSUSblQo0Qn5sR
         4wPbWkWZHDYmA==
Message-ID: <3cc667aa-cff0-f2c8-84d0-995871f31d7d@kernel.org>
Date:   Wed, 23 Nov 2022 23:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: introduce discard_urgent_util sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221117143509.58913-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221117143509.58913-1-frank.li@vivo.com>
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

On 2022/11/17 22:35, Yangtao Li wrote:
> Through this node, you can control the background discard
> to run more aggressively when reach the utilization rate of
> the space.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
>   fs/f2fs/f2fs.h                          | 1 +
>   fs/f2fs/segment.c                       | 3 ++-
>   fs/f2fs/sysfs.c                         | 9 +++++++++
>   4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 24e7cb77f265..202ac1bfc6f2 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -646,3 +646,11 @@ Date:		October 2022
>   Contact:	"Yangtao Li" <frank.li@vivo.com>
>   Description:	Show the current gc_mode as a string.
>   		This is a read-only entry.
> +
> +What:		/sys/fs/f2fs/<disk>/discard_urgent_util
> +Date:		November 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	When space utilization exceeds this, do background DISCARD aggressively.
> +		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
> +		of discards is not 0 and set discard granularity to 1.
> +	    Default: 80
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dedac413bf64..fe42ac74491d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -411,6 +411,7 @@ struct discard_cmd_control {
>   	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
>   	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
>   	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
> +	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
>   	unsigned int discard_granularity;	/* discard granularity */
>   	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
>   	unsigned int undiscard_blks;		/* # of undiscard blocks */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..575c24b42df9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1069,7 +1069,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   		dpolicy->io_aware = true;
>   		dpolicy->sync = false;
>   		dpolicy->ordered = true;
> -		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> +		if (utilization(sbi) > dcc->discard_urgent_util) {
>   			dpolicy->granularity = 1;
>   			if (atomic_read(&dcc->discard_cmd_cnt))
>   				dpolicy->max_interval =
> @@ -2085,6 +2085,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>   	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
>   	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
> +	dcc->discard_urgent_util = DEF_DISCARD_URGENT_UTIL;
>   	dcc->undiscard_blks = 0;
>   	dcc->next_pos = 0;
>   	dcc->root = RB_ROOT_CACHED;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 97bf0dbb0974..a7dc726054b9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -493,6 +493,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "discard_urgent_util")) {
> +		if (t == 0 || t > 100)

0 is allowed?

Thanks,

> +			return -EINVAL;
> +		*ui = t;
> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "migration_granularity")) {
>   		if (t == 0 || t > sbi->segs_per_sec)
>   			return -EINVAL;
> @@ -795,6 +802,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_req
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_urgent_util, discard_urgent_util);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
>   F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
> @@ -925,6 +933,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(min_discard_issue_time),
>   	ATTR_LIST(mid_discard_issue_time),
>   	ATTR_LIST(max_discard_issue_time),
> +	ATTR_LIST(discard_urgent_util),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(pending_discard),
