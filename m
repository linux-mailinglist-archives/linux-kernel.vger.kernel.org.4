Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C255BE34D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiITKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiITKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:25 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1770E73
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 16680280BCB;
        Tue, 20 Sep 2022 18:31:22 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 16/20] gpio/rockchip: try to get gpio id from uid when ACPI enabled
Date:   Tue, 20 Sep 2022 18:31:04 +0800
Message-Id: <20220920103108.23074-17-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxpDVktDSUweTx5IGBhDSVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6Lyo6ST0qPhwyFxRDLy4N
        ThcKChlVSlVKTU1ITU1CQ0NJTElNVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhNQkw3Bg++
X-HM-Tid: 0a835a73cdea2eb1kusn16680280bcb
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ACPI is enabled, the GPIO index should be get from the uid,
otherwise get it from the dt alias or a static count to the legency dt
files.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 40 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 09ed5c880dde..11586d93549b 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -710,6 +711,29 @@ rockchip_gpio_find_bank(struct pinctrl_dev *pctldev, int id)
 	return found ? bank : NULL;
 }
 
+static int rockchip_gpio_get_bank_id(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	int bank_id = -EINVAL;
+	u64 uid;
+	int ret;
+	static int gpio;
+
+	if (is_acpi_node(fwnode)) {
+		ret = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+		if (ret < 0)
+			return ret;
+
+		bank_id = uid;
+	} else {
+		bank_id = of_alias_get_id(to_of_node(fwnode), "gpio");
+		if (bank_id < 0)
+			bank_id = gpio++;
+	}
+
+	return bank_id;
+}
+
 static int rockchip_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -717,8 +741,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	struct device_node *pctlnp = of_get_parent(np);
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
-	static int gpio;
-	int id, ret;
+	int ret;
 
 	if (!np || !pctlnp)
 		return -ENODEV;
@@ -727,13 +750,11 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
-	id = of_alias_get_id(np, "gpio");
-	if (id < 0)
-		id = gpio++;
-
-	bank = rockchip_gpio_find_bank(pctldev, id);
-	if (!bank)
-		return -EINVAL;
+	ret = rockchip_gpio_get_bank_id(dev);
+	if (ret >= 0)
+		bank->bank_num = ret;
+	else
+		goto err;
 
 	bank->dev = dev;
 	bank->of_node = np;
@@ -759,6 +780,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	clk_put(bank->db_clk);
 	clk_disable_unprepare(bank->clk);
 	clk_disable_unprepare(bank->db_clk);
+err:
 
 	return ret;
 }
-- 
2.25.1

