Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062307451B8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGBT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjGBT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500313A9B;
        Sun,  2 Jul 2023 12:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B2960C94;
        Sun,  2 Jul 2023 19:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E307C433CB;
        Sun,  2 Jul 2023 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327524;
        bh=Zsj4slkqrA/eZ1T/Xcud8syfsENHN9G8VFtvwEnkfY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmP1mMdvBaHuC3MBuaYkFHo4EI69KDawLRot1Bv9alhMiwmz9eB798Alx2NsvVwGz
         ffH7GxmfaMnwFyLHgq7vtxnXXCMlKIXAmVVH2TOPbgmT2X3Ux9WKwpJe2tALDJGPpq
         OF3h87hQfvmXr2AtAP22xFaM02guUBITRBuIEafDg7IbQvbtYtMM9bHPGxYwDCHriN
         jVZljfjF+1RqESZyCMWJSjiAz51IoVTm2HaE9hcQbtoSDbplTYFBniWeY1p7lU/ipU
         VFGZKPeqlFTdbipsdZqqClc/SGhl+t5NKn5GSdF8NbATct7gYw1QLv272QHSFFpA5v
         m588TDhfE/mjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/9] ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
Date:   Sun,  2 Jul 2023 15:51:49 -0400
Message-Id: <20230702195159.1788402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195159.1788402-1-sashal@kernel.org>
References: <20230702195159.1788402-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
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

[ Upstream commit 4fd5556608bfa9c2bf276fc115ef04288331aded ]

The LID0 device on the Nextbook Ares 8A tablet always reports lid
closed causing userspace to suspend the device as soon as booting
is complete.

Add a DMI quirk to disable the broken lid functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/button.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1f9b9a4c38c7d..d8b1481141385 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,15 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
+	{
+		/* Nextbook Ares 8A tablet, _LID device always reports lid closed */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+	},
 	{
 		/*
 		 * Lenovo Yoga 9 14ITL5, initial notification of the LID device
-- 
2.39.2

