Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02E72289C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFEOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFEOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:18:28 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B59B;
        Mon,  5 Jun 2023 07:18:27 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1q6B2N-00073n-07;
        Mon, 05 Jun 2023 14:18:23 +0000
Date:   Mon, 5 Jun 2023 15:18:12 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] cpufreq: mediatek: correct voltages for MT7622 and MT7623
Message-ID: <ZH3umLU883eGbYBx@makrotopia.org>
References: <9d7e62049e3442582bd64dbc9e4d2a64f1ad0c1a.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7e62049e3442582bd64dbc9e4d2a64f1ad0c1a.camel@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6380 regulator typically used together with MT7622 does not
support the current maximum processor and SRAM voltage in the cpufreq
driver (1360000uV).
For MT7622 limit processor and SRAM supply voltages to 1350000uV to
avoid having the tracking algorithm request unsupported voltages from
the regulator.

On MT7623 there is no separate SRAM supply and the maximum voltage used
is 1300000uV. Create dedicated platform data for MT7623 to cover that
case as well.

Fixes: 0883426fd07e3 ("cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623")
Suggested-by: Jia-wei Chang <Jia-wei.Chang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 9a39a7ccfae96..fef68cb2b38f7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -696,9 +696,16 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
 static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
 	.min_volt_shift = 100000,
 	.max_volt_shift = 200000,
-	.proc_max_volt = 1360000,
+	.proc_max_volt = 1350000,
 	.sram_min_volt = 0,
-	.sram_max_volt = 1360000,
+	.sram_max_volt = 1350000,
+	.ccifreq_supported = false,
+};
+
+static const struct mtk_cpufreq_platform_data mt7623_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1300000,
 	.ccifreq_supported = false,
 };
 
@@ -734,7 +741,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
-	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
+	{ .compatible = "mediatek,mt7623", .data = &mt7623_platform_data },
 	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
-- 
2.41.0

