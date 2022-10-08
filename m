Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56F5F84FE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJHLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJHLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:31:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3499474E1;
        Sat,  8 Oct 2022 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665228703; x=1696764703;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LDOZuPnvdyIIP2zXcLvST+qrGac6FUwAPpwT3ykbwdY=;
  b=QSDyYpHgJQHk1cvhYR3jxHFSf+MKUqHrp7rCA+UQd7IDpSqrPx1LIDVT
   SLjzkrJkeaxHXqPbM03HhA6FTDC2A7L3de83kjXWBL0Wm+FDj9iT03nFZ
   4YSI3jw3C9ybaxWBcl2aQwR4qq1DoqOHRIqsYS4XhjbpAsKBchnHA3/V8
   EgregvBZBdqXNqeHJiaNGyKlDUP+mpAUYELew64rZfLJPd2pegAqAKRKA
   PqtU6S1iMnT75rb3rQnaR3xGdpwi/9WDBJWsCUBvzThFDLhCB7u8KXqt0
   J0Pb521reSdSG36lagGJvTJHfR4Wjh0KZqiG+nA4jeDGEJFvfWt2XD/l+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="365877808"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="365877808"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 04:31:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="694099300"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="694099300"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.77])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 04:31:41 -0700
Message-ID: <490cdc50-737a-ff64-f21a-23dd59153cbc@intel.com>
Date:   Sat, 8 Oct 2022 14:31:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCHv2 2/2] mmc: queue: Cancel recovery work on cleanup
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c865c0c9789d428494b67b820a78923e@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c865c0c9789d428494b67b820a78923e@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 18:43, Christian Löhle wrote:
> To prevent any recovery work running after the queue cleanup cancel it.
> Any recovery running post-cleanup dereferenced mq->card as NULL
> and was not meaningful to begin with.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> -v2: Use cancel instead of flush
> 
>  drivers/mmc/core/queue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..86be55d7cf55 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -493,6 +493,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>  	if (blk_queue_quiesced(q))
>  		blk_mq_unquiesce_queue(q);
>  
> +	/*
> +	 * If the recovery completes the last (and only remaining) request in
> +	 * the queue, and the card has been removed, we could end up here with
> +	 * the recovery not quite finished yet, so cancel it.
> +	 */
> +	cancel_work_sync(&mq->recovery_work);
> +
>  	blk_mq_free_tag_set(&mq->tag_set);
>  
>  	/*

