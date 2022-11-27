Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57C0639D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK0VGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0VGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:06:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A904BF61
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:06:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v8so13079948edi.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpEq2XM1YcTPQcw+4JJSyNeoXgL2xBwAGVLtnrNWxhU=;
        b=i3T3lCm9VZPExCvJlK5TujyGU4OIfNjPc8i3cng1iMlplAGywfCDL3o132gbIkZM1S
         zWV5H/jzE3BIFQ7Znss8FYsyFlRWLSDv/0zd2lwV2VGhkmKAhDr2PluaTX2mE1WGfi3R
         L+bnHqTFYru/HN75HYc/Xfcd0hSFFvGWBai/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpEq2XM1YcTPQcw+4JJSyNeoXgL2xBwAGVLtnrNWxhU=;
        b=pVN1k+nQtPyCMJwVR/xBBfX8o0wKCNH84viahOMLun/UgUzW5CvYhZetu235wJigKa
         i136wxmKjVyA4+t9yf/KrWL8Rc4AqsFxreWNhSjWlZS/3ax+E2Eg8hFhBwWk418UWj+u
         1Ct+GcrcNY4ljNc+KOxA/u4Ym3qxp6OaVgv7v7zcPgofwPt2umUso5uPSPtJLbkycyo5
         POsGYtKBLfYMaYgl46ra6pHxXSAso0+aWFUPjVoMXpX+yODI7bl6iNxlJTNSa5CgJ4hE
         lYLIV6WRVQQeJETJJ5D+CUlzo1L6OQhoUkyqh3OzKxlerVu8qRz1yaeadLjIl3UcuPtg
         7DkA==
X-Gm-Message-State: ANoB5pkapyaLmIeLjrUoyODCpKygcywtPMaGYPHisatZCd/vtRVoDHJI
        BOMMn9cW0PDIg0sZeDuqyEzMhXFqE8NnAA==
X-Google-Smtp-Source: AA0mqf7AK0u4SFho7bYNOX0OHN0NXJHVzesCrSaAduE2uZjphYIWcoxLSGn/r68Za0WEhEMKpaZKig==
X-Received: by 2002:a05:6402:4027:b0:468:fc39:e89 with SMTP id d39-20020a056402402700b00468fc390e89mr28057871eda.170.1669583171485;
        Sun, 27 Nov 2022 13:06:11 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id md6-20020a170906ae8600b007af0f0d2249sm4177891ejb.52.2022.11.27.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:06:11 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 27 Nov 2022 22:06:02 +0100
Subject: [PATCH v2] regulator: da9211: Use irq handler when ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=64X4q4g/buDNWHqsk0ePMcVX3nLxG/h6WzT9QC73iVI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjg9E89h5L1WLokbAJhqGvCAzAw4pa/x+MDYyvgkjb
 WemUw8aJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4PRPAAKCRDRN9E+zzrEiCX7D/
 9MgWfQijyj0r6rQqXgYfRFRX+fg9DLj68wzrxKaqd1WrvuM2Lx3V3VTlI2B0RSDvXY8bfGxmcAw+LO
 qIk/kXF0HqJdWOAn1EwyT1iT0QOjQZVlgiUGrNYbejHY2XQyxLej0QWfQ0eR+xkwd2t6fMuF3E7yqQ
 npGkK3mmtDMgoRbKQvF3LUb8Cv/QgNjog5zvYbnjEogo2U5Zdfcd6nR2LWSO3ZXc0ed1UpMClkWS81
 tgt3y1aojof5QGMS5FP/IW/yFEYpNu4uSqtgvMf0CgqNb+qOv7xxjceK9Yl/yvPUk6HRQPDlANtQPg
 aLt1OKOIu9JNFJXgq7LCMc+ZTKxqN6SnzoAqSVYhmi2OnQKBCpstsnAdY6N4nj8K4olR1vve23L4DO
 W1XhH+HWFAxC8bmT1GmKk4T9gqDXOA+V3lhIFbfzdA/YhnBbRYDCX4DzVfmADBUOLyYHLeQ2bZ/KIO
 DXeBgnQdWMBn0VAD97/jU9hVapduykiDy+Z/alqwP+MxR6uqYaJ2jvIRAYHoA7W9lQINp3BWtEhD9H
 CIiF+x5TR6HA3j18k9aaruFBR7NYWT9bL8eU9XIoHxrfo8nYcO7uEvOTmNC/ztlpramk+Cpw7mZgCT
 zOiYdOMRrVeewSR4+lSETn/pM3mOOzobClJ34+25i1Yc8CM2z1ktR70F7mjQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system does not come from reset (like when it is kexec()), the
regulator might have an IRQ waiting for us.

If we enable the IRQ handler before its structures are ready, we crash.

This patch fixes:

[    1.141839] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
[    1.316096] Call trace:
[    1.316101]  blocking_notifier_call_chain+0x20/0xa8
[    1.322757] cpu cpu0: dummy supplies not allowed for exclusive requests
[    1.327823]  regulator_notifier_call_chain+0x1c/0x2c
[    1.327825]  da9211_irq_handler+0x68/0xf8
[    1.327829]  irq_thread+0x11c/0x234
[    1.327833]  kthread+0x13c/0x154

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
regulator: da9211: Fix crash when irqs are pre-enabled

If the system does not come from reset (like when it is kexec()), the
regulator might have an IRQ waiting for us.

If we enable the IRQ handler before its structures are ready, we crash.

To: Support Opensource <support.opensource@diasemi.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Move chip_irq assignment before regulator_init (Thanks Adam)
- Reduce commit message (Thanks Mark)
- Link to v1: https://lore.kernel.org/r/20221124-da9211-v1-0-a54549aa6d3b@chromium.org
---
 drivers/regulator/da9211-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index e01b32d1fa17..00828f5baa97 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -498,6 +498,12 @@ static int da9211_i2c_probe(struct i2c_client *i2c)
 
 	chip->chip_irq = i2c->irq;
 
+	ret = da9211_regulator_init(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to initialize regulator: %d\n", ret);
+		return ret;
+	}
+
 	if (chip->chip_irq != 0) {
 		ret = devm_request_threaded_irq(chip->dev, chip->chip_irq, NULL,
 					da9211_irq_handler,
@@ -512,11 +518,6 @@ static int da9211_i2c_probe(struct i2c_client *i2c)
 		dev_warn(chip->dev, "No IRQ configured\n");
 	}
 
-	ret = da9211_regulator_init(chip);
-
-	if (ret < 0)
-		dev_err(chip->dev, "Failed to initialize regulator: %d\n", ret);
-
 	return ret;
 }
 

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221124-da9211-4b8904b4feb5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
