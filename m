Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F45BE33A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiITKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiITKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:15 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A026F275
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 3F483280AB7;
        Tue, 20 Sep 2022 18:31:12 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 03/20] pinctrl/rockchip: use fwnode instead of of_node
Date:   Tue, 20 Sep 2022 18:30:51 +0800
Message-Id: <20220920103108.23074-4-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh5IVkpIGU9KT0pITkxLH1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6ARw6ED0YURxCLQpNLyhD
        PhVPFD5VSlVKTU1ITU1CQ0xJQ0JNVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhJT083Bg++
X-HM-Tid: 0a835a73a7882eb1kusn3f483280ab7
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the pinctrl driver to use fwnode instead of the of_node.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 25633c7b4244..723b44edc1f2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3033,8 +3033,8 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 					      struct rockchip_pinctrl *info)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *child;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct device_node *np = to_of_node(fwnode), *child;
 	int ret;
 	int i;
 
@@ -3129,7 +3129,8 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 						struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct device_node *node = to_of_node(fwnode);
 	const struct of_device_id *match;
 	struct rockchip_pin_ctrl *ctrl;
 	struct rockchip_pin_bank *bank;
@@ -3291,15 +3292,16 @@ static SIMPLE_DEV_PM_OPS(rockchip_pinctrl_dev_pm_ops, rockchip_pinctrl_suspend,
 
 static int rockchip_pinctrl_probe(struct platform_device *pdev)
 {
-	struct rockchip_pinctrl *info;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node, *node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct device_node *np = to_of_node(fwnode), *node;
+	struct rockchip_pinctrl *info;
 	struct rockchip_pin_ctrl *ctrl;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
 
-	if (!dev->of_node)
+	if (!is_of_node(fwnode))
 		return dev_err_probe(dev, -ENODEV, "device tree node not found\n");
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
-- 
2.25.1

