Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1B743BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjF3Mg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjF3MgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:36:25 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 05:36:23 PDT
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6935AC;
        Fri, 30 Jun 2023 05:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688127645; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Dk//0Njx8FF/AYZDBW5cKe7m2rtHr10S73FYJqgvmWntZzP5z6aOK11OIguSvl34Tn0oA5o9RYe7Nul1ynIAU4+vdSXlvpC0lqGh/+TeRWsvJAjI3sQ5FoKUPSA0Xy/xLvxvW7VY7DieQXS2tp01Qrj/ndruwWSuli4q9pc71QQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688127645; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6LhIr6V17BrdC653wm2u6g1ZGMjqgmuF6Gf290y9Mik=; 
        b=htfyOO+Tg6ZDjzP4O23dkxu4Y2pLn/9npK0Y5pvRUVlKGgIeugjje7yMHjoeL3dyvKmB5NnD79YXpHrtqHjefP7pEmefnkEZWgJyUQ2FAftPondNUhf9aTrmoELXgY+ycZTs6Yi/Ole0m5gYbbZOaaPTof7AeAoGMNRko3i0cY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688127645;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=6LhIr6V17BrdC653wm2u6g1ZGMjqgmuF6Gf290y9Mik=;
        b=LOmNU0Fs53LMzNr2s0M3AfsVLMlnYVstdIi8idH4DbWSjuampAXE4MZq2PiFJMrC
        ATu31HqUwn/PQhhi02rhd0zNgxDhLKnEsGlOa1YwoW/a191EzAkF3ju0DuAlCc96UKl
        KdIN1Mii9hvpmiTgh1hoxP9s3oFHjg7AuNVZPnYI=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1688127644347812.1873140766394; Fri, 30 Jun 2023 05:20:44 -0700 (PDT)
Date:   Fri, 30 Jun 2023 20:20:44 +0800
From:   Li Chen <me@linux.beauty>
To:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-acpi" <linux-acpi@vger.kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <1890c3fa24c.d101fdf01298845.3731868257024939195@linux.beauty>
In-Reply-To: 
Subject: [PATCH] ACPI: resource: Add IRQ override for MECHREV Jiaolong17KS
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a regression introduced by commit 9946e39fe8d0 ("ACPI: resource: skip
IRQ override on AMD Zen platforms") on MECHREV Jiaolong17KS, which
causes the built-in keyboard to not work. This restores the functionality
by adding an IRQ override.

I have personally tested this on the 17" model but I'm not sure if this
issue is present on the 16 model.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Signed-off-by: Li Chen <me@linux.beauty>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0800a9d77558..5b00ee90388a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -527,6 +527,17 @@ static const struct dmi_system_id lg_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id mechrev_laptop[] = {
+	{
+		.ident = "Jiaolong17KS Series GM7XG0M",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jiaolong17KS Series GM7XG0M"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -544,6 +555,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ mechrev_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.41.0


