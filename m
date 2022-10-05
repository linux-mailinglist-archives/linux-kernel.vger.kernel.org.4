Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389925F5BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJEVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJEVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC78275D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay9so36899qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=JMIcP68+Fkm6QiK7bn2NZQ+WwlSpELUW7JSzlcBQXcE=;
        b=RdlMc163f0DwQiYc58pXZZHCtKq17vcinyVQ5I3n1gtbL9aZrGWogdk9LB0JeE5STV
         2t1voGI1U8lB6aEImQ0agWciSFUb4QEImZ6vwSY2aXnqhcdClH6xbIjVKYFICbU1dbTB
         RHnacX7eI3DZoWGYVRMTQ/6wUQJsRF2YBp1+Y6B76FpzVBSCbxqdlCIAgE9XrPBsiGoI
         LBwqWMZB49pLzXTrkwYn02e3HrxVrEe8BkTcs1WIeocuKG9HjQ6VQuVXXxzTY4owMnKy
         MuJOFHJ1QbUnz3OIge9Y7O2N+05h7s+wWQoaF+k2XReDSmH/WpZaZUIyJ8x5p10xEHwG
         vBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JMIcP68+Fkm6QiK7bn2NZQ+WwlSpELUW7JSzlcBQXcE=;
        b=7VgLZPSf4fnEr8GESaunba2BdY0dRz1/geD9qdQci/PdhF/RJWrXKKcWCCXZBd1X7n
         egL4vHgkuikOW2aO8omyCRA2DGpOZNJ2+QW2ZWfMXz6bxjTV8j0mqvwv80W3xtPdF1i1
         LHLPFlJW216T+SVxPm1yUqzja/9AaeOMS0rT1AzbCCdUGH6gUmGGkaoMypZZzTbcS6Su
         76MhsQxlDkvvH9UbeBKjBfnLpCbTowtd4Q/iJvQNKoA1xmrAAonWUdxwmVylC7KIEpgz
         uAMXeF3yLHpOnQ9vB67281f1Uzj5brvY+X4xo2zZTW0w0Bi1eNOryFK1png++NcQzQjX
         C3kQ==
X-Gm-Message-State: ACrzQf3rDggXvJCdmPpk6FovN0UV/Pfr7bVfI3pTWRbM4vjrFED+O505
        2IPSXhYWarfQkoNgOiPVSJo=
X-Google-Smtp-Source: AMsMyM7yBI/1soiutIAnpBUkd2ed6zqRgJOIjL8DjGpPDQ+u2ATre1Q0dxIKJX/13+4NsRLpTj30kg==
X-Received: by 2002:a05:622a:248:b0:388:60a2:5eed with SMTP id c8-20020a05622a024800b0038860a25eedmr1200614qtx.296.1665005432904;
        Wed, 05 Oct 2022 14:30:32 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:32 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 4/6] phy: usb: Disable phy auto-suspend
Date:   Wed,  5 Oct 2022 14:30:16 -0700
Message-Id: <1665005418-15807-5-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

The BDC block requires the PLL lock in order to grab the PLL clock.
The phy auto-suspend feature turns off the phy when nothing is attached
leading to the PLL to not lock. This leads the BDC block to grab the AUX
clock instead of the PLL clock. This is not ideal, so lets turn this
feature off.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 26e9585e..6a4d478 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -62,6 +62,7 @@
 
 /* Register definitions for the USB_PHY block in 7211b0 */
 #define USB_PHY_PLL_CTL			0x00
+#define   USB_PHY_PLL_CTL_PLL_SUSPEND_MASK		BIT(27)
 #define   USB_PHY_PLL_CTL_PLL_RESETB_MASK		BIT(30)
 #define USB_PHY_PLL_LDO_CTL		0x08
 #define   USB_PHY_PLL_LDO_CTL_AFE_BG_PWRDWNB_MASK	BIT(0)
@@ -259,6 +260,11 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 		brcm_usb_writel(reg, usb_phy + USB_PHY_UTMI_CTL_1);
 	}
 
+	/* Disable PLL auto suspend */
+	reg = brcm_usb_readl(usb_phy + USB_PHY_PLL_CTL);
+	reg |= USB_PHY_PLL_CTL_PLL_SUSPEND_MASK;
+	brcm_usb_writel(reg, usb_phy + USB_PHY_PLL_CTL);
+
 	/* Init the PHY */
 	reg = USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK |
 		USB_PHY_PLL_LDO_CTL_AFE_LDO_PWRDWNB_MASK |
-- 
2.7.4

