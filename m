Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A06D7C11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjDEL5f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDEL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:57:33 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5583A9F;
        Wed,  5 Apr 2023 04:57:32 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id AA3223A2A48;
        Wed,  5 Apr 2023 13:57:30 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9F7493A2A2E;
        Wed,  5 Apr 2023 13:57:30 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 13:57:30 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/3] mmc: block: ioctl: do write error check for spi
Thread-Topic: [PATCH 2/3] mmc: block: ioctl: do write error check for spi
Thread-Index: AdlntXn494MEXcKXSfqeBK92Asvg4Q==
Date:   Wed, 5 Apr 2023 11:57:29 +0000
Message-ID: <4bdab00c5b6f4f8f95b53e586552acfa@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27546.007
X-TMASE-Result: 10--4.347800-10.000000
X-TMASE-MatchedRID: w2TFuZOvAtcQGnUKwIl68khwlOfYeSqxNYERielKfYUN76LiU8zntr8F
        Hrw7frluf146W0iUu2vw/CbUDQShN4XAE/PjVlh/9k5nZzZVBSCZIt4iAQN6PzYnGCpPrrgS1Ie
        ckOrbKEzJk6fP3XeBhftIw293QqFjJBgtEIxUn4HwgrvJFY9E0bv20oRSy8wlmyiLZetSf8lRfL
        aSAVDtyiq2rl3dzGQ1t+hBIx76WOATnqbUC7CCRIv294R2X7x+V9n+w3jzGffJhriFTHyEkg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 8a8d3480-9faf-4afb-9436-8b4aa079d621-0-0-200-0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI doesn't have the usual PROG path we can check for error bits
after moving back to TRAN. Instead it holds the line LOW until
completion. We can then check if the card shows any errors or
is in IDLE state, indicating the line is no longer LOW because
the card was reset.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 16e262ddc954..35ff7101cbb1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -182,6 +182,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       int recovery_mode,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
+static int mmc_spi_err_check(struct mmc_card *card);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -553,7 +554,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	/* If it's an R1B response we need some more preparations. */
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
-	if (r1b_resp)
+	if (r1b_resp && !mmc_host_is_spi(card->host))
 		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
 						    busy_timeout_ms);
 
@@ -612,8 +613,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 		return 0;
 
+	if (mmc_host_is_spi(card->host)) {
+		if (idata->ic.write_flag)
+			err = mmc_spi_err_check(card);
+	}
 	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
-	if (idata->rpmb || r1b_resp)
+	else if (idata->rpmb || r1b_resp)
 		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
 					MMC_BUSY_IO);
 
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

