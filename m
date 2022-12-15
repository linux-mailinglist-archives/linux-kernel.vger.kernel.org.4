Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A564D54B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLOC1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOC1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:27:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F455AAC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF67661BC8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0791C433EF;
        Thu, 15 Dec 2022 02:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671071255;
        bh=6P0YU/kHb4MLrqdFcxUR9lquyd86rwTP5ITcamVK9p8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D7k8vy9cvAV512lD8LMxtybCL0jRAFdoc2HUJYIhpYv8A9+vHKjh9MIsubO3UPllQ
         F/9zGaBukJ1TS12KJSsH8l+RDBqQZFC8SX6NN1gEM3A9391sPCIauXsSZZNZTyXoQc
         AvR44DOTInaumSEuansw+p6n7BV92eIOUV9M10zgM6cla08M74b/uRjyWDrrNlwtAY
         YDNuJyDfETOsdo/hpe83xRuMfddTgSS3C/RPse3wJUnc0yy1a1V9Z8KJ9Pk3d/NN9C
         i7NDMWucQE+lHBPEk9Pnj9sqtWO7SARRP18YeZMkC+Q7roi2F5P7uaPbBgmhsgT+xF
         ssW4ifduEut2g==
Message-ID: <ff5f1e9d-1f44-5a3b-4b76-d3cfa877b18b@kernel.org>
Date:   Thu, 15 Dec 2022 10:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] f2fs: deliver the accumulated 'issued' to
 __issue_discard_cmd_orderly() to meet the max_requests limit
Content-Language: en-US
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221213093419.134-1-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221213093419.134-1-Yuwei.Guan@zeekrlife.com>
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

On 2022/12/13 17:34, Yuwei Guan wrote:
> Any of the following scenarios will send more than the number of
> max_requests at a time, which will not meet the design of the
> max_requests limit.
> 
> - Set max_ordered_discard larger than discard_granularity from userspace.
> - It is a small size device, discard_granularity can be tuned to 1 in
>    f2fs_tuning_parameters().
> 
> We need to deliver the accumulated @issued to __issue_discard_cmd_orderly()
> to meet the max_requests limit.
> 
> BTW, convert the parameter type of @issued in __submit_discard_cmd().
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>

For the code part, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/segment.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a9099a754dd2..5268938466f5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1097,8 +1097,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>   /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
>   static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   						struct discard_policy *dpolicy,
> -						struct discard_cmd *dc,
> -						unsigned int *issued)
> +						struct discard_cmd *dc, int *issued)
>   {
>   	struct block_device *bdev = dc->bdev;
>   	unsigned int max_discard_blocks =
> @@ -1379,8 +1378,8 @@ static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
>   	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
>   }
>   
> -static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy)
> +static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy, int *issued)
>   {
>   	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>   	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> @@ -1388,7 +1387,6 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   	struct discard_cmd *dc;
>   	struct blk_plug plug;
>   	unsigned int pos = dcc->next_pos;
> -	unsigned int issued = 0;
>   	bool io_interrupted = false;
>   
>   	mutex_lock(&dcc->cmd_lock);
> @@ -1415,9 +1413,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   		}
>   
>   		dcc->next_pos = dc->lstart + dc->len;
> -		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
> +		err = __submit_discard_cmd(sbi, dpolicy, dc, issued);
>   
> -		if (issued >= dpolicy->max_requests)
> +		if (*issued >= dpolicy->max_requests)
>   			break;
>   next:
>   		node = rb_next(&dc->rb_node);
> @@ -1433,10 +1431,8 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   
>   	mutex_unlock(&dcc->cmd_lock);
>   
> -	if (!issued && io_interrupted)
> -		issued = -1;
> -
> -	return issued;
> +	if (!(*issued) && io_interrupted)
> +		*issued = -1;
>   }
>   static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>   					struct discard_policy *dpolicy);
> @@ -1464,8 +1460,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   		if (i + 1 < dpolicy->granularity)
>   			break;
>   
> -		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
> -			return __issue_discard_cmd_orderly(sbi, dpolicy);
> +		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered) {
> +			__issue_discard_cmd_orderly(sbi, dpolicy, &issued);
> +			return issued;
> +		}
>   
>   		pend_list = &dcc->pend_list[i];
>   
