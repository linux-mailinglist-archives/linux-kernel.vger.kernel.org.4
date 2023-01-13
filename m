Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3B66A5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjAMWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAMWGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:06:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A3FAC2;
        Fri, 13 Jan 2023 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673647594; x=1705183594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Flxi6EUcZGij5EF5GXZlsxhBlLZcNoFG8oxpYWo86fA=;
  b=YGFCafbnY+E/wMz4R0S2rNvzbl8MULJcQVrF6IE1TDIIsqtPKFi06LRK
   o2scBYSm6z1YWWU4e1VC3IJD9ohiNDeiV4VbGr73wqK4VOnG/UOVljT94
   67QXdCeq09xOZVcvUx/JCP9YIRohrPuJR4r3Eno3Ey7oV8G3hYeUydXcu
   1uBJUtUR6YG8ql6sZm6/5L/A8T8IvM33FsNIXQlpQVGk/hvxUfYclrN4T
   j1nS/9h0i4GNziLK8ml7yfSHRFg3KiXgEEdAAzzrPOcT7egf2hZvh0eRn
   wOKcTLQRQ148YI8QoKTffyv9B5Bvt7js+9EGlXeomaeqjmveLxTn1KYNh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410353619"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="410353619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 14:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="903715618"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="903715618"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2023 14:06:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 743BEE1; Sat, 14 Jan 2023 00:07:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: qcom: Unify accessing to device fwnode
Date:   Sat, 14 Jan 2023 00:07:03 +0200
Message-Id: <20230113220703.45686-1-andriy.shevchenko@linux.intel.com>
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

The device fwnode can be get via dev_fwnode() getter.
Use it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c       | 2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 47e9a8b0d474..5142c363480a 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1350,7 +1350,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	girq = &chip->irq;
 	gpio_irq_chip_set_chip(girq, &msm_gpio_irq_chip);
 	girq->parent_handler = msm_gpio_irq_handler;
-	girq->fwnode = pctrl->dev->fwnode;
+	girq->fwnode = dev_fwnode(pctrl->dev);
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(pctrl->dev, 1, sizeof(*girq->parents),
 				     GFP_KERNEL);
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 66d6d7ffbd43..ea3485344f06 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1146,7 +1146,7 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	gpio_irq_chip_set_chip(girq, &spmi_gpio_irq_chip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
-	girq->fwnode = of_node_to_fwnode(state->dev->of_node);
+	girq->fwnode = dev_fwnode(state->dev);
 	girq->parent_domain = parent_domain;
 	girq->child_to_parent_hwirq = pmic_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = pmic_gpio_populate_parent_fwspec;
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 063177b79927..644fb4a0e72a 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -927,7 +927,7 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 	girq->chip = &state->irq;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
-	girq->fwnode = of_node_to_fwnode(state->dev->of_node);
+	girq->fwnode = dev_fwnode(state->dev);
 	girq->parent_domain = parent_domain;
 	girq->child_to_parent_hwirq = pmic_mpp_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = gpiochip_populate_parent_fwspec_fourcell;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 99314925bb13..e973001e5c88 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -791,7 +791,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	girq->chip = &pm8xxx_irq_chip;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
-	girq->fwnode = of_node_to_fwnode(pctrl->dev->of_node);
+	girq->fwnode = dev_fwnode(pctrl->dev);
 	girq->parent_domain = parent_domain;
 	girq->child_to_parent_hwirq = pm8xxx_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = gpiochip_populate_parent_fwspec_twocell;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index a46650db678a..86f66cb8bf30 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -881,7 +881,7 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	girq->chip = &pctrl->irq;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
-	girq->fwnode = of_node_to_fwnode(pctrl->dev->of_node);
+	girq->fwnode = dev_fwnode(pctrl->dev);
 	girq->parent_domain = parent_domain;
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,pm8821-mpp"))
 		girq->child_to_parent_hwirq = pm8821_mpp_child_to_parent_hwirq;
-- 
2.39.0

