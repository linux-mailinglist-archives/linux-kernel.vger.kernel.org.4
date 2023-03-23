Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980C6C661B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCWLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCWLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:06:21 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4CB10AA5;
        Thu, 23 Mar 2023 04:06:19 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pfIlm-0002bz-3B;
        Thu, 23 Mar 2023 12:06:11 +0100
Date:   Thu, 23 Mar 2023 11:04:23 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, John Crispin <john@phrozen.org>
Subject: [PATCH] cpufreq: mediatek: guard error paths to avoid kernel panic
Message-ID: <ZBwyN7NwZ2zqHygr@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guard pointer access in error path of mtk_cpu_dvfs_info_init() to
make sure info->proc_reg and info->sram_reg are valid pointers before
accessing them, which would result in kernel panic e.g. in case of
them being set to -EPROBE_DEFER.

Fixes: 4b9ceb757bbb ("cpufreq: mediatek: Enable clocks and regulators")
Reported-by: Sam Shih <sam.shih@mediatek.com>
Suggested-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 4466d0c91a6a..980a31ddd0f2 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -579,10 +579,12 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
-	if (regulator_is_enabled(info->proc_reg))
-		regulator_disable(info->proc_reg);
-	if (info->sram_reg && regulator_is_enabled(info->sram_reg))
-		regulator_disable(info->sram_reg);
+	if (!IS_ERR(info->proc_reg))
+		if (regulator_is_enabled(info->proc_reg))
+			regulator_disable(info->proc_reg);
+	if (!IS_ERR(info->sram_reg))
+		if (info->sram_reg && regulator_is_enabled(info->sram_reg))
+			regulator_disable(info->sram_reg);
 
 	if (!IS_ERR(info->proc_reg))
 		regulator_put(info->proc_reg);
-- 
2.40.0

