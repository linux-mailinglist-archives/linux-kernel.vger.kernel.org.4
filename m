Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A0657525
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiL1KGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiL1KGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:06:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE4297;
        Wed, 28 Dec 2022 02:06:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g16so5975103plq.12;
        Wed, 28 Dec 2022 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKyVlX/Mpa7o0t27gnVLycSg68+P2J70WhEPAp5+xtQ=;
        b=jW6UGc8/hz58oCJqSTWk/8gf9CLM3mNxTZAFS3SXwTFhJ/Z78w8psS4N18vpeYFb6o
         7VOWq3YknGEueXdTDv93bve3q7NB9V9CPgrDiH9jP1gSjA8m0SvBIQe3W7qp8xqpSLDs
         NCmpb6xtwd41Gg4PL2MDXo8JHtfEYrGo8EYjw9tq8YukXxQjbLsYI+SrCBc7IK68Zs4o
         kytjatg3jUQqANdrm7BJPnxuOMDbTCgONcx1ZAFs6/bH9CtzyfEH5JhF1019Mfo6oZKm
         udYiaC57Qi8k8lZZ+8KyzfcIfd74so98zxwVcm4iZ2/1nSYFeHEn1qOxZ+n4TdxSrGTy
         aUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKyVlX/Mpa7o0t27gnVLycSg68+P2J70WhEPAp5+xtQ=;
        b=LsOyqIAcj8t7meskK13kzuViSMkdJHHB8YnONPajLG1DcAeAZ2Jy7O63mptL+MKQ3/
         kVbm9qgSejU2e1MsXkFkQjCQgTTU4/MWL6yVmVH+tXYtvfBaoCWWc/XDvk9y3EtdLsBw
         VRv5rcm9Ud+mTpxzPJu3W/wKXiALqYNCeMYU9j4mchWxUkaV8hcqinymxBwk/AaGNY++
         Z4JE/WTArhoav4A5daTR8tjR+CrZ6U+cIbp+bQcwKC+4u45TDl97cHlMluf4B/I17WF5
         c5kRUgxwriwReXVPu8mwZK/u4qrqBgWQab26VBGDUU8f1bXeQvq41uEr1rZ06v7xZohR
         Mu+g==
X-Gm-Message-State: AFqh2kqZplNtXlaeVT2qrBiXZXhLITw8lY59VPWv7b6purbiIXT2ERUX
        MhHu3nCSyQv1oX4QViLcBpM=
X-Google-Smtp-Source: AMrXdXs8wZYfIJ+CtLGOH0BY4QUfPWlXmu4EZUOEgBiXxFuHJG5Tq3gPePXoBIHSu9XinQ2fw2/aqw==
X-Received: by 2002:a17:902:7042:b0:189:6a5a:7289 with SMTP id h2-20020a170902704200b001896a5a7289mr33309457plt.52.1672221963337;
        Wed, 28 Dec 2022 02:06:03 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:06:02 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/11] usb: misc: onboard_usb_hub: add VIA LAB VL817Q7 hub support
Date:   Wed, 28 Dec 2022 10:03:19 +0000
Message-Id: <20221228100321.15949-11-linux.amoon@gmail.com>
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

VIA LAB VL817Q7 is a 4-port USB 3.1 hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 2 ++
 drivers/usb/misc/onboard_usb_hub.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 699050eb3f17..025572019d16 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -335,6 +335,7 @@ static struct platform_driver onboard_hub_driver = {
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_VIA		0x2109
 
 /*
  * Returns the onboard_hub platform device that is associated with the USB
@@ -418,6 +419,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817Q7 3.1 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index b32fad3a70f9..1fb3371ebdae 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -26,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 };
 
+static const struct onboard_hub_pdata vialab_vl817q7_data = {
+	.reset_us = 3,
+};
+
 static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
@@ -37,6 +41,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
+	{ .compatible = "vialab,usb2109", .data = &vialab_vl817q7_data, },
 	{}
 };
 
-- 
2.38.1

