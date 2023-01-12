Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5B667E95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjALTEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjALTDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:03:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF569B19;
        Thu, 12 Jan 2023 10:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673548996; x=1705084996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XQH5u3DL5ISx2GfFC4iQ4W+ecE1+55/FppouOEOhfe8=;
  b=VVsrj5WMcC2BPr6ywLtnKXGPa4ohqPXLGkil3fAX56O5tjzutKLgXZQv
   MmFacd08PX9HKKNbXG5HbYuiYlws8jbuzQh8tyKc9a0RW3mischey3T7h
   7Nk1PRJ/LSOjAZ1s2/iTGB+89f59I+alWSpGOri4WzDJ1wjIGDHp2ftto
   01piTyp8UF5lDxwlExHmd8wosvWF5wL1qc5P2wtfyY431t+4lMr41yk/h
   PwKFOCGxVpCPRl+SDPCRTx6quZPvs9hkTVm6QTYH8BbsWnInHD4Hi4bMN
   oqfEV35ZsyoSfv7QqFFYvInvSSb7/dcCX4b3jeWZCJlirwXvHGvOPgCLe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325844576"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325844576"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="781868438"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="781868438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2023 10:43:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 074E0130; Thu, 12 Jan 2023 20:43:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: mediatek: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 20:43:40 +0200
Message-Id: <20230112184340.79606-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 1ec0413959e1..007b98ce5631 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -574,7 +574,6 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
-	chip->of_gpio_n_cells	= 2;
 
 	ret = gpiochip_add_data(chip, hw);
 	if (ret < 0)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 553d16703475..665dec419e7c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -906,7 +906,6 @@ static const struct gpio_chip mtk_gpio_chip = {
 	.set			= mtk_gpio_set,
 	.to_irq			= mtk_gpio_to_irq,
 	.set_config		= mtk_gpio_set_config,
-	.of_gpio_n_cells	= 2,
 };
 
 static int mtk_eint_suspend(struct device *device)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 475f4172d508..17eead44b675 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -987,7 +987,6 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
-	chip->of_gpio_n_cells	= 2;
 
 	ret = gpiochip_add_data(chip, hw);
 	if (ret < 0)
-- 
2.39.0

