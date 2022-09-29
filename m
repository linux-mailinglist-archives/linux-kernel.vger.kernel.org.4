Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2705EF045
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiI2IVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiI2IVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:21:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91112BD9D;
        Thu, 29 Sep 2022 01:21:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f193so848090pgc.0;
        Thu, 29 Sep 2022 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NjjNdfU7BK4+fCgcb+UZylzDA9M3ULA0OcbRITJqecM=;
        b=ZEOC/qb5CBW/kvV5MZCRG0+x+ZBkWEqBjstKDrR7uA99IU41DCUbROyAzlmlq0amUl
         /0S686uPgHKdDsurz8SpizusT/Q4vvk5n3j0t7Te4XgfhsoIS43tjwQXcW0R4xxE3MXo
         kEbE3zw9u0+LDlXiUVF3bBm90VLzK2+FeJTDgxGo8PeR+UW5KKwa4VneFmD90jNBnJG8
         sf/JfHQJ9QBKJapQO6A9k/e6SCSWePs/umwPiEge4+Dm4jJUjFM2/W1Girav5Pbv41eD
         t5BFrnUK+LEwCSyRaGUhkD1KcczsQTDrCalIFpzwaHV9VtAgq4RCx2B0DRl1QRn2vmCA
         plXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NjjNdfU7BK4+fCgcb+UZylzDA9M3ULA0OcbRITJqecM=;
        b=6w5zM8VpHEoustKWLMLvGk/fBh7azpJXlUn+KU+64UEHbzTp8rV1o85njpsIUafK6/
         qEqx1sS50l+zYjsl5a90gwol4kNy1wTLqf0rtvtcVy3FOh8BXaEvEcSLwZU3eN3pRI4t
         lDL/QybOYG0z1dqyasf/IkTT6YTdiTIlAcPdxR6Nw0MBFXGFloaMZVIXUaSEJYKdKwmc
         Tsy7cxuYjTjS+rrxMtSkqfbwnjQ15F5eEcw3HILviDqCNQtpR8TlvvRZxTTQWpW173il
         E+0Evshq5zSbGSHMbw88RutMJIdL0zVi0lVfmEQYCAguZRsewWy47kAhIuEsVOEJ3JXJ
         01ug==
X-Gm-Message-State: ACrzQf3vfBOdnn2C9Qg54bDMkeED1MD0/PbLpuskYvmK7jZuJMx3zRXe
        bR8/huZ39hlvFF7maMkW3oj5hqtu8Y7nnw==
X-Google-Smtp-Source: AMsMyM4XWKbJsHG/mCz5GtTGkKRrENKjqwkuZxAM2HXH9QI56am5s9gIo3s8aj/LhIuoZ2eupGGnoQ==
X-Received: by 2002:aa7:8543:0:b0:54b:6ea4:7a12 with SMTP id y3-20020aa78543000000b0054b6ea47a12mr2227453pfn.33.1664439683067;
        Thu, 29 Sep 2022 01:21:23 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id p16-20020aa79e90000000b005360da6b26bsm5474476pfq.159.2022.09.29.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:21:22 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Thu, 29 Sep 2022 01:21:19 -0700
Message-Id: <20220929082119.22112-4-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929082119.22112-1-nyanpasu256@gmail.com>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
v3 touchpad (dmesg says "with firmware version 0x450f02"), the reported
size of my touchpad (in userspace by calling mtdev_configure() and
libevdev_get_abs_maximum(), in kernel space
elantech_device_info::x_max/y_max, either way 1470 by 700) is half that
of the actual touch range (2940 by 1400), and the upper half of my
touchpad reports negative values. As a result, with the Synaptics or
libinput X11 driver set to edge scrolling mode, the entire right half of
my touchpad has x-values past evdev's reported maximum size, and acts as
a giant scrollbar!

The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
sets up absolute mode and doubles the hardware resolution (doubling the
hardware's maximum reported x/y coordinates and its response to
ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
coordinate system size using ETP_FW_ID_QUERY, which gets cached and
reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
touchpad size reported to userspace (and used to subtract vertical
coordinates from) is half the maximum position of actual touches.

This patch splits out a function elantech_query_range_v3() which fetches
*only* ETP_FW_ID_QUERY (touchpad size), and calls it a second time if
elantech_set_absolute_mode() enables double-size mode. This means the
first call is redundant and wasted if a second call occurs, but this
minimizes the need to restructure the driver.

Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/

Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
---
 drivers/input/mouse/elantech.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 263779c031..a2176f0fd3 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1006,6 +1006,9 @@ static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
 		psmouse_err(psmouse, "restoring reg_07 failed\n");
 }
 
+static int elantech_query_range_v3(struct psmouse *psmouse,
+				   struct elantech_device_info *info);
+
 /*
  * Put the touchpad into absolute mode
  */
@@ -1047,6 +1050,14 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
 			rc = -1;
 
+		/*
+		 * If we boost hardware resolution, we have to re-query
+		 * info->x_max and y_max.
+		 */
+		if (etd->info.set_hw_resolution)
+			if (elantech_query_range_v3(psmouse, &etd->info))
+				rc = -1;
+
 		break;
 
 	case 4:
@@ -1671,6 +1682,20 @@ static int elantech_set_properties(struct elantech_device_info *info)
 	return 0;
 }
 
+static int elantech_query_range_v3(struct psmouse *psmouse,
+				   struct elantech_device_info *info)
+{
+	unsigned char param[3];
+
+	if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		return -EINVAL;
+
+	info->x_max = (0x0f & param[0]) << 8 | param[1];
+	info->y_max = (0xf0 & param[0]) << 4 | param[2];
+
+	return 0;
+}
+
 static int elantech_query_info(struct psmouse *psmouse,
 			       struct elantech_device_info *info)
 {
@@ -1826,11 +1851,8 @@ static int elantech_query_info(struct psmouse *psmouse,
 		break;
 
 	case 3:
-		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (elantech_query_range_v3(psmouse, info))
 			return -EINVAL;
-
-		info->x_max = (0x0f & param[0]) << 8 | param[1];
-		info->y_max = (0xf0 & param[0]) << 4 | param[2];
 		break;
 
 	case 4:
-- 
2.37.3

