Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947396535BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLUSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLUSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:00:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F624BC5;
        Wed, 21 Dec 2022 10:00:01 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671645598;
        bh=BKyn4L5rGVDIx0LQ1r4Z4c57jvx4ixuqMWSoYecKAck=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Iqs1b+RIkAYD5w6CkJJkyw5HM+R3zTa0Nwk/7A2kjt8qDlCGnR4XB2Df1ry2/fuk4
         jMR+IemR5T5gveJPq3ts40EI/+Be5Vi6tfYatI9Hop/hLi+QXgoXkXWOyGItrxtu1D
         TRDQE2nMqPpuarOlcFOAL4WCWRMuQGw2Laoqv1bo=
Date:   Wed, 21 Dec 2022 17:59:50 +0000
Subject: [PATCH 2/3] platform/x86: asus-wmi: Ignore fan on E410MA
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221221-asus-fan-v1-2-e07f3949725b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671645591; l=1274;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BKyn4L5rGVDIx0LQ1r4Z4c57jvx4ixuqMWSoYecKAck=;
 b=TPX3qg+3FekqQNnjfwWv+uM4mOthddidtLw5lc+cg3Jcs0H/Je0MNbvnWonrttIzLrzaO9GrQTLF
 8ciGd5SqBEKhoGzgy/N+rGq1y3ycecsNPU3Auwhz78rQOh1bv1z/
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

The ASUS VivoBook has a fan device described in its ACPI tables but does
not actually contain any physical fan.
Use the quirk to inhibit fan handling.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index c685a705b73d..5b603c686c8a 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -121,6 +121,10 @@ static struct quirk_entry quirk_asus_tablet_mode = {
 	.tablet_switch_mode = asus_wmi_lid_flip_rog_devid,
 };
 
+static struct quirk_entry quirk_asus_ignore_fan = {
+	.wmi_ignore_fan = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -473,6 +477,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS VivoBook E410MA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E410MA"),
+		},
+		.driver_data = &quirk_asus_ignore_fan,
+	},
 	{},
 };
 

-- 
2.39.0
