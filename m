Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC17711603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjEYSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242662AbjEYSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E83A94;
        Thu, 25 May 2023 11:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE0E60BCC;
        Thu, 25 May 2023 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C2C433EF;
        Thu, 25 May 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040023;
        bh=x9I+mP7q2Y5v2IAomGu1k9FrDjK3hjenaJlu4HSWBPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0qz98EuyQbJhB2lIPQZeyNjNClkr7T8TsmxbYQGjNZ0V3m4aQas5ANCR1J3w08RO
         oixLPvVKwWC8JZF67Qp0wRAqChcJy2q1rD8qM2C1MKN8l0ZIy+kq/c6s1wLw8mOLAq
         HNcTWyi7G9SX0X+Fy/kNc5LmUZuvN5HeCFjQZcH/fzhIjWcR50MEffMv2IJY8pBRUW
         HEdy2OdsZQXhdrA4uayYgg3Dj3H3xoKbHH5+hQWYpEhmF1y51epm9MmAgAWqi9bPpT
         NBGnZL1sG7/fc8quu1HW2CbtRep2Z1ARybdecnovg+SVrBUbWWMkiWVjk4Vrvx+rng
         KX3UQfGim9J+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Rub=C3=A9n=20G=C3=B3mez?= <mrgommer@proton.me>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/43] ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P
Date:   Thu, 25 May 2023 14:38:38 -0400
Message-Id: <20230525183854.1855431-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 803dc6afa6d69..b0c7ae50a8d79 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,6 +470,17 @@ static const struct dmi_system_id maingear_laptop[] = {
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
@@ -486,6 +497,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.39.2

