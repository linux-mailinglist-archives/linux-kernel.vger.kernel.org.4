Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFD5ED99B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiI1J6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiI1J6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:58:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032138C;
        Wed, 28 Sep 2022 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664359083; x=1695895083;
  h=from:to:cc:subject:date:message-id;
  bh=UvFxLRpsRpkF+7Lng/OJg8E0Da3LP+hPhxQx7w68Mqg=;
  b=OEagP1hsG44lQSKr9nDWkITOhJkN928bj7cZwF7LawBiXZFp+uydRLJk
   LIwQu6SxQOB7njR2Svb4Ka5U1bfPYVtK42WgqI3aqKqVP6bs1eHP2wOb/
   eaUWVfLvTnPmZd/SRKZU1xUS+opyKpnNQI+MHSkPy5XW9mdFOKkCAUct5
   AuuBAaeckakpHYPmtqhYKQ+RNeJjM2s1iUWGToWmexHLI9edDH542otoD
   E1LICINw22Q5gGKJ+fihiIEWzfx2DtorNFsX6KvDeWsYInOC7jp86AZLV
   cCK9SCYF76K0Gf/bXxlM+5Q3+8HJRYpCPiODRUmwXmy9xa9ZlQ6bSEAtj
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="316758252"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 17:58:02 +0800
IronPort-SDR: FcV5PZkDMSkuvx3kVlQ2tuXqDRhR3rNdHlAONXd+nCnDDP5azYPAFTXck4eUOiQtafdmfzfeZV
 ySAsS9aP7GvCCOR4nUEqCaEJAtodZRDfllfcrAmALbRwXwAmhkfqaYiDz2IT4LlOgOZ03lIIzm
 y+5I+3Sws12uSVKxXhuC3ErW9lq2uy1MOOKO9gXu8YfCPFjvPg0QXWFLhjpXaxAsxGyiCD/t1A
 9bG5RqtLe05g5EgtzQfs+hBaTPRf1zvFWRR/ljrJo/Aw/zSltZ3xUBSxgSLsRjwTfd6uqvCB+Q
 tzuKSTtz0DCnG9lnzvPJ8sOB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 02:12:26 -0700
IronPort-SDR: sOZSnNwSW/4+x8Cf4w53/oBDXXiIFrsMinZyiY8Un4QobTlvDW86u9dnh5VokjegmetrZ/EWeO
 YGaYEOldP+yiCjdKQjC1KkaOvaqibt2YR2PIGZl/MObSufEXyGv5ALhjwKubpapwIZLektJNyM
 rT+5CxmInTBclzGMTr8uL83Ys0Ibf4nBT34rxK1AYvckUFazbiSrzWptwEkj/EcJsTWWN4PD+D
 xCWXCIujNwOZfD1KqLAvperiQxpgt+ugNqe583AzGEf/m7mHRp2CoZShUfGKkbAuzba4E32ruT
 82s=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.30.255])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Sep 2022 02:57:58 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Date:   Wed, 28 Sep 2022 12:57:44 +0300
Message-Id: <20220928095744.16455-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
 - Address Ulf's suggestions

Some SD-cards that are SDA-6.0 compliant reports they supports discard
while they actually don't.  This might cause mk2fs to fail while trying
to format the card and revert it to a read-only mode.

While at it, add SD MID for SANDISK. This is because eMMC MID is assign
by JEDEC and SD MID is assigned by SD 3c-LLC.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c  | 6 +++++-
 drivers/mmc/core/card.h   | 6 ++++++
 drivers/mmc/core/quirks.h | 6 ++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..54cd009aee50 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
+	unsigned int arg = card->erase_arg;
 
-	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
+	if (mmc_card_broken_sd_discard(card))
+		arg = SD_ERASE_ARG;
+
+	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 99045e138ba4..cfdd1ff40b86 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -73,6 +73,7 @@ struct mmc_fixup {
 #define EXT_CSD_REV_ANY (-1u)
 
 #define CID_MANFID_SANDISK      0x2
+#define CID_MANFID_SANDISK_SD   0x3
 #define CID_MANFID_ATP          0x9
 #define CID_MANFID_TOSHIBA      0x11
 #define CID_MANFID_MICRON       0x13
@@ -258,4 +259,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_HPI;
 }
 
+static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
+}
+
 #endif
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

