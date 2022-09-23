Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51D5E7C66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiIWN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIWN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:56:54 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15413D1F5;
        Fri, 23 Sep 2022 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663941411; x=1695477411;
  h=from:to:cc:subject:date:message-id;
  bh=rSlGfTKQBVCzTe5a81XRRo+bRydyGLI/yUxd5mqmvHM=;
  b=cJEHkKnyHZ0Tw05+Evpy3QKv4WTcfAeQ/NKeOc/fXwYvFCnWRhSUeSnY
   vKdfRZ7P/jeb08NV+RDIaZfU2uBTi07yXK+EfbNQcBBdaXzZ308ci4eUO
   onNwmVa3TS3/gcyqBnji060SknB8aQDGvGDkeIGWMFvQ38OhzoEJ9NdWk
   onari8Jx5rftJRZRLhvl/PBHW4OtIzBw5jqnd+MchNEui4SYfpP//qYbI
   rniyEcAGAEEEAvBbuZlqyu3f53xuIQYGXOk6wLOuRj3Uns+POyf5rA7Y3
   5zNu/RwdII1earnJML4bTBTrt2FlSwkoilmjXPsM7NdtUsZ1nGPtaoRkK
   w==;
X-IronPort-AV: E=Sophos;i="5.93,339,1654531200"; 
   d="scan'208";a="217299539"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 21:56:50 +0800
IronPort-SDR: LYGHiP5PwOG+geeY94GH8F4ojP7mCFpJg32+2W1lTMUtGkOWpskvXcoN4xF93HPGw6Av57G+H6
 k3AhsGPkeLAI4mA39c8wl54qm9fr7xbLHkhDzps2q4bE4bW2T9/crmZg3yIIWTx+nbidKLBqCR
 voPAh3xCLyo8M4uM0ZiQN+qHjhmgZt2L8iT3XLFdhlYi3lg9muwP8lJ4o5PPoEMHVBW7YVvCw+
 GgxhTyGNNIJCaHqulo6x9l8xp1nxyOEeeU4fQo2/hkRc/W5bPfev3p0gZZVcrR3TH3TxCcKgSY
 JQ5CgEj/mADVy0dWUtksV8iV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 06:16:53 -0700
IronPort-SDR: AVatPTWYIqGWnR+dL9eT17aaUvAMRMzp9wQJuefWl6aZRvOBh2dUGO7WAoF5th/2m8HCevLpjh
 J9s9ZuOLM8l91QeiHOdpZMDHpxRR444QyelYk3XdbyrRt+/oLVZkZUzn3aoEv/WNQGVXbte8Py
 p8Lfk/Ugf0vOaUmANUv65XMlesekwz35rwUi0usI56/VkKdiSM6BNr4d6dpnfz7Y65cLkeST6M
 rLnVL4RdWGxDJDyRmxspqY9PXsFF6qZKzCe7ClqtJsmLp0LH+5poEHfSMERr1M3sOf4rqy61U5
 auc=
WDCIronportException: Internal
Received: from 5cg1421gqg.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.87])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Sep 2022 06:56:48 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Date:   Fri, 23 Sep 2022 16:56:17 +0300
Message-Id: <20220923135617.46-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SD-cards that are SDA-6.0 compliant reports they supports discard
while they actually don't.  This might cause mk2fs to fail while trying
to format the card and revert it to a read-only mode.

While at it, add SD MID for SANDISK. This is because eMMC MID is assign
by JEDEC and SD MID is assigned by SD 3c-LLC.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c  | 6 +++++-
 drivers/mmc/core/card.h   | 1 +
 drivers/mmc/core/quirks.h | 6 ++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..a31dc915c5ec 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
+	unsigned int arg = card->erase_arg;
 
-	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
+	if (mmc_card_sd(card) && (card->quirks & MMC_QUIRK_BROKEN_SD_DISCARD))
+		arg = SD_ERASE_ARG;
+
+	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 99045e138ba4..881432309b46 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -73,6 +73,7 @@ struct mmc_fixup {
 #define EXT_CSD_REV_ANY (-1u)
 
 #define CID_MANFID_SANDISK      0x2
+#define CID_MANFID_SANDISK_SD   0x3
 #define CID_MANFID_ATP          0x9
 #define CID_MANFID_TOSHIBA      0x11
 #define CID_MANFID_MICRON       0x13
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index be4393988086..29b9497936df 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -100,6 +100,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Some SD cards reports discard support while they don't
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
+		  MMC_QUIRK_BROKEN_SD_DISCARD),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8a30de08e913..c726ea781255 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -293,6 +293,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.17.1

