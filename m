Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADA6C3A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCUTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCUTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:18:01 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620F2B2A1;
        Tue, 21 Mar 2023 12:17:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E9690C80090;
        Tue, 21 Mar 2023 20:16:22 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1679426182; x=1681240583; bh=PDJL0u9SS+5H17TAfTadFLsb
        jnLrahA1Gw422eRsLgQ=; b=Bp50ZfyGq9nWDe2bma6htE/LvfJI7IfYcSJQLSli
        cAA4WqLTr5D5vEpkkWgjASMfCix07T7XWtNLUvAslR9pNhK244z5MHUNOAs0Zre3
        5bqqKq50Qn+DnzD9NLR5qtezzbpkhWJ4nkx0wtxKQEOuPYCE6LioqIAQneCZd7+X
        /F8=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id fFXkc6qfRKUc; Tue, 21 Mar 2023 20:16:22 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 4E34AC8008E;
        Tue, 21 Mar 2023 20:16:22 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        wse@tuxedocomputers.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: i8042 - add TUXEDO devices to i8042 quirk tables for partial fix
Date:   Tue, 21 Mar 2023 20:16:19 +0100
Message-Id: <20230321191619.647911-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of modern Clevo barebones have touchpad and/or keyboard issues after
suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
have an external PS/2 port so this can safely be set for all of them.

I'm not entirely sure if every device listed really needs all four quirks,
but after testing and production use. No negative effects could be
observed when setting all four.

Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
boot and sometimes also after resume. However both are required for the
keyboard to not fail completely sometimes after boot or resume.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-acpipnpio.h | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index efc61736099b9..371406f85ab39 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1116,6 +1116,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
+		 * the keyboard very laggy for ~5 seconds after boot and
+		 * sometimes also after resume.
+		 * However both are required for the keyboard to not fail
+		 * completely sometimes after boot or resume.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
@@ -1123,6 +1137,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
+		 * the keyboard very laggy for ~5 seconds after boot and
+		 * sometimes also after resume.
+		 * However both are required for the keyboard to not fail
+		 * completely sometimes after boot or resume.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-- 
2.34.1

