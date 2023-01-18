Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF306712BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAREpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAREpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878654B3E;
        Tue, 17 Jan 2023 20:44:58 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so23667206pgc.0;
        Tue, 17 Jan 2023 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D62QMVerlbHiyJGnbiMPg5OFumoXXbcE1NYnWS92Nek=;
        b=YnwAJLYYmNrSJ2611D8WOEipldiLlKr60N05t7pGUjMqmf/PaOVcD+iBQ/bEdKOGuK
         Aznvm7XYmCkQNTrBzKwF1SqJRuIWi6i3zbCKL3UOOOymZ2ruJYhTeJqwcRECp7kGHL7d
         DI4VR2JmcSEDpYKFERHE4BJumSUntUJkuA+9tFf34Pj5nS91b7eQv0Dgo/+1suXw/AQd
         NPyUZByJZq0f2mcsSqBGDwcD0cSBeBJZaGQKTJ83jCyCTU/tMA5RJGXg4lMZa426XsJk
         wYinfYfa0HKImcaD3Qyqr6aqNS6D4mvxFqWwYSfJFIL2Bv9UhxAHUKi3VRspIi7ll9aR
         DzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D62QMVerlbHiyJGnbiMPg5OFumoXXbcE1NYnWS92Nek=;
        b=JDPFo4g/Iu1Op4thv7yNVTsmbzouCJn653pAZSz8qPKERyWLl5KHVvFYUQ+vzf6yM6
         tT0v1qjH5sAnFuj8ovBVmENRmQ76gm9uvYfbyCpkJwqWRC6qc3BzwvI5nCjFWNFiwD3W
         2eiZCKRVaSBylO5sbcd444YygoK+LLSEpzC6LgDa0tZ64zKFGxEDCaQlvp9Jy8bV3XmM
         dsOyZob5XZeIeBY4aptPobwiiCGumSLSSU+H25blX2GAEhhzRbrNXOl2569RCGQvOChC
         sNhdFZdBehOIEbzvbXmRNy03d7siaTvti7Ayi/JiRrBwv/UHAhJqMenNz4vV2q5dTBUE
         BYOA==
X-Gm-Message-State: AFqh2koYne3ALRuLUo/D/AVqglGhp7MJtb435285AVkPO1FzrOiT7a66
        fNZ5ZSNE53MCFnkwXguHsf0=
X-Google-Smtp-Source: AMrXdXsh+fX6wFVwZRY4xo68oRaBk9FmudTk1cSnjbhf23RkmY4pHCEDgfNQy57E+IP8NNuYjT4XgQ==
X-Received: by 2002:a62:1507:0:b0:581:6069:5c00 with SMTP id 7-20020a621507000000b0058160695c00mr6413991pfv.28.1674017098355;
        Tue, 17 Jan 2023 20:44:58 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:44:57 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] usb: misc: onboard_usb_hub: add Genesys Logic GL852G hub support
Date:   Wed, 18 Jan 2023 04:44:12 +0000
Message-Id: <20230118044418.875-5-linux.amoon@gmail.com>
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

Genesys Logic GL852G is a 4-port USB 2.0 STT hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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

