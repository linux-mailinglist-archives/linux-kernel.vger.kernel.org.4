Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0217E6491F9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLKCgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:36:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11C13E31
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0221FB80959
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90980C433EF;
        Sun, 11 Dec 2022 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670726169;
        bh=XWHn21ifsX5oD2GoaKAPEWjwGFhWVCPr6vE1FimUBKs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QYf9/Hmjx3JUY4dPoN8Kp4x8XtXZy2VQH2KGZ4LUZ5d0PmxACcDqEGKBrXV6ZyJs3
         EkK4Sw9w/5uuCny18ZUzChn6hwmMHKboBDuogRbtKAZaaMXWq0e9O8x6H/+qCwtv9a
         kY1G0tA94sVotgJVOT9x1cNt4l8dnfVblxgkAPyHKuimv2HJCFXWt272p9uqELccuC
         qkDFmBY+Pf+QuFEMphW/tO2NRwQo4Fhx6b5CcB7KUqLvyxIRyELm/EwiqfbIumCKwc
         SNYHfveVtWvuOrawiefLJeYiCxYuSwzhcQNacZHFGlkvhpKNh5tyoiDefL70TtzlpQ
         hpDaXxt8aZIgg==
Message-ID: <7368c57a-141e-86b0-365f-8af795940483@kernel.org>
Date:   Sun, 11 Dec 2022 10:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: continuous counting for 'issued' in
 __issue_discard_cmd_orderly()
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221121161101.72847-1-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221121161101.72847-1-Yuwei.Guan@zeekrlife.com>
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

On 2022/11/22 0:11, Yuwei Guan wrote:
> As the 'dcc->discard_granularity' and 'dcc->max_ordered_discard' can be set
> at the user space, and if the 'dcc->max_ordered_discard' is set larger than
> 'dcc->discard_granularity' in DPOLICY_BG mode, or it's a volume device,
> discard_granularity can be tuned to 1 in f2fs_tuning_parameters(),
> it will may send more requests than the number of 'dpolicy->max_requests'
> in issue_discard_thread().
> 
> This patch will fix the issue.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   fs/f2fs/segment.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..b0157bf392fb 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1379,8 +1379,8 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>   	return 0;
>   }
>   
> -static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy)
> +static int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy, int *issued)
>   {
>   	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>   	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> @@ -1388,7 +1388,6 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   	struct discard_cmd *dc;
>   	struct blk_plug plug;
>   	unsigned int pos = dcc->next_pos;
> -	unsigned int issued = 0;
>   	bool io_interrupted = false;
>   
>   	mutex_lock(&dcc->cmd_lock);
> @@ -1415,9 +1414,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
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
> @@ -1433,10 +1432,10 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>   
>   	mutex_unlock(&dcc->cmd_lock);
>   
> -	if (!issued && io_interrupted)
> -		issued = -1;
> +	if (!(*issued) && io_interrupted)
> +		*issued = -1;
>   
> -	return issued;
> +	return *issued;

A little weired that __issue_discard_cmd_orderly() will output the data
in both return value and @issued parameter.

How about changing type of return value __issue_discard_cmd_orderly()
from unsigned int to void.

Thanks,

>   }
>   static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>   					struct discard_policy *dpolicy);
> @@ -1465,7 +1464,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   			break;
>   
>   		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
> -			return __issue_discard_cmd_orderly(sbi, dpolicy);
> +			return __issue_discard_cmd_orderly(sbi, dpolicy, &issued);
>   
>   		pend_list = &dcc->pend_list[i];
>   
