Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9D65C213
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjACOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbjACOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16F11829
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:49 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r26so38830120edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zE/D4J+qsdGyCRspywDzgfmKn2UepOqc9aDMzc7tN+0=;
        b=mqOPefvzjudmmghdvjicswADD648taX3TwblKDUjsogqygEgIlBO1pB8qwzrSTKC8k
         5MIoQvUrlscfl1H3YSU4HLhcxXN+Jjuejy5uaYJcBvetyGoc9qC247W44l/+9A2//1sC
         5f3EOUXM1g6DSQaX7sQPGdBnTorjPN1viVoIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE/D4J+qsdGyCRspywDzgfmKn2UepOqc9aDMzc7tN+0=;
        b=uwu+OcFlURhl8qz9I1Ggd9PdUzIJ2GtFcWe0+SvBKsHvqIBajaQgwx6CRyFMySjxJI
         k2wHzyPp3GIdBtCLNMGR1ddmIVw3WQ42PfWAuU3douPfDWZIHqXvUwnZHgKTvy/HUrE1
         vPqiOVgdV2BhhjD309fIzs1/o7HbFHcnC4byKDVZDnFWHETZreg2F422vbXJeD/4yHnJ
         /wvr1UWSMMlwCk7vSG8Q02y/JqteHkXTF0q36p2e3McfmQ4BsSqhJf1sTeVs4tfYSPn2
         asuA1robRqBRGdcQq1QvcIjhzcMGqiCSDXrPTh8YxjfTZGOhTn227zx70Tano1tzxe/1
         mA4Q==
X-Gm-Message-State: AFqh2krzPSSM7JHzNTP5hqfNAvJ43nAANbpuP75NAO9pm4G/xtqp3FeJ
        s9RO3OY9ywnIRc1I2Qlc+cOkCA==
X-Google-Smtp-Source: AMrXdXvrG/icB/AxrF+Mtk79mTLUwLtAUf2Jo46vsAJbtKZTNHYOLM2kdgnVdJ7fZtWDh84Nrhq6+A==
X-Received: by 2002:a05:6402:3ce:b0:481:f14d:fda5 with SMTP id t14-20020a05640203ce00b00481f14dfda5mr34418013edw.39.1672756607742;
        Tue, 03 Jan 2023 06:36:47 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:23 +0100
Subject: [PATCH v3 5/8] media: uvcvideo: Fix handling on Bitmask controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-5-598d33a15815@chromium.org>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=/UXa7D+904aszgGVJg9MhDXEF8Qvo7g/0S8PptJkuaw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD1zcL22Ph3au1U3gzHL8SWYDK7mYXfBWKoblEKt
 vdwEXkyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9cwAKCRDRN9E+zzrEiLVJD/
 4gkhLghiJBjonvw6CJAfVqI0aasnm/3bx9A5syTAog7bKFD70PgcslI9eWgs30Hg4IXhGjZCqcNFV3
 oO96EhhRbfAjeeBFWUzC5ClsT3Ms12e+4JfyrUbEjirRcr691puM9WrJ+27r1w8PRvkJg9q3Ce3fQY
 m5PDEbsaUvpjB94DFxv63b3mvOD49o/ljPEoEf5p2Oqe8R5rvUvyuSC7y6ZfE051bw1xFqNgD33x9t
 iMNnjPtv3MJHehd2juFvyVBo+WD59yoTlf83AP8JFV+NAVuwBuWp7uKeEuLJ0DhZtHw5BoWsAU2WpK
 q/oQbm9pJq5WDZWLMlmNRTD3SeDssmXUpmd7azj13hVvgXrCChNMgKK9POBJY0+O0p/NKvlJLV1grP
 Nm6JTBmVwi9IzHoZKAGpH84vZDkEseUFIF10WtzoC+GQf4XmfYH2o0D4cdMht87ifWaeolSWRvHfT5
 pQdSDuCXOdWhsWlsrrZ4OFr9YOg7m5jND6XtSPkbRmPtap96tXz7TSpXUJ9RxixdPEY9z8e1NeLT3+
 fnmNt3Sgo5LyXV8p+FGHqaQ4kLaGAVx0U7WgL7eee6WqOoKuGE6zCP+mU4mMCL564DEflVeRrUd42q
 xX0YDY0sVrMasnfxsioE78cPvkyZfiJXgsQ4cC6XiNnE0aNGcg/gksf0aIYQ==
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

Finally, handle UVC 1.5 mask controls that use MAX instead of RES to
describe the valid bits.

Fixes v4l2-compliane:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 6165d6b8e855..7622c5b54b35 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1161,6 +1161,25 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
 	return "Unknown Control";
 }
 
+static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
+			       struct uvc_control_mapping *mapping)
+{
+	/*
+	 * Some controls, like CT_AE_MODE_CONTROL, use GET_RES to represent
+	 * the number of bits supported. Those controls do not list GET_MAX
+	 * as supported.
+	 */
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
+		return mapping->get(mapping, UVC_GET_RES,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
+
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
+		return mapping->get(mapping, UVC_GET_MAX,
+				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
+	return ~0;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1235,6 +1254,12 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1336,19 +1361,14 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 
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
@@ -1831,6 +1851,17 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		value = xctrl->value;
 		break;
 
+	case V4L2_CTRL_TYPE_BITMASK:
+		if (!ctrl->cached) {
+			ret = uvc_ctrl_populate_cache(chain, ctrl);
+			if (ret < 0)
+				return ret;
+		}
+
+		xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
+		value = xctrl->value;
+		break;
+
 	case V4L2_CTRL_TYPE_BOOLEAN:
 		xctrl->value = clamp(xctrl->value, 0, 1);
 		value = xctrl->value;
@@ -1845,17 +1876,14 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
