Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865967BE88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjAYV2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjAYV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31446D48
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674682003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sOoHsm7MS2bdA393wRj32TqJ4i4jAbnYJ0SnvWhXtHw=;
        b=K6qYgMotXzCME9RbypNzgKrdr2U4aZ72eVpplR95r6yZEGukNbqnOpUPXDF3lL3xAFIoK4
        iQzSVqx4HclanFluvq42Q8KVO6VCzVQii6gR8vQTqJoZdk2j/v0I/v7GwX6DxF+a3Aw4Dk
        GjwQCSIHdcIC1OajrlgjgAmJyfRI4Bc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-ICXFdIdrNEq5tIfTjsUkZA-1; Wed, 25 Jan 2023 16:26:42 -0500
X-MC-Unique: ICXFdIdrNEq5tIfTjsUkZA-1
Received: by mail-qk1-f199.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so25582qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOoHsm7MS2bdA393wRj32TqJ4i4jAbnYJ0SnvWhXtHw=;
        b=Vd1Ke2804R3oly77GB2cx/wyWNzGJFnSSEeqM4BniEGn9H7ymYq63nHRebmhiDYPNc
         FosJRT9V2+ogGyB1RlUdfQ+eatvCIGzhfAFNUKX/o/74O1bNCeXvjKleiMXsV+dJGgG7
         lnCcNl4PYAUfMSR16fPIvhAR3i8HSxDQQZFLV+CI7V7h8hjIvuecYrhdFt1s+xDvlMKU
         lssiV2oS9yMN71VuY2TSTQEVw02X2L8AEkjm8fAefjd5VdaAm9g99gzg1WOIsJrfSKZw
         OmfXfx37YZwtNge4C9+ex2UtEliBSvMu1I5Y/Fz+PPVs1gD6qXCdZarK9R0TSGPUIghm
         G3kQ==
X-Gm-Message-State: AFqh2kpdu9k6w1qYRujdwn2BMTJtSCdClfyT8driEGr11Nlu4w64jcMS
        JcOlBmPM0oLHI+8szJ6EjCXY5fiTKOD9R1FQh82sGAyotAz3azDO2WnoSAdaJ9S7apIgrw7A8sT
        U8YqLaiFQKA8DBmU/JJK/EvSR
X-Received: by 2002:a0c:aa07:0:b0:531:9e7a:6778 with SMTP id d7-20020a0caa07000000b005319e7a6778mr72020816qvb.1.1674682001460;
        Wed, 25 Jan 2023 13:26:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuJA9ZbWt2pH5x/49GeXNlvIod0ok2NhUl785oS3p0fPE6WFT7R+8daehKb2LTqGaIqJAbHpA==
X-Received: by 2002:a0c:aa07:0:b0:531:9e7a:6778 with SMTP id d7-20020a0caa07000000b005319e7a6778mr72020792qvb.1.1674682001182;
        Wed, 25 Jan 2023 13:26:41 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z17-20020ae9c111000000b00706284b74b5sm4173350qki.52.2023.01.25.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:26:40 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] gpio: tegra186: remove unneeded loop in tegra186_gpio_init_route_mapping()
Date:   Wed, 25 Jan 2023 13:26:31 -0800
Message-Id: <20230125212631.749094-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewing the j loop over num_irqs_per_bank, in the code previous
to the fixes: commit, every j was used. now only when j == 0.
If only j == 0 is used, there is no need for the loop.

Fixes: 210386804745 ("gpio: tegra186: Support multiple interrupts per bank")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpio/gpio-tegra186.c | 40 ++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 9941f35af823..14c872b6ad05 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -677,7 +677,7 @@ static const struct of_device_id tegra186_pmc_of_match[] = {
 static void tegra186_gpio_init_route_mapping(struct tegra_gpio *gpio)
 {
 	struct device *dev = gpio->gpio.parent;
-	unsigned int i, j;
+	unsigned int i;
 	u32 value;
 
 	for (i = 0; i < gpio->soc->num_ports; i++) {
@@ -699,27 +699,23 @@ static void tegra186_gpio_init_route_mapping(struct tegra_gpio *gpio)
 			 * On Tegra194 and later, each pin can be routed to one or more
 			 * interrupts.
 			 */
-			for (j = 0; j < gpio->num_irqs_per_bank; j++) {
-				dev_dbg(dev, "programming default interrupt routing for port %s\n",
-					port->name);
-
-				offset = TEGRA186_GPIO_INT_ROUTE_MAPPING(p, j);
-
-				/*
-				 * By default we only want to route GPIO pins to IRQ 0. This works
-				 * only under the assumption that we're running as the host kernel
-				 * and hence all GPIO pins are owned by Linux.
-				 *
-				 * For cases where Linux is the guest OS, the hypervisor will have
-				 * to configure the interrupt routing and pass only the valid
-				 * interrupts via device tree.
-				 */
-				if (j == 0) {
-					value = readl(base + offset);
-					value = BIT(port->pins) - 1;
-					writel(value, base + offset);
-				}
-			}
+			dev_dbg(dev, "programming default interrupt routing for port %s\n",
+				port->name);
+
+			offset = TEGRA186_GPIO_INT_ROUTE_MAPPING(p, 0);
+
+			/*
+			 * By default we only want to route GPIO pins to IRQ 0. This works
+			 * only under the assumption that we're running as the host kernel
+			 * and hence all GPIO pins are owned by Linux.
+			 *
+			 * For cases where Linux is the guest OS, the hypervisor will have
+			 * to configure the interrupt routing and pass only the valid
+			 * interrupts via device tree.
+			 */
+			value = readl(base + offset);
+			value = BIT(port->pins) - 1;
+			writel(value, base + offset);
 		}
 	}
 }
-- 
2.26.3

