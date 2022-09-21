Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B05BFA64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIUJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIUJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3118C46C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lh5so12085046ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=7SbWdOzYyZ4DvXywVbhtnQssUKjn+mgaC4ezA3WwW3o=;
        b=YijMFEwnZJDizWX0f+eH3pCP+PWv7I8ClvZqfqQGbyTBg+SvtkVyjU+P/WvwbEE50S
         +NMSIRy+dcM8bTM+wYAEYkmvlr62VDaH4EORp+cAmhjRqroexl8TKoEEkfPCBirUHQQq
         2nk1JtH8nEHYdjTzZelWVV5p/wOPvnz5WuvUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7SbWdOzYyZ4DvXywVbhtnQssUKjn+mgaC4ezA3WwW3o=;
        b=7RiZ5ZT5ARPWuhnOxmqGF13y3/1wtTRAd4Tgqu4j+PZxHk+FDW8kD1QugQfbdc2tzS
         gzQWP3cxT7WdefzbbWPmlu/N151R4Di5MTl70BaPyXSJa7ylCSbMOc1ShR4njvVfBcRM
         UoGUK+Q7lC+hpN9PWOWN51iN5S2Q93W0gkERtI8sVxDg46K5tdP7SnfMql5gsjVfuvnm
         tJwWHUaUe6k6j+ys+T4bMJGGJhBCzSTeLPQMG++aQtqg1KZq1oeI3fuM9NEzaV3oNHB0
         freXVkm8jRC7F4n/vLq7ngmF7cWHRKWBlJrQLw6vRwBsqztz+kOUpx+mPi6i9YBpUOvE
         /d7A==
X-Gm-Message-State: ACrzQf0UDENkI8fIuKxvLWmCLzoShbVOhoLDQ3rXx/S5VKQLsJmiOPF6
        h/7ouwWFnffQI/cuyY3/fFFhLA==
X-Google-Smtp-Source: AMsMyM6wc3c0+orkPQiXhGroUrR/GRGODLFbNoe8tE5I0NOINNXOXlik+5dSr3v4pts5Z1EB9057ZQ==
X-Received: by 2002:a17:906:fd82:b0:770:7e61:3707 with SMTP id xa2-20020a170906fd8200b007707e613707mr19611883ejb.143.1663751553499;
        Wed, 21 Sep 2022 02:12:33 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:33 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:10 +0200
Subject: [PATCH v2 1/7] media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <20220920-resend-v4l2-compliance-v2-1-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xRue/wJ3pUDw9TYU7ZEzphzigf/XRMvyyhrkUV+XLC0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV1Mb5wbPhj9MC58ku5ntzQRAlRcyVv7zWahjM8
 r72EY9OJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVdQAKCRDRN9E+zzrEiEfAD/
 48ZhGIcYGmGxqiQ9n40ihVBvUK3jJ5KfCOYT746WdTq+vT7eQg0JAwOlmXpgIDYIvA2mZ+jIKKqh4s
 S9ERooFZUEtDxxTiNZIwFbPfJ6AcYWK/qzkK3qmo/j2u7WPN2m3XAal0Ne/h1ENt9KbZxJkdHYHJfE
 s0Zt1F5zv3W562TVf3gfjqwtZ0icqgUCFcFlkFo6qKssvpxxiXw0/GPwWcc4oIY5Ztu8z4KYU8SNaF
 o0fy5HTn3hzw89cygG/v9/Jo+pckc1PZ+UTQrmtL9DM6sfsR7yQ857Ojbx37W19BGJv9jG/KN3/Pa5
 hJRFaIicwCRKIMmOqYLxPcO8/37lazhxmNpmXAFHzl6nwCQNiueLFnFwfAEZara8dkBICWbZnFrkXg
 ke8rsUfY1mupBQgrzGs5vHashKNrBT9IM+wWrORTgdTFTj7Gk84efHFbsZylQPPzWU3GVVM1s7p9np
 cX3xpAiQ89KXf8nyR5j/fx2FFCFK9o5r+PRhbpmWetUKvrF8/Lvq2b44jc93W/ye5Enw9vCaSDv7MS
 AFxdNN9dfdrH6aRey1HaFyPj1hgGHl9HXnS9edAA97785Ym9KHDeoCrnFsMT1jUChF0zf/FtVF1/5f
 IfFk8gaeJdxv4p3xwT5tX2U5kRoBG5A1oqn2tpTG3z6jJW1HFA8Vgd464pYQ==
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
