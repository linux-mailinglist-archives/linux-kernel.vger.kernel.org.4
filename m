Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADC6712C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAREqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjAREpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50D58282;
        Tue, 17 Jan 2023 20:45:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 7so23652841pga.1;
        Tue, 17 Jan 2023 20:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqZvv1Cxb0t6cisyG3CZwbwpWlMQdpI86dZp44hCMJE=;
        b=Ic8i3YOMVPjMMlQf/D1uuQd3aP2Lhx409y7YULdVTLd/7eN673woYXVvEUvFyyQ/cY
         YBxR3xFENzl0TNGqcM1Hkgxyu7aINGAzAB1kc+1+u7guIL4HZVMoNnCjpUZvEAH36B8R
         kH3CyXA3TA4Rdyf6M0E7iNNzT2fmY6LpFKLVDYqOXCYPj/TCETbg5D9c2Oa8Jim4pI0V
         5BJOwjd5P3eBifZpbpmn7hwyZhYiNB7IvHUuigXKaUNpZgEkrzhLVioIXAXjoiS+3q3D
         2uGn1JxItYJYM19wHMNeje6B/wWFOZ+pJ/MXh477y6DP9oTzv0MXkLbvCI/1R/Ps3C0R
         1eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqZvv1Cxb0t6cisyG3CZwbwpWlMQdpI86dZp44hCMJE=;
        b=Jp9T53zJODpWNFzRMMgUuwRHCAWkKBFgGeVP8gRNyT3l62Thz3Cd6w370ABJPkQ9VJ
         PQHtLbv853ruZPY3nwRi9FbQpd6TAyD1ygK5qzpeb92/D+UTfNkI/rdvpeFDLt/vKAPN
         MWBbTtiXOMeBF92vSvieTDUT/n+SzNtXUnBIbNlRgQ6NnxQq0TUBnDIHgQh7QPTgkt3u
         uJtIvLh2paU2p873N7/37p0i6PSCu0fMtHF3g3Nzf6V0C4VjJCpeYEKSjW8uevmaVzbu
         YA+lpcOLuoXhuXJFibGQxHe9fvD/6WIKCQ5K5/U+3ZHadpa4U3Tp4Btrm8YnHuosvPy3
         XiPg==
X-Gm-Message-State: AFqh2krkMGrR7fBJklSodL+gVZRi/gWERBAV3gt6upZz40kCDXYvS7uL
        j6+JoLsZt+HwkWdpvhGnoq8=
X-Google-Smtp-Source: AMrXdXt5xk2t/sQ/51ctGAJEnM+Yurf7/AZjXNJCvnsmxW4tJY0w4R4su484w6z/qIAmqUPB/4+7Bg==
X-Received: by 2002:a62:be0f:0:b0:588:d6c1:66f9 with SMTP id l15-20020a62be0f000000b00588d6c166f9mr5333009pff.31.1674017124362;
        Tue, 17 Jan 2023 20:45:24 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:45:24 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] usb: misc: onboard_usb_hub: add VIA LAB VL817 hub support
Date:   Wed, 18 Jan 2023 04:44:16 +0000
Message-Id: <20230118044418.875-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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

