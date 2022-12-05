Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1C643954
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiLEXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiLEXPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:15:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F89B1C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:15:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vp12so2113882ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Beoi+HxjU4bD0mML68pXWDtSUgO/hmk0aZwS/xrq0=;
        b=gnEwRpF1Qyk8SKYC5QxUU/Vg42hptJUDlr9IYVnd9KsPV2vrmuYT6xYps+CyG1Ak/K
         GSs9JNHc3DzsW5ARFHfmVSVVOpYjL9JLC6Wj+YyVnds2uCuL2RrIUgYeNLZ3r5W4rtNp
         eNP1zErrVgyW7yLqIvZRsm3Kstm0D2yU50cxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/Beoi+HxjU4bD0mML68pXWDtSUgO/hmk0aZwS/xrq0=;
        b=Dy/cJxMzmBTQw4YsaxoMB6acCkF9eBIbKhcj91+W8timwMze6DxS/xWuzoAa1E5wdL
         HFpNe2WltEIcQUcqmggNoPpZ4YLQQqSdj+nXJurv4N1BU3pyGmW0tk0UxEDWB8mqLr3l
         SSvmj7LRPfiH6XVShbv76+7Awc0USVHtA/qnAO8Fy6cCKG1fMR9wahq58sTqTVeA505D
         AZChrTWmXeS6qakiGwDzCNo2v2/pGhALMmPCMWTWTQ4qABxzHbDZPGgYSftBonvrVczJ
         rvaXpDdJD9YaF5Q9g6HDrS2pjJReWGWj8DRuhjnMLiE3d9c0rpbu42GZaaKqhi8l48SY
         zsHQ==
X-Gm-Message-State: ANoB5pmQdi7C0cMsr6GtN2Wt59BI7U8eEfM9ZSqr9Bs2UrIUf3lRl8d1
        fwo52Z3kE71PhAJkGE/l/B3kog==
X-Google-Smtp-Source: AA0mqf5cYK77NcHGp/u0BL5CPQuHqO2nDi98CQVKUKvUeePbrCvvif19n+7adsET/AuwFloS7bjPVQ==
X-Received: by 2002:a17:906:7852:b0:7b7:718d:22c with SMTP id p18-20020a170906785200b007b7718d022cmr57416073ejm.507.1670282121260;
        Mon, 05 Dec 2022 15:15:21 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id g8-20020a50ee08000000b00461a6997c5dsm307721eds.83.2022.12.05.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:15:20 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 06 Dec 2022 00:15:04 +0100
Subject: [PATCH v4] media: uvcvideo: Recover stalled ElGato devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-elgato-v4-0-f9555e13e458@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, Yunke Cao <yunkec@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4190; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=4nCyPRr4vmvXgAGQdttjXOjOWhbEbSku+mtDCUMD/Ic=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjjnuC5Yq/i3u9Cjv7y0R07DQ6zTQT4CkD/KzdlzfT
 sl7e0CiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY457ggAKCRDRN9E+zzrEiBQ+D/
 9eVc4c6f4POVnTrYNN6WCEva1u2pO6cmY07A46NDIPzw+6ND3E4Iu9QzNz9uWZMmkZek3AcWhev3aU
 UhwXfF0Qx+TzD6D30VHtt0rkAuvJopCzrV2Maxn+Jq3OZGOyCBy+wSB7MEv2jhkDanvcD1o5FQTCBl
 WqPDYuHAU6/HeUx41GXw/9R5gs852uJW/BDYhhuV54poM3aS9SdBNOQuVrleVZ3Az/+mSqp+zPGo3m
 1hjJ0mT8asXSA/GGc3Zqy7Xfv28VYPpGrh6VEq1ECpEknskG/1Up+7nrH7rsJgXGcLDzJWKX9KIfvR
 39aKVrt4J9Okh5RQ+p0lHdEQsHWHy0ZIHweysYjqNS4m7oUgX2v38IVfhp4sAnr39p5HydxObhE39E
 mHDHeWnMYBUbRbD2/PjA1QMo8o++hfp9haQC/lvv7QtHaLceCBVt+fwvwZjSXKSZuDjLDHPi9wVKIl
 5nR5/JqGxKAj3lkHLxl3BZA0KPYQ0g66eeR2qP76G/DZsE6doR5b78KBL5PPQzJM8aaadSmgJ5SJXB
 e78JCJq43KL/m9DITKBbGXSrd2nYYx8IjB5+s1fbb2oNKMlaIW73C1aYs7RI0IdkK7P8WzagZInv1d
 htLSqRRL3ZzmGwQqAGY3tpyhLzu0RE1xyNFnGrgtI599n9s1J76AIxnf/BsQ==
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Changes in v4:
- Add Reviewed-by: Laurent
- Update error messages (Thanks Laurent!)
- Swap checks on if (Thanks Laurent)
- Link to v3: https://lore.kernel.org/r/20220920-resend-elgato-v3-0-57668054127f@chromium.org

Changes in v3:
- Add Reviewed-by: Sergey
- Improve identation (Thanks Sergey!)
- Link to v2: https://lore.kernel.org/r/20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org

Changes in v2:
- Remove info from lsusb 
- Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org
---
 drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..ba7c159cb2a6 100644
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
 
@@ -2121,6 +2122,21 @@ int uvc_video_init(struct uvc_streaming *stream)
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
+	if (ret == -EPROTO &&
+	    usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k)) {
+		dev_err(&stream->intf->dev, "Elgato Cam Link 4K firmware crash detected\n");
+		dev_err(&stream->intf->dev, "Resetting the device, unplug and replug to recover\n");
+		usb_reset_device(stream->dev->udev);
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
