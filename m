Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FDA696E83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBNU1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBNU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:27:23 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7662B63D;
        Tue, 14 Feb 2023 12:27:20 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D0CF2000A;
        Tue, 14 Feb 2023 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676406438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kFl2gCxIHg3QvyVZmKtJSbaITKo9XPbL736NQUgE8dA=;
        b=RDemrODO9PXsKgVcTP4KbMUxdKWC8JRBJqwlWaS7CWhVu+i9v/xPtnqT1Sq5gY7kVDLi40
        YT4U+FBAg0DSc8t/8QjAzlIM2JbBOmllEk0ScfOl0H637aGDhZY5hzpIf1C3pcKjA/RtCG
        HzLA30m2BuKvcIBnaEd1aphcnujB4sVmHPJPno8z/CD6Cs6Y0jJadXIhNCWs82bwi58Q26
        mAfIyCm+Ys5bepda1M46IPiUQ+sQpgjKDY1GWT+YZ2uAmSP1cB994nPyG5gsMZCglLTbHF
        zKWdVBte9H4BWW1Gppe/1oaCa0MwS0tlj16EVn+dk066ImG44eZ+rs4QIaQljw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv3032: add ACPI support
Date:   Tue, 14 Feb 2023 21:27:15 +0100
Message-Id: <20230214202716.565749-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RV-3032 has been assigned the MCRY3032 ACPI ID.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3032.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index bf6954ec5943..1ff4f2e6fa77 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -980,6 +980,12 @@ static int rv3032_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct acpi_device_id rv3032_i2c_acpi_match[] = {
+	{ "MCRY3032" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rv3032_i2c_acpi_match);
+
 static const __maybe_unused struct of_device_id rv3032_of_match[] = {
 	{ .compatible = "microcrystal,rv3032", },
 	{ }
@@ -989,6 +995,7 @@ MODULE_DEVICE_TABLE(of, rv3032_of_match);
 static struct i2c_driver rv3032_driver = {
 	.driver = {
 		.name = "rtc-rv3032",
+		.acpi_match_table = rv3032_i2c_acpi_match,
 		.of_match_table = of_match_ptr(rv3032_of_match),
 	},
 	.probe_new	= rv3032_probe,
-- 
2.39.1

