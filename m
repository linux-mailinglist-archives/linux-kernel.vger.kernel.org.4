Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDB6ECC64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDXMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDXMxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:53:46 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75EF123;
        Mon, 24 Apr 2023 05:53:45 -0700 (PDT)
Received: from haru.localdomain ([10.12.176.125])
        (user=m202071377@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33OCpkk5030859-33OCpkk6030859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Apr 2023 20:51:53 +0800
From:   XuDong Liu <m202071377@hust.edu.cn>
To:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Date:   Mon, 24 Apr 2023 20:51:00 +0800
Message-Id: <20230424125100.4783-1-m202071377@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: m202071377@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn: 
'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.

In the function brcmuart_probe(), baud_mux_clk was not correctly released
in subsequent error handling, which may cause memory leaks.

To fix this issue, an error handling branch, err_clk_put, is added to
release the variable using clk_put(), and an err_disable branch is added
to meet the requirement of balancing clk_disable and clk_enable calls.

Fixes: 15ac1122fd6d ("serial: 8250_bcm7271: Fix arbitration handling")
Signed-off-by: XuDong Liu <m202071377@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is discovered by static analysis, and the patch is not tested
yet.
---
 drivers/tty/serial/8250/8250_bcm7271.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index f801b1f5b46c..b1670558868b 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1023,7 +1023,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 		dev_dbg(dev, "BAUD MUX clock found\n");
 		ret = clk_prepare_enable(baud_mux_clk);
 		if (ret)
-			goto release_dma;
+			goto err_clk_put;
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
 		clk_rate = priv->default_mux_rate;
@@ -1032,7 +1032,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
 		ret = -EINVAL;
-		goto release_dma;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1119,6 +1119,10 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
+err_clk_disable:
+	clk_disable_unprepare(baud_mux_clk);
+err_clk_put:
+	clk_put(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
-- 
2.34.1

