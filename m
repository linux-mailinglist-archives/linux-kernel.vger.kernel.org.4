Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96119639993
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiK0Hcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 02:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiK0Hcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 02:32:43 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC963E7;
        Sat, 26 Nov 2022 23:32:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669534342; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hj7/bFUVYhihM1GikmhedRj09QbrDWBjB0hES5R2Jq2mhZ5oNyOkqnyt6nlhdHQT3qBOz3Bry7OseIlJUk4bIfy6t2JSWKom1bgXzFOgXbCryRSMsQSxVqat4GvqYOdYgqOlcaPoc26Wcqqoqtxd2Ab+dbLJ/k3bU5jW/jhnhP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669534342; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=W3L1gxk3bykxDA4m0BaAtEIoLOyC+p+JqRqguKBAXqc=; 
        b=I2kBoj40phc4IK6iZhHjewrACylqPTeEE/wKmtnL/e0OAKNnopu342k+nEc8yZmQt+Abm+z0q6WbSxoa5p8xYUCORYKCkpAExDdVbsdWonWxAZzC0EgBKnpLdenbjZgCpW/E3mgqDHX7ot25hXd11a8U1EqxIc3ekTo/L81wwzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669534342;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=W3L1gxk3bykxDA4m0BaAtEIoLOyC+p+JqRqguKBAXqc=;
        b=XsKaS/9l26VWoqXTd662uao5C7vFNvnuRvxdXJGcniV8eDrk8H4vKNWRbi2PZcx9
        1+XRtsmn6lRY+BZduFXPmXQzOb3JYUu3J7n6jhwE2IEAvpG57mQhBrPtfnmmKgmMlWF
        mpf6lTjy7fBOljEqnzI9f8Wqzk99tJXzQYaSFm+c=
Received: from edelgard.fodlan.icenowy.me (112.94.100.108 [112.94.100.108]) by mx.zohomail.com
        with SMTPS id 1669534340551186.66915670319236; Sat, 26 Nov 2022 23:32:20 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 3/6] usb: misc: onboard_usb_hub: add Genesys Logic GL850G hub support
Date:   Sun, 27 Nov 2022 15:31:37 +0800
Message-Id: <20221127073140.2093897-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127073140.2093897-1-uwu@icenowy.me>
References: <20221127073140.2093897-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 4-port USB 2.0 STT hub.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/usb/misc/onboard_usb_hub.c | 2 ++
 drivers/usb/misc/onboard_usb_hub.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index d63c63942af1..f5c71d724be6 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -334,6 +334,7 @@ static struct platform_driver onboard_hub_driver = {
 #define VENDOR_ID_MICROCHIP	0x0424
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
+#define VENDOR_ID_GENESYS	0x05e3
 
 /*
  * Returns the onboard_hub platform device that is associated with the USB
@@ -414,6 +415,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 34beab8bce3d..1ca188713b1f 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -22,6 +22,10 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
 
+static const struct onboard_hub_pdata genesys_gl850g_data = {
+	.reset_us = 3,
+};
+
 static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
@@ -30,6 +34,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
+	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{}
 };
 
-- 
2.37.1

