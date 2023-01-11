Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA09F66568B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjAKIxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjAKIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:52:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB938F024
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p24so16057353plw.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flIhO45h+mwJLw1XX1p4rJpdGUR0h1OEp/Ako5axtJg=;
        b=hMc8jI1K1VoA2Oz/6g/H4SgZ1M+wv0nts25v+cfYIGnHub05Thjt5mZMJ90mo149iW
         LLkjWYL96OFBEcEJKZzjLgT/K6OiHl7YZp1KJvSucokcRDcjLglyIbXvugeBDtVBo+oK
         YPEmj+RMakWFOlG9w7WSSQqnB1r9NivNnuoMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flIhO45h+mwJLw1XX1p4rJpdGUR0h1OEp/Ako5axtJg=;
        b=YDHZ1I6s5UUMlwZP+C5cf5a9YTdio2CnSmEAmS4rZnwJCzjPY6DHxOFt9kThM3zzk1
         KqfkI/w/sM6gx2EmF6ngei23lGrAP3IJdDzl9tMGmbSQA+ag1xfOSaaypuOAjq4chp8G
         p9wNQJ5y/ULMSKh7tEW4EQjUSlYMS0SpOv9QKIENGkOw1KhUu0KgWiqcW/VUvTDSxPx9
         Q1JTSHE9EsXT9b/XcWAJK8bkH7N2KLs+khQpJsN2zIlcHQJmMpGvvFYpdKdqkJn5KwoV
         vZ3HY4hBXRbRMiY+U89HI5Z6Ee3ABxxp5NjqCd4VffnqlNBsVqe/rvKfQGu5VALTLLEg
         3cLg==
X-Gm-Message-State: AFqh2kp4o1XQ69o0Id36nbYNyiDKjA2tiwoZdZKsfM8jdj1fY0akLiDL
        7fyc/sHv+SDompffDKY++U/qpw==
X-Google-Smtp-Source: AMrXdXsSJsIFBuA/d45r8k5J1kxFK5aNDcnKRC5HH1dSgUuy2J2TMrpHEEhl9oozjl9WyqtaXXMLFg==
X-Received: by 2002:a17:902:ebc3:b0:189:361f:89ac with SMTP id p3-20020a170902ebc300b00189361f89acmr86973770plg.64.1673427164224;
        Wed, 11 Jan 2023 00:52:44 -0800 (PST)
Received: from yunkec1.tok.corp.google.com ([2401:fa00:8f:203:c84:581:fd3a:b32b])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm9566612plb.22.2023.01.11.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:52:43 -0800 (PST)
From:   Yunke Cao <yunkec@chromium.org>
Date:   Wed, 11 Jan 2023 17:52:38 +0900
Subject: [PATCH RFC 1/3] media: v4l2-ctrls: Expose v4l2_ctrl_fill_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230111-uvc_privacy_subdev-v1-1-f859ac9a01e3@chromium.org>
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Yunke Cao <yunkec@chromium.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-4d321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fill_event() to v4l2_ctrl_fill_event() and expose it to drivers.

Signed-off-by: Yunke Cao <yunkec@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c |  9 +++++----
 include/media/v4l2-ctrls.h                | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 29169170880a..184e03d032d9 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -16,8 +16,8 @@
 
 static const union v4l2_ctrl_ptr ptr_null;
 
-static void fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl,
-		       u32 changes)
+void v4l2_ctrl_fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl,
+			  u32 changes)
 {
 	memset(ev, 0, sizeof(*ev));
 	ev->type = V4L2_EVENT_CTRL;
@@ -38,6 +38,7 @@ static void fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl,
 		ev->u.ctrl.step = ctrl->step;
 	ev->u.ctrl.default_value = ctrl->default_value;
 }
+EXPORT_SYMBOL(v4l2_ctrl_fill_event);
 
 void send_initial_event(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl)
 {
@@ -46,7 +47,7 @@ void send_initial_event(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl)
 
 	if (!(ctrl->flags & V4L2_CTRL_FLAG_WRITE_ONLY))
 		changes |= V4L2_EVENT_CTRL_CH_VALUE;
-	fill_event(&ev, ctrl, changes);
+	v4l2_ctrl_fill_event(&ev, ctrl, changes);
 	v4l2_event_queue_fh(fh, &ev);
 }
 
@@ -57,7 +58,7 @@ void send_event(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl, u32 changes)
 
 	if (list_empty(&ctrl->ev_subs))
 		return;
-	fill_event(&ev, ctrl, changes);
+	v4l2_ctrl_fill_event(&ev, ctrl, changes);
 
 	list_for_each_entry(sev, &ctrl->ev_subs, node)
 		if (sev->fh != fh ||
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index e59d9a234631..52b2f366cdb6 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -847,6 +847,18 @@ void v4l2_ctrl_auto_cluster(unsigned int ncontrols,
  */
 struct v4l2_ctrl *v4l2_ctrl_find(struct v4l2_ctrl_handler *hdl, u32 id);
 
+/**
+ * v4l2_ctrl_fill_event() - Fill the v4l2 event for a control.
+ *
+ * @ev:		The event to fill.
+ * @ctrl:	The struct v4l2_ctrl for the control event.
+ * @changes:	A bitmask that tells what has changed.
+ *
+ * This function assumes that the control handler is locked.
+ */
+void v4l2_ctrl_fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl,
+			  u32 changes);
+
 /**
  * v4l2_ctrl_activate() - Make the control active or inactive.
  * @ctrl:	The control to (de)activate.

-- 
b4 0.11.0-dev-4d321
