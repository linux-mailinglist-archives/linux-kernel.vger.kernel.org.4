Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE8B60EBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiJZWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiJZWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:46:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6A614FD0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:45:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z6so3321521qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6Inx+2mnGbd87syi22INdQZv7d9rvjsHpIiLrtgoFk=;
        b=qhzYBGmPJLhr8FTtHtDHTDfF6FveUlj/50ukcwNWiL09tfLEQeDT1eJ6yHVlePX8De
         1JAhpVZfHM0OLzPnJPCofWMmbnDTLgLAvMNkRlSOU7rrHj1GfmEK/n//wSoZRkYyXDPB
         vQIXxP8bH3s5+rCid+nhpK+2TFBuAOti2UTot4o5v5dQWw5naEw6+ZTOF8dvwRo+142u
         uB9nh7tFjtqRHK6iuexCz8w/BSBtPm6wQfycyjHmvbNEyQSmyu7PcYM2OKbz7UpnDxoH
         Q3wvsiStSf/uu+ttt+YzftSb1X/p8ujRRudK7Q3ksTNs7BAb0DSgLFkGyXAnBgIHk5+G
         3mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6Inx+2mnGbd87syi22INdQZv7d9rvjsHpIiLrtgoFk=;
        b=zcEPm4nff44NJuYXSXLqaiWoZbm0tTlIEZFTyQ2UAtunMnAYCCZSEuiL1Zphv4ueWi
         ayPhUBIP7U9ijoXKm6ifiO1y2x37+XxcvydTGcRzi7zD4/T1Lk+QoSOsHSBHrPazKxFp
         +iUb6O7U26upH+cmPHU5PDfHrbUIcua/aeT07sklkOLTrytTyxmTqXc7qmdpmzzKRlBu
         0hm8qEYmbEdyd7FRVN8OR0L1KVZmaq2TNk0GPBFTq4B6wB2vpXRctRCKok9psO92188V
         MXVgwhLMl1SkDyO9aJJPK22q2xhhPqCljwR3TSZrIB/QGUGbGn5lbEuQ5yCArQ8bIvj2
         Ez8w==
X-Gm-Message-State: ACrzQf2TXS3pskHu85U9lnaLrBxlC6c0YfJAkz/CcBqxNywZcu3E15/S
        sbXJsDtDxTDtKAKPI5C6tSdmJsMDtvrR9A==
X-Google-Smtp-Source: AMsMyM7MvMhCDWgRBDgUrZo7cfyQBcnISZuDPBui6lKaPU83fxccaA7gUQsXIT2f5HaUidS9r3icag==
X-Received: by 2002:a05:622a:284:b0:39c:cbec:e1f0 with SMTP id z4-20020a05622a028400b0039ccbece1f0mr38410506qtw.451.1666824340718;
        Wed, 26 Oct 2022 15:45:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ff12-20020a05622a4d8c00b0039cb5c9dbacsm3895060qtb.22.2022.10.26.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:45:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     justinpopo6@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH] phy: phy-brcm-usb: Utilize platform_get_irq_byname_optional()
Date:   Wed, 26 Oct 2022 15:44:49 -0700
Message-Id: <20221026224450.2958762-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wake-up interrupt lines are entirely optional, avoid printing
messages that interrupts were not found by switching to the _optional
variant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 2cb3779fcdf8..fbf454b206f2 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -445,9 +445,9 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 		priv->suspend_clk = NULL;
 	}
 
-	priv->wake_irq = platform_get_irq_byname(pdev, "wake");
+	priv->wake_irq = platform_get_irq_byname_optional(pdev, "wake");
 	if (priv->wake_irq < 0)
-		priv->wake_irq = platform_get_irq_byname(pdev, "wakeup");
+		priv->wake_irq = platform_get_irq_byname_optional(pdev, "wakeup");
 	if (priv->wake_irq >= 0) {
 		err = devm_request_irq(dev, priv->wake_irq,
 				       brcm_usb_phy_wake_isr, 0,
-- 
2.25.1

