Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419F1725792
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjFGI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjFGI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:27:26 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE6E60;
        Wed,  7 Jun 2023 01:27:22 -0700 (PDT)
Received: from xps.skovby (85.184.138.13.dynamic.dhcp.aura-net.dk [85.184.138.13])
        by first.geanix.com (Postfix) with ESMTPSA id 9FB794E5FAC;
        Wed,  7 Jun 2023 08:27:19 +0000 (UTC)
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=martin@geanix.com smtp.mailfrom=martin@geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1686126439; bh=2eMiQLgQD/9nKKzqJMDwHwcTU9X0x8fIp1G9yAWOOlg=;
        h=From:To:Cc:Subject:Date;
        b=TtGoA9zU9lpibDRIM3aDNFNrxRnIwkOrgdkO2k2gc8vtM9pTKpROaI5bO8gBJvGvk
         92sdMMzipGbcBN1RzvCRsHEkbZmE5AG3EpimE5KZcEuMYU6thfOcSTNVuTGOTfC4ap
         iNl2WronG7BsYKsReUdimBavtb1Jer9Pkqkk3ebJV2LKz3qUZH7g4atFevGpgMgZhs
         BVwP3YI8F2CEIVuAgu74UbRakxSH5kuJPX0hyKWW6Og93Cb9hFL7P8xZpQrpl4JlJo
         c0+taRo/VeIBnzsd/ExOWecFl6EBlkZbB+cF2pdIhkkqM6ES+LC7QjdDCwkpxO8vkb
         5qzoTVU7kBxLg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] mmc: meson: remove redundant mmc_request_done() call from irq context
Date:   Wed,  7 Jun 2023 10:27:12 +0200
Message-Id: <20230607082713.517157-1-martin@geanix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to mmc_request_done() can schedule, so it must not be called
from irq context. Wake the irq thread if it needs to be called, and let
its existing logic do its work.

Fixes the following kernel bug, which appears when running an RT patched
kernel on the AmLogic Meson AXG A113X SoC:
[   11.111407] BUG: scheduling while atomic: kworker/0:1H/75/0x00010001
[   11.111438] Modules linked in:
[   11.111451] CPU: 0 PID: 75 Comm: kworker/0:1H Not tainted 6.4.0-rc3-rt2-rtx-00081-gfd07f41ed6b4-dirty #1
[   11.111461] Hardware name: RTX AXG A113X Linux Platform Board (DT)
[   11.111469] Workqueue: kblockd blk_mq_run_work_fn
[   11.111492] Call trace:
[   11.111497]  dump_backtrace+0xac/0xe8
[   11.111510]  show_stack+0x18/0x28
[   11.111518]  dump_stack_lvl+0x48/0x60
[   11.111530]  dump_stack+0x18/0x24
[   11.111537]  __schedule_bug+0x4c/0x68
[   11.111548]  __schedule+0x80/0x574
[   11.111558]  schedule_loop+0x2c/0x50
[   11.111567]  schedule_rtlock+0x14/0x20
[   11.111576]  rtlock_slowlock_locked+0x468/0x730
[   11.111587]  rt_spin_lock+0x40/0x64
[   11.111596]  __wake_up_common_lock+0x5c/0xc4
[   11.111610]  __wake_up+0x18/0x24
[   11.111620]  mmc_blk_mq_req_done+0x68/0x138
[   11.111633]  mmc_request_done+0x104/0x118
[   11.111644]  meson_mmc_request_done+0x38/0x48
[   11.111654]  meson_mmc_irq+0x128/0x1f0
[   11.111663]  __handle_irq_event_percpu+0x70/0x114
[   11.111674]  handle_irq_event_percpu+0x18/0x4c
[   11.111683]  handle_irq_event+0x80/0xb8
[   11.111691]  handle_fasteoi_irq+0xa4/0x120
[   11.111704]  handle_irq_desc+0x20/0x38
[   11.111712]  generic_handle_domain_irq+0x1c/0x28
[   11.111721]  gic_handle_irq+0x8c/0xa8
[   11.111735]  call_on_irq_stack+0x24/0x4c
[   11.111746]  do_interrupt_handler+0x88/0x94
[   11.111757]  el1_interrupt+0x34/0x64
[   11.111769]  el1h_64_irq_handler+0x18/0x24
[   11.111779]  el1h_64_irq+0x64/0x68
[   11.111786]  __add_wait_queue+0x0/0x4c
[   11.111795]  mmc_blk_rw_wait+0x84/0x118
[   11.111804]  mmc_blk_mq_issue_rq+0x5c4/0x654
[   11.111814]  mmc_mq_queue_rq+0x194/0x214
[   11.111822]  blk_mq_dispatch_rq_list+0x3ac/0x528
[   11.111834]  __blk_mq_sched_dispatch_requests+0x340/0x4d0
[   11.111847]  blk_mq_sched_dispatch_requests+0x38/0x70
[   11.111858]  blk_mq_run_work_fn+0x3c/0x70
[   11.111865]  process_one_work+0x17c/0x1f0
[   11.111876]  worker_thread+0x1d4/0x26c
[   11.111885]  kthread+0xe4/0xf4
[   11.111894]  ret_from_fork+0x10/0x20

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
Version 1 of this patch:
https://lore.kernel.org/linux-amlogic/20230606065918.460866-1-martin@geanix.com/

Changes since v1:
 * remove redundant change to meson_mmc_irq_thread(), as per Martin's
   review
 * return early instead of assigning to "ret" variable
 * change commit short-log to reflect code removal instead of it being
   moved. (Was: "mmc: meson: move mmc_request_done() call to irq thread")

 drivers/mmc/host/meson-gx-mmc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8514d9d5e736..f90b0fd8d8b00 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -991,11 +991,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		return IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -1007,9 +1004,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
 	return ret;
 }
 
-- 
2.40.1

