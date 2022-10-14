Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76BB5FED16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJNLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJNLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:16:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD71119E5;
        Fri, 14 Oct 2022 04:16:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so7626746pjg.1;
        Fri, 14 Oct 2022 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ9x1DKTDjWXt2rrutxCXuZDyQghZxj5+fEV2TfvAvs=;
        b=GGR9QAAHAfGR9wweKWtDevR/eOldcfQ/e3droNg75WCBIpN/C/lma0OPWhc8Hd4U9V
         YjnZxHcC9hcfeFfwycH8GwZRAdKsHsj+yD0uazhdKYcbsGCd+kMPULTc8spBWEAZQ3uX
         jvP9oHCKS3C5VWdxjNLJoppUf4j7M9WWQYzw//4O/fqseNDD81EwxfP/PgAY+O/6/C2i
         7vjmV5PM9vz9VqLfe5xWXLUUCFj5T9apYLbLdcmTHSZuXY+M+xiB0JEol8+ShyZLsUxb
         PKOpZgyih+6xnf8kXEMaB/esQNABS/qy38N9Dx8VejPPQYP3S4DJtEO6goan4wWikLVp
         Dd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ9x1DKTDjWXt2rrutxCXuZDyQghZxj5+fEV2TfvAvs=;
        b=DL6nvpwxrOsyO+UZQFvKXjW+GDQTkgXzHz5SY5vH2fqdgUA+jeZVEPIePewlBSp1tl
         g5+idqpdCYFuZo4rBS+wEeOO80jTqjqnO8hl5ka43hYcCzeRLqi3kEkWd8cPf4i6XrGD
         e+LsgddLiawlu8aSl8CSaLd740wV+uYhaHZLh3Jq1isNbCxskRj8Mf7JU1lrSdrSrGAg
         gxdDsG76SNEhqoFYLhwmO5EnPt+vypXDi1KT7OhUmxjEC1RrZxAzV6+vU+4b/tonV+fp
         5XZLcpmyoR+b61HcEDcqW7fWLEb+HkspE34Bl5Ke5ZItPO4i9VOk9pQNd+kz76mj0s88
         nx+Q==
X-Gm-Message-State: ACrzQf1YzJvJQc5EIPxEmrC0f58SPcHEJkBCO4JfTWk98K1bDaldE0aG
        dBX2/es442cuhPqY6mWQIhaD46Q5lVRTVw==
X-Google-Smtp-Source: AMsMyM7aDREuTHl33wnQ/JXerAa++TTxykddWXni6Bj6WI5JVwfUP0KF13Cqh5ADZVOarFqL0oCiKg==
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id ie15-20020a17090b400f00b0020a9965ef08mr5338283pjb.155.1665746185246;
        Fri, 14 Oct 2022 04:16:25 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b001fd6066284dsm1304628pjq.6.2022.10.14.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:16:24 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Fri, 14 Oct 2022 04:15:33 -0700
Message-Id: <20221014111533.908-4-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014111533.908-1-nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
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
Link: https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
Fixes: 37548659bb22 ("Input: elantech - query the min/max information beforehand too")
Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
---

Notes:
    Should we move (elantech_set_absolute_mode ->
    elantech_write_reg(...0x0b or 0x01)) *earlier* into elantech_query_info()
    before "query range information"? See discussion at
    https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/

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
2.38.0

