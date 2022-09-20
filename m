Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D75BE856
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiITOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiITONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E41A060
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q21so4008291edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=UQpZaYJCKWK0Pu7l712TNk2BJuL6CIWDc5YrLh30wjs=;
        b=GY4dKTSFJ0aG7Ehgy1MQE6tDuKby5zBXGij1uk7Qd+/Dk2wp7f6GqmcDMLAP869lbk
         /vHkLEpGb9aQvj/GmqYFqHRw27BHxBWPurpptweyXnhdi9bSkGa6MeOMW+Ac3MHRWQHa
         f/p86/iDC3Txt5zk/EDhzUwc5XlLWFwMG4a2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UQpZaYJCKWK0Pu7l712TNk2BJuL6CIWDc5YrLh30wjs=;
        b=QRF+whg4qpL+ns2HxDfrHUv/ZWz9VIQnvklSkcYNYTfKPF39dPXImWc07oCba9tKh1
         2amSZ97YNMAL+EJHg7zkL9+7qC1FB1Lxta9Kr/gG2rLNDccBbGNV7QLajMzK237ZvIYd
         K10LhN4zz9igS9xdRabdL5GejHNfY5fcwFEnQ0Jz3StFdNqCK9kVG5RJlHtWXZl8YEoT
         M1lBqJE6+L89i0nMrETogqgXxm3HIdUE/xZYEGHhC87HVeVz3yXwrgF+O5U8/HvJiVrt
         SL9rAKNedfqpp5DaxLJ/SjNvRVP+ayG26L3H2o+IZyqZ8ScXLbzY0N5ORuKXCMhvvim/
         EQfA==
X-Gm-Message-State: ACrzQf1zv0EhJYpZ+iVEbmhtNP4f+5B+8lLxUFnqBl+mJuyEm8wnxDNY
        sHMOOm8ydaC1bpRKxJ2T23+APUD262siM1RIGCQ=
X-Google-Smtp-Source: AMsMyM4Ls0dzBeoa3LjXsd2FcBrpl+vb18hTbIVmQX2kbkqiq5AXBRiNryvGL2FN2Y2L8jMkJjLSIA==
X-Received: by 2002:a05:6402:26d6:b0:451:24da:f8cf with SMTP id x22-20020a05640226d600b0045124daf8cfmr20723773edd.385.1663683084906;
        Tue, 20 Sep 2022 07:11:24 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c918000000b004518ee90b4dsm129668edt.1.2022.09.20.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:11:24 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:08 +0200
Subject: [PATCH v1 5/5] media: uvcvideo: Fix handling on Bitmask controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v1-5-81364c15229b@chromium.org>
References: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=/j8z6PN7/Plr9CdgjDkkTYHlK0/ZUdYfEEIDx5PJha0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcoDcJy26EznzdSST9G5q2VOlkTv+RVQAJ67x7J6
 FAxG4U+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynKAwAKCRDRN9E+zzrEiC08D/
 9xxiRVxqttcN9YCHY0dq93HYXrt7mGQ2+zQWqPRCnkWRdXCJwJt8JJcGrTxH1ChIPw1dnojnhvuJNQ
 hcOiiyViyLqLq5nhN/BhdBuqjUINPXW2ypaG5WtFkXS0gECDxFBCuA4gFdDSB8CUR1P2ITK9E0xlia
 2WV527A3O8t8D+bOxV5pjmE4M+9tKizYf6U52PHAJRUWcBongM3uOC0dKXp5QP5L4JrRlr/5P1JHVR
 KlMX4QevuMLB4mEfLcogVzxvNLtA91t666zOJCHdprXOphDqGMpP88b1O6zkNgJaeh4hy9mdJpd//H
 uLZHLLAdhacL/rj7RIGOckstDmquiY4yvqG/tPjm6O9c3bK25EjaQHeXq9A+LEZqzobVTTuyd+00AD
 Z92kPrJpnhvMvOKfxRN5cU81w354TXRXy8/qd6DQpTr/uvX8S8JhYav99vY4PsVGXGdfeO71eiPeTR
 gKsAax7PL+izxg/+aK8HUw4tset+qZXbdAAihSeYf2TDHJNu79eY9/Wt+NBcYolSak+J9NlU5q4zBZ
 QHTkCNZaXy77EPbQigTJLctpOX13DDSbYyv5z2HXCQeAJfiHE0svWUhhsrf9o2rgbc5H9W4HG9KzK8
 XQCy0lnz12AiuQUw6cBJyBGXlMIdoKnI1WQSc2aDb3DSwcZs/vcGwWozNwkQ==
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
