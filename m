Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4873803B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjFUKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjFUKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED0E57;
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98bcc5338d8so82998366b.1;
        Wed, 21 Jun 2023 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343890; x=1689935890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alj5XJx3xHWqgp1qRnBOikrTF0Qcwk6IxtFo9ldPUY0=;
        b=cIuVUTtwi/CZkHKFpLGdr6IxphA7oYETVXsJobI4sKb8Mis9n6rDKpZQWLwCU2arku
         JbqDX2NJNK4qmxXBa9h/mlZpM6Sky8eRrQObRkoUZml+I0FJQQExw2EFGcfZO5hM3+Vg
         /4k+Gb0z6fw5yo8mpz6/AAK+o7tI3h6Rtxlku3Q+Y37TpX54vjm+Fitejf/BB3qtHMpq
         lz1LoSkbl99X4W9c8CNTtkYFzirACSbGhllS7b6A3jTva3QP6HH0rENP4EawJpHrWHQB
         sVTmzXCrKUXjq20LnkZNQDaFFytGew1cpaAckX+FFQ7avCKAF1HEnttxekV+f3D343uR
         esJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343890; x=1689935890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alj5XJx3xHWqgp1qRnBOikrTF0Qcwk6IxtFo9ldPUY0=;
        b=Gcx25B+190LC+MMWsRn/p8F/dPgc6VqRsZdRaJYJPRrQErrVXIR7MWcKlI+gvpraGF
         MPNIK/0yA6XFrWX6Wqt8F2akv4yfCAn+aI2SN/DHvAWjdtbH0z1c3ZBy+AQRt30lXGXL
         SfBrP8h5wVWTbfN/KQcAOl/tdpTIDWqzExIxwsrjFt2Or/V9pVy6w1DLJceGX6GOSKV9
         GGy6p9ntWvGDWT8Hwnlrb2BU0PwqHIYwaw5uAGNFsixLfdn3cqCFxKV9CANQqXN16Oxc
         yV8sHs2txWt3nu0Z88AM/5cHN50f5ys7YJj3f+dAd7LyPBvQ2C126N3/cLGR29NK/Udp
         vMaA==
X-Gm-Message-State: AC+VfDyqyqlay8PUlNathw2E+adStmJ35lo280NPkHVANX8CKhbHgvE6
        dzVYnBbMH1dRePA87LKGpba6WWflbBhe4g==
X-Google-Smtp-Source: ACHHUZ6xA5GEGRtM15xbmvFKBo0Bvv0l6Y7qk//eirjGzucjYwq3fiw/c0uIR+WrnOf3ntAIlOsdzw==
X-Received: by 2002:a17:906:db0c:b0:989:1a52:72b5 with SMTP id xj12-20020a170906db0c00b009891a5272b5mr3878783ejb.45.1687343889912;
        Wed, 21 Jun 2023 03:38:09 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm2873055ejf.53.2023.06.21.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:38:09 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 12:38:00 +0200
Subject: [PATCH 1/4] usb: misc: onboard-hub: resort by VID and PID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-hx3-v1-1-3a649b34c85b@skidata.com>
References: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
In-Reply-To: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Resort the existing entries by VID and then by PID to be able to find
entries easier.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 12 ++++++------
 drivers/usb/misc/onboard_usb_hub.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 12fc6eb67c3b..94006714c273 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -329,10 +329,10 @@ static struct platform_driver onboard_hub_driver = {
 
 /************************** USB driver **************************/
 
-#define VENDOR_ID_GENESYS	0x05e3
 #define VENDOR_ID_MICROCHIP	0x0424
-#define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_GENESYS	0x05e3
+#define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_VIA		0x2109
 
 /*
@@ -407,16 +407,16 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_hub_id_table[] = {
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
-	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
-	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
 	{}
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..ff8925aa6d3a 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -14,10 +14,6 @@ static const struct onboard_hub_pdata microchip_usb424_data = {
 	.reset_us = 1,
 };
 
-static const struct onboard_hub_pdata realtek_rts5411_data = {
-	.reset_us = 0,
-};
-
 static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
@@ -30,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl852g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_pdata realtek_rts5411_data = {
+	.reset_us = 0,
+};
+
 static const struct onboard_hub_pdata vialab_vl817_data = {
 	.reset_us = 10,
 };

-- 
2.34.1

