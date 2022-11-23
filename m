Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D56362FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiKWPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiKWPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:12:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81925F85C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6511FB820BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C589AC433D6;
        Wed, 23 Nov 2022 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216376;
        bh=yOULMtM0+KTy5LieyRbQAWfjtQdPuaw3HboADHL+tcs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sMCqNymJxYM7LJZnkYSsMm0pvmOet0Bly0terUqPs6d/6rwXk4qNjqr5pK0jGWLdh
         rPQRdeGafDEounT3RlYYaor5lL3rC3qERosoVGqQirdwBObE6pVcnLNZlRN1EuEin7
         pbmJ6/fTBtQ7jdGdL0bHNGjqEsN+HkmOGfygM08k367XwdNtdzDwxdGZywBbWxA1c2
         SXtBgmMba3C9aMJkbNBHnsCneixzc2RYbVeK3LS9nbreuqTDd9NlY2tWvZn9yRhd4a
         HNwvja0CbmkL6FX2pbM8PF1dILO0SlryUUhbFf+dlHkPYQ3d3HvG09GaCNzz8c9ORR
         KKG+6y3ClB+VA==
Message-ID: <a73cb0ce-7666-607a-fb00-dde2befb9108@kernel.org>
Date:   Wed, 23 Nov 2022 23:12:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: remove useless io_aware_gran variable
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221116131035.1056523-1-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221116131035.1056523-1-Yuwei.Guan@zeekrlife.com>
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

On 2022/11/16 21:10, Yuwei Guan wrote:
> This 'io_aware_gran' is initialized as MAX_PLIST_NUM in
> __init_discard_policy(), and use as 'i < dpolicy->io_aware_gran'
> in __issue_discard_cmd(), but 'i < dpolicy->io_aware_gran' is
> true always, so remvoe this variable.

I guess we can export it via sysfs for better configuation?

Thanks,

> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   fs/f2fs/f2fs.h    | 1 -
>   fs/f2fs/segment.c | 4 +---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dedac413bf64..ced8a5b226b5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -388,7 +388,6 @@ struct discard_policy {
>   	unsigned int mid_interval;	/* used for device busy */
>   	unsigned int max_interval;	/* used for candidates not exist */
>   	unsigned int max_requests;	/* # of discards issued per round */
> -	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
>   	bool io_aware;			/* issue discard in idle time */
>   	bool sync;			/* submit discard with REQ_SYNC flag */
>   	bool ordered;			/* issue discard by lba order */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..1cc41a65a645 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1059,7 +1059,6 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   	dpolicy->granularity = granularity;
>   
>   	dpolicy->max_requests = dcc->max_discard_request;
> -	dpolicy->io_aware_gran = MAX_PLIST_NUM;
>   	dpolicy->timeout = false;
>   
>   	if (discard_type == DPOLICY_BG) {
> @@ -1483,8 +1482,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>   				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
>   				break;
>   
> -			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> -						!is_idle(sbi, DISCARD_TIME)) {
> +			if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
>   				io_interrupted = true;
>   				break;
>   			}
