Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1C64012B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLBHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:44:09 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144765E6A;
        Thu,  1 Dec 2022 23:44:08 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 682CB1A09F4;
        Fri,  2 Dec 2022 08:44:07 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3153A1A09DA;
        Fri,  2 Dec 2022 08:44:07 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F1474180031C;
        Fri,  2 Dec 2022 15:44:05 +0800 (+08)
From:   andy.tang@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Tang <andy.tang@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock frequency
Date:   Fri,  2 Dec 2022 15:59:05 +0800
Message-Id: <20221202075905.25363-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Tang <andy.tang@nxp.com>

The highest clock frequency for eMMC HS200 mode on ls1043a
is 116.7Mhz according to its specification.
So add the limit to gate the frequency.

Signed-off-by: Andy Tang <andy.tang@nxp.com>
---
v2: change the author to andy tang

 drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 00542dd74c07..1fd4ae10862d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -43,6 +43,12 @@ static const struct esdhc_clk_fixup ls1021a_esdhc_clk = {
 	.max_clk[MMC_TIMING_SD_HS] = 46500000,
 };
 
+static const struct esdhc_clk_fixup ls1043a_esdhc_clk = {
+	.sd_dflt_max_clk = 25000000,
+	.max_clk[MMC_TIMING_UHS_SDR104] = 116700000,
+	.max_clk[MMC_TIMING_MMC_HS200] = 116700000,
+};
+
 static const struct esdhc_clk_fixup ls1046a_esdhc_clk = {
 	.sd_dflt_max_clk = 25000000,
 	.max_clk[MMC_TIMING_UHS_SDR104] = 167000000,
@@ -64,6 +70,7 @@ static const struct esdhc_clk_fixup p1010_esdhc_clk = {
 
 static const struct of_device_id sdhci_esdhc_of_match[] = {
 	{ .compatible = "fsl,ls1021a-esdhc", .data = &ls1021a_esdhc_clk},
+	{ .compatible = "fsl,ls1043a-esdhc", .data = &ls1043a_esdhc_clk},
 	{ .compatible = "fsl,ls1046a-esdhc", .data = &ls1046a_esdhc_clk},
 	{ .compatible = "fsl,ls1012a-esdhc", .data = &ls1012a_esdhc_clk},
 	{ .compatible = "fsl,p1010-esdhc",   .data = &p1010_esdhc_clk},
-- 
2.25.1

