Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79642726780
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFGReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFGReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:34:11 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA42680;
        Wed,  7 Jun 2023 10:33:46 -0700 (PDT)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPA id 625932FC00BA;
        Wed,  7 Jun 2023 19:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1686159224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aTmFew1pGWDakBdUlS/JLcrpZ3lyY/CpAeW8FQngm5Y=;
        b=k8yeBHRTQgJehYq+iBzNFWacybGKve8gqWcmOs4ravmf8bZwdlj3YHxNbL6Blj0nFCu5LH
        tr7XiUABWb5w4LYxo5kwHorMqRUGmTqUCDsGjYO4PdS7xB8ULJHciNhdAtsde1g9aXqfl2
        J2OaYzCrK60PIbe6eCE8iPg8+zyDv9g=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN
Date:   Wed,  7 Jun 2023 19:33:31 +0200
Message-Id: <20230607173331.851192-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpad of this device is both connected via PS/2 and i2c. This causes
strange behavior when both driver fight for control. The easy fix is to
prevent the PS/2 driver from accessing the mouse port as the full feature
set of the touchpad is only supported in the i2c interface anyway.

The strange behavior in this case is, that when an external screen is
connected and the notebook is closed, the pointer on the external screen is
moving to the lower right corner. When the notebook is opened again, this
movement stops, but the touchpad clicks are unresponsive afterwards until
reboot.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 028e45bd050bf..1724d6cb8649d 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1281,6 +1281,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PD5x_7xPNP_PNR_PNN_PNT"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
-- 
2.34.1

