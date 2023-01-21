Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7C6767E0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjAUR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:58:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD9265B8;
        Sat, 21 Jan 2023 09:57:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jl3so7955209plb.8;
        Sat, 21 Jan 2023 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGtMPXG+Aka08SYYYyo/KkQe1dgGt7Jtohr7QlueNXo=;
        b=CDHKAHMPL7wIv23meaxe+3ZzUxHgMo5m6Tm4N/VqgoAGblTS+VmcmY6flogCoaD980
         Z8pvO8Mbg1842kAFblDR2hLPxfoJaT1oUIB0GCNaJP4HD9RDviBwsUTsDW0YTui/cTV/
         rLb6waQCHhShKnIkxASdlZoQ7ixPTW/EW1hGuUjg/ZPThzoHLTTa68cpolyDrUaCrUK9
         4NxJ4IFDduAxiAYvLCoMPrHhEac+PsDLt7HVQId0Qu96dSUm5mY1iHtjW5+daiYkk++q
         xiCYnORnV1BVuymOBx/jILTcrrZFKukg/Z9Cp/pvjFBl1niuu+bvDTwINYR77qqkQ1Sn
         11zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGtMPXG+Aka08SYYYyo/KkQe1dgGt7Jtohr7QlueNXo=;
        b=P1gvtcTUCNah0CkcZ0J0I4s65n+ybvwoQeFMaR5tMNxUbyEr6Ckzoh4hRtPCQIg0Cu
         HtIjLahjrjUa1pkCPFtl7XpWROT97wl/DK/UyddqA0UkZFgSdgRLeUCRHz8FzEQW5wg8
         IWy/Lu33akMoH7TEGvKix9hRltdgRWi5sOf84gsOdHeJ734ZuTfjXJrykwsA5n+OjRom
         EO6hDZ01FW2ztkfZ5M2gWHDuMLdd5p6fXkL8v7h2ZgUOtlCFLXC1pEwz7Dc9A/5qG9hS
         cc2Bk7qswUSfOQPwLO4Awl4eVLZK+8u4yvTmDFGM+oIH2Jw4lJ1pCPMWOUXLZWF9YhAe
         Vv0w==
X-Gm-Message-State: AFqh2kqOHRmK8cpy4xJ5YtwZb2JkkPRmolFB8Pun0FvP07Dc7RdfQ6Ud
        ZeknIaBsAEo4Hrb059mrDSc=
X-Google-Smtp-Source: AMrXdXvI7b8pbgzCZcQDa0EQ94L2M5q99LsBpbLZlfEUjgkB1i5500YQOa7vzYwZfWYDNT4GCK91+Q==
X-Received: by 2002:a05:6a20:1601:b0:b8:c659:9d51 with SMTP id l1-20020a056a20160100b000b8c6599d51mr23177312pzj.56.1674323866966;
        Sat, 21 Jan 2023 09:57:46 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:46 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] usb: misc: onboard_usb_hub: add VIA LAB VL817 hub support
Date:   Sat, 21 Jan 2023 17:56:36 +0000
Message-Id: <20230121175639.12818-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIA LAB VL817 is a 4-port USB 3.1 hub and USB 2.0 root hub
that has a reset pin to toggle and a 5.0V core supply exported
though an integrated LDO is available for powering it.

Add the support for this hub, for controlling the reset pin and
the core power supply.

Add USB device id's for USB 2.0 and USB 3.0 root hub.

Acked-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3 - Add ack Matthias
v2 - fix the compatible string and update the commit message
   - update the USB device id for USB 3.0 and USB 2.0 root hub.
---
 drivers/usb/misc/onboard_usb_hub.c | 3 +++
 drivers/usb/misc/onboard_usb_hub.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 9bf59792fb94..945d4e7125ea 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -335,6 +335,7 @@ static struct platform_driver onboard_hub_driver = {
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_VIA		0x2109
 
 /*
  * Returns the onboard_hub platform device that is associated with the USB
@@ -417,6 +418,8 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
+	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 163fc07abf25..0a943a154649 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -30,6 +30,10 @@ static const struct onboard_hub_pdata genesys_gl852g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_pdata vialab_vl817_data = {
+	.reset_us = 10,
+};
+
 static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
@@ -40,6 +44,8 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
+	{ .compatible = "usb2109,817", .data = &vialab_vl817_data, },
+	{ .compatible = "usb2109,2817", .data = &vialab_vl817_data, },
 	{}
 };
 
-- 
2.38.1

