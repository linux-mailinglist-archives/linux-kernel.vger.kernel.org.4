Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B9721DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjFEGB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:01:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B0CA;
        Sun,  4 Jun 2023 23:01:17 -0700 (PDT)
X-UUID: 5ed2b33a036611ee9cb5633481061a41-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZWZFr/18qkTzkN+m8S3/zs4o4uIe3CpN4mxCWBr/BzU=;
        b=m5vbC2+6McGRKKDyuFPfCEZjrnb2f1UOrdguzXEg7USZrci+Hb2e+GPfugBbnfZ8wIQF2s9JpawIMrwmjxgVWa7KNP8YPf4+bPPwniiOvVUtHGQ6B7y0orM/424H39WiSETNrxkhvbRnMDz+ZlxzTrovf8bBuEjG7QXvpq/9+yk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:acdd7724-f194-42a4-824a-04e700831a06,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.25,REQID:acdd7724-f194-42a4-824a-04e700831a06,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9f5e066e-2f20-4998-991c-3b78627e4938,B
        ulkID:230605140111FP2VMDKM,BulkQuantity:1,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5ed2b33a036611ee9cb5633481061a41-20230605
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 507589308; Mon, 05 Jun 2023 14:01:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 14:01:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 14:01:08 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Date:   Mon, 5 Jun 2023 14:01:07 +0800
Message-ID: <20230605060107.22044-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
SEND_QUEUE_STATUS(CMD13) polling.
Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
frequency to get the actual time.
The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
decrease it to 0x40 that corresponds to 2.35us, which can improve the
performance of some eMMC devices.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 drivers/mmc/host/cqhci.h  |  1 +
 drivers/mmc/host/mtk-sd.c | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index ba9387ed90eb..292b89ebd978 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -23,6 +23,7 @@
 /* capabilities */
 #define CQHCI_CAP			0x04
 #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
+#define CQHCI_CAP_ITCFMUL(x)		(((x) & GENMASK(15, 12)) >> 12)
 
 /* configuration */
 #define CQHCI_CFG			0x08
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index edade0e54a0c..c221ef8a6992 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -473,6 +473,7 @@ struct msdc_host {
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
 	struct cqhci_host *cq_host;
+	u32 cq_ssc1_time;
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
@@ -2450,9 +2451,50 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
 	}
 }
 
+static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
+{
+	struct mmc_host *mmc = mmc_from_priv(host);
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u8 itcfmul;
+	u32 hclk_freq;
+	u64 value;
+
+	/* Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
+	 * frequency to get the actual time for CIT.
+	 */
+	if (host->h_clk) {
+		hclk_freq = clk_get_rate(host->h_clk);
+		itcfmul = CQHCI_CAP_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
+		switch (itcfmul) {
+		case 0x0:
+			do_div(hclk_freq, 1000);
+			break;
+		case 0x1:
+			do_div(hclk_freq, 100);
+			break;
+		case 0x2:
+			do_div(hclk_freq, 10);
+			break;
+		case 0x3:
+			break;
+		case 0x4:
+			hclk_freq = hclk_freq * 10;
+			break;
+		default:
+			host->cq_ssc1_time = 0x40;
+			return;
+		value = hclk_freq * timer_ns;
+		do_div(value, 1000000000ULL);
+		host->cq_ssc1_time = value;
+	} else {
+		host->cq_ssc1_time = 0x40;
+	}
+}
+
 static void msdc_cqe_enable(struct mmc_host *mmc)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+	struct cqhci_host *cq_host = mmc->cqe_private;
 
 	/* enable cmdq irq */
 	writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
@@ -2462,6 +2504,9 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
 	msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
 	/* default read data timeout 1s */
 	msdc_set_timeout(host, 1000000000ULL, 0);
+
+	/* Set the send status command idle timer */
+	cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
 }
 
 static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
@@ -2803,6 +2848,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		/* cqhci 16bit length */
 		/* 0 size, means 65536 so we don't have to -1 here */
 		mmc->max_seg_size = 64 * 1024;
+		/* Reduce CIT to 0x40 that corresponds to 2.35us */
+		msdc_cqe_cit_cal(host, 2350);
 	}
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
-- 
2.25.1

