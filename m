Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A77694F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBMSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBMSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:17:20 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9461EBF3;
        Mon, 13 Feb 2023 10:17:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 79D95C80098;
        Mon, 13 Feb 2023 19:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1676312216; x=1678126617; bh=e+QJjfVRihIyZHA7FNTA1kat
        Vny8VH++O2nlHPm8bXI=; b=Eu6yoPz+9tHsbLGxIu2BJaTIE5BfXydW0M9ZyU8p
        BoQ2bhKYG8aqX+ouyBL6uN5DQFQjuGNBtjYLCuMhnOd8IMq4tAb6e8byQsOQz/+P
        pqkoXongYH+fE92//yoYsT0oC2WtOH2oJf6oswxxCssmKGff4YI1eR02682OoB/j
        YOs=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id CP39ETjdK-S9; Mon, 13 Feb 2023 19:16:56 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 23593C80091;
        Mon, 13 Feb 2023 19:16:56 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: resource: Do IRQ override on all TongFang GMxRGxx
Date:   Mon, 13 Feb 2023 19:16:53 +0100
Message-Id: <20230213181653.587327-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply
commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
override for all vendors using this mainboard.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/resource.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 16dcd31d124fe..176e1f6684dc6 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -460,11 +460,10 @@ static const struct dmi_system_id lenovo_laptop[] = {
 	{ }
 };
 
-static const struct dmi_system_id schenker_gm_rg[] = {
+static const struct dmi_system_id tongfang_gm_rg[] = {
 	{
-		.ident = "XMG CORE 15 (M22)",
+		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
@@ -485,7 +484,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.34.1

