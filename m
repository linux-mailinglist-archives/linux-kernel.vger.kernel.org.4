Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048586FDD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbjEJLwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjEJLvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7761B7;
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso5542085e9.1;
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719509; x=1686311509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR46O1ewornF4KltourK6EuEJV9QcToba83RDfovgnI=;
        b=EIrVFwBoQ73odE5gh3AtMWRfGoVQ4blS7eoVlR5sfuLr21zl1CsOESFbQG4nLANrdA
         ayMOi4qPvy2PZhZP7+JPPZjCsluyL6JiO5biJBWNbss0Vaiene/1yc5HLu3qAF3N1i3k
         dwEEHOzSJ1vc0LGQ08hz+hH4URCIpypAxu6wLHizBrH/oJlOvNOn1lgtWlsa2Q0hzI31
         SoAzyKYfCn6gDTGPqifUj/ipOHVzK5KJtm10BRj/v0wL4XIImxaHGo5cVaC8j9keLAj7
         6eh88/pzks4NJfmd2eetp11BIdNZ75HpKjKUj7CvcY1FltB+WAXybAPXwmxThnCqGbVo
         DjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719509; x=1686311509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR46O1ewornF4KltourK6EuEJV9QcToba83RDfovgnI=;
        b=jJiKI1fQI5MdK3Xqr8WHIMQxOyhuJLITmESLUAP+PWx2dz+CbEmwvvoEaeGvYpUGlh
         tZ4jSswnQtlVzv+RAk61i7rYfGOVm3hZotks6+JrFGwBSGHpsXLNYzi2MM5nzZhvWzOj
         d0RkzVhWPbJv6Hg/9+RiOU5Eu+zf4sTOkgdGDeJrzn8k4KwUR6NB+OK6qrrQnOJCwipl
         zhzz2GpWMMRwYdFEUB61uLPthn68+phqeffKhW6I1MY/bueivjOKeuI0/PoFbd+GMwPC
         YBuILPSiGWF0jzwx63vAkYyuH2PcmVHe9nsPqpWBPgaDKsCFFt990Ui+z7I6nVKHTHdv
         Y2TQ==
X-Gm-Message-State: AC+VfDzd9n4LqF9PV4kOffuB+xwxKpWZSw/LzaL1Nc/4OWC/aZUUPoPh
        9n1IZ04s8RqQyvLb6yxDLG8=
X-Google-Smtp-Source: ACHHUZ7C2yULL2cD2dUgmTZW0WhBHnojLHseO6LNzYDLrZnTtQn5Nrzm7hkQ1hsELrS0upjeuGH8NQ==
X-Received: by 2002:a1c:f70b:0:b0:3ed:e5db:52e1 with SMTP id v11-20020a1cf70b000000b003ede5db52e1mr11794556wmh.15.1683719509423;
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm22540802wmq.26.2023.05.10.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:49 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Wed, 10 May 2023 12:50:45 +0100
Message-Id: <20230510115046.963432-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AXP192. It is most similar to the AXP202 but
the current limits are different and the USB OTG status register
has a different address (0x04 instead of 0x02).

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 089fe837a4b2..51c3f9b6458d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -26,6 +26,8 @@
 
 #define DRVNAME "axp20x-usb-power-supply"
 
+#define AXP192_USB_OTG_STATUS		0x04
+
 #define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
 #define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
 
@@ -365,6 +367,13 @@ static const char * const axp22x_irq_names[] = {
 	"VBUS_REMOVAL",
 };
 
+static int axp192_usb_curr_lim_table[] = {
+	-1,
+	-1,
+	500000,
+	100000,
+};
+
 static int axp20x_usb_curr_lim_table[] = {
 	900000,
 	500000,
@@ -386,6 +395,16 @@ static int axp813_usb_curr_lim_table[] = {
 	2500000,
 };
 
+static const struct axp_data axp192_data = {
+	.power_desc	= &axp20x_usb_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.curr_lim_table = axp192_usb_curr_lim_table,
+	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
+	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+};
+
 static const struct axp_data axp202_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
@@ -634,6 +653,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{
+		.compatible = "x-powers,axp192-usb-power-supply",
+		.data = &axp192_data,
+	}, {
 		.compatible = "x-powers,axp202-usb-power-supply",
 		.data = &axp202_data,
 	}, {
-- 
2.39.2

