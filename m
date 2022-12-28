Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAF65751B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiL1KGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiL1KFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9B1007C;
        Wed, 28 Dec 2022 02:05:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso5996989pjc.2;
        Wed, 28 Dec 2022 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTZpZDLmOBMESWnhE00PibYliTCVq7n9n0KaHIBRUgo=;
        b=ASD375cpLc8wE91QgoQZ79vhHoTccoa+M+X5uZ7MY27gKKGlPUZycPZp5ItavoE8Y2
         mmmSRWhRwvpBCtlaexQrHpIx9cS4zCvabcVfw41PxMsOXRs2kYhz1QYaNYt71MVWasdo
         tE+7YN1OMa9d83NfJRqK/CjrQLVtJH4zbAXH0JwSu17WcjvQLE6r8f/XQx/hz5vlh3Up
         GCusR8SIRGkI8ZYOcs8kj8zS3pbNplb6OiDTMMJB42gVpOD8qFHRP5t8YxVpFf+OiC8+
         2X2qvKUD2Lsw/n3ieW7Cv9V/UoOzKY4xDJMGeTOluGsIDDL1Km3KVPUfmThSSzf6WKPL
         K3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTZpZDLmOBMESWnhE00PibYliTCVq7n9n0KaHIBRUgo=;
        b=b7QmiUPTZJVeWnJso/03KhggRltjExe3IjP6OfmGMfdjDGYhkYHdjDF8SXqfgL296w
         J1nXuSICmv0t7LqKBdiGnhitORRr1ziKU3djvfUao7UTVlSDu/amWj+LfMTXCKbqVfoe
         CbkBoDmncGCShe9CO0iAdrbzFH3lef3lF1BSRt3v9Msip3n3kCqmHM7+UadfPvf7Lnu2
         +/22bw8m7dQ6toke81rtsoddc3B8VPJd9TrnbZ8eUGHjKuKWSG4uEwdJW5xsn9WZjsND
         xruiks1/2OjzxAkWEfcjD6O/ybhpZHjBOzQ2JeUBQT8Qw4IEnr2GjNxIyife/X8dnm0a
         Kpdw==
X-Gm-Message-State: AFqh2krHTPbgp/9avWRn61rB6Zk1GRzmrZBFrz87TURaJT9EfVV8xQoB
        Au+QpsUuPyP6iV9OJk8cE6k=
X-Google-Smtp-Source: AMrXdXv8C2IoFp8OPcwFQG8p+cLItjMQYOvAVdLCN1EyZpTCc09FpVxsJ9XHFfbJeQIa+ovcIyAOwQ==
X-Received: by 2002:a05:6a21:3988:b0:ad:a09c:5734 with SMTP id ad8-20020a056a21398800b000ada09c5734mr37897250pzc.44.1672221932657;
        Wed, 28 Dec 2022 02:05:32 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:32 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/11] usb: misc: onboard_usb_hub: add Genesys Logic GL852G-OHG hub support
Date:   Wed, 28 Dec 2022 10:03:14 +0000
Message-Id: <20221228100321.15949-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

Genesys Logic GL852G-OHG is a 4-port USB 2.0 STT hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 94e7966e199d..c0e8e6f4ec0a 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G-OHG USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 62129a6a1ba5..2ee1b0032d23 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -31,6 +31,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
+	{ .compatible = "genesys,usb5e3,610", .data = &genesys_gl850g_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.38.1

