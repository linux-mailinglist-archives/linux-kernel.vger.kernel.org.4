Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B577A746F19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGDKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:50:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331EE5F;
        Tue,  4 Jul 2023 03:50:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so49688575e9.2;
        Tue, 04 Jul 2023 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688467838; x=1691059838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/Vv88KHXlPANE205TDrfh0iF/o9LJIXB5/cB9oUZBs=;
        b=VJMcfzXE3WsRYyleYwyyc1j0Ml/0ZQXtGB65RtsegFzdTDiYDGF1VW8Cl8l//ejFBw
         QD2+6TxLkNk3wlxDqZ2cMVD5+4HLulFDszkztimGTyyc9N2dD+TPNzUt04dexHxeknLt
         TUV3Bmb7H9f1odNS7alN3ivpxEvk8DNO8FkNrdLj1fDb01EyYLxSwilCmMuCwibloEVf
         6LtLtqDeGaI9Glmt5PRDKPfEFbg3d+N9ey9zY9N9o+jSujDN3rnKNhkKT1su8jhnO6Ef
         TkKrE6ljIla3rDqHsPj6KH9DTv3LWwqPKPyU7IcSP8HQK/IGTrsJRfUM83GGZekj/3bQ
         Z5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688467838; x=1691059838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/Vv88KHXlPANE205TDrfh0iF/o9LJIXB5/cB9oUZBs=;
        b=DXFdT3U7LMWoTd1w8DftUYx4rf78/9MLPxYYV9wJGw+VNvcs6/cKZFnZX539Ti3nrv
         AFeKYP5PHyXcbV8MIE7DcjslEFyrloW/gJ7HihXOLElXvoLH9HwPk5vXrris8Po/s9jR
         fC7M4CvOl4FFDyz9sMv8S7aaqDk2VugKSrbIuPFK8PNG7Za9ccNjRtHkroL9F5ilgp9N
         hvU9PjQBKK8McoHzVTCiVRIZ1wcHxCWGcoM8q3atT/M3FO4nLPYJuTRJgLWBz1wENWhv
         rEmGa8mA0HJEsdxeE2jB9YvMOOkw4zbNnN6RgJy45/ehM7VhiNbwIsQI3x3tEtUapkXX
         eIgw==
X-Gm-Message-State: AC+VfDz9MdsLq5amRArKISY+CcSbjhNSyxDZ8SEwb7HcOwAWkZeLHzDu
        dTywFCHapFg4CsSDRSpblbaVJ/mNqDU=
X-Google-Smtp-Source: ACHHUZ5yQPfVFHpG018p2/oMDOOJtVWRgOURtobhuC2twH+8XfcoTMCEAKKbrn50fM1kO3yjQCY1EA==
X-Received: by 2002:a05:600c:218f:b0:3fa:a6ce:54ad with SMTP id e15-20020a05600c218f00b003faa6ce54admr10306500wme.6.1688467838185;
        Tue, 04 Jul 2023 03:50:38 -0700 (PDT)
Received: from localhost.localdomain ([77.243.43.130])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm21409237wmj.39.2023.07.04.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 03:50:37 -0700 (PDT)
From:   Andreas Helbech Kleist <andreaskleist@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andreas Helbech Kleist <andreaskleist@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
Date:   Tue,  4 Jul 2023 12:50:20 +0200
Message-Id: <20230704105021.898555-1-andreaskleist@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXC80H60 is used in Ambu aBox2 with ACPI _HID "EGA00001".

Snippet of from "apcidump -b; iasl ssdt2.dat" on target:

        Device (TPL2)
        {
            Name (HID2, Zero)
            Name (_HID, "EGA00001")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)
		// _CID: Compatible ID
            Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
            Name (SBFB, ResourceTemplate ()

Signed-off-by: Andreas Helbech Kleist <andreaskleist@gmail.com>
---
 drivers/input/touchscreen/exc3000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 69eae79e2087..f3a90155fb04 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -7,6 +7,7 @@
  * minimal implementation based on egalax_ts.c and egalax_i2c.c
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -454,10 +455,19 @@ static const struct of_device_id exc3000_of_match[] = {
 MODULE_DEVICE_TABLE(of, exc3000_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id exc3000_acpi_match[] = {
+	{ "EGA00001", .driver_data = &exc3000_info[EETI_EXC80H60] },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, exc3000_acpi_match);
+#endif
+
 static struct i2c_driver exc3000_driver = {
 	.driver = {
 		.name	= "exc3000",
 		.of_match_table = of_match_ptr(exc3000_of_match),
+		.acpi_match_table = ACPI_PTR(exc3000_acpi_match),
 	},
 	.id_table	= exc3000_id,
 	.probe_new	= exc3000_probe,
-- 
2.34.1

