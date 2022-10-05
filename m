Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51405F55B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJENl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJENlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:41:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE063BD;
        Wed,  5 Oct 2022 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664977311; x=1696513311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L9K5RDrN7KfTgonccFCMA4OA8kj+5MRjzXgIf353dDY=;
  b=BWC9q73C8sXVfDP2Z/kUJ1BVrsi+85htlVLx5TkMdbQgSkpRy4+8Y1oN
   OWDJ/mbJHPd8/2SfVjd8rWX52BkkrEAcbp/lNzV5b2kJ8/DKbmloOqfM+
   c90s+RgsnmZ1aSd9X5IVfTosdzcnHKiYwXpCAi/Qi1KkzrjFcTSVjDAci
   tAubIp5hKMYNr5ZVWU641IXTegoHezn8vJgIFY07J/vVTY0H9DIDUu3uB
   XOY2OxbsdYoaRQyxHz0mrWANREYkT98WGc8LYVQSOyA0fehPRP0TSG5R6
   1YnR0AHseKr83ahXmTW+AMTNrGhCP/BfsqeeXKTSgGt9KT7cAyR1w5ZBQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="300760131"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="300760131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 06:41:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="766726388"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="766726388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.192])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 06:41:49 -0700
Message-ID: <d301cdf7-a7cd-a4b1-83e6-51769b6bccd0@intel.com>
Date:   Wed, 5 Oct 2022 16:41:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCHv2] mmc: core: fix race of queue reset and card removal
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Avri Altman <Avri.Altman@wdc.com>
References: <1a5810475d7a475db5e4e5130b8f455c@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1a5810475d7a475db5e4e5130b8f455c@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 16:13, Christian Löhle wrote:
> If a recovery is active and the card is removed do not
> try to switch back partitions. Furthermore do not reference
> mq->card which might be NULLed in the meantime.
> 
> This has been observed with recovery active with CQE.
> [ 1083.510578] Unable to handle kernel NULL pointer dereference at virtual address 000000000000038c
> [ 1083.511362] Mem abort info:
> [ 1083.511626]   ESR = 0x96000004
> [ 1083.511912]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1083.512395]   SET = 0, FnV = 0
> [ 1083.512681]   EA = 0, S1PTW = 0
> [ 1083.512973]   FSC = 0x04: level 0 translation fault
> [ 1083.513417] Data abort info:
> [ 1083.513686]   ISV = 0, ISS = 0x00000004
> [ 1083.514039]   CM = 0, WnR = 0
> [ 1083.514318] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000a4c3000
> [ 1083.514899] [000000000000038c] pgd=0000000000000000, p4d=0000000000000000
> [ 1083.515854] Internal error: Oops: 96000004 [#1] SMP
> [ 1083.516295] CPU: 0 PID: 153 Comm: kworker/0:2 Tainted: G        W         5.18.12-g925ff1d10c99-dirty #7
> [ 1083.517127] Hardware name: Pine64 RockPro64 v2.1 (DT)
> [ 1083.517574] Workqueue: events mmc_mq_recovery_handler
> [ 1083.518032] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1083.518645] pc : mmc_blk_reset+0x60/0x1ac
> [ 1083.519004] lr : mmc_blk_reset+0x38/0x1ac
> [ 1083.519361] sp : ffff8000100b3cd0
> [ 1083.519654] x29: ffff8000100b3cd0 x28: 0000000000000000 x27: 0000000000000000
> [ 1083.520288] x26: ffff80000b0ba000 x25: ffff0000f6e74805 x24: ffff000004c2fdc0
> [ 1083.520922] x23: ffff000014950000 x22: ffff000004c2fc18 x21: ffff00000a33c000
> [ 1083.521556] x20: 00000000ffffff85 x19: ffff000004c2fc00 x18: ffffffffffffffff
> [ 1083.522189] x17: ffff80000cd9b200 x16: ffff80000cd9b190 x15: 0000000000000006
> [ 1083.522823] x14: 0000000000000000 x13: ffff80000b0c28f0 x12: 0000000000001707
> [ 1083.523457] x11: 00000000000007ad x10: ffff80000c6c28f0 x9 : ffff80000b0c28f0
> [ 1083.524090] x8 : 00000000fffbffff x7 : 0000000000000001 x6 : 0000000000000000
> [ 1083.524723] x5 : 0000000000000000 x4 : ffff0000f6e62d30 x3 : 0000000000000000
> [ 1083.525357] x2 : 0000000000000000 x1 : ffff00000b6e0000 x0 : 0000000000000000
> [ 1083.525990] Call trace:
> [ 1083.526209]  mmc_blk_reset+0x60/0x1ac
> [ 1083.526536]  mmc_blk_cqe_recovery+0x8c/0xd0
> [ 1083.526908]  mmc_mq_recovery_handler+0xc4/0xd0
> [ 1083.527303]  process_one_work+0x23c/0x3fc
> [ 1083.527663]  worker_thread+0x74/0x420
> [ 1083.527990]  kthread+0xec/0xf0
> [ 1083.528264]  ret_from_fork+0x10/0x20
> [ 1083.528587] Code: d50323bf d65f03c0 f94352a0 f9404000 (b9438c01)
> [ 1083.529126] ---[ end trace 0000000000000000 ]---
> 
> [ 1431.677970] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [ 1431.678753] Mem abort info:
> [ 1431.679017]   ESR = 0x96000004
> [ 1431.679303]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1431.679786]   SET = 0, FnV = 0
> [ 1431.680072]   EA = 0, S1PTW = 0
> [ 1431.680366]   FSC = 0x04: level 0 translation fault
> [ 1431.680810] Data abort info:
> [ 1431.681080]   ISV = 0, ISS = 0x00000004
> [ 1431.681432]   CM = 0, WnR = 0
> [ 1431.681712] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000bb98000
> [ 1431.682390] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [ 1431.683393] Internal error: Oops: 96000004 [#1] SMP
> [ 1431.683841] CPU: 0 PID: 19948 Comm: kworker/0:2 Not tainted 5.18.12-gf65532578f32-dirty #16
> [ 1431.684576] Hardware name: Pine64 RockPro64 v2.1 (DT)
> [ 1431.685024] Workqueue: events mmc_mq_recovery_handler
> [ 1431.685487] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1431.686100] pc : mmc_put_card+0x38/0x110
> [ 1431.686453] lr : mmc_mq_recovery_handler+0x98/0xd0
> [ 1431.686879] sp : ffff800015813cf0
> [ 1431.687173] x29: ffff800015813cf0 x28: 0000000000000000 x27: 0000000000000000
> [ 1431.687807] x26: ffff80000b0ba000 x25: ffff0000f6e74805 x24: ffff000013bd65c0
> [ 1431.688441] x23: ffff000013b96120 x22: ffff000013bd6418 x21: 0000000000000000
> [ 1431.689075] x20: ffff800008ed1c70 x19: ffff8000091767d8 x18: ffffffffffffffff
> [ 1431.689709] x17: 31335b1b6d375b1b x16: 6d305b1b47554245 x15: 0000000000000006
> [ 1431.690343] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [ 1431.690976] x11: ffff000013bd6570 x10: 0000000000000001 x9 : ffff80000ea69228
> [ 1431.691611] x8 : ffff80000df892c8 x7 : 0000000000000000 x6 : 0000000000000001
> [ 1431.692245] x5 : 0000000000000001 x4 : 0000000000000002 x3 : ffff80000e6feac8
> [ 1431.692879] x2 : 000000000000036e x1 : ffff800008ed1c70 x0 : 0000000000000000
> [ 1431.693513] Call trace:
> [ 1431.693732]  mmc_put_card+0x38/0x110
> [ 1431.694055]  mmc_mq_recovery_handler+0x98/0xd0
> [ 1431.694452]  process_one_work+0x23c/0x3fc
> [ 1431.694812]  worker_thread+0x74/0x420
> [ 1431.695139]  kthread+0xec/0xf0
> [ 1431.695414]  ret_from_fork+0x10/0x20
> [ 1431.695738] Code: f9001bf7 aa0103f6 aa0003f5 aa1403e1 (f9400017)
> [ 1431.696278] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Thanks for finding these issues. A couple of comments below.

> ---
>  drivers/mmc/core/block.c | 4 ++--
>  drivers/mmc/core/queue.c | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..0cd3a7065629 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -997,8 +997,8 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>  
>  	md->reset_done |= type;
>  	err = mmc_hw_reset(host->card);
> -	/* Ensure we switch back to the correct partition */
> -	if (err) {
> +	/* Ensure we switch back to the correct partition on successful reset */
> +	if (!err) {

This isn't quite right.  Originally, this was err != -EOPNOTSUPP
so "always" unless the reset was not attempted at all.  When the -EOPNOTSUPP
return value went away, this should have become unconditional.

Also this change should be a separate patch, and have a fixes tag
i.e.

Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")

>  		struct mmc_blk_data *main_md =
>  			dev_get_drvdata(&host->card->dev);
>  		int part_err;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..6931fa082ea7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -137,9 +137,10 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>  	struct mmc_queue *mq = container_of(work, struct mmc_queue,
>  					    recovery_work);
>  	struct request_queue *q = mq->queue;
> +	struct mmc_card *card = mq->card;
>  	struct mmc_host *host = mq->card->host;
>  
> -	mmc_get_card(mq->card, &mq->ctx);
> +	mmc_get_card(card, &mq->ctx);
>  
>  	mq->in_recovery = true;
>  
> @@ -157,7 +158,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>  	if (host->hsq_enabled)
>  		host->cqe_ops->cqe_recovery_finish(host);
>  
> -	mmc_put_card(mq->card, &mq->ctx);
> +	mmc_put_card(card, &mq->ctx);
>  
>  	blk_mq_run_hw_queues(q, true);
>  }

Please try this instead:

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6931fa082ea7..d8d9115c51f6 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -494,6 +494,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	if (blk_queue_quiesced(q))
 		blk_mq_unquiesce_queue(q);
 
+	/*
+	 * If the recovery completes the last (and only remaining) request in
+	 * the queue, and the card has been removed, we could end up here with
+	 * the recovery not quite finished yet, so flush it.
+	 */
+	flush_work(&mq->recovery_work);
+
 	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*

