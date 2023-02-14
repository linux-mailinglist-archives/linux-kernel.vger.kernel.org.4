Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97134696E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjBNU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:27:03 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CF55B2;
        Tue, 14 Feb 2023 12:26:59 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5776124000A;
        Tue, 14 Feb 2023 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676406418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1A4RUTbfnc65jupGXX1vqO8ka/IeCWy0ag+WUvvgKxo=;
        b=ikS/IIrYp2OVQAjLURRBiuKWnrDyr7FCGxLiso8A8QoDtOQSgEA4DbhTURLN1wWylyYNar
        6XVI4hodY2NEcoOMaiqjJ5P2DRT+zMhLeOJyiAWX0pMlgx05UWuYmhHQ7qprYFVzBhuHsK
        YFgra9IBjz9gwanAvineG/onj1MU31YPqu/drwH/GHxm4qU8n3pUNZHuJ2OfzpYwuDshbc
        JnIgiZOgTxXjgw5vrLZ/e5cEdihMFjV3FjxMAmd3uf5fHaB67NQ6hbPbFa/zDLb/wmDU8R
        nEIvobA1q7Jq9LtFrqHKMRXLFD678rJVRhZeUthqgqJHC6x/0WJl+9lriJfRaA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv3028: add ACPI support
Date:   Tue, 14 Feb 2023 21:26:53 +0100
Message-Id: <20230214202653.565647-1-alexandre.belloni@bootlin.com>
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

The RV-3028 has been assigned the MCRY3028 ACPI ID.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3028.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index b0099e26e3b0..ec5d7a614e2d 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -982,6 +982,12 @@ static int rv3028_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct acpi_device_id rv3028_i2c_acpi_match[] = {
+	{ "MCRY3028" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rv3028_i2c_acpi_match);
+
 static const __maybe_unused struct of_device_id rv3028_of_match[] = {
 	{ .compatible = "microcrystal,rv3028", },
 	{ }
@@ -991,6 +997,7 @@ MODULE_DEVICE_TABLE(of, rv3028_of_match);
 static struct i2c_driver rv3028_driver = {
 	.driver = {
 		.name = "rtc-rv3028",
+		.acpi_match_table = rv3028_i2c_acpi_match,
 		.of_match_table = of_match_ptr(rv3028_of_match),
 	},
 	.probe_new	= rv3028_probe,
-- 
2.39.1

