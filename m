Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51FE671557
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjARHqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjARHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:44:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD463E11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b4so28839131edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sResmjpkOst92em2xHEqCRKaDl2VpyxVgJORb+VfbaQ=;
        b=YemzCb/qx1iRfYzhK9MKaNtuiANnVfC1Abut0sC2esnXr2/e+4FpPdrNk8mYkAQWoM
         BZENHwcZvGshPwQWDz5EjDBnHW6zY9Iqe5ziDE4GUICXxQid/AKpK87Ukj32x1c/MJqp
         HzqWrCB0q6TxjbFtDi/h6W5e6HtSLqVkd2EzLgiBGM/kYJUSuLQbdm8Kd+bclLgn26M4
         B07WtxWgeNeXX+pvGTXdTfICy0GIo46l/iHWM4TyjR1Dn4DxnQAw7utgEKARMSkYfwLn
         Ka7ZGRQjc676jd5oTl7XYr24IintPyUY/ADOlTXsBKxdZhQsT/9KgqjEzc8noOj8MDxk
         hJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sResmjpkOst92em2xHEqCRKaDl2VpyxVgJORb+VfbaQ=;
        b=0Y1EBpewCnNzreJDFNrOfx/JlUL9/Gls9OwOTfkQRIG2W84BoNLtiJlqW+AidqtDw6
         6tLhm47KUB7laSarWkUvocnqWrhzGasuL6xLYpuAxkdlgHwN/l3LzVpmT7EjanzThWA3
         r+pSPexPieh0MRVOrzENziQddBbhjRX2UFR4TEYN8zJKKg2Ib1ZZK75IbBuG7nj1NG+I
         ijzV1oywwc1tMP/xWrlW6zVWJ6rXcQkwGdATavRQYzPHY5Z7fFc0nMcwqGbe9enAd6zn
         qnuLhW1xsJ2WMC8h9yqytmwRYyagpaiEX2JDvUv+/Rq+MTgMoF9X06DmY+J9z86k6s6+
         5oOQ==
X-Gm-Message-State: AFqh2kr9IeNE4qccKkNuwE5DGtsQGxra5SZNY8Kz3SzZDknaH9trDrVw
        e5df1n0nEO9hd9iMl0vgOio74A==
X-Google-Smtp-Source: AMrXdXvHolvXpn338X+Xd6mmsm/S0UgEeFH7Qz6oPd+L0ab6LKcoRXGsVyk6VswdzoX9g5djyMJ1og==
X-Received: by 2002:a05:6402:4025:b0:49b:67c3:39ae with SMTP id d37-20020a056402402500b0049b67c339aemr6608930eda.33.1674025776660;
        Tue, 17 Jan 2023 23:09:36 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm13596984edb.93.2023.01.17.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:09:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:09:19 +0100
Subject: [PATCH v2 5/7] usb: fotg210: Check role register in core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v2-5-100388af9810@linaro.org>
References: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the role register and check that we are in host/peripheral
mode and issue warnings if we're not in the right role when
probing respective driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 58d84747fb30..013a1d0112fc 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -18,6 +18,11 @@
 
 #include "fotg210.h"
 
+/* Role Register 0x80 */
+#define FOTG210_RR			0x80
+#define FOTG210_RR_ID			BIT(21) /* 1 = B-device, 0 = A-device */
+#define FOTG210_RR_CROLE		BIT(20) /* 1 = device, 0 = host */
+
 /*
  * Gemini-specific initialization function, only executed on the
  * Gemini SoC using the global misc control register.
@@ -95,6 +100,7 @@ static int fotg210_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	enum usb_dr_mode mode;
 	struct fotg210 *fotg;
+	u32 val;
 	int ret;
 
 	fotg = devm_kzalloc(dev, sizeof(*fotg), GFP_KERNEL);
@@ -122,10 +128,16 @@ static int fotg210_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (mode == USB_DR_MODE_PERIPHERAL)
+	val = readl(fotg->base + FOTG210_RR);
+	if (mode == USB_DR_MODE_PERIPHERAL) {
+		if (!(val & FOTG210_RR_CROLE))
+			dev_err(dev, "block not in device role\n");
 		ret = fotg210_udc_probe(pdev, fotg);
-	else
+	} else {
+		if (val & FOTG210_RR_CROLE)
+			dev_err(dev, "block not in host role\n");
 		ret = fotg210_hcd_probe(pdev, fotg);
+	}
 
 	return ret;
 }

-- 
2.39.0
