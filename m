Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FC652871
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiLTVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLTVgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:36:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E9B7E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:36:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d20so19515599edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lyUV6xhkVX1jxFg/jG5gRApY46OlNTkuYd457vayac=;
        b=gVqohdibGEdeei9fsTgHEy+rBBwRrMzzoJpK2ZVW3G/htQHdtR73FFjqXBBOVHjtZJ
         QlcZAxPDEeh7Gwvny0Gbp+BQrILe6FPlYbPklqq6B9zN590KtTZCOOXxsIJLHedbZlG5
         gTQfOMeEnrIuREejUNygZ1QABsCVtWel9RHSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lyUV6xhkVX1jxFg/jG5gRApY46OlNTkuYd457vayac=;
        b=o8rqoWaSZ/nJAP6izoT7g0J0URfiTc+bti7zZ7W23uZBWmBuumH6xJbpm+yj6ge605
         2GNG9vHILNjeFVwHcjkMKU9GsMCoMRp8/vHcxMzuaOTsqJ9Gkh/4dcgvVSb0J900lMj1
         d+EEU2VOpbwj+ZWktUp5SCz98MQHgok9A9C3BNJIVw4mefK310HuCvu3PaVVxwouWaPA
         UgEyo3SeB0F0xzB8IV/U0tUER7tACqsYuqbW0EWiAoByF9Xd92HsxyvNyQSa1h9FDlHf
         5oOUsOCCQ+Ik98g2GknLIFnqWlFNVZAhQ9hmKwcqlCbv3Nvp9Cz3uxpVezg6xvai7dLs
         Nhzg==
X-Gm-Message-State: ANoB5pnw36zqDNsMdcZ0sFKnGD/JuGbuiFrwbyuth9cLuyhZjnIJg7ML
        dcSU4JUbug8cq+iLXhVSlRQlfQ==
X-Google-Smtp-Source: AA0mqf7bNWoFW5s7NHYngkKWVC/m06khl90VikHTGVzQsD2M2A5s8J3bZ00PCQ+tgoyaSGhIlfjEfg==
X-Received: by 2002:a05:6402:48:b0:470:411f:3609 with SMTP id f8-20020a056402004800b00470411f3609mr26747749edu.1.1671572165411;
        Tue, 20 Dec 2022 13:36:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7cb5a000000b0046c53c3b2dfsm6215407edt.38.2022.12.20.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:36:04 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 22:35:59 +0100
Subject: [PATCH v2] soc: mediatek: mtk-svs: Enable the IRQ later
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221127-mtk-svs-v2-0-145b07663ea8@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <Roger.Lu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ZkyAdASklJW55ktI7Cr1DlzlpiQsAvq/12fzDjEbbmM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjoirCWGDzP8RsUxqTlT7kRNFrvvvoqGTcR0Pq8Jvi
 Ifipfz+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IqwgAKCRDRN9E+zzrEiN4AD/
 9xQxyU+XNUoy+PyFq1DU1yoU5ZQ6tk7Gopqcf8zrq2y5J7KvTQwWrRTc7uPWkORF8rAmY7zSkYN+qw
 H31Z0qvTHIqouB33gUly+eJkPak+idn9LPZYuz0mj1GPUaoXzO+nWIqV12X5wFgjjddhRMsBaz7FTI
 WV3I5DtNennC0jbea49wD7HNJ/jEnkwnQ/4lhmsYeRPuK4OxVPRVGSCeOnJ7muXDv/okL9bfhE+dVK
 tuOqvN8w6gw0toavDXcR4ac7RrVFb+57A/aAe+HdsT1rnAQNBkfElHnhNpjFZoxQIdAeUHk3O10qMP
 hXUQsI2cNi5+/l+TE/NmLEw4Iw4Uk6ltXCtBsmVsodXi5dS62gG39vhOiGVo74sC7ul2Y6n7ZDAGni
 ebPfnjZCvIPA9T+DtbKgnrC73tolrAOPPPssPdJSXNefpy0OCYtNoHFvNGnHkFwxyer0OQIWtdHKR0
 6V9MrtfSoK9mhKlzJbplndsVUHL7ETIadXYWwKmLP2/ZPEL64eZAc/l8SF/X1Mh769BM0WiHRDfeXu
 er44ft/maUSuAGhzkw0WKr3pPtYgBYW1W8nsOGTAtn4T1oDSOxn6zlDn+LR1B0Ea5tGXPsH+1EKG5j
 +LoOSB2Qlbm9kWKsymSsifnYbjOhm6vmTR0iE5Ykz9L+2uqM87S4rB4vFCvA==
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

If the system does not come from reset (like when is booted via
kexec()), the peripheral might triger an IRQ before the data structures
are initialised.

Fixes:

[    0.227710] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f08
[    0.227913] Call trace:
[    0.227918]  svs_isr+0x8c/0x538

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Roger Lu <Roger.Lu@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Enable the irq before svs_start, to avoid MT8192 not starting.
- Link to v1: https://lore.kernel.org/r/20221127-mtk-svs-v1-0-7a5819595838@chromium.org
---
 drivers/soc/mediatek/mtk-svs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 0469c9dfeb04..75b2f534aa9d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2385,14 +2385,6 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_resource;
 	}
 
-	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
-					IRQF_ONESHOT, svsp->name, svsp);
-	if (ret) {
-		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
-			svsp_irq, ret);
-		goto svs_probe_free_resource;
-	}
-
 	svsp->main_clk = devm_clk_get(svsp->dev, "main");
 	if (IS_ERR(svsp->main_clk)) {
 		dev_err(svsp->dev, "failed to get clock: %ld\n",
@@ -2414,6 +2406,14 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_clk_disable;
 	}
 
+	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
+					IRQF_ONESHOT, svsp->name, svsp);
+	if (ret) {
+		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
+			svsp_irq, ret);
+		goto svs_probe_iounmap;
+	}
+
 	ret = svs_start(svsp);
 	if (ret) {
 		dev_err(svsp->dev, "svs start fail: %d\n", ret);

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-mtk-svs-add137fbf187

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
