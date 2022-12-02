Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7851640B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiLBRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiLBRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:01:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32FAB2FC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:01:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x2so7316043edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sIUmdJ7DFvd8F2b99tqP9bH5MN6eyMo2GF/GHFz9Yk=;
        b=ISUcs9i/0M/8hqqlPWXiI0BQVt86asWYB1JMJuiiqyCmkhg5i9g4/6hDwXewwgaec5
         IzvcCyaiA7sdZcUuz58xJt+49xqiyFQKy0ZGfNScddAMIx0I6Qkg3135ZlZ7OI+zH8+r
         A7KJyuuzi66sUWuMHdUGSNt/ycZ479iAf6d8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sIUmdJ7DFvd8F2b99tqP9bH5MN6eyMo2GF/GHFz9Yk=;
        b=YK/cHb7aeIFkE36o8XSBClDScS3lWlkFCiotS5Avp/HtFvxKL7lgh1Sag10oQ1NeD7
         cEnvZeYgpRZWIxoYoqpUf3WK6BwmSMX3N536Sf007UF8t7I0YdZGDGm9IhBJFxoSacWu
         2x5MVDQqlX6kbloWzxJ/caCQMS3f7JGMvuwC9z60URP5Tb1xcjhJnZTbQaXmP91NFcMS
         ou14KKrXYVcNBgNI8VAh6J7A4gfaov/QEDKqVb9r9bXpCHXn9bPrYCVoy/J3nTbo9YYh
         OUI3M3UYtLyslq8TQfvDroIyF3KZKukCQQcVDCPbtxb4GiejpT0bZvuCXIv7VmHSqWGj
         u3ew==
X-Gm-Message-State: ANoB5plX5i28L1iAr84ife1z8+fAxzoGh69UxNCRzHUk/i9Kb9lcCfiw
        zqozwIeX7PyQbdWtue88sj679A==
X-Google-Smtp-Source: AA0mqf5zzAP88qRuwlLS4mgDoF5OWl54ir7l99FJY2ZvfaT39fQ7SazCQQzc22sg4W30tgLN+Mp5fA==
X-Received: by 2002:a05:6402:361:b0:46c:25ea:731 with SMTP id s1-20020a056402036100b0046c25ea0731mr3819687edw.194.1670000472413;
        Fri, 02 Dec 2022 09:01:12 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7c48a000000b0045b3853c4b7sm3111528edq.51.2022.12.02.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:01:12 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:01:07 +0100
Subject: [PATCH v2] media: uvcvideo: Recover stalled ElGato devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Yd9dIG/JiyCXqVOfCELBolrMGzArptXcaP/svlsJG2g=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii9VlLRoLlAgECDFoybg7+F8l22YZbz6mRXcEHok
 PObjDhWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovVQAKCRDRN9E+zzrEiIxOEA
 CY/TFzXhV/Enno/NNx6IwrrRYQvaq5APqxIKfuX1gJQr0Plv9Eet+ncRtptywVr/UiRMway8/LeeEA
 KL9fS8j+2UC26ui4xRnWCdWXi3hCwH+I4LibzxnUJgkIbsgc9AUBrZHP6+IOTNfn6ku8+fOyHDsbPS
 FVwUjf8707/Gd9cNsWByQcscVMt7xpkbnudFSXqu37aa6B+C7JagGDAEwj/aLvb5Ddd76ucq0Htw6O
 lcGbVnfvSx7FsZMu6YbLFUNB9kf4xDL9X5bKDLGOXgbVwf9x+LrGAvNKadDD4kkpvaOmo5/smtDiT9
 GqqTLm85JCtJqhNzFe/mVuqeSOH3AH6MH3U7f2MBSyEbMNM6pLnv0yHQntwclwITCQUEEGHxYGAHf3
 FwWPl48DfhqsT0BboW4h6iADrghckuWoAd7e1WR1M7in8/4C8zwOD8Tsy0IrHf6n+LiKbKbCYp8tx4
 MSQW50JCCyfGpz/k3lM9CARe5qEWIiLeia/qnQrq30uWbj+l0jV+c/GwVfFxfxsn48qc7eCxzAZhtv
 mawm7Y3K5JHf3k5Q0gtruGnF0ME8evJkLzq7sh4L3PpK/rVKlzvr2k/GkiNGABEEquMbtIHkZNWb/G
 qRcYOlwlt2QFMyyTdRy+vco365cnumdWVP8aNsyNGKWUrdcp1kr15SPLuYjA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elgato Cam Link 4k can be in a stalled state if the resolution of
the external source has changed while the firmware initializes.
Once in this state, the device is useless until it receives a
USB reset. It has even been observed that the stalled state will
continue even after unplugging the device.

lsusb -v

Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0         9
  idVendor           0x0fd9 Elgato Systems GmbH
  idProduct          0x0066
  bcdDevice            0.00
  iManufacturer           1 Elgato
  iProduct                2 Cam Link 4K
  iSerial                 4 0005AC52FE000
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Recover stalled ElGato devices

Just a resend of this hw fix.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@chromium.org>
---
Changes in v2:
- Remove info from lsusb 
- Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org
---
 drivers/media/usb/uvc/uvc_video.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..ad1762b66c4c 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -129,12 +129,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	return -EPIPE;
 }
 
+static const struct usb_device_id elgato_cam_link_4k = {
+						USB_DEVICE(0x0fd9, 0x0066)};
+
 static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl)
 {
-	static const struct usb_device_id elgato_cam_link_4k = {
-		USB_DEVICE(0x0fd9, 0x0066)
-	};
 	struct uvc_format *format = NULL;
 	struct uvc_frame *frame = NULL;
 	unsigned int i;
@@ -297,7 +297,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		dev_err(&stream->intf->dev,
 			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
 			query, probe ? "probe" : "commit", ret, size);
-		ret = -EIO;
+		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
 		goto out;
 	}
 
@@ -2121,6 +2121,20 @@ int uvc_video_init(struct uvc_streaming *stream)
 	 * request on the probe control, as required by the UVC specification.
 	 */
 	ret = uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
+
+	/*
+	 * Elgato Cam Link 4k can be in a stalled state if the resolution of
+	 * the external source has changed while the firmware initializes.
+	 * Once in this state, the device is useless until it receives a
+	 * USB reset. It has even been observed that the stalled state will
+	 * continue even after unplugging the device.
+	 */
+	if (usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k) &&
+	    (ret == -EPROTO)) {
+		usb_reset_device(stream->dev->udev);
+		dev_err(&stream->intf->dev, "Restarting Elgato Cam Link 4K\n");
+	}
+
 	if (ret < 0)
 		return ret;
 

---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-elgato-a845482bdd02

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
