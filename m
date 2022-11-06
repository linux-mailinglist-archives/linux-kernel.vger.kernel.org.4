Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0005861E030
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKFDkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKFDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:40:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A1C75E;
        Sat,  5 Nov 2022 20:40:14 -0700 (PDT)
X-UUID: 08aac0423735415ead2c733b63bb463f-20221106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dz2mheJDfObycJwcc1Bk8TmgsLqq6x+ImrkrFILsGBU=;
        b=EQ9dWJKA8DZWU1A8AqxqKdlm5H3HZBmJuDJOK9FR/Ax/KIr1UYp3qQ/u5eXnUbBwntZD3Xn/vh+yxFI7Uu5EhEKOxcfef0EUfUFfuR2b843XRIUe3k4bbpsfcJwggn3e4js4pzmseQi/I5Cwvf+qVnyHKKi277s5bJDofR8+MR8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:541ddcc8-6027-48e8-90ec-4ac15b9e2825,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:6be18beb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 08aac0423735415ead2c733b63bb463f-20221106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 542255528; Sun, 06 Nov 2022 11:40:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 6 Nov 2022 11:40:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sun, 6 Nov 2022 11:40:08 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <mengqi.zhang@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND v2 1/2] mmc: mtk-sd: add Inline Crypto Engine clock control
Date:   Sun, 6 Nov 2022 11:39:24 +0800
Message-ID: <20221106033924.9854-2-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
References: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto clock control and ungate it before CQHCI init.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 3f7f3a1e0df8..652a67f9b054 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -452,6 +452,7 @@ struct msdc_host {
 	struct clk *bus_clk;	/* bus clock which used to access register */
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	struct clk *sys_clk_cg;	/* msdc subsys clock control gate */
+	struct clk *crypto_clk; /* msdc crypto clock control gate */
 	struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
@@ -840,6 +841,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 static void msdc_gate_clock(struct msdc_host *host)
 {
 	clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
+	clk_disable_unprepare(host->crypto_clk);
 	clk_disable_unprepare(host->src_clk_cg);
 	clk_disable_unprepare(host->src_clk);
 	clk_disable_unprepare(host->bus_clk);
@@ -855,6 +857,7 @@ static int msdc_ungate_clock(struct msdc_host *host)
 	clk_prepare_enable(host->bus_clk);
 	clk_prepare_enable(host->src_clk);
 	clk_prepare_enable(host->src_clk_cg);
+	clk_prepare_enable(host->crypto_clk);
 	ret = clk_bulk_prepare_enable(MSDC_NR_CLOCKS, host->bulk_clks);
 	if (ret) {
 		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
@@ -2672,6 +2675,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* only eMMC has crypto property */
+	if (!(mmc->caps2 & MMC_CAP2_NO_MMC)) {
+		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
+		if (IS_ERR(host->crypto_clk))
+			host->crypto_clk = NULL;
+		else
+			mmc->caps2 |= MMC_CAP2_CRYPTO;
+	}
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = -EINVAL;
-- 
2.25.1

