Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFE640C04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiLBRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLBRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B56AE7861
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so13157198ejh.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhS+JBqxHQJxyGff9DpvK+kt09IedMih5IP8k22GY28=;
        b=CDmPCRBe4IMk6p0oPlsz1zfKi7fsgZn30ytnDuUodDsq+R0J3sCgnUXk2+KAwY84qz
         dhYh/JyqBoWJgHb86Hw+Uc/s6Ej7yTzgzxNPALs9bCzWRbpPq++MZeNZxEd9DTOyXmWf
         oNAHsYnMqAvXhSUylCHPDssa5ks2raFhpco4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhS+JBqxHQJxyGff9DpvK+kt09IedMih5IP8k22GY28=;
        b=nWjexhNurlx1TUSfpVgTC6DWE1ZeopgpvhdIL78ziAlHBfzcoR4abWQ2JwSGsxvQYx
         gVy3bXKBonibiHw0JE7PmOkJCeQdp21VYgJnxEK4yeB3/thO1Pzgh45rPBga0ibk5lvy
         jqXCWWKC6LUcX0D07+sLzmWycAVpLx3sEUD2FLF3gYlmVPeuzopSkxtLiY9dLqTHkRXK
         17TR4fhrnQf92eaSj2bDYGJtkGqeQjHr3yKxxlztY0Ifte1IrwaAaLP7Re6CB3SjGwiQ
         cGbZsPPiwm/OIAwR6O86+WplIXYEQk0yAyicUbYGCbYTOCyCyZkjKtydVkQpmk4GJJ0u
         ibsA==
X-Gm-Message-State: ANoB5plUFYnUq83Aojc4wNfrnTpxbqTYVibRAO+KQG2qa7FV0Scbc6K5
        mb9SQFzK6qUgX3sVxe1TUb6U2w==
X-Google-Smtp-Source: AA0mqf7JWgDbMIHLMrOHMVSeCYaxJbQsRDC1nP0YmwjU76wCPH/5s9B8MdAkRHhsIDfobJHnnQ/z6w==
X-Received: by 2002:a17:906:2352:b0:7ad:a030:487e with SMTP id m18-20020a170906235200b007ada030487emr62542555eja.508.1670001710996;
        Fri, 02 Dec 2022 09:21:50 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:35 +0100
Subject: [PATCH RESEND v2 1/7] media: uvcvideo: uvc_ctrl_is_accessible: check
 for INACTIVE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-1-b0ceb15353ac@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5265; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=tVt2FQwFWMzsSMl0muyb+NJLs92ZMfXZ/5urTCanEaY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQj5Jwb/s3MtZM6LnzqyJVwaqUWM2+ULqkL3TGt
 3vilUAyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0IwAKCRDRN9E+zzrEiOlCEA
 Ca5s+4X4YKwXvy9cPwI/cDHlh15ZgXJZ+3di0azDRwhMWVjUZDovHBJhz7sDnwO7gWCn7omPDq5mdF
 IEgEJw5ZyyqjFp33oDe4xjBdafldE23hYh8gXUj6DjyxsdkSrLbUaZfS+PeCeiHNEVu8FWnsvEtwkJ
 Nv34577sjadbyXkNpaQFJFAdfbB5BOy667bUv06sCYdrzNAlXS1JyJmanypFGF4pUHAuQLH74LdWHq
 Z55HJJQCp8e+PqgHP/Lenhxe6FbBNvjIQ8D2abzxdOENvF8lND3G5q1zWbXYD+BeLFjhhq0bh/iIY4
 bQdpdusLhL3llwyD88qaeaYOv/vnKpjGwdkRsVYuO8CaHQEaxNO/zjJ6k9NM0zU6fSCeC06MlmKup8
 qKk1p4Cmm/nK6UDPpDOV+iA5LCFocWb9ADgm30RqsBKBr7+j7Of+D9KaNXWr6JUk5lTbPcIEBthnaf
 Qsg7kW2hihNgm1+AehAEodK3mqIcw29zpU2PCtERvf7hHZ7rD75wYTfFWBz3TM+PnTARDuVI/aXLDF
 b7tTXVdx8zezvsWCO91S80571pnbwQEUbKcA8R1b9+8Uv3CcvyjEo8Oi/XrtrQxJ+NpmgbK2h7GaaX
 3554EW94M64DmLTeV+PNX7aObgbodMhFZahMNMoXg3zysIb3cHGxA89rBW0A==
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

From: Hans Verkuil <hverkuil@xs4all.nl>

Check for inactive controls in uvc_ctrl_is_accessible().
Use the new value for the master_id controls if present,
otherwise use the existing value to determine if it is OK
to set the control. Doing this here avoids attempting to
set an inactive control, which will return an error from the
USB device, which returns an invalid errorcode.

This fixes:
  warn: v4l2-test-controls.cpp(483): s_ctrl returned EIO
  warn: v4l2-test-controls.cpp(483): s_ctrl returned EIO
test VIDIOC_G/S_CTRL: OK
  warn: v4l2-test-controls.cpp(739): s_ext_ctrls returned EIO
  warn: v4l2-test-controls.cpp(739): s_ext_ctrls returned EIO
  warn: v4l2-test-controls.cpp(816): s_ext_ctrls returned EIO
test VIDIOC_G/S/TRY_EXT_CTRLS: OK

Tested with:
v4l2-ctl -c auto_exposure=1
OK
v4l2-ctl -c exposure_time_absolute=251
OK
v4l2-ctl -c auto_exposure=3
OK
v4l2-ctl -c exposure_time_absolute=251
VIDIOC_S_EXT_CTRLS: failed: Input/output error
exposure_time_absolute: Input/output error
ERROR
v4l2-ctl -c auto_exposure=3,exposure_time_absolute=251,auto_exposure=1
v4l2-ctl -C auto_exposure,exposure_time_absolute  
auto_exposure: 1
exposure_time_absolute: 251

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 47 +++++++++++++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvc_v4l2.c |  4 ++--
 drivers/media/usb/uvc/uvcvideo.h |  3 ++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 8c208db9600b..7153ee5aabb1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1064,11 +1064,33 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
 	return 0;
 }
 
+/**
+ * uvc_ctrl_is_accessible() - Check if a control can be read/writen/tried.
+ * @chain: uvc_video_chain that the controls belong to.
+ * @v4l2_id: video4linux id of the control.
+ * @ctrl: Other controls that will be accessed in the ioctl.
+ * @ioctl: ioctl used to access the control.
+ *
+ * Check if a control can be accessed by a specicific ioctl operation,
+ * assuming that other controls are also going to be accessed by that ioctl.
+ * We need to check the value of the other controls, to support operations
+ * where a master value is changed with a slave value. Eg.
+ * auto_exposure=1,exposure_time_absolute=251
+ *
+ */
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   bool read)
+			   const struct v4l2_ext_controls *ctrls,
+			   unsigned long ioctl)
 {
+	struct uvc_control_mapping *master_map = NULL;
+	struct uvc_control *master_ctrl = NULL;
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
+	bool read = ioctl == VIDIOC_G_EXT_CTRLS;
+	bool try = ioctl == VIDIOC_TRY_EXT_CTRLS;
+	s32 val;
+	int ret;
+	int i;
 
 	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
 		return -EACCES;
@@ -1083,6 +1105,29 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
 		return -EACCES;
 
+	if (read || try || !mapping->master_id)
+		return 0;
+
+	/*
+	 * Iterate backwards in cases where the master control is accessed
+	 * multiple times in the same ioctl. We want the last value.
+	 */
+	for (i = ctrls->count - 1; i >= 0; i--) {
+		if (ctrls->controls[i].id == mapping->master_id)
+			return ctrls->controls[i].value ==
+					mapping->master_manual ? 0 : -EACCES;
+	}
+
+	__uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
+			   &master_ctrl, 0);
+
+	if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
+		return 0;
+
+	ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
+	if (ret >= 0 && val != mapping->master_manual)
+		return -EACCES;
+
 	return 0;
 }
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 4cc3fa6b8c98..d95168cdc2d1 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1020,8 +1020,8 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 	int ret = 0;
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-		ret = uvc_ctrl_is_accessible(chain, ctrl->id,
-					    ioctl == VIDIOC_G_EXT_CTRLS);
+		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls,
+					    ioctl);
 		if (ret)
 			break;
 	}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 24c911aeebce..644d5fcf2eef 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -905,7 +905,8 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
 int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   bool read);
+			   const struct v4l2_ext_controls *ctrls,
+			   unsigned long ioctl);
 
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
