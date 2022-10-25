Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFB60C4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJYHGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJYHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:06:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9C7CE1E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF55AB81A99
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449DAC433D7;
        Tue, 25 Oct 2022 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666681573;
        bh=FK2hLWqW8o/+ohg5F3oci1iOm+qnjC9Ne0BOHtIr+dQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ezhCLrJW1TXHHe7innJlISBXAUSWMF8Q076pZF7PjLvEg7DQWWJZXIXxyZ6NMwxXa
         WLqbMIcmqgH3AAT8BHU1J0fI0s4HJPBGh9G0/ELTdaeTTGJ86Iyt/edmWFEPZMWWFW
         DWEC7QHe2/KDJvkPYCo88lbG0ZbyR5U87PVWCiapSoTGGKJvR2E47Z9Nw2IkD8xqsp
         6JAjpZPajs/ZSDu4oJRl6G7ylfyvIIwKmBhHuJuFRSlIapX642cvBObqZZFk9+wlq+
         VSakJm1hdq32hyaUYYzWFwuvz1j72k99bO+UMvd70CCYj/WBpKMPORCcYSMkTmNV0J
         EdvlblEuaC8CQ==
Message-ID: <63ebd06c-9b1c-a390-4a7a-b24b1ed647c5@kernel.org>
Date:   Tue, 25 Oct 2022 15:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: introduce max_order_discard sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221021102806.25459-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021102806.25459-1-frank.li@vivo.com>
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

On 2022/10/21 18:28, Yangtao Li wrote:
> The current max_order_discard is a fixed value,

max_ordered_discard?

> change it to be configurable through the sys node.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>   fs/f2fs/f2fs.h                          |  3 +++
>   fs/f2fs/segment.c                       |  3 ++-
>   fs/f2fs/sysfs.c                         | 11 +++++++++++
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 11ce4a8bdacd..8faef2078a7a 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -99,6 +99,12 @@ Description:	Controls the issue rate of discard commands that consist of small
>   		checkpoint is triggered, and issued during the checkpoint.
>   		By default, it is disabled with 0.
>   
> +What:		/sys/fs/f2fs/<disk>/max_order_discard
> +Date:		October 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Controls the maximum ordered discard, the unit size is one block(4KB).
> +		By default, it is disabled with 16.

By default, it is disabled with 16

Set it to 16 by default?

Thanks,

> +
>   What:		/sys/fs/f2fs/<disk>/max_discard_request
>   Date:		December 2021
>   Contact:	"Konstantin Vyshetsky" <vkon@google.com>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c444f3f86608..070dee37b915 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -330,6 +330,8 @@ struct discard_entry {
>   
>   /* default discard granularity of inner discard thread, unit: block count */
>   #define DEFAULT_DISCARD_GRANULARITY		16
> +/* default maximum discard granularity of ordered discard, unit: block count */
> +#define DEFAULT_MAX_ORDER_DISCARD_GRANULARITY	16
>   
>   /* max discard pend list number */
>   #define MAX_PLIST_NUM		512
> @@ -409,6 +411,7 @@ struct discard_cmd_control {
>   	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
>   	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
>   	unsigned int discard_granularity;	/* discard granularity */
> +	unsigned int max_order_discard; /* maximum discard granularity issued by lba order */
>   	unsigned int undiscard_blks;		/* # of undiscard blocks */
>   	unsigned int next_pos;			/* next discard position */
>   	atomic_t issued_discard;		/* # of issued discard */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..921ec17a40ce 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1448,7 +1448,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   		if (i + 1 < dpolicy->granularity)
>   			break;
>   
> -		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
> +		if (i < dcc->max_order_discard && dpolicy->ordered)
>   			return __issue_discard_cmd_orderly(sbi, dpolicy);
>   
>   		pend_list = &dcc->pend_list[i];
> @@ -2046,6 +2046,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   		return -ENOMEM;
>   
>   	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
> +	dcc->max_order_discard = DEFAULT_MAX_ORDER_DISCARD_GRANULARITY;
>   	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
>   		dcc->discard_granularity = sbi->blocks_per_seg;
>   	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 555849d4c744..81f628aed2e5 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -487,6 +487,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "max_order_discard")) {
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
> @@ -801,6 +810,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_order_discard, max_order_discard);
>   F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
> @@ -931,6 +941,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(mid_discard_issue_time),
>   	ATTR_LIST(max_discard_issue_time),
>   	ATTR_LIST(discard_granularity),
> +	ATTR_LIST(max_order_discard),
>   	ATTR_LIST(pending_discard),
>   	ATTR_LIST(batched_trim_sections),
>   	ATTR_LIST(ipu_policy),
