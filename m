Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9706D57CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjDDE4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjDDE4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD131BE1;
        Mon,  3 Apr 2023 21:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AF3462772;
        Tue,  4 Apr 2023 04:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F8C433EF;
        Tue,  4 Apr 2023 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680584197;
        bh=DEj7fP4yjaJYRm0hK8YbMkOV78W9FUtbKMsN0uDAz4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=jsIPPz2U4XtabVsmSKvsFRyZNqWTmmtZnTtO9J4sNtkztz51JGfaiKxbX/TaNOBuU
         fGdbIrMUQIuT29BDoTnmA4nen1n8MQyf9DtBq8coohhLPVIeHHxf3KZmiIxNtC+pz1
         MRjh/4fID5Zimdum/pVMkX9cqCwkEuiXkuE0txlnR6zsfIdBAShAqNF2OKWttQPuVS
         VVG7yKFr5/VFKT28MfXCLQTY9fw6+njKgXSqvyOivk4LZk7J1xy1R3kUJ87ShjPSsW
         zezg11hu1DSVrS+AM5AwGx465qyX6lQGE5aTiFx8MIFEwhtGhqRh5sHVZcUpwMLOOM
         BMsComMRqpm1g==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        "Garmin . Chang" <Garmin.Chang@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] clk: mediatek: Use right match table, include mod_devicetable
Date:   Mon,  3 Apr 2023 21:56:36 -0700
Message-Id: <20230404045636.1114141-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is copy/pasta that breaks modular builds. Fix the match table to
use the right pointer, or the right device table type. And while we're
including the header, fix the order to be linux, dt-bindings, and
finally local.

Cc: Garmin.Chang <Garmin.Chang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
Fixes: 0d2f2cefba64 ("clk: mediatek: Add MT8188 adsp clock support")
Fixes: e4aaa60eae16 ("clk: mediatek: Add MT8188 vdosys0 clock support")
Fixes: cfa4609f9bbe ("clk: mediatek: Add MT8188 vdosys1 clock support")
Fixes: bb87c1109ce2 ("clk: mediatek: Add MT8188 vencsys clock support")
Fixes: f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304011039.UBDX1UOT-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202304020649.QO2HlpD5-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202304021055.WDhQPcoS-lkp@intel.com/
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c | 6 ++++--
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c  | 6 ++++--
 drivers/clk/mediatek/clk-mt8188-vdo0.c          | 4 +++-
 drivers/clk/mediatek/clk-mt8188-vdo1.c          | 4 +++-
 drivers/clk/mediatek/clk-mt8188-venc.c          | 6 ++++--
 drivers/clk/mediatek/clk-mt8188-wpe.c           | 2 +-
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
index b3c31ffff931..808f2ad3b7ee 100644
--- a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
+++ b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
@@ -4,10 +4,12 @@
  * Author: Garmin Chang <garmin.chang@mediatek.com>
  */
 
-#include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
@@ -34,7 +36,7 @@ static const struct of_device_id of_match_clk_mt8188_adsp_audio26m[] = {
 	{ .compatible = "mediatek,mt8188-adsp-audio26m", .data = &adsp_audio26m_desc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, of_match_clk_mt8188_adsp_audio26m);
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_adsp_audio26m);
 
 static struct platform_driver clk_mt8188_adsp_audio26m_drv = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
index 2238d2984320..da41a3c59919 100644
--- a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
@@ -4,10 +4,12 @@
  * Author: Garmin Chang <garmin.chang@mediatek.com>
  */
 
-#include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
@@ -65,7 +67,7 @@ static const struct of_device_id of_match_clk_mt8188_imp_iic_wrap[] = {
 	{ .compatible = "mediatek,mt8188-imp-iic-wrap-en", .data = &imp_iic_wrap_en_desc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, of_match_clk_mt8188_imp_iic_wrap);
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_imp_iic_wrap);
 
 static struct platform_driver clk_mt8188_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo0.c b/drivers/clk/mediatek/clk-mt8188-vdo0.c
index 0c61c2dc4337..d2be44c2f3f5 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo0.c
@@ -4,10 +4,12 @@
  * Author: Garmin Chang <garmin.chang@mediatek.com>
  */
 
-#include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo1.c b/drivers/clk/mediatek/clk-mt8188-vdo1.c
index 99fcf6d7b1ab..2ef8cae2e16e 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo1.c
@@ -4,10 +4,12 @@
  * Author: Garmin Chang <garmin.chang@mediatek.com>
  */
 
-#include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
diff --git a/drivers/clk/mediatek/clk-mt8188-venc.c b/drivers/clk/mediatek/clk-mt8188-venc.c
index 6f6589ccd5a0..245367f33fa5 100644
--- a/drivers/clk/mediatek/clk-mt8188-venc.c
+++ b/drivers/clk/mediatek/clk-mt8188-venc.c
@@ -4,10 +4,12 @@
  * Author: Garmin Chang <garmin.chang@mediatek.com>
  */
 
-#include <dt-bindings/clock/mediatek,mt8188-clk.h>
 #include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+
 #include "clk-gate.h"
 #include "clk-mtk.h"
 
@@ -39,7 +41,7 @@ static const struct of_device_id of_match_clk_mt8188_venc1[] = {
 	{ .compatible = "mediatek,mt8188-vencsys", .data = &venc1_desc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, of_match_clk_mt8188_venc1);
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_venc1);
 
 static struct platform_driver clk_mt8188_venc1_drv = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt8188-wpe.c b/drivers/clk/mediatek/clk-mt8188-wpe.c
index 5abded13cece..c372ff703f9c 100644
--- a/drivers/clk/mediatek/clk-mt8188-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8188-wpe.c
@@ -88,7 +88,7 @@ static const struct of_device_id of_match_clk_mt8188_wpe[] = {
 	{ .compatible = "mediatek,mt8188-wpesys-vpp0", .data = &wpe_vpp0_desc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
+MODULE_DEVICE_TABLE(platform, of_match_clk_mt8188_wpe);
 
 static struct platform_driver clk_mt8188_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

