Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DFC5BFA63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiIUJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIUJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C98E0E6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z13so7607472edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=UQpZaYJCKWK0Pu7l712TNk2BJuL6CIWDc5YrLh30wjs=;
        b=MgXgDx//fd0NqwJytxhHSEaaNmr//wmBDBr0bEO3dLg66V/stnsiHXKtG46bTGVHcx
         yd/hN01VxmfOhhVLDUn9Nz1iNG6fiovULNK/htb/fwDk1EDecd+mvzveLnkCM+R9VU0A
         51JCOXBeE1byB7GnjfwiBjzOaYDy7Yo9fGBKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UQpZaYJCKWK0Pu7l712TNk2BJuL6CIWDc5YrLh30wjs=;
        b=2/vfe4Nj2DUD+yjjAyS9dKG0o3UPg+ojNzwKlqeZpc1T+DmmwHRrYJL497v68VcHIx
         zkQX4yi4DJWExtgy2wgxMjTSpCfZTcs+7XJeSCyY/yKf0bLalHWOYHaJWuio61Zd+wPP
         xPyg+frQFijTpnHbYv4/wQP4DbVLjnffejcAewOnUMrYdldApidc+OFc7uagm2OIMpv3
         Mz6etRtT5P5P+K9AH5DbSbgh0PztmbVK4Gq5VGwjVl0dqzFSvFup5P53jp74stumh95r
         4GQLO514HHLIt2iKaglS5zWPap828j3UsVoJmMB3aRHLLZT+Tuu58OaiMpxB0B662VAg
         RAgw==
X-Gm-Message-State: ACrzQf349+K5g414bNRdcMALYbcUpXkqaqcpncc5A++COWV4PlcSZ6d7
        7HDGKxVL+djsBxVDRNLFzsvmjA==
X-Google-Smtp-Source: AMsMyM7muKLEbH6Q9UiO/fiHShwtGLWxRfl/6UH6w9rUIgVTIwfXxRFbMACiXwud2rsq7aZ9a1rGbg==
X-Received: by 2002:aa7:ca50:0:b0:44e:973b:461e with SMTP id j16-20020aa7ca50000000b0044e973b461emr23671691edt.414.1663751556860;
        Wed, 21 Sep 2022 02:12:36 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:36 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:14 +0200
Subject: [PATCH v2 5/7] media: uvcvideo: Fix handling on Bitmask controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-5-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=/j8z6PN7/Plr9CdgjDkkTYHlK0/ZUdYfEEIDx5PJha0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV7XWu1XTOSLsSuTXNJ12oJ1lLl4CG1/yGmfOPp
 dFsycSqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVewAKCRDRN9E+zzrEiLI8D/
 47MLxXYeeZ2bUqGtxERKbyJHuNsPThzQcMnXwfke15DM1fdQSCz3VmQNmJDt6HeJ9JzCcXzcfhsKw1
 ZrSdvN6/3CJWK/seaPYR0+XzeS1+n2DnnrPTtBt8cH/BY7+Vkm2An8bkvNIWYVRBSHuBCw9tTJBnaU
 zARKsxKsrwn+dPOFj1ZMk8FB7M4YOT3xl1McBKxRJM04QOb/2zOAk0RHHtHwM0mbzTQshBFqlVUS3J
 Jtyui4IMIv4JlAL95sMPvEadvUNfLCGlUHgAAVaca8FZ9HwviEXJSTEquv86L7LGeXzPQ0i5w2MlJu
 wPrQfTb4zOFR97rhyWgxQ23BKGTMm7qZqkqAcj0yl0xnu8IYCg4uGSYIU0x/48G985XxwT5C9fzQsV
 BGLSYAhEHFe3HFfc/+92iEvIdhc0RxRSVABAoyTAuyu3sWttxBw43pLHignXeLyKlknGyBtTffTQwq
 WCjctyljkCsOkZPLUKTRWNcZTCWDXM237I+1b8aPSl378S3uHlihuKmvoe71EQxp1d/QMlSarvLxMF
 aS7zLZF1TbWlVDPk16yPfUAx0IXSXA3zbapH7Ye3YYP+NUdecixYDYy5LADJ5MgfCKfZhV7IzfWtie
 gSahxwFFY1DeqF9Ox52ehIcuiD9p7EQI3hmGkiXovpz96PdO2T0+CeOnSOWA==
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
b4 0.11.0-dev-d93f8
