Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393760B3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiJXRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJXRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:15:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D311057D7;
        Mon, 24 Oct 2022 08:51:00 -0700 (PDT)
Received: from dimapc.. (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D3136602390;
        Mon, 24 Oct 2022 15:12:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666620745;
        bh=Q+4AswO00Nv3cSoxhgG3pbKKgBU8khIrJ9IPMDqjLhM=;
        h=From:To:Cc:Subject:Date:From;
        b=BX4v4wwl71EG6cAbPY4kIPmUD5EAK8yw3SwFizvk8menDgKGNFbUp+LWQSgVm1do/
         CjR3LkdhpvTKq+QsndmvG6LMybi5UhroTz7ClD8VD7QbiWJBuC3cgb/Y9sZeeMRi1I
         jAVX9uLRP3GYZtvjxj/lnXUkbdIALmeDbAsvPX5zvSl9uaFKhbAXm6QgUXT56bm/XV
         iDtys/1MHprPhKIOddRRqBK6gMEL7d37ugQHFYlhfkEn0qw1hRWm/g4X+S81BD40Tq
         Sh/roxAT4B4mAOImsoGYXUWwP6mam4OiBVe+VGa/oTd6u/nBK1yQUozURtHaDYWj/7
         XBKRWjZswx00g==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     kernel@collabora.com, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: video: Fix missing native backlight on Chromebooks
Date:   Mon, 24 Oct 2022 17:12:10 +0300
Message-Id: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
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

Chromebooks don't have backlight in ACPI table, they suppose to use
native backlight in this case. Check presence of the CrOS embedded
controller ACPI device and prefer the native backlight if EC found.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

Changelog:

v2: - Added explanatory comment to the code and added check for the
      native backlight presence, like was requested by Hans de Goede.

 drivers/acpi/video_detect.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0d9064a9804c..9cd8797d12bb 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{ },
 };
 
+static bool google_cros_ec_present(void)
+{
+	return acpi_dev_found("GOOG0004");
+}
+
 /*
  * Determine which type of backlight interface to use on this system,
  * First check cmdline, then dmi quirks, then do autodetect.
@@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 			return acpi_backlight_video;
 	}
 
+	/*
+	 * Chromebooks that don't have backlight handle in ACPI table
+	 * are supposed to use native backlight if it's available.
+	 */
+	if (google_cros_ec_present() && native_available)
+		return acpi_backlight_native;
+
 	/* No ACPI video (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
 }
-- 
2.37.3

