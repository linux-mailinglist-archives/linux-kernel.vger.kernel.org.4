Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BFA6A63EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB1Xxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjB1Xxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:53:42 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE820D3D;
        Tue, 28 Feb 2023 15:53:32 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17235c8dab9so12689758fac.7;
        Tue, 28 Feb 2023 15:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aI0IGm7iAqk6zQ/LnlfcNFRLt84DlvpSajHyHkJ9AI=;
        b=m6hxFVX85BqRKlC0rhX0/G7+8aOcOCgLBQEaMChjy6vUGZxvfslaDLkQI3TY3QkJlg
         aKwQFDQihSVg2vn3psolp2fhxUVc1V8njHVaMizmdmqvEhOBmOiIJouEYA8I4IcawIDP
         KTbdrf0APsO2Ax/SXVUN6U2CitzkyQpKFM9eeH9NL9DKFTY6xqw4rQeQw17UcyEnpdbL
         12DIMxHxk38nnYEEDzX3aA+yW84T9+OoYza65fPL41Zy4Iz3gkUuKx1bk7STLW7bCtEs
         8f1IV/nTMYGq/ZenjicM/QVqtGP9IUtCLSV4EdTMhA96QZSifGGTl5j7NJQVZEQ69pFZ
         n/9Q==
X-Gm-Message-State: AO0yUKVGMZtzPWbRaVElxd3GFmdAz5UT/pbvB93RxnY8XYN64Dxb5I7U
        mi0y2ew9FG2nDn/0GqkmSC9zZ+cLPQ==
X-Google-Smtp-Source: AK7set+JrriyX6HdMqID62LqWmw8BTkKVgjKbjm9wEZPDH7xsJa3/YNQ6EJtcOe1pqpWsp4js4lKMw==
X-Received: by 2002:a05:6870:17a3:b0:175:72b6:ec4d with SMTP id r35-20020a05687017a300b0017572b6ec4dmr821652oae.25.1677628411329;
        Tue, 28 Feb 2023 15:53:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g12-20020a4ac4cc000000b005250c840e64sm4305728ooq.3.2023.02.28.15.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:53:30 -0800 (PST)
Received: (nullmailer pid 13474 invoked by uid 1000);
        Tue, 28 Feb 2023 23:53:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: xhci-tegra: Drop using of_irq_parse_one()
Date:   Tue, 28 Feb 2023 17:53:22 -0600
Message-Id: <20230228235322.13289-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers generally shouldn't be using of_irq_parse_one() directly as it
is a low-level interrupt parsing API. The exceptions are cases that need
the values from the 'interrupts' property.

This is not the case for Tegra XHCI driver as it just uses
of_irq_parse_one() to test for 'interrupts' being absent or invalid.
Instead, just make the interrupt optional on any error other than
deferred probe. The exact reason for failing to get the interrupt is not
that important.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/host/xhci-tegra.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ff22f675930..b9349b8c8ff1 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1535,7 +1535,6 @@ static void tegra_xusb_deinit_usb_phy(struct tegra_xusb *tegra)
 
 static int tegra_xusb_probe(struct platform_device *pdev)
 {
-	struct of_phandle_args args;
 	struct tegra_xusb *tegra;
 	struct device_node *np;
 	struct resource *regs;
@@ -1594,15 +1593,13 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto put_padctl;
 	}
 
-	/* Older device-trees don't have padctrl interrupt */
-	err = of_irq_parse_one(np, 0, &args);
-	if (!err) {
-		tegra->padctl_irq = of_irq_get(np, 0);
-		if (tegra->padctl_irq <= 0) {
-			err = (tegra->padctl_irq == 0) ? -ENODEV : tegra->padctl_irq;
-			goto put_padctl;
-		}
-	} else {
+	tegra->padctl_irq = of_irq_get(np, 0);
+	if (tegra->padctl_irq == -EPROBE_DEFER) {
+		err = tegra->padctl_irq;
+		goto put_padctl;
+	} else if (tegra->padctl_irq <= 0) {
+		/* Older device-trees don't have padctrl interrupt */
+		tegra->padctl_irq = 0;
 		dev_dbg(&pdev->dev,
 			"%pOF is missing an interrupt, disabling PM support\n", np);
 	}
-- 
2.39.2

