Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97D69A985
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBQK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:59:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4C3028D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:59:13 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SySNpfME7qIOtSySNpIV5M; Fri, 17 Feb 2023 11:59:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 11:59:11 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Reorder fields in 'struct acpi_video_device'
Date:   Fri, 17 Feb 2023 11:59:08 +0100
Message-Id: <6b868520dac20434296b6282496d3234fae01115.1676631473.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct acpi_video_device'
from 264 to 256 bytes.

This size is much better when the struct is kmalloc()'ed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct acpi_video_device {
	long unsigned int          device_id;            /*     0     8 */
	struct acpi_video_device_flags flags;            /*     8     1 */
	struct acpi_video_device_cap cap;                /*     9     1 */

	/* XXX 6 bytes hole, try to pack */

	struct list_head           entry;                /*    16    16 */
	struct delayed_work        switch_brightness_work; /*    32   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
	int                        switch_brightness_event; /*   216     4 */

	/* XXX 4 bytes hole, try to pack */

	struct acpi_video_bus *    video;                /*   224     8 */
	struct acpi_device *       dev;                  /*   232     8 */
	struct acpi_video_device_brightness * brightness; /*   240     8 */
	struct backlight_device *  backlight;            /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	struct thermal_cooling_device * cooling_dev;     /*   256     8 */

	/* size: 264, cachelines: 5, members: 11 */
	/* sum members: 254, holes: 2, sum holes: 10 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct acpi_video_device {
	long unsigned int          device_id;            /*     0     8 */
	struct list_head           entry;                /*     8    16 */
	struct acpi_video_device_flags flags;            /*    24     1 */
	struct acpi_video_device_cap cap;                /*    25     1 */

	/* XXX 2 bytes hole, try to pack */

	int                        switch_brightness_event; /*    28     4 */
	struct delayed_work        switch_brightness_work; /*    32   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
	struct acpi_video_bus *    video;                /*   216     8 */
	struct acpi_device *       dev;                  /*   224     8 */
	struct acpi_video_device_brightness * brightness; /*   232     8 */
	struct backlight_device *  backlight;            /*   240     8 */
	struct thermal_cooling_device * cooling_dev;     /*   248     8 */

	/* size: 256, cachelines: 4, members: 11 */
	/* sum members: 254, holes: 1, sum holes: 2 */
	/* paddings: 1, sum paddings: 4 */
};
---
 drivers/acpi/acpi_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 97b711e57bff..1118dd7dbf6c 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -202,11 +202,11 @@ struct acpi_video_device_cap {
 
 struct acpi_video_device {
 	unsigned long device_id;
+	struct list_head entry;
 	struct acpi_video_device_flags flags;
 	struct acpi_video_device_cap cap;
-	struct list_head entry;
-	struct delayed_work switch_brightness_work;
 	int switch_brightness_event;
+	struct delayed_work switch_brightness_work;
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
-- 
2.34.1

