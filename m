Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E216535B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLUSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:00:01 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8E24BC2;
        Wed, 21 Dec 2022 10:00:00 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671645598;
        bh=6GqkRUcKuJwMJo72qVD9f/Gx/0oC7Cwj+9937ZraC8U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eF8CmCCFfRQRyq96H5YPy2zQhG11HnEGg9Zz+Kkq6PXoPld3lna9OQhzM5XkmDaFq
         vgg5So5htnyqdBd/0io2IM+6KLg8JZhFtFf+0OZj+wSc1Cf8/dYdplUm41IKXxX40D
         PXa4T6I+dcSseQCo6xgs+lKrR1OPCIgAgnHQOc5g=
Date:   Wed, 21 Dec 2022 17:59:49 +0000
Subject: [PATCH 1/3] platform/x86: asus-wmi: Add quirk wmi_ignore_fan
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221221-asus-fan-v1-1-e07f3949725b@weissschuh.net>
References: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
In-Reply-To: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671645591; l=1566;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6GqkRUcKuJwMJo72qVD9f/Gx/0oC7Cwj+9937ZraC8U=;
 b=2tJc6DdqWrSkjnXYGSw8yaqYHBQu5/Z3B5QJ0VkOvuyF1+Qm8E8EBzmDmgCLGOBQQo/uNfLdaaJQ
 RaPrQD+8BZPt5OmCmoDeI3lPts7nCNe+oZN9MiwYEqlSIQdXPC5R
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops have a fan device listed in their ACPI tables but do not
actually contain a fan.
Introduce a quirk that can be used to override the fan detection logic.

This was observed with a ASUS VivoBook E410MA running firmware
E410MAB.304.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/asus-wmi.c | 4 +++-
 drivers/platform/x86/asus-wmi.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6f81b2844dcb..4a289ca7e76c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2243,7 +2243,9 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	asus->fan_type = FAN_TYPE_NONE;
 	asus->agfn_pwm = -1;
 
-	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CPU_FAN_CTRL))
+	if (asus->driver->quirks->wmi_ignore_fan)
+		asus->fan_type = FAN_TYPE_NONE;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CPU_FAN_CTRL))
 		asus->fan_type = FAN_TYPE_SPEC83;
 	else if (asus_wmi_has_agfn_fan(asus))
 		asus->fan_type = FAN_TYPE_AGFN;
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 65316998b898..a478ebfd34df 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -38,6 +38,7 @@ struct quirk_entry {
 	bool store_backlight_power;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
+	bool wmi_ignore_fan;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*

-- 
2.39.0
