Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E448F627F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiKNM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiKNM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:56:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA23286E4;
        Mon, 14 Nov 2022 04:56:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so17163724edc.6;
        Mon, 14 Nov 2022 04:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSCoAMd5ij+y73I07p+YhPw7UjTyLQk7rY41RsaGjf0=;
        b=Vs0ezKqhulrQy4LrTgbXUJsLL1E+njapaniLkEvOCDhSGfbt+PiWNMPu2yd1ioJdV0
         jQ1UZy45mvphmwLSdlMKWkt9nv6hcKE4zNnQkOsr3NVU4Er9OEQdFFJiUYxnES4pHuih
         W/VrVHn+ayAqD8JfNIFT5g8Dt2gRaGftA7lY0gUEINVF2w6VWFWaAMB1Q0lCDovsMrFc
         ZL9IGAo52/Va0H646lOB3cz3lxz37K7UVuOryrf9tto+TpM/QFfW/YXRddSFnUmxcRNk
         /lbW4agBfmJp/izEGP/9CPyI/bTzbIoArh/Show9sqbqxVm7cCyOYxT5fpnDbRMXJOv3
         OGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSCoAMd5ij+y73I07p+YhPw7UjTyLQk7rY41RsaGjf0=;
        b=ngO/IN0miDuz3BM9DCiNrU+cZX0y6IhgmpIrc09Bv2kh6zGRuDM8Rsk0INww8WB1BU
         /G63AEbzh09UJot58QR1XH+bEO5HP7OrMdtAB1C1RGVwrfRlxi7nyzbpMwhtawqkadjB
         NrIXq5H8RXsJFfTCn/OrnFZ/P3BfMCSkXhvvMp1U3ZDzx/FfG0xrP95T4usmjyfe2WvV
         14BMsIR0gKgIPYTM9g7hPKAu+UgVKisjjo6bJDcLf3dFipgrHOXCaIvcppIlnpxmDph6
         UWcz1NKrLFGCpmt/UWtQBx4ATpFlRlkK2mYQT2Qjr/tU0vrY9EWFl+tHN+0U5QcDvNfa
         FVuw==
X-Gm-Message-State: ANoB5pmby4XJ/tyQvEZjeuTUQE0G+lBr7cF6hZ9aC5WDD/fnnmNUjS8W
        M2iGeOMp2gFMLJsVmUuc47s=
X-Google-Smtp-Source: AA0mqf53bdMQADFT39A2YbQtYdfW0PRCMkLqHmcFX9aRvznKCnzOwLhhM2dVR6ncXjuoFP1nLwwMNw==
X-Received: by 2002:a05:6402:715:b0:461:9fe:6d8a with SMTP id w21-20020a056402071500b0046109fe6d8amr10724137edx.4.1668430601085;
        Mon, 14 Nov 2022 04:56:41 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b0078d38cda2b1sm4097302ejb.202.2022.11.14.04.56.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:56:40 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-usb@vger.kernel.org,
        tony@atomide.com, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] usb: phy: add dedicated notifier for charger events
Date:   Mon, 14 Nov 2022 14:56:02 +0200
Message-Id: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_phy::notifier is already used by various PHY drivers (including
phy_generic) to report VBUS status changes and its usage conflicts with
charger current limit changes reporting.

Fix that by introducing a second notifier that is dedicated to usb charger
notifications. Add usb_charger_XXX_notifier functions. Fix charger drivers
that currently (ab)use usb_XXX_notifier() to use the new API.

Fixes: a9081a008f84 ("usb: phy: Add USB charger support")

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/supply/sc2731_charger.c |  4 ++--
 drivers/power/supply/wm831x_power.c   |  7 ++++---
 drivers/usb/phy/phy.c                 |  7 +++++--
 include/linux/usb/phy.h               | 14 ++++++++++++++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 9ac17cf..e3fa0e2 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -500,7 +500,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 	}
 
 	info->usb_notify.notifier_call = sc2731_charger_usb_change;
-	ret = usb_register_notifier(info->usb_phy, &info->usb_notify);
+	ret = usb_charger_register_notifier(info->usb_phy, &info->usb_notify);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register notifier: %d\n", ret);
 		return ret;
@@ -515,7 +515,7 @@ static int sc2731_charger_remove(struct platform_device *pdev)
 {
 	struct sc2731_charger_info *info = platform_get_drvdata(pdev);
 
-	usb_unregister_notifier(info->usb_phy, &info->usb_notify);
+	usb_charger_unregister_notifier(info->usb_phy, &info->usb_notify);
 
 	return 0;
 }
diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 82e3106..0744167 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -650,7 +650,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	switch (ret) {
 	case 0:
 		power->usb_notify.notifier_call = wm831x_usb_limit_change;
-		ret = usb_register_notifier(power->usb_phy, &power->usb_notify);
+		ret = usb_charger_register_notifier(power->usb_phy,
+						    &power->usb_notify);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to register notifier: %d\n",
 				ret);
@@ -701,8 +702,8 @@ static int wm831x_power_remove(struct platform_device *pdev)
 	int irq, i;
 
 	if (wm831x_power->usb_phy) {
-		usb_unregister_notifier(wm831x_power->usb_phy,
-					&wm831x_power->usb_notify);
+		usb_charger_unregister_notifier(wm831x_power->usb_phy,
+						&wm831x_power->usb_notify);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 1b24492..6b8bf05 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -129,12 +129,13 @@ static void usb_phy_notify_charger_work(struct work_struct *work)
 	case USB_CHARGER_PRESENT:
 		usb_phy_get_charger_current(usb_phy, &min, &max);
 
-		atomic_notifier_call_chain(&usb_phy->notifier, max, usb_phy);
+		atomic_notifier_call_chain(&usb_phy->chg_notifier, max,
+					   usb_phy);
 		break;
 	case USB_CHARGER_ABSENT:
 		usb_phy_set_default_current(usb_phy);
 
-		atomic_notifier_call_chain(&usb_phy->notifier, 0, usb_phy);
+		atomic_notifier_call_chain(&usb_phy->chg_notifier, 0, usb_phy);
 		break;
 	default:
 		dev_warn(usb_phy->dev, "Unknown USB charger state: %d\n",
@@ -678,6 +679,7 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 		return ret;
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&x->notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&x->chg_notifier);
 
 	spin_lock_irqsave(&phy_lock, flags);
 
@@ -730,6 +732,7 @@ int usb_add_phy_dev(struct usb_phy *x)
 	x->dev->type = &usb_phy_dev_type;
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&x->notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&x->chg_notifier);
 
 	spin_lock_irqsave(&phy_lock, flags);
 	list_add_tail(&x->head, &phy_list);
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc..23db554 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -111,6 +111,7 @@ struct usb_phy {
 	enum usb_charger_state	chg_state;
 	struct usb_charger_current	chg_cur;
 	struct work_struct		chg_work;
+	struct atomic_notifier_head	chg_notifier;
 
 	/* for notification of usb_phy_events */
 	struct atomic_notifier_head	notifier;
@@ -347,6 +348,19 @@ static inline void usb_phy_set_charger_state(struct usb_phy *usb_phy,
 	atomic_notifier_chain_unregister(&x->notifier, nb);
 }
 
+/* notifiers */
+static inline int
+usb_charger_register_notifier(struct usb_phy *x, struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&x->chg_notifier, nb);
+}
+
+static inline void
+usb_charger_unregister_notifier(struct usb_phy *x, struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&x->chg_notifier, nb);
+}
+
 static inline const char *usb_phy_type_string(enum usb_phy_type type)
 {
 	switch (type) {
-- 
1.9.1

