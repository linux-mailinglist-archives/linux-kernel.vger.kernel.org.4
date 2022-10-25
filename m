Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5C60CF53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiJYOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiJYOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:41:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43B5BC86
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:41:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so7548205ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8Q7Eo8f6MX7051gxMFYWST4RQwUsS8lCeTzT9duqJA=;
        b=F8cArrqGhNbIDu30ZlYDVoGzbO0uCStS7Tj1qhfSS0HoX1LJDPY92IpgXhArfICEcK
         0Qr8AgZgKgy9XF2Da5E4E3XePJ9AL1eMKs94wyutjuN5B5QjE+R014QRTnn1oKrcWXA4
         0uvGj8mPBI3IpHLA7qF0PJ2s1HHzEhskM3xLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8Q7Eo8f6MX7051gxMFYWST4RQwUsS8lCeTzT9duqJA=;
        b=LTKXryjhsCmay5SrXq941UgL46QNIdp0PgE//j3u3/6v4YVPYtThlqgi+rgENgEch8
         c9RP69ve296bFUW/9TfwRqPksfe8KtA5lf/LTtYPUM8kiHbEwtyXR+WqohN/fqW8ypvZ
         CdCPsAqEeCYkA/EMVJfM8BUim11JE8J/y3EWUa9tIpYKrNneTJYE4mS3GTdf4vO1zleT
         3bYZxSfgR7ZdrgOr+I21YUWtqx/MjSLWz8cUYazTdPkoy7Jn8V4Eeua7hQFuYKqkU5n+
         l0QH5oI7bYjkHYTbhn/vF7q58Oc4KSbozQcD2ijYNywIc87oAybrLLcX9KlZF8Vz7A0m
         q9Sw==
X-Gm-Message-State: ACrzQf2VgZcTZjARo8tO04Y25sgmRSzpIh1VcIU1uZM7WlCWF6wR0io/
        i2jomfuP9Rfwk+kgvK+p1bg0OkHubo1ljkJl
X-Google-Smtp-Source: AMsMyM4Ja6PNxxkiFC6rRppD1DFEiI6C3QFhB4I6FS37Xe1LBbHdngdO9FgPkmwASZa2sAre/5Oauw==
X-Received: by 2002:a17:906:8b81:b0:78e:1cb:e411 with SMTP id nr1-20020a1709068b8100b0078e01cbe411mr31939787ejc.681.1666708871272;
        Tue, 25 Oct 2022 07:41:11 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id kz12-20020a17090777cc00b00734bfab4d59sm1500813ejc.170.2022.10.25.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:41:10 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:41:01 +0200
Subject: [PATCH v1 1/1] media: uvcvideo: Handle errors from calls to usb_string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221025-usb-string-v1-1-4c351b6907bb@chromium.org>
References: <20221025-usb-string-v1-0-4c351b6907bb@chromium.org>
In-Reply-To: <20221025-usb-string-v1-0-4c351b6907bb@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4832; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cTCPKelWtEgBKQLFQFET74HVmg1j9rftmX9QZBAVbL4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/WDCANcIccORULUf/p2hsS8zyoeEvkkWPv5JgMF
 8FQBgx+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f1gwAKCRDRN9E+zzrEiFEoD/
 0b/PPW67kslsrYvtQ9ubr3rJqrybZAoFlU8ST+e09Q0c5TFfFa531GG8JvAOUt5foP/raTfxvooV85
 L6pulj3D7qn+vJaQFTTrZD1sE7hrnY8jNdm1KL1V1LzHrrbGyTdCr2peASY6MRzvTpR9VU2TMy6vY5
 +dpeRoHD2TK5zcZEzF4hBjmAuvcXS9KHfCfECE4bKM6KNPM2SeVEsXPMeDUn++8c6Q0HYB1g5MZcJz
 o0PPSFc5mCqQFqnmLxjf4Epn+qNH0HT1qbaOCtPXLCjZHaO+FVNGL6xDq3LTzRXwfLSXX5pVOmza8R
 GudjwFbbHmI/RXvJngiopT5zxHH+YrS2Uz/GNgk8AZDb2zwCPPdNMBq7zbbygPgfciF0lb2vTVilKE
 c+YVONURsU2iJ1MVZa7LctuE0V/pWVN+c6t1GjJc+RZG7dBZYXG9Em4ueT/CWZgyhQzXefELv+fVRw
 y3Ua7IAMh24qFbUlAngTZdpigg/966iS56OVvbqz+FGFyeitKuOQ3RYLdPUtf7WZa8nyaZN6IOcByR
 jtgAADUURJWKsNRnL9c7FYHmd2GLoXhsnOJwpPC0rrvACWEHqKB4Rd3pLWhfwZ5zb4iOYm97l3kbt1
 RZF+0+N8JCmgMCA9sSZ6G1Ws/2wsdI0a/3wjSG/75CN3x4B+XmbvusbnnN9g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

On a Webcam from Quanta, we see the following error.

usb 3-5: New USB device found, idVendor=0408, idProduct=30d2, bcdDevice= 0.03
usb 3-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
usb 3-5: Product: USB2.0 HD UVC WebCam
usb 3-5: Manufacturer: Quanta
usb 3-5: SerialNumber: 0x0001
...
uvcvideo: Found UVC 1.10 device USB2.0 HD UVC WebCam (0408:30d2)
uvcvideo: Failed to initialize entity for entity 5
uvcvideo: Failed to register entities (-22).

The Webcam reports an entity of type UVC_VC_EXTENSION_UNIT. It reports a
string index of '7' associated with that entity. The attempt to read that
string from the camera fails with error -32 (-EPIPE). usb_string() returns
that error, but it is ignored. As result, the entity name is empty. This
later causes v4l2_device_register_subdev() to return -EINVAL, and no
entities are registered as result.

While this appears to be a firmware problem with the camera, the kernel
should still handle the situation gracefully. To do that, check the return
value from usb_string(). If it reports an error, assign the entity's
default name.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..828c443faaa9 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -879,10 +879,8 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 					       + n;
 		memcpy(unit->extension.bmControls, &buffer[23+p], 2*n);
 
-		if (buffer[24+p+2*n] != 0)
-			usb_string(udev, buffer[24+p+2*n], unit->name,
-				   sizeof(unit->name));
-		else
+		if (buffer[24+p+2*n] == 0 ||
+		    usb_string(udev, buffer[24+p+2*n], unit->name, sizeof(unit->name)) < 0)
 			sprintf(unit->name, "Extension %u", buffer[3]);
 
 		list_add_tail(&unit->list, &dev->entities);
@@ -1006,15 +1004,15 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			memcpy(term->media.bmTransportModes, &buffer[10+n], p);
 		}
 
-		if (buffer[7] != 0)
-			usb_string(udev, buffer[7], term->name,
-				   sizeof(term->name));
-		else if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA)
-			sprintf(term->name, "Camera %u", buffer[3]);
-		else if (UVC_ENTITY_TYPE(term) == UVC_ITT_MEDIA_TRANSPORT_INPUT)
-			sprintf(term->name, "Media %u", buffer[3]);
-		else
-			sprintf(term->name, "Input %u", buffer[3]);
+		if (buffer[7] == 0 ||
+		    usb_string(udev, buffer[7], term->name, sizeof(term->name)) < 0) {
+			if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA)
+				sprintf(term->name, "Camera %u", buffer[3]);
+			if (UVC_ENTITY_TYPE(term) == UVC_ITT_MEDIA_TRANSPORT_INPUT)
+				sprintf(term->name, "Media %u", buffer[3]);
+			else
+				sprintf(term->name, "Input %u", buffer[3]);
+		}
 
 		list_add_tail(&term->list, &dev->entities);
 		break;
@@ -1047,10 +1045,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 
 		memcpy(term->baSourceID, &buffer[7], 1);
 
-		if (buffer[8] != 0)
-			usb_string(udev, buffer[8], term->name,
-				   sizeof(term->name));
-		else
+		if (buffer[8] == 0 ||
+		    usb_string(udev, buffer[8], term->name, sizeof(term->name)) < 0)
 			sprintf(term->name, "Output %u", buffer[3]);
 
 		list_add_tail(&term->list, &dev->entities);
@@ -1072,10 +1068,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 
 		memcpy(unit->baSourceID, &buffer[5], p);
 
-		if (buffer[5+p] != 0)
-			usb_string(udev, buffer[5+p], unit->name,
-				   sizeof(unit->name));
-		else
+		if (buffer[5+p] == 0 ||
+		    usb_string(udev, buffer[5+p], unit->name, sizeof(unit->name)) < 0)
 			sprintf(unit->name, "Selector %u", buffer[3]);
 
 		list_add_tail(&unit->list, &dev->entities);
@@ -1105,10 +1099,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 		if (dev->uvc_version >= 0x0110)
 			unit->processing.bmVideoStandards = buffer[9+n];
 
-		if (buffer[8+n] != 0)
-			usb_string(udev, buffer[8+n], unit->name,
-				   sizeof(unit->name));
-		else
+		if (buffer[8+n] == 0 ||
+		    usb_string(udev, buffer[8+n], unit->name, sizeof(unit->name)) < 0)
 			sprintf(unit->name, "Processing %u", buffer[3]);
 
 		list_add_tail(&unit->list, &dev->entities);
@@ -1136,10 +1128,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 		unit->extension.bmControls = (u8 *)unit + sizeof(*unit);
 		memcpy(unit->extension.bmControls, &buffer[23+p], n);
 
-		if (buffer[23+p+n] != 0)
-			usb_string(udev, buffer[23+p+n], unit->name,
-				   sizeof(unit->name));
-		else
+		if (buffer[23+p+n] == 0 ||
+		    usb_string(udev, buffer[23+p+n], unit->name, sizeof(unit->name)) < 0)
 			sprintf(unit->name, "Extension %u", buffer[3]);
 
 		list_add_tail(&unit->list, &dev->entities);

-- 
b4 0.11.0-dev-d93f8
