Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AE7480B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGEJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjGEJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:18:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8A1735;
        Wed,  5 Jul 2023 02:18:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f766777605so10055361e87.1;
        Wed, 05 Jul 2023 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688548706; x=1691140706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urOxsrVY+tk/gJ4cc4FN+6hpWmfeSeBhKbODS5RKDv0=;
        b=NjD+YzWHCIFqWlT2f4wR7cHvIKBX/LRB6XmuWXnwD0miOgCC7YzAWY0RSUB3gFrRi9
         xx/k4h5eM5jxyWtAuOjsSvFqMLH9pN/d2N+PbB2LmS+0AVT7eCatZCmWTIFvA7PUEBFq
         uGEkTmXUKLFlS0ncwGPed5vT5Zv8EyQ4Wkt+oPU/ji40fiI1A02CSEzajO1I/6ZOD2MB
         SwkPJ4fl66rHI8JKEpWxBUpaOMUD2CsDQR2FszOhjb/8mmKBjT6ql/iwboaktlCBYWqA
         QIoohh0SHk9dpo82paSfPbVIY4WNBD/y+73oDEW2bhTDb9PD2I686ByKt8zrpMs9kuUS
         3CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548706; x=1691140706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urOxsrVY+tk/gJ4cc4FN+6hpWmfeSeBhKbODS5RKDv0=;
        b=bATIr6V7extpMn5yGWZeeU8ZppfoV8rsEvZL5oRnWf8LhKs38n+2mDMKbSDeA5DEhT
         pnqA/aP9aduewG2isI2kZXWhJ+ymHds2FGPTsRlz5gxyte5AUFrvRVDEDlvM148G8NCE
         T4X/bhwnaGFjwTdMA644pcmu7p6Mmg0gZylJ2gZSKUprM9tS9Og1k4z9BfsHdLZixbrl
         aY1FKoEeB8xScLxBz8jJjCp1FDDuntGpByZ291QZJgExpLctGmOYq5p2kRzvKb2ogztY
         c/LppNyQc8owRWAYHkcWiW8CeKj1qdbTD7DAvutWn/vYlP+HXJaVYwKQsFypBpdZnfdB
         QaQQ==
X-Gm-Message-State: ABy/qLaJEPiu4kzlIeyKdxsDwEDpWA/8xr35ssnE11EYtLvVneRV8ke5
        Dauo8CEgNZ8ULwEoEZZ24T3VxXzNeD4=
X-Google-Smtp-Source: APBJJlHHtCrrRafwZ9aTD/vJPm+YBvttGYdBxNlmj7pgD2G+OLN5TwsuoBee1fAJwAwrsHQG2xPtXA==
X-Received: by 2002:a05:6512:3b9c:b0:4ec:9ef9:e3d with SMTP id g28-20020a0565123b9c00b004ec9ef90e3dmr13777727lfv.26.1688548705534;
        Wed, 05 Jul 2023 02:18:25 -0700 (PDT)
Received: from localhost.localdomain ([77.243.43.130])
        by smtp.gmail.com with ESMTPSA id a7-20020a05600c224700b003fbc90e030csm1531832wmm.37.2023.07.05.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:18:24 -0700 (PDT)
From:   Andreas Helbech Kleist <andreaskleist@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andreas Helbech Kleist <andreaskleist@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: exc3000 - add ACPI support for EXC80H60
Date:   Wed,  5 Jul 2023 11:18:16 +0200
Message-Id: <20230705091817.1300928-1-andreaskleist@gmail.com>
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
v2:
- Fixed compiler warning reported by kernel test robot

 drivers/input/touchscreen/exc3000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 69eae79e2087..7a52879d8ac3 100644
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
+	{ "EGA00001", .driver_data = (kernel_ulong_t)&exc3000_info[EETI_EXC80H60] },
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

