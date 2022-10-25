Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A260C5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiJYHuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiJYHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF289943
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00062617CB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301FEC433D6;
        Tue, 25 Oct 2022 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666684200;
        bh=/lF9L48lkqUnyEQE/8PiJ5Lu/Nje0pWZJAMkQ74xJog=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QgzibIlRQD7cmZQti9XdpK5m0PM1+mLS4tP3oktXVHCDEPEXNjksCoSa4gNEM1Fb8
         9nT47U0qbGL0cVVs9OpV0Rt0OjlQZT0h7izbu8Ry0jnuT+3/AFwxoiTwSGGVhjUoBt
         14nW9Q53OoB6BBiQNaRgHzKDqWApMPzFThstA9HwL0/SgqO1VSWaJikrea3X9ImIXk
         LTibl8KfTxOm3b3CNGRSYuCoGtRTxtqKX/lZu2EbEbEonh/tHQDutD94CzO+UFDAI2
         JnMlgY7MiIzfj/QAxH5sMdYID7zLd4bdkd3dbB8n++LXgK11Ba+ULJ6h/nerEsMSa7
         dVQP3S3DWLp/Q==
Message-ID: <86e95d5f-69fe-ed9b-c0d8-dd35d97f1a7f@kernel.org>
Date:   Tue, 25 Oct 2022 15:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] f2fs: introduce max_ordered_discard sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025073503.43935-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025073503.43935-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 15:35, Yangtao Li wrote:
> The current max_ordered_discard is a fixed value,
> change it to be configurable through the sys node.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> - s/order/ordered
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>   fs/f2fs/f2fs.h                          |  3 +++
>   fs/f2fs/segment.c                       |  3 ++-
>   fs/f2fs/sysfs.c                         | 11 +++++++++++
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 859c4e53a846..8faf7b1274df 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -99,6 +99,12 @@ Description:	Controls the issue rate of discard commands that consist of small
>   		checkpoint is triggered, and issued during the checkpoint.
>   		By default, it is disabled with 0.
>   
> +What:		/sys/fs/f2fs/<disk>/max_ordered_discard
> +Date:		October 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Controls the maximum ordered discard, the unit size is one block(4KB).
> +		Set it to 16 by default.
> +
>   What:		/sys/fs/f2fs/<disk>/max_discard_request
>   Date:		December 2021
>   Contact:	"Konstantin Vyshetsky" <vkon@google.com>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2bad69cf9fd9..91c3fc5383f1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -330,6 +330,8 @@ struct discard_entry {
>   
>   /* default discard granularity of inner discard thread, unit: block count */
>   #define DEFAULT_DISCARD_GRANULARITY		16
> +/* default maximum discard granularity of ordered discard, unit: block count */
> +#define DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY	16
>   
>   /* max discard pend list number */
>   #define MAX_PLIST_NUM		512
> @@ -409,6 +411,7 @@ struct discard_cmd_control {
>   	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
>   	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
>   	unsigned int discard_granularity;	/* discard granularity */
> +	unsigned int max_ordered_discard; /* maximum discard granularity issued by lba order */

	unsigned int max_ordered_discard; 	/* maximum discard granularity issued by lba order */

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


>   	unsigned int undiscard_blks;		/* # of undiscard blocks */
>   	unsigned int next_pos;			/* next discard position */
>   	atomic_t issued_discard;		/* # of issued discard */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..dfa9dc3a1bc3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1448,7 +1448,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   		if (i + 1 < dpolicy->granularity)
>   			break;
>   
> -		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
> +		if (i < dcc->max_ordered_discard && dpolicy->ordered)
>   			return __issue_discard_cmd_orderly(sbi, dpolicy);
>   
>   		pend_list = &dcc->pend_list[i];
> @@ -2046,6 +2046,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   		return -ENOMEM;
>   
>   	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
> +	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
>   	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
>   		dcc->discard_granularity = sbi->blocks_per_seg;
>   	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 2b1c653b37cf..e2325d8dcbb1 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -483,6 +483,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "max_ordered_discard")) {
> +		if (t == 0 || t > MAX_PLIST_NUM)
> +			return -EINVAL;
> +		if (!f2fs_block_unit_discard(sbi))
> +			return -EINVAL;
> +		*ui = t;
> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "migration_granularity")) {
>   		if (t == 0 || t > sbi->segs_per_sec)
>   			return -EINVAL;
> @@ -793,6 +802,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
>   F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
> @@ -923,6 +933,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(mid_discard_issue_time),
>   	ATTR_LIST(max_discard_issue_time),
>   	ATTR_LIST(discard_granularity),
> +	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(pending_discard),
>   	ATTR_LIST(batched_trim_sections),
>   	ATTR_LIST(ipu_policy),
