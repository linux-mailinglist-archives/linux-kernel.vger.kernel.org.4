Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F936F2D39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjEADJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjEADE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBDA4EDD;
        Sun, 30 Apr 2023 20:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12C1617AC;
        Mon,  1 May 2023 03:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68765C433D2;
        Mon,  1 May 2023 03:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910100;
        bh=9iCPb1n3q1m6MRO13zX8nNwGXFG5gf9fMLylunhSlBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwhsbiOJGytTThkiMXtqjz1/4Eo5lA2FM+7qczpIhdug3zUl7gp8oJJuPxinEW9TL
         LUfbEBP6yWF0tIh8QJrzeR5wRKabYSHOwW/XLRroHY2tDBT+kwBL5OCcUk9wtwPFV0
         dG+9n8LTIhTfnUn+p9OIqaiqUOTCAAd6ayIUVWtDIstzNNaHG2GS7Gzj4BwV2ctHKE
         U3RbdSzbwTKkMOOPLb4HdInecGW6fHvYwR82ud07RC6NWbo9OmtxQZv4tij50xNchc
         zVcmGIYsYrVZGPcF63jhbTgKRKcbiJ6VrsdMZuUEk14Kh+rCaBzcFY4mlVTe0cZpBO
         2oSCVZc+k+rfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 31/37] ACPI: video: Remove desktops without backlight DMI quirks
Date:   Sun, 30 Apr 2023 22:59:39 -0400
Message-Id: <20230501025945.3253774-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit abe4f5ae5efa6a63c7d5abfa07eb02bb56b4654e ]

After the recent backlight changes acpi_video# backlight devices are only
registered when explicitly requested from the cmdline, by DMI quirk or by
the GPU driver.

This means that we no longer get false-positive backlight control support
advertised on desktop boards.

Remove the 3 DMI quirks for desktop boards where the false-positive issue
was fixed through quirks before. Note many more desktop boards were
affected but we never build a full quirk list for this.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e85729fc481fd..69ef2d9710c2c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,12 +130,6 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_detect_force_none(const struct dmi_system_id *d)
-{
-	acpi_backlight_dmi = acpi_backlight_none;
-	return 0;
-}
-
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -768,35 +762,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
-
-	/*
-	 * Desktops which falsely report a backlight and which our heuristics
-	 * for this do not catch.
-	 */
-	{
-	 .callback = video_detect_force_none,
-	 /* Dell OptiPlex 9020M */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* GIGABYTE GB-BXBT-2807 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* MSI MS-7721 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
-		},
-	},
 	{ },
 };
 
-- 
2.39.2

