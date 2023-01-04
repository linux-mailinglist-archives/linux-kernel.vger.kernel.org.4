Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AB65CBDB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjADCZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:25:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D0178B9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:25:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807806157C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB1DC433EF;
        Wed,  4 Jan 2023 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672799129;
        bh=oK2mDCxzprTJCQ6Rr1YJkLumKen+sr1SehohaD2wNYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MinH0ScOgSHfP1f9X11R3VKxQOT+0oCHAfQJjH6XS0wbHlObm4gu2IqDWW4hGH2WG
         TQ9Ox6If7ucCXFSqpvAvLVfA3CcudhAO/qCztYytMeA4chtLjIVhG9kUQqgmd44c/w
         olShQlxY6ttbVht3c0KFWp7Tm8Egyisq5RIJmS4cwtXnCN5izwJmYqT7qJxgW/tSeu
         cMSy3davXhJm3GLmZy3NJnkDeILWuGpqlZEk3wQNzbXJjWwcXhcmCLLigAtWq+EET9
         6uIX/ZChxKZQUHe2I0oUrKdNWpzjpE7rwQUSt7fcRdC4tl9zJrTZ6fCMbWTmaUeaFx
         7H60HgxUtphMw==
Date:   Tue, 3 Jan 2023 18:25:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: Re: [PATCH v2] f2fs: introduce discard_io_aware_gran sysfs node
Message-ID: <Y7TjmBqDo9IgUaZw@google.com>
References: <20221212140540.5187-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212140540.5187-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Yangtao Li wrote:
> The current discard_io_aware_gran is a fixed value, change it to be
> configurable through the sys node.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> - allow 0
>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>  fs/f2fs/f2fs.h                          |  3 +++
>  fs/f2fs/segment.c                       |  3 ++-
>  fs/f2fs/sysfs.c                         | 13 +++++++++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 9e3756625a81..7b6cd4cf40ce 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -669,3 +669,12 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>  Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
>  		the data blocks as warm. By default it was initialized as 2621440 blocks
>  		(equals to 10GB).
> +
> +What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
> +Date:		December 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Controls background discard granularity of inner discard thread
> +		when is not in idle. Inner thread will not issue discards with size that
> +		is smaller than granularity. The unit size is one block(4KB), now only
> +		support configuring in range of [0, 512].
> +		Default: 512
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e8953c3dc81a..bd1430d09c6d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -332,6 +332,8 @@ struct discard_entry {
>  #define DEFAULT_DISCARD_GRANULARITY		16
>  /* default maximum discard granularity of ordered discard, unit: block count */
>  #define DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY	16
> +/* default minimum granularity discard not be aware of I/O, unit: block count */
> +#define DEFAULT_IO_AWARE_DISCARD_GRANULARITY	512

It seems we don't need to add another dependency between this and MAX_PLIST_NUM.
Can we use one?

>  
>  /* max discard pend list number */
>  #define MAX_PLIST_NUM		512
> @@ -410,6 +412,7 @@ struct discard_cmd_control {
>  	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
>  	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
>  	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
> +	unsigned int discard_io_aware_gran; /* minimum discard granularity not be aware of I/O */
>  	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
>  	unsigned int discard_granularity;	/* discard granularity */
>  	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a9099a754dd2..f4bf39ee31c6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1060,7 +1060,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  	dpolicy->granularity = granularity;
>  
>  	dpolicy->max_requests = dcc->max_discard_request;
> -	dpolicy->io_aware_gran = MAX_PLIST_NUM;
> +	dpolicy->io_aware_gran = dcc->discard_io_aware_gran;
>  	dpolicy->timeout = false;
>  
>  	if (discard_type == DPOLICY_BG) {
> @@ -2066,6 +2066,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	if (!dcc)
>  		return -ENOMEM;
>  
> +	dcc->discard_io_aware_gran = DEFAULT_IO_AWARE_DISCARD_GRANULARITY;
>  	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
>  	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
>  	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 83a366f3ee80..5ab42da5f2a3 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -473,6 +473,17 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "discard_io_aware_gran")) {
> +		if (t > MAX_PLIST_NUM)
> +			return -EINVAL;
> +		if (!f2fs_block_unit_discard(sbi))
> +			return -EINVAL;
> +		if (t == *ui)
> +			return count;
> +		*ui = t;
> +		return count;
> +	}
> +
>  	if (!strcmp(a->attr.name, "discard_granularity")) {
>  		if (t == 0 || t > MAX_PLIST_NUM)
>  			return -EINVAL;
> @@ -825,6 +836,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_req
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_io_aware_gran, discard_io_aware_gran);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_urgent_util, discard_urgent_util);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
> @@ -960,6 +972,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(min_discard_issue_time),
>  	ATTR_LIST(mid_discard_issue_time),
>  	ATTR_LIST(max_discard_issue_time),
> +	ATTR_LIST(discard_io_aware_gran),
>  	ATTR_LIST(discard_urgent_util),
>  	ATTR_LIST(discard_granularity),
>  	ATTR_LIST(max_ordered_discard),
> -- 
> 2.25.1
