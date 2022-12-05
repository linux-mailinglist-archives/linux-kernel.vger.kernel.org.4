Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022FF6428D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiLEMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiLEMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:53:21 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9D1A396
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:53:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d14so10665727edj.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pktvKtBLNq1PAA5aM/sYGTOJ0VBRLMEQcf2yEqcZqw=;
        b=iymU2SEmxN3Z7pWDWqvpK+oxnRigFRqXjn4ICnAE5LHqYOfixqb6usbk7EmDicXcIz
         8F2e9icw6ViPvU1EpPk37Y5GnzI/hkV5zFCxTDOO8RXFJuqMcvCBAIIXTAtvBSu/pELN
         6dy6A/gqK0Qn1TWrJt3IRjT1rjhPJTYUzX0zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pktvKtBLNq1PAA5aM/sYGTOJ0VBRLMEQcf2yEqcZqw=;
        b=QnsAy1C6UJh4UEZ34A8Hjqh/0vw9gzzzvEy8xRAUmwDy1/s22pXThmzrpJfKxDTTvI
         p7Z8bEVPvy+0BkaJ7kEr5Kk1R3aHRsSask4SifM4ZV+fdjGAnPeqcyS1jzUb/LVcn405
         O4695JdMlnVfvjUmOFd9NrTqwHL3BK5ndQ1OOmMWbr1TWvAooafzWqxxHGiUbZuM3L20
         bG9W+lJZzRoC9OEmf6OqFHFqIvmWNQsuZ8ofbLTrxdE2L6b4bg+vjzsMq85UZ6npAxqY
         vOE3jGBm5CiSGVCoNKEmrBjzf6UBLCuo9CtAVDal6ypfRnDBsxVAPHUUsDmHneqDaDVj
         McXA==
X-Gm-Message-State: ANoB5pnZL2XCBVugoILcYDhSoQi4aEnTqb8YqAN+TYrZdvBceTstq3Qd
        2eBjii6MEbmhKZS8HPZd3VmH+g==
X-Google-Smtp-Source: AA0mqf7xREaNKTnUTqwE2OWl+MtDFzAat59ZM3DlL0i5NKrJp6j+s55EEQof1Ig3VIQ41P4lFbnQfw==
X-Received: by 2002:aa7:d14c:0:b0:46c:f8af:b331 with SMTP id r12-20020aa7d14c000000b0046cf8afb331mr440531edo.390.1670244799173;
        Mon, 05 Dec 2022 04:53:19 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e241:d242:baa1:ab8a])
        by smtp.gmail.com with ESMTPSA id rr25-20020a170907899900b007c00323cc23sm6176444ejc.27.2022.12.05.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:53:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 05 Dec 2022 13:53:01 +0100
Subject: [PATCH v3] media: uvcvideo: Recover stalled ElGato devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-elgato-v3-0-57668054127f@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Zf5Wsf2SpYeBdvbLdiOq0t+7iE7rTaz9vkE/4tO7rXI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjjemvdZqK1J8e6vN3ZJaryXWNOdpEMaVV7uiXExc4
 SkdLoUiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY43prwAKCRDRN9E+zzrEiOw3EA
 CeBMHgCQiE8AT1ll56nXYaETiGvdksawnUrCBO8+AKJqLLnAiyPDBlhpum8YO0Ow2vxjcIvSvPPrgq
 T4kJ2dxNwerUklr1EYfEgEQ0ZhyLt1D/ws0E+/RlsKNqQTAvOF8UAU6+Gccw8N4pLe2kkxCjYNep5W
 M+pYfnp8VAF1j1JcAPphP44UAVeHXLMoI0j5+Sblmyku5vReLYhgnbRiRV+xUceG2Weyc8xck5eWy+
 V9cNrNuq/M7BZr8i7qOnDKtThn+49MY3kKFbr7u4DpQnWCFEVxPP7Pq0GBPSAC10qKQYEtcdrDyXDH
 YKIJmDw58Cgw6PH//XFdaROzHYhx7YfXGoPcWxfKDoNLRoE2Myg1O06WB9B37qt2HKg5ASo3fOF7eG
 3bDcpoPCUCeocYO6ar2Gqxg6kJWLKh3V9VnWgJWZnmKB+P7xkEpKl9uJwsxwNqBGFkL6fGOBJuhRWp
 FqY31USrNyq0FIIBBMZ7zoHNmef8i5EmZB+P50V13E8+EuACH/vupHwcFdsb/mK58e1PvEp0OgyteN
 X3RBgqf11AIMIPGUkWwFTW9SlVd2B4sU8C7dOLpbRg1Ht8GoQhiXfr6gyAzYs9OrTfPcmXTQCP4NBI
 JiIcZRSHcJCSY3ATch1mw8M63CuiXl9Zzq0CVy9sftjfZq6b7xmT/H3qkwrg==
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

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
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
Changes in v3:
- Add Reviewed-by: Sergey
- Improve identation (Thanks Sergey!)
- Link to v2: https://lore.kernel.org/r/20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org

Changes in v2:
- Remove info from lsusb 
- Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org
---
 drivers/media/usb/uvc/uvc_video.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..a8323cf0e9f9 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -129,12 +129,13 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	return -EPIPE;
 }
 
+static const struct usb_device_id elgato_cam_link_4k = {
+	USB_DEVICE(0x0fd9, 0x0066)
+};
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
@@ -297,7 +298,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		dev_err(&stream->intf->dev,
 			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
 			query, probe ? "probe" : "commit", ret, size);
-		ret = -EIO;
+		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
 		goto out;
 	}
 
@@ -2121,6 +2122,20 @@ int uvc_video_init(struct uvc_streaming *stream)
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
