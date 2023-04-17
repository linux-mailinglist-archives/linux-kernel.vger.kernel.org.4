Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200266E45C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDQKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjDQKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69985FE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63FE96223B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A31C433EF;
        Mon, 17 Apr 2023 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681728500;
        bh=Myep5m/XBEvKs0wTrDcqM9pMLIWqZt/FGVgHVGRjfRc=;
        h=From:To:Cc:Subject:Date:From;
        b=sKuIA6NbgHFxeW93bS9xscAlZLOFvfHBeWJTCp57Q/68f7zXp8Gt3M1e/OetfJXmu
         XgcUowxWisA+5dWAyouBeaTyVoRx/OavvtTrjd6aSaAsf0zD8SdsQHcrDMRdBa811u
         D2bsidQsP6y1e1BFr0jKSoDOXUPdkqZ1uaNhEKhXsPbeIlG+Y1LH4uT/vooprljnjC
         QR9pbi3oWwh5tJ84W39B8+00gKAjzFTaR/oUwfReYZ/ncjn5nTPcxBJrKb3ZPm5ADc
         OfGU1++Y9/T0dTS6tBGWC3isR9n0irXPqmbwhl9J/K4/pK+zqVdeBBFUiMrvgSDkNy
         MwesziC/6ETCw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
Date:   Mon, 17 Apr 2023 12:48:17 +0200
Message-Id: <20230417104817.30254-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

From: Hans de Goede <hdegoede@redhat.com>

The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
acpi_video for backlight control. But this is not functional on this
model.

Add a DMI quirk to use the native backlight interface which works.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 69ef2d9710c2..af5cea005f54 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -459,6 +459,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
 		},
 	},
+	{
+	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Ideapad Z470 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
-- 
2.40.0

