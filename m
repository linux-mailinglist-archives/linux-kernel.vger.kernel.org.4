Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0C67155A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjARHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjARHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:45:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5906468B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so37928609ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERUzW2NTS0HSKxHZgJkhNmc/Fre4SMT/MoW1Mr8mzQ4=;
        b=zQwd7J7HLRznjgSFM9pKJya0EuA8lZun8bi0lci+/+J+INOZCIV9Q3HPoKn/H2t7EZ
         jGeRwvaXEEWwexTNs3th+4lE4e2mfsFiw/zpJ3Z2FAhlJ8oZ4NPzOPm3JmLPTx3MBNFa
         w+ISOMSy7RMkJTr+lHArjUK0VmYFRNOdUPFojbNu8WS85Fhi/m+b4tZShv0heXwB4nZ+
         OaD6sQhZ5YawH9Zq9fKNUcFXqrmF8AdLX7z3wvO56SfZWRMkcpGeS2cMRP2lbeOTxsxi
         Riltb4cI1zp2s3bCg92Y1AWH58vCLH83S015+aG7gcRb/BeKW1MbD21VA3x+OJyB4tLM
         uKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERUzW2NTS0HSKxHZgJkhNmc/Fre4SMT/MoW1Mr8mzQ4=;
        b=MSB4KBJnXbcfjPVp4qadTQa8zdqyEkIyvyKoLWa6AX7MhXoyam/Hy5DxF/8g0gppF4
         Vx+EY5h7vytSqb7jGCBUOwO2b/Zw1FGevp66m534gKir4Vppa6Dh/Lx2KfZyVNJ2WB2/
         4dUWBMh/Y8nDKvqLT7EgoAV7oKwbhngXysZN1NV34X7MPdX6F06yZ8q1wcw+brCcstf2
         ts+lAbOS36+KN16bXfbq6RNdRvpXZD15pzRAyOvnW4UaQ+GcNtLdQFqICi97tjvNT5aH
         2vu4uM69dKXfDNK3GBG5J3xesCLOSVHE5uTUxktJrwPbkbr9qezBJkpnrzphmuT43YS/
         cwwg==
X-Gm-Message-State: AFqh2koOqQD1FVyzqY2c25Y74Yl9w4Yr5EY+rr4oz8Z3w59GkDzEhT8l
        uGFYWCLFLYGOymDNirWFdyT2Gg==
X-Google-Smtp-Source: AMrXdXu9lF2KzIrGyO/dXleTYY7hoYpmKSAJsg5YK0OSjR507Yv6uTjCD3X7ZbwT73YIZ7fWv5YvoA==
X-Received: by 2002:a17:907:b9da:b0:872:21b2:9a1f with SMTP id xa26-20020a170907b9da00b0087221b29a1fmr5931576ejc.58.1674025778843;
        Tue, 17 Jan 2023 23:09:38 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm13596984edb.93.2023.01.17.23.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:09:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:09:21 +0100
Subject: [PATCH v2 7/7] usb: fotg210-udc: Implement VBUS session
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v2-7-100388af9810@linaro.org>
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

Implement VBUS session handling for FOTG210. This is
mainly used by the UDC driver which needs to call down to
the FOTG210 core and enable/disable VBUS, as this needs to be
handled outside of the HCD and UDC drivers, by platform
specific glue code.

The Gemini has a special bit in a system register to turn
VBUS on and off so we implement this in the FOTG210 core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-core.c | 29 +++++++++++++++++++++++++++++
 drivers/usb/fotg210/fotg210-udc.c  | 17 +++++++++++++++++
 drivers/usb/fotg210/fotg210.h      |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 013a1d0112fc..70d2ff5a2682 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -95,6 +95,35 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 	return 0;
 }
 
+/**
+ * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
+ * @enable: true to enable VBUS, false to disable VBUS
+ */
+void fotg210_vbus(struct fotg210 *fotg, bool enable)
+{
+	u32 mask;
+	u32 val;
+	int ret;
+
+	switch (fotg->port) {
+	case GEMINI_PORT_0:
+		mask = GEMINI_MISC_USB0_VBUS_ON;
+		val = enable ? GEMINI_MISC_USB0_VBUS_ON : 0;
+		break;
+	case GEMINI_PORT_1:
+		mask = GEMINI_MISC_USB1_VBUS_ON;
+		val = enable ? GEMINI_MISC_USB1_VBUS_ON : 0;
+		break;
+	default:
+		return;
+	}
+	ret = regmap_update_bits(fotg->map, GEMINI_GLOBAL_MISC_CTRL, mask, val);
+	if (ret)
+		dev_err(fotg->dev, "failed to %s VBUS\n",
+			enable ? "enable" : "disable");
+	dev_info(fotg->dev, "%s: %s VBUS\n", __func__, enable ? "enable" : "disable");
+}
+
 static int fotg210_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 4099e7453112..754429553f61 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1082,9 +1082,26 @@ static int fotg210_udc_stop(struct usb_gadget *g)
 	return 0;
 }
 
+/**
+ * fotg210_vbus_session - Called by external transceiver to enable/disable udc
+ * @_gadget: usb gadget
+ * @is_active: 0 if should disable UDC VBUS, 1 if should enable
+ *
+ * Returns 0
+ */
+static int fotg210_vbus_session(struct usb_gadget *g, int is_active)
+{
+	struct fotg210_udc *fotg210 = gadget_to_fotg210(g);
+
+	/* Call down to core integration layer to drive or disable VBUS */
+	fotg210_vbus(fotg210->fotg, is_active);
+	return 0;
+}
+
 static const struct usb_gadget_ops fotg210_gadget_ops = {
 	.udc_start		= fotg210_udc_start,
 	.udc_stop		= fotg210_udc_stop,
+	.vbus_session		= fotg210_vbus_session,
 };
 
 /**
diff --git a/drivers/usb/fotg210/fotg210.h b/drivers/usb/fotg210/fotg210.h
index 4d0d4ae1a957..c44c0afe2956 100644
--- a/drivers/usb/fotg210/fotg210.h
+++ b/drivers/usb/fotg210/fotg210.h
@@ -17,6 +17,8 @@ struct fotg210 {
 	enum gemini_port port;
 };
 
+void fotg210_vbus(struct fotg210 *fotg, bool enable);
+
 #ifdef CONFIG_USB_FOTG210_HCD
 int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg);
 int fotg210_hcd_remove(struct platform_device *pdev);

-- 
2.39.0
