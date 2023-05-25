Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D0711442
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbjEYSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241690AbjEYSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9910DD;
        Thu, 25 May 2023 11:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6110D648A9;
        Thu, 25 May 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2FC433EF;
        Thu, 25 May 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039661;
        bh=yCycSPHSw5nWKhjjZfEVu6ifWKOZhPfIznzIcS3wp84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRL0jC3W8xbYHkgbSkkueKRSywnlm2H4OFYaQXemfERcbP9ddpm6qCvk4zq0BQdKN
         mJDDKkeuxd/zVMEttOqHCg+OMCEEOPITyigvHyyZOeccQI4bf8g34TC8bToO0ZcqL2
         POU/6xl92Wm6s20u5zyOLvHDQ2dDWZmqlff0gr2U12G2hK4Rrd2O4V0TneIOVO0Suf
         T1ZlRaQBkdjC4kwQNpWB7MSXlNUPXKPS61PRe/Kzd+wJARJhS2DOIbMSHsRNwJq/uu
         a+uje7fb1yIBjmHKpJYLw//ZYH4i7p+HCxlI54gqATEbuTdyInoZpBQ/3T9Z/TAxL9
         cbfmFCuUNlHpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Rub=C3=A9n=20G=C3=B3mez?= <mrgommer@proton.me>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 39/67] ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P
Date:   Thu, 25 May 2023 14:31:16 -0400
Message-Id: <20230525183144.1717540-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rubén Gómez <mrgommer@proton.me>

[ Upstream commit 71a485624c4cbb144169852d7bb8ca8c0667d7a3 ]

Add an ACPI IRQ override quirk for LG UltraPC 17U70P to address the
internal keyboard problem on it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213031
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216983
Signed-off-by: Rubén Gómez Agudo <mrgommer@proton.me>
[ rjw: Subject, changelog, white space damage fixes ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index e8492b3a393ab..0800a9d775580 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -516,6 +516,17 @@ static const struct dmi_system_id maingear_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lg_laptop[] = {
+	{
+		.ident = "LG Electronics 17U70P",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -532,6 +543,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.39.2

