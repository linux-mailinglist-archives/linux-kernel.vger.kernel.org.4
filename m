Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1518604B95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJSPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiJSPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:33:52 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B4155DBB;
        Wed, 19 Oct 2022 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1666193322;
  x=1697729322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hCTTTOmWPuE1nWOozcq8XqfrXalZRdh/62SN0Hq9k/w=;
  b=IoyWvcE3I23IrYGwjXMnrIcRZqADX9mVwWFm21pzRNtbiqO+boTXR9FE
   vjm/MioM/teU5PLVosGqge+6VShQIi5e8nsgF9zFtzdkj06z54Mg0JzTq
   cpB4AEJXTebz7cxTZbHkiLx5fhW/M4MhZnKy49gXQNwdzgcWw+cYHExb4
   wjAYufjf3wA2TcSPgqjj/Lmc8nRtj3jhxGHRZuZuOoHFWYh3w/PVkFTpL
   eA87mS463WvwzICfNEmyWwEtMX+Obyelk1s1Kq8Fg2O7nOLtCx57VSZ5L
   H3MQXx0z9d4wSIBAC+JTRUq1RRsLMQ6+IO/mdAwkP3NrCpPLZhOyi8fjP
   g==;
Date:   Wed, 19 Oct 2022 17:07:27 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prathamesh Shete <pshete@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: support zeroout using TRIM
Message-ID: <Y1ASr6zpqobEbFmG@axis.com>
References: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
 <3c75ca82-f889-a346-a031-2c417c57e2b0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c75ca82-f889-a346-a031-2c417c57e2b0@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:54:12PM +0200, Jon Hunter wrote:
> [    4.168317] mmc0: Command Queue Engine enabled
> [    4.176723] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    4.189609] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    4.207660] mmc0: running CQE recovery
> [    4.215332]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42
> [    4.249403] mmcblk0boot0: mmc0:0001 HBG4a2 8.00 MiB
> [    4.255457] mmcblk0boot1: mmc0:0001 HBG4a2 8.00 MiB
> [    4.262063] mmcblk0rpmb: mmc0:0001 HBG4a2 4.00 MiB, chardev (511:0)
> ...
> [    9.034384] ------------[ cut here ]------------
> [    9.038985] WARNING: CPU: 4 PID: 199 at /mlt/kernel/drivers/mmc/core/block.c:2379 mmc_blk_mq_issue_rq+0x370/0x820
> [    9.049100] Modules linked in: ip_tables x_tables ipv6
> [    9.054180] CPU: 4 PID: 199 Comm: kworker/4:1H Not tainted 6.1.0-rc1-00025-gaae703b02f92 #1
> [    9.062399] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
> [    9.068821] Workqueue: kblockd blk_mq_run_work_fn
> [    9.073464] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.080318] pc : mmc_blk_mq_issue_rq+0x370/0x820
> [    9.084872] lr : mmc_blk_mq_issue_rq+0x70/0x820
> [    9.089382] sp : ffff80000b5b3ad0
> [    9.092643] x29: ffff80000b5b3ad0 x28: ffff00008467a288 x27: 0000000000000014
> [    9.099733] x26: ffff000082d49000 x25: ffff00008467a240 x24: ffff0000802acad8
> [    9.106758] x23: ffff0000802aca10 x22: ffff0000802aca00 x21: 0000000000000000
> [    9.113810] x20: ffff000080fa0800 x19: ffff800009824000 x18: 0000000000000080
> [    9.120858] x17: 0000000000000000 x16: f8ffffffffffffff x15: 000000000000029a
> [    9.127918] x14: 0000000000000000 x13: 0000000000002000 x12: 0000000000000000
> [    9.134980] x11: 0000000106d66000 x10: 0000000000000001 x9 : 0000000000000002
> [    9.142066] x8 : 0000000000000009 x7 : ffff000084650118 x6 : 00000000000000ff
> [    9.149171] x5 : ffff000084650000 x4 : 0000000000403082 x3 : ffffffffffffca4a
> [    9.156240] x2 : 0000000000000000 x1 : 00000000ffffffe7 x0 : 0000000000000009
> [    9.163276] Call trace:
> [    9.165737]  mmc_blk_mq_issue_rq+0x370/0x820
> [    9.169993]  mmc_mq_queue_rq+0x134/0x270
> [    9.173900]  blk_mq_dispatch_rq_list+0x14c/0x8d8
> [    9.178500]  blk_mq_do_dispatch_sched+0x330/0x348
> [    9.183169]  __blk_mq_sched_dispatch_requests+0xd4/0x170
> [    9.188440]  blk_mq_sched_dispatch_requests+0x34/0x70
> [    9.193456]  __blk_mq_run_hw_queue+0x58/0xb0
> [    9.197666]  blk_mq_run_work_fn+0x20/0x28
> [    9.201673]  process_one_work+0x1e0/0x348
> [    9.205672]  worker_thread+0x48/0x410
> [    9.209326]  kthread+0xf4/0x110
> [    9.212462]  ret_from_fork+0x10/0x20
> [    9.216025] ---[ end trace 0000000000000000 ]---
> [    9.220899] I/O error, dev mmcblk0, sector 12624 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> [   11.500035] I/O error, dev mmcblk0, sector 16720 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> [   13.804317] I/O error, dev mmcblk0, sector 20816 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> [   16.104063] I/O error, dev mmcblk0, sector 24912 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
> 
> 
> Reverting this makes the issue go away. Please let me know if you have any thoughts on this.

Could you please test if the below change fixes it?  Thank you.

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fefaa901b50f..3661ba0bbc87 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -48,6 +48,7 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
 	case REQ_OP_DRV_OUT:
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
 		return MMC_ISSUE_SYNC;
 	case REQ_OP_FLUSH:
 		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
