Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8992F70A616
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjETHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjETHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:11:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFE1BD
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:11:09 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0Gk7qZUTZEQ0Y0Gk7qts3h; Sat, 20 May 2023 09:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684566667;
        bh=VFjzBLHfhQsZzoJFtk+tIh2Z2Xhz+SOk2hnwtR5F5/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gZIYGipVV9Y4wpoaG1QQOBvBgDEiE428BuqGFIX1gqxPpi0KdfnBBQu9bSB3wnmCg
         7EzstYJn3mlm9bOMx3hDyRCkD9zEj+LeWGir81pLUs98sWBo0K1RmyAPPiP7DFd5oW
         90O7twltgmBEhN1gqd33gvckuN3/XqvqGOWJkICYdcyOoZx5GYbOwnp+sGa6VlQVcQ
         Y6g6+dFIfmK6cgM7hvCP4p27LtBLMBoZdvPe1tWFa5hCYlLFGMLNSG7feLQR3Wz4zL
         QaScYGdILL8ywj4COQhM0xp9KgGHwHdJi/W9/Nn/fPGi3kEZeuuX/QRZOmorEy6Lmf
         Eb2p/acrFLUxw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 09:11:07 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] mfd: wcd934x: Simplify with dev_err_probe()
Date:   Sat, 20 May 2023 09:11:05 +0200
Message-Id: <73fdc6ecf619f80fad126abca11fb579d3d87f64.1684565021.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <02d8447f6d1df52cc8357aae698152e9a9be67c6.1684565021.git.christophe.jaillet@wanadoo.fr>
References: <02d8447f6d1df52cc8357aae698152e9a9be67c6.1684565021.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to simplify code, save a few LoC and be consistent
with error codes handling in messages.
It also filters -EPROBE_DEFER that can be returned by devm_clk_get().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/wcd934x.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 281470d6b0b9..6b942d5270c1 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -227,10 +227,9 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 				     "Failed to get IRQ\n");
 
 	ddata->extclk = devm_clk_get(dev, "extclk");
-	if (IS_ERR(ddata->extclk)) {
-		dev_err(dev, "Failed to get extclk");
-		return PTR_ERR(ddata->extclk);
-	}
+	if (IS_ERR(ddata->extclk))
+		return dev_err_probe(dev, PTR_ERR(ddata->extclk),
+				     "Failed to get extclk");
 
 	ddata->supplies[0].supply = "vdd-buck";
 	ddata->supplies[1].supply = "vdd-buck-sido";
@@ -239,16 +238,12 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	ddata->supplies[4].supply = "vdd-io";
 
 	ret = regulator_bulk_get(dev, WCD934X_MAX_SUPPLY, ddata->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD934X_MAX_SUPPLY, ddata->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to enable supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
 
 	/*
 	 * For WCD934X, it takes about 600us for the Vout_A and
-- 
2.34.1

