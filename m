Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5635BE84C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiITONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiITONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F813F3D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l14so6464182eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=7SbWdOzYyZ4DvXywVbhtnQssUKjn+mgaC4ezA3WwW3o=;
        b=kFnQKOcSb/HOluTfiESWSAxS4b+ac0m+08CMknX881ZXIUR0v9dOBCavYs5OMdQNPU
         eCpl00nnhyL+MyRpU2RBjqO5YwxhfXJ8QlBW0F4XnCpnnE+D8jYhQqr1jiTOA2FXphRK
         kQ7YzKh8Cu4L3ZgBj4RItpa/KXTXl27RQXByI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7SbWdOzYyZ4DvXywVbhtnQssUKjn+mgaC4ezA3WwW3o=;
        b=D7NDVroArusaklnCGOTPOJLc4ySY1GcXcfZvC6xIO9NjyZyq5od61OwsSnwKMic3Yt
         I3ReZrKrpmNOF8b6uFFRjAtNcmmdWoXo+g7/mVPZVJZnB3GU8T+khYlVLmfqJD5KbS1E
         78iSvFqdYDBg2S4i4IZAmfeVptynQ6SKlftubOajRN7OJDcesogrvitA516vG6fQ52pP
         Fj7LyhTbMCX6YicC4hUrF+T51yV+oXDc80QrKEaUvY3WhLxyxONzRLeZm+nl4/TWimIq
         ZD7wgsQQlgWHMr1/WOsEfge3U4xukvjr2/qkETXBT8lsJhkRG/B8wyVJi3GNmjIkIvTc
         0HWQ==
X-Gm-Message-State: ACrzQf2nCIziKzwixTl86w4q4e0K6c3BfpxRrVobGRQr95mEXH+doaD5
        o3X5mPE4VbvALLdaf3ojR2FfCFuhN9550+RyJ58=
X-Google-Smtp-Source: AMsMyM5hpLGMkj0xF0Ypp3/noizXD8wsUtLqgxhUtfLkgm3MkcTW4dTp7JImq3L8FJYDgR/Pn4l5pQ==
X-Received: by 2002:a17:907:2bf8:b0:770:837a:e3b8 with SMTP id gv56-20020a1709072bf800b00770837ae3b8mr16739970ejc.562.1663683080412;
        Tue, 20 Sep 2022 07:11:20 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c918000000b004518ee90b4dsm129668edt.1.2022.09.20.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:11:20 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:04 +0200
Subject: [PATCH v1 1/5] media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <20220920-resend-v4l2-compliance-v1-1-81364c15229b@chromium.org>
References: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xRue/wJ3pUDw9TYU7ZEzphzigf/XRMvyyhrkUV+XLC0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcn8gTHpYmKRi+gxssRJuwAH49xopUaixfYUXUXW
 LbdiivGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJ/AAKCRDRN9E+zzrEiB8lD/
 466NcHWkpY/16/og8S+G/pUJWwOuyuigoz0K0WcxyjUc/2vZnC/gwhsrHzCctVuGu7lKpKDC3XiuJ9
 hV4pCSdlwY6cMEkecm5cLEVeEhHx08R5qSyOeJgCGlacRSuaztPALYi2OMdq4muShHXEfPq4/OGctE
 x6Y+N7hBNLIGFuWo8DArMJkpt9UGYdaJus6qdLH3nlViUQNvqMwJSfFf/ymk2JHKdcgxPt4kpc+lQ/
 YaADo4viomu6zZE/RdvK+M5TW/PJtQNML3Vk8CSq9Hllt9eH3ou6kDrI4fuTUS7pj2IrIKOGOU3nbW
 4UK9TYs+nQvsMKoImC42Awzb7FSURZ9ZXF288zop5OwRqBTM3tgzqOm6KTHygOVahwJfBgWZmhN4ys
 GnvBULhoqfJYEoJUTepIzEkTzNutKgB1tOxfA5zh2LwjzRDd+mmYsTbbTWjdHgy+Xd/uJOoSigAR9U
 vl1hldSTGDTeEML68emSIhdg1fTuvbnftHYR7gdFdCSr0NQfACXGkBWqxhYCE+LnJElKDIj/KP102U
 HUUINTAzC3JxpRqkYc6P52hVHggkzh6xVHL4GAb0KdlA0S7DlZ0UVV8/RGh0aJIpN8EBFBCXdLwvWO
 bQ3J+ZQClvZDt7aqGc7+XoTakTIfjWW/4kHcYObNz9N5Pt0fUbHjpz3bal2Q==
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
b4 0.11.0-dev-d93f8
