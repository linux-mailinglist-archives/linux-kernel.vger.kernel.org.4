Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6965BE8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjACLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbjACLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:01:56 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6110D9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:01:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m18so72609164eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co9IVvG+/S6WvoqX0pBLNaNrTdqsJyhBz/38h+pUNcQ=;
        b=PNXXFXIq+faqpY2Liq7EY/E7M78Zi+NAF2s5xp+2bI1depV/ZFGgtfGg3DaeAmlK2w
         77aqj/inIHQokfyHkn1PvhTYD4WQuxdkQKud4EUbOQlrBPpp70eenxPZnumWgnNbeyHK
         NfeGLIwhNoGllFYDPc/UDKAG/gCrb0NsNCir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co9IVvG+/S6WvoqX0pBLNaNrTdqsJyhBz/38h+pUNcQ=;
        b=MQQnlHWZoOe0uD+HwEXG0evbMagzMcbv+Rz/qQE/KS3/NHouDZLX5hbIwbreVIK3Q8
         M/Gno3hNuyimNCkpbBj2+HchQfUnDnyyAdGhPQR0Oo4fRZZaurouM0jTIcjYEXVDViZa
         UZUL5DguIjwY9KHRmCRCDJUxoeKYEGJoBPqjYJmN4/sMTC3wgk1HvpZsSfyP2MqTXrUI
         h8XJXXKMAzQ+/23MxxcvV4iE2vAlCJchEa2r/A+8qwcyNlDIML/shwi7xQgWBff11Peo
         mftl/w5J7WS1CRw+g/U5qqqNSxoonbRK09emmEcUDpYiFRef1JnurtgyjZzSeEI8ZGsf
         BIXw==
X-Gm-Message-State: AFqh2koeE/WMNwCaWAFVBSi3xJZpwDMnT6Z4ONw8AikLgeClxYVXxwUU
        hmyHgFi/5+F1PVlNmACmx4qzdbJOxXt9OCQ13+c=
X-Google-Smtp-Source: AMrXdXuFHS3L/k5nrZ5ec5hc//xVb2JMLvmw84nYYasWMhxgx8Fkj5YlZAzRCWmEl4kL3LBVdlT16w==
X-Received: by 2002:a17:907:6e16:b0:7e0:eed0:8beb with SMTP id sd22-20020a1709076e1600b007e0eed08bebmr50674638ejc.41.1672743714098;
        Tue, 03 Jan 2023 03:01:54 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef23:1430:9acc:b68])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090615cc00b007c0cd272a06sm13944331ejd.225.2023.01.03.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 03:01:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 12:01:21 +0100
Subject: [PATCH v3 1/3] media: uvcvideo: Limit power line control for Acer EasyCamera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221101-easycam-v3-1-2c9881a7a4f7@chromium.org>
References: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
In-Reply-To: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rO1fkJL8+8p1iNyVTD4jSQz4HIqEXb4KMbzC4AEwi/0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtAsZuAFlyAU0OVj1MY8bdt/khTMDCzwe3OKTs8DM
 bi51/RSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7QLGQAKCRDRN9E+zzrEiM8gD/
 9/PDhrsZcm4p8YEssdUzKS1CTASCQ6oDA6Je7r2pDnjab0mpapPCh1Gur5rqkAMGtSkiMHQhYMblWZ
 Ic/HIIWaQgEoQaY/K++MqsT+D8pvG0G/BEa0JZaSQ2btZBw1va2+znLxCuet8juawAAGCiho1ZaW1l
 x5QvEmNlXtrfC/0RJkThtbZ2tqq1Me+ZGEhy9Qv5KhqXUezod2pcYX4QrthCW/Lo0XnBuOCNgH/Al6
 pUbqA658hjtsmeEFEzZEQw8d3CGDDlwbzfLDJh1w3cwDcu7dZIvxrXQ6aqCyCRLGdRcFd2E2z8WOmm
 bSselOPrt4FsONFb8r5W7BfWLIY5WsQTkfDnLIG+DBV3NvFA3+QOLvyXCND8eODA7gdWUEc4Ir6zP3
 hA0TA9ZzAwLSBy8PQP0r1Yxe/zFFNawesdyFDOAnT5rJF8nGbs0/NuAkBflf8lkLS8pGnSAEGN8U+Y
 HI/rnLFDLXhmezNbdK6mXbNbrzcYT6x+PM48P2FaixjZOhgJGf5Aef22geEBomVmOy3vnLtCUvqXv4
 J3hxP1y0t9QJL70J077umXvdQTOO1N3EZlQ96rnQnq+e9j0H/6cKh1+DX1eafOYvKJlngsmv4t43iH
 7Yv6DQD0bS53NCtDuffsDRX5FcPefJsUOpIvckQq1UpQpSvmWpjh8rV+vRkg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the power line control correctly. Add a
corresponding control mapping override.

Bus 003 Device 002: ID 5986:1180 Acer, Inc EasyCamera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x5986 Acer, Inc
  idProduct          0x1180
  bcdDevice           56.04
  iManufacturer           3 Bison
  iProduct                1 EasyCamera
  iSerial                 2
  bNumConfigurations      1

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e4bcb5011360..f2abd9d0c717 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2991,6 +2991,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Acer EasyCamera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x5986,
+	  .idProduct		= 0x1180,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Intel RealSense D4M */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
