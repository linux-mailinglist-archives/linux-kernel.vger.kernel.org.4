Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1D5BE337
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiITKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiITKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:14 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CDB6F267
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 88F27280B5E;
        Tue, 20 Sep 2022 18:31:11 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 02/20] pinctrl/rockchip: populate GPIO platform early
Date:   Tue, 20 Sep 2022 18:30:50 +0800
Message-Id: <20220920103108.23074-3-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkpOVh5PQ0xPTUxJSUlOSFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktPSElVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6Djo4Fz0qTRw2VgsuLyxI
        TDJPFChVSlVKTU1ITU1CQ0xJSUtOVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUlOSks3Bg++
X-HM-Tid: 0a835a73a4c42eb1kusn88f27280b5e
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to register GPIO devices before pinctrl device, so move the
populate GPIO platform early before pinctrl do really probe.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index a91061f9c2ac..25633c7b4244 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3302,6 +3302,10 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return dev_err_probe(dev, -ENODEV, "device tree node not found\n");
 
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register gpio device\n");
+
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -3360,10 +3364,6 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to register gpio device\n");
-
 	return 0;
 }
 
-- 
2.25.1

