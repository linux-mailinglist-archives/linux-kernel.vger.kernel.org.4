Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B955B341C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIIJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiIIJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:37:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5797EDE;
        Fri,  9 Sep 2022 02:37:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC1136601657;
        Fri,  9 Sep 2022 10:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662716251;
        bh=VUIE2ULcIZ7NEXZB53jupjRin58XQGFQ/42Sux2176I=;
        h=From:To:Cc:Subject:Date:From;
        b=LVuPgSXSB1Q94QcHPkBlwznaWhMhNik57Es0RYRkm5EF2fIW0UG9UhUNf7y3bUWjW
         19XtHTJyuv5DtMYpHHiWSRFyfu7J/G9DsM1qeU5JZFQhE3tbAhAU4pu4BrIFSIKbH3
         PAyVB+Nc+p3wXz2Cj6vE6kX++OfbehaS1Esm1mkRF7eODzukX4tRp715gC4C4jrKFz
         MhN61qfYysiInZ/++gvBhIGMQdYLYKH9JmrQ01J9ntUUPg9QmaPoTby0loyAu+RyWI
         14GfqhZd6+MsbuxFNp4RzrCGM3Ljy+P+NQZyeGU9Vb0YN/lm/Y6kMSwz44vmPWZ0hL
         rYYAEmfBAxjHw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, andrew-sh.cheng@mediatek.com,
        jia-wei.chang@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] cpufreq: mediatek: Fix KP and lockups on proc/sram regulators error
Date:   Fri,  9 Sep 2022 11:37:24 +0200
Message-Id: <20220909093724.40078-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function regulator_get_optional() returns a negative error number on
any kind of regulator_get() failure: failing to check for that in the
teardown path will lead to a kernel panic due to a call to function
regulator_disable().

Besides that, the "proc" regulator does actually provide power to the
CPU cluster(s): disabling it will produce a lockup on at least some
SoCs, such as MT8173.

That consideration is also valid for the "sram" regulator, providing
power to the CPU caches instead, present on some other SoCs, such as
MT8183, MT8186 (and others).

Resolve both situations and by simply removing the entire faulty
branches responsible for disabling the aforementioned regulators if
enabled, keeping in mind that these are enabled (and left enabled)
by the bootloader before booting the kernel.

Fixes: 4b9ceb757bbb ("cpufreq: mediatek: Enable clocks and regulators")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7f2680bc9a0f..d68f16f475a6 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -534,11 +534,6 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
-	if (regulator_is_enabled(info->proc_reg))
-		regulator_disable(info->proc_reg);
-	if (info->sram_reg && regulator_is_enabled(info->sram_reg))
-		regulator_disable(info->sram_reg);
-
 	if (!IS_ERR(info->proc_reg))
 		regulator_put(info->proc_reg);
 	if (!IS_ERR(info->sram_reg))
@@ -553,14 +548,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 
 static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 {
-	if (!IS_ERR(info->proc_reg)) {
-		regulator_disable(info->proc_reg);
+	if (!IS_ERR(info->proc_reg))
 		regulator_put(info->proc_reg);
-	}
-	if (!IS_ERR(info->sram_reg)) {
-		regulator_disable(info->sram_reg);
+	if (!IS_ERR(info->sram_reg))
 		regulator_put(info->sram_reg);
-	}
 	if (!IS_ERR(info->cpu_clk)) {
 		clk_disable_unprepare(info->cpu_clk);
 		clk_put(info->cpu_clk);
-- 
2.37.2

