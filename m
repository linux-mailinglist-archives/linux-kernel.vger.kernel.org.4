Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452D74522A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjGBULP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjGBULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B21702;
        Sun,  2 Jul 2023 13:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FA860CBB;
        Sun,  2 Jul 2023 19:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA9C433CD;
        Sun,  2 Jul 2023 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327501;
        bh=r3acrmM5R6Trb3LGMO+5Sf8srO34ZIZ0Ug9mIqIz684=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sm+szgI/DHNV5RF0vRdPQN7vknumQ0vbB7fHWSx9PVVZts8W1a0cOo4OB+lOhJGrM
         IPSUiCLkf1Zk61eH4vax7dPOvKFi6f3hrFD0Tg9rpSiDiADI2gH9Ci/sVhxJRLiz0F
         G2t0BDmiihQZRW3Dp+qCRAW00BQ6sEp+9oOKv0q1MJ+V8pOLEan4viLBp9WwF7wgqL
         oLOmhBZKEMi4aJ+vv1tITWf/xa4xK5RcBBJN32XiSb1+T0I2ESwOwWL3yl1z1U1M5V
         0UdEChYHnZ7s5BKCiG8nW7q8optlnKfaWOHUcyIta1lLb0UsuruAAWpXikNofu7z7m
         OpW3ujqyVUtzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 06/11] ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)
Date:   Sun,  2 Jul 2023 15:51:22 -0400
Message-Id: <20230702195127.1787911-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195127.1787911-1-sashal@kernel.org>
References: <20230702195127.1787911-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit bd5d93df86a7ddf98a2a37e9c3751e3cb334a66c ]

Linux defaults to picking the non-working ACPI video backlight interface
on the Lenovo ThinkPad X131e (3371 AMD version).

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 61586caebb01b..b87783c5872dd 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -470,6 +470,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo ThinkPad X131e (3371 AMD version) */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "3371"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple iMac11,3 */
-- 
2.39.2

