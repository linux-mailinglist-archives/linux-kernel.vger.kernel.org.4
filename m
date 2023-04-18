Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95646E5988
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDRGmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A40210E0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 359FB61B38
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72813C433EF;
        Tue, 18 Apr 2023 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681800123;
        bh=y72DF0E7u7RU4Cxgdpwh3A5xcMzSKvfburM2M0qXuxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EOVwF1tfaMJciSs9pQ7IaKeHgB2VmmYdVlEuizjK4bqRIiYngAB1eHd4dhXKH+ZkD
         XalyJyjaTaHNTRhW+X3aTuPIut4EEKbBl8b0ze+I6C+5u8vNUPAshThhmHw4KhNTMx
         Q9kKZ4ExhACMH87OfVFn0iT8bhyQBSQlTuFHIjYYJhNcSHqXoFlEwliEx1Qk/WaeaU
         J0lNcgcfhqVTBH7D+Q9dNv9zkxG1AQaqXVYdfmaeTMEhRlI8rv3aJlZ3Skd4Gp7lsU
         qGQO3j2zCwJb0ipBZD2NJt4yVk75OYj9r+8CMm2yrOOHtmA9FwAoQmyABKbNO7xeW+
         /MZu0/CmJD55w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
Date:   Tue, 18 Apr 2023 08:42:00 +0200
Message-Id: <20230418064200.24303-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
acpi_video for backlight control. But this is not functional on this
model.

Add a DMI quirk to use the native backlight interface which works.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Notes:
    [v2] fix authorship

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

