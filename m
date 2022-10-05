Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAB5F5BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJEVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiJEVaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD26CD07
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id df9so61082qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=5O3jIVr64CiQseI05tQ1L9JTmyGQdfGurfwQZxipgug=;
        b=YZjqFIYRm86r88eet+RHegWc516nit5XY2Kvkl5gHgki3N1vL+ITbzkyOFd6Qc7frr
         rkIOXSlM3r/tWEJvurcmIFzU9I0R0yvZ23TR9GVTcSbRwzaajXULVkgftfdNF7yoZAPG
         +Xs6OL2AZhFphrmmnNMRY4zSl2k5kURdCafE8ZECN9y0jOxsGbIdR+y23b4cn67ae7Cg
         fcvV9XxsA0VGdYw1jfty3HrLVFn1Wb7xo4vZpwAynJJWPVRCLC0pxGzt5ejaI6sjnIB1
         tCSzN67IlK0aJDapKwKl1UBZxV9D/8GtMCuzzgDu9wflQJjwdTZaSwxa6DEkNSiB1Yh0
         Gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5O3jIVr64CiQseI05tQ1L9JTmyGQdfGurfwQZxipgug=;
        b=zjfcEYDQXjq9rgnW7pQoscmITPWotiG2XCtn+ya7XbuuHXlUMylnF9zF5gaofW3zi2
         MDRvTj+TUD/ZdbDjncoBfGWNzHKNyK+38La3Bwo+duCuYDUj6hbN4ft05CI5F4g50s9b
         /PNYrzRexBgVw4dA+DpNimaKQP0H5AKYIkpZj9v7+R2q9RHRpkgXyin+akjLNSEcf4rA
         /XjLnc5R9ie33c5teHy8/NqsvuqNE9RkDgkUgBFPk1cNYqtZl98pihdl8eR32mF6tll3
         s099M35phQeinpc9zagipVNmPkatU0WXUAHqSdrDdcq3cN/dU1b54OpMgl8BG6qjLvRD
         2Jhw==
X-Gm-Message-State: ACrzQf0J93GmITDDCB5FW77hbkamOvp9oL2JH0gnyZWWQxmKA/q+bLnz
        1ke1n3AUWBCEXd3ZES1Ve6I=
X-Google-Smtp-Source: AMsMyM5kZeauboCPZed7iPEVN88q/fKgdIhWoaBA+Osd+L7E0yJamlnOBDk2GsnuG6HEiFAi8efw3w==
X-Received: by 2002:a05:6214:d06:b0:4ad:1fe1:9b49 with SMTP id 6-20020a0562140d0600b004ad1fe19b49mr1377386qvh.57.1665005428187;
        Wed, 05 Oct 2022 14:30:28 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:27 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 2/6] phy: usb: s2 WoL wakeup_count not incremented for USB->Eth devices
Date:   Wed,  5 Oct 2022 14:30:14 -0700
Message-Id: <1665005418-15807-3-git-send-email-justinpopo6@gmail.com>
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

From: Al Cooper <alcooperx@gmail.com>

The PHY's "wakeup_count" is not incrementing when waking from
WoL. The wakeup count can be found in sysfs at:
/sys/bus/platform/devices/rdb/*.usb-phy/power/wakeup_count.
The problem is that the system wakup event handler was being passed
the wrong "device" by the PHY driver.

Fixes: f1c0db40a3ad ("usb: Add "wake on" functionality")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 99d4dea..d97fa58 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -102,9 +102,9 @@ static int brcm_pm_notifier(struct notifier_block *notifier,
 
 static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
 {
-	struct phy *gphy = dev_id;
+	struct device *dev = dev_id;
 
-	pm_wakeup_event(&gphy->dev, 0);
+	pm_wakeup_event(dev, 0);
 
 	return IRQ_HANDLED;
 }
@@ -452,7 +452,7 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 	if (priv->wake_irq >= 0) {
 		err = devm_request_irq(dev, priv->wake_irq,
 				       brcm_usb_phy_wake_isr, 0,
-				       dev_name(dev), gphy);
+				       dev_name(dev), dev);
 		if (err < 0)
 			return err;
 		device_set_wakeup_capable(dev, 1);
-- 
2.7.4

