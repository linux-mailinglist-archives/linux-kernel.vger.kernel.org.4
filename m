Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD129640C07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLBRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiLBRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:56 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67717E7879
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so13035029ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TOCYbcSDGYo9uBDae2YM90jdMCkFXFL9pKLx8gH8lk=;
        b=Rv8G+gUWpIQ0RpbmMyAexFTzcwXByWUGtbzZhNjQV34dWvYdqMGVOyV2zgXVLnStUI
         JreWZrXYPkvYSMfX3iLfHq8zfjqx+7nFjRu1T6UvpwfVUHXcrrefkFAztT2nA9iV1aBf
         9PKgvJcAuYoIrWWM1bdOOwvDxl6pCt6GEzHVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TOCYbcSDGYo9uBDae2YM90jdMCkFXFL9pKLx8gH8lk=;
        b=fXfSVmleq67wo/EW62J0MlZKtaGCNmZy7jNpY0yoFQPhimoEwCH1YTC3O62hSMpqrX
         3Yf/OnYfMArNrEKYn9/f5VsPkxOTqLkEXvFv2HlQGS1oszj7XgS5OgparkWMtPjJLXGD
         tAkCiz1TeYChwQfrjp8z4Hi4OEs60rD4r77PnymecVZjV6goeeAyeUCVbNiB0j7wHJ7M
         IS3iO25u9pPUT5wm/qZaHcXL+1z7FzcYXOj34kO1m01/vzypcZYJu8Z5dZ5Mi8W0+o+b
         BH9VVPo9Kk1MCsDN/ooKbCSHmJWQKYcmX97zD+6S5HDGXAzjtuOnlfGhS3FeIO8dGmGE
         FMtQ==
X-Gm-Message-State: ANoB5pkCTkkE6I99etkNH+Yf1YApqsor5dHu4fKHx5kS9YWeipGntPrj
        WbWCTKcbrlz9iFDCMdltnUel3w==
X-Google-Smtp-Source: AA0mqf4YI5O/1Q0etPueEfxbOhCrWpfHsgxQYe97PVIfsp7yScExzeZqmoEDXX7hwm2eGhImyXPRwA==
X-Received: by 2002:a17:906:a387:b0:7bc:2ad:7c1e with SMTP id k7-20020a170906a38700b007bc02ad7c1emr34567522ejz.588.1670001713981;
        Fri, 02 Dec 2022 09:21:53 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:39 +0100
Subject: [PATCH RESEND v2 5/7] media: uvcvideo: Fix handling on Bitmask controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v2-5-b0ceb15353ac@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4061; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Q6Ty28eEyDWUJosEKd4UTXCsSOQeb3Aa2fdI+JNxN3I=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQpN+Gp11+KJtyf2NqCaonYO3z4AG74/0P4ktMz
 X+9mnGyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0KQAKCRDRN9E+zzrEiDabD/
 4hdednARo9vIZ63cZE6rj/LqS7zBcNbf4ARBjcT0uoLqLwPIoOBReqPeG7oJyDA7hLjdCVFOvjQpLp
 C2Cskx1EE/9OoCEVpnh8KpSiqv4vOdkh9MrXErvEs3ftBp4ygmFnC1epjDrjn7R5YzQAyMdNdew04S
 qOmrIGTuDkPpo0rwg+zjuwMuPSUwmAuHr21BHWQpCEp10jfllYv8bc5Wpnh7c3u+36ri8mTD5ACwva
 EcWSQjHA1/krvk24Rm/78XqJWJ/l6ocDc+1vLfspiPYs/jzKO1UxAJwHY6FpYWeQLVApg2KyVPVuaf
 Ha6Xc5oFzZOZKJdzbjtNtIt5ds5L5zpUS6TtQEWdoWHsLZneng1Md9yh7PuCSmDq2dCSLBqxCP6Ujw
 kw+qmFX5Y550YZ+alIAdvaqxkIrWNB1jR962Mxg7bD4Zm+FOHlFlA/O7EO5TXGB+Kj+7DVrARWAXxL
 d/x8eUeFbdqXGhxDtt/FPH64Qz5pIrgElhgSfQplbJo2XSkCyArPy8d3C5bAHQk0AbW0A59U9+P6DX
 9Xn0B6UzUIwaxA89+K7Md2aTY/wxc5bQ4ZlUOJw+tKmbb1PtGpDGNrn+vwm4SVXjR5JNBgV9xqHJ5N
 J1RsVk6vooHSyqNZPxJ888bSHIsN3xBVxlQG7/n8vad5+q4YuseFYRFGI4iQ==
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

Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
There is no need to query the camera firmware about this and maybe get
invalid results.

Also value should be masked to the max value advertised by the
hardware.

Finally, handle uvc 1.5 mask controls that use MAX instead of RES to
describe the valid bits.

Fixes v4l2-compliane:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 53 +++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 7153ee5aabb1..526572044e82 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1145,6 +1145,25 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
 	return "Unknown Control";
 }
 
+static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
+			       struct uvc_control_mapping *mapping)
+{
+	/*
+	 * Some controls, like CT_AE_MODE_CONTROL use GET_RES to
+	 * represent the number of bits supported, those controls
+	 * do not list GET_MAX as supported.
+	 */
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
+		return mapping->get(mapping, UVC_GET_MAX,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
+		return mapping->get(mapping, UVC_GET_RES,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
+
+	return ~0;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1219,6 +1238,12 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->step = 0;
 		return 0;
 
+	case V4L2_CTRL_TYPE_BITMASK:
+		v4l2_ctrl->minimum = 0;
+		v4l2_ctrl->maximum = uvc_get_ctrl_bitmap(ctrl, mapping);
+		v4l2_ctrl->step = 0;
+		return 0;
+
 	default:
 		break;
 	}
@@ -1320,19 +1345,14 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 
 	menu_info = &mapping->menu_info[query_menu->index];
 
-	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
-	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
-		s32 bitmap;
-
+	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
 			if (ret < 0)
 				goto done;
 		}
 
-		bitmap = mapping->get(mapping, UVC_GET_RES,
-				      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-		if (!(bitmap & menu_info->value)) {
+		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
 			ret = -EINVAL;
 			goto done;
 		}
@@ -1815,6 +1835,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		value = xctrl->value;
 		break;
 
+	case V4L2_CTRL_TYPE_BITMASK:
+		if (!ctrl->cached) {
+			ret = uvc_ctrl_populate_cache(chain, ctrl);
+			if (ret < 0)
+				return ret;
+		}
+
+		xctrl->value = max(0, xctrl->value);
+		xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
+		value = xctrl->value;
+		break;
+
 	case V4L2_CTRL_TYPE_BOOLEAN:
 		xctrl->value = clamp(xctrl->value, 0, 1);
 		value = xctrl->value;
@@ -1829,17 +1861,14 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		 * Valid menu indices are reported by the GET_RES request for
 		 * UVC controls that support it.
 		 */
-		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
-		    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
+		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
 			if (!ctrl->cached) {
 				ret = uvc_ctrl_populate_cache(chain, ctrl);
 				if (ret < 0)
 					return ret;
 			}
 
-			step = mapping->get(mapping, UVC_GET_RES,
-					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-			if (!(step & value))
+			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
 				return -EINVAL;
 		}
 

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
