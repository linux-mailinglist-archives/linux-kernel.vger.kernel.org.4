Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7B5BE345
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiITKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiITKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:25 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E716F560
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 52F51280BC7;
        Tue, 20 Sep 2022 18:31:21 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 15/20] gpio/rockchip: disable and put clocks when gpiolib register failed
Date:   Tue, 20 Sep 2022 18:31:03 +0800
Message-Id: <20220920103108.23074-16-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx9IVkodH01PSR9OQ0pPSFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6Fxw5PT0oKhwJLRQDLyMR
        DQowCQhVSlVKTU1ITU1CQ0NJS0hMVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUlITkI3Bg++
X-HM-Tid: 0a835a73cafe2eb1kusn52f51280bc7
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gpiolib register failed, the clocks should be disabled and put.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 4fcd75d710c1..09ed5c880dde 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -746,14 +746,21 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
-		clk_disable_unprepare(bank->clk);
-		return ret;
+		dev_err(bank->dev, "Failed to register gpio %d\n", ret);
+		goto err_put_clk;
 	}
 
 	platform_set_drvdata(pdev, bank);
 	dev_info(dev, "probed %pOF\n", np);
 
 	return 0;
+err_put_clk:
+	clk_put(bank->clk);
+	clk_put(bank->db_clk);
+	clk_disable_unprepare(bank->clk);
+	clk_disable_unprepare(bank->db_clk);
+
+	return ret;
 }
 
 static int rockchip_gpio_remove(struct platform_device *pdev)
-- 
2.25.1

