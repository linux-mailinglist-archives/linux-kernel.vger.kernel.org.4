Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B156767D7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAUR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EB26869;
        Sat, 21 Jan 2023 09:57:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b10so8397237pjo.1;
        Sat, 21 Jan 2023 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7SuZc4P45+/SBaDlaz2WkZ7htQPLlLb7VbRabYVtdI=;
        b=kP7U3BbF4sadebIHCzs1+Lz+rNORdylAzj5dWUqkea0xhy66aWxeL8r7yhN34neUsH
         eAUDm43C5lXA6WV2OAH+beRIkFhUYCnQs3skvsK58c7wUTN6PimZfExaowTrj6cUUYFD
         dlMpa/e/bI9cff+OQFKUNvKBjsl1KNGD5En5S6Uj+yJKPZPh2nAuUwopv568YrV8SQy9
         W9MMKQsdgYluRXoo2xXX5WkJ/nPvkebnVwyEYMAwePhsWJaokVNCRUc6xEpeTBJkl9iY
         wT6PbkmvaQXmZ/rWky+ojiqdVlPEarl7BCO6QCjiqc4K7E+JGk0nkRI6sDAJL4VajY8A
         Y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7SuZc4P45+/SBaDlaz2WkZ7htQPLlLb7VbRabYVtdI=;
        b=r43bXianzMkbMqUwNemIS0xd24CZSJCfO+HqGmhvgQBwXpBsVE9WWqzQzgV9+YYuxy
         URLHME6TREibvWs6UAFS/aX7pslK25ywEFRCfECD8fPgvvMi5ULSlQ2s2h6ZMCUMpYUd
         UGbmYLsd+5VtCcLHtTG8+rbwVAup48ieeY5NL/RtI2ckfId+8l6Dy4hwotzKWtBD0a1L
         2dupKe9h4T4a02vPdrAk/Z1i0K/+4O/lR9HqhpaUCTC1MMV56Nbk8XL5qhwe9Aa5nya/
         M9Mufx48tHaCjViFm6kj/X7uZOqpdB3XL1Own8me3DM7pjrfdfO5xpxMOeE7O60xn5Yb
         mtrQ==
X-Gm-Message-State: AFqh2kqZi+oho70Fjsj32+aNDKHqYd0gKAHFXLCGD2QLN0ReXYBLJoIM
        yPWPvvEWMQ1P1PDM2MirlG4=
X-Google-Smtp-Source: AMrXdXvpJKSkHiYRPl5XWzj2YzqDC9QAgz57GlKP9VkGjPfRKXn9vxsxzAJoEW2hF7bO5MlzwnB9jA==
X-Received: by 2002:a05:6a20:d80e:b0:ac:b2a3:e39c with SMTP id iv14-20020a056a20d80e00b000acb2a3e39cmr18740290pzb.62.1674323840228;
        Sat, 21 Jan 2023 09:57:20 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:19 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] usb: misc: onboard_usb_hub: add Genesys Logic GL852G hub support
Date:   Sat, 21 Jan 2023 17:56:32 +0000
Message-Id: <20230121175639.12818-5-linux.amoon@gmail.com>
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

Genesys Logic GL852G is a 4-port USB 2.0 STT hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Acked-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: - Add Ack Matthias
v2: - fix the compatible string
    - drop the -OHG suffix from commit message.
    - Add reset delay.
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 94e7966e199d..9bf59792fb94 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 62129a6a1ba5..163fc07abf25 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -26,11 +26,16 @@ static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 };
 
+static const struct onboard_hub_pdata genesys_gl852g_data = {
+	.reset_us = 50,
+};
+
 static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
+	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.38.1

