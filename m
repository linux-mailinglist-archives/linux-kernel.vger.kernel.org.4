Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAD640BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiLBRTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiLBRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:19:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFD862D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:19:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bj12so13022324ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4bSOSlIclNNMQjhpRHtDeBwxprB0cAQM7uBgtvrsE0=;
        b=IBEHZHv0WH5QpgzyMh/FDZY7giKGelj7WrVy6ToYlYHm52XFl/KS36wnfihqGQfxHa
         Z7SMeR0plGpOvu8dDta2o/Fa9mEzNb7ghpeqFFUWUPFv1KAGIKNzKCAiZZCOh6EyU8Yq
         GRsUSuyY8FV457PCDDkTfUC/BzSytXx0ig3lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4bSOSlIclNNMQjhpRHtDeBwxprB0cAQM7uBgtvrsE0=;
        b=VvLG73hwUxTy9ZCmHaNGqrYBVW9WXCLyzwOCnSSk9vWYINdrYKQHeSuHzTGUq3r2Vx
         fFzWwDP0WkyIOD712FzKPCfBebqIym8As+Bwg3e22VOgm9pdt3KaYoOh49odU9g88iI9
         qu74PZrHy7HC1X0EvEcTy5mpkLefyI0dzffwP3pzdSUjxn7oU0zDUGTXKdq+zwue5//J
         en2lUFvPxcRmNvpDdCZce+RJkaBkTxmr+IvRtkcVqaCf19v6loajZM8XZWeWms+FUTDm
         6n2N7MSAwN0S04QbsA5w5PXd74zrywVdR54QkkvL2W6JlKyNpMTpfiB9yMV7pVO4yD1U
         ZpIQ==
X-Gm-Message-State: ANoB5pn9gwkTIV0h2hs4Xax4iOfygiXdhFMNykheYQpDUggs1SdTGxNL
        NZsfXcWCjIJ2s7OsKz5etqfaCg==
X-Google-Smtp-Source: AA0mqf4JeClR0d1G8oCCLmzY970oo/5VJQHMin/gM3RFAfig3y90eRJSt50EyMUO+hJemwLe+oDKNw==
X-Received: by 2002:a17:906:d295:b0:7c0:aff1:f1b6 with SMTP id ay21-20020a170906d29500b007c0aff1f1b6mr7039524ejb.418.1670001584870;
        Fri, 02 Dec 2022 09:19:44 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm3117864edq.72.2022.12.02.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:19:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:19:31 +0100
Subject: [PATCH v4 1/2] media: uvcvideo: Refactor streamon/streamoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-powersave-v4-1-47484ae40761@chromium.org>
References: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
In-Reply-To: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        Max Staudt <mstaudt@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=it0NuE/Vzlg0rdtNCao9FxFkt3XwIbqERC0L8SjLc2M=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijOqhC3V07c53unnuqEQsWOyNuPKlRrDkDPQ5XOJ
 FC3WYDGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ozqgAKCRDRN9E+zzrEiBRiD/
 9moZtau9pKvyLy0ry+B+VFxfqRBh0kJe9Na4fV3RTQyL78Ax7jW+6XDflbPTV11RuodZ4EW7IgI5Jb
 F4icdovhxKQNLijZKyQcmDWrfU8gGLM2Mxnlo7a6UcQcyaP8h0rRWHwDvwnKwDtu5FfoQcABZW3jfk
 mPgVzLiJgMMN4ERLyRFPdW0MlmQ+7aIZ2qDS3d6DNbgaYWrmoinUkxhlknyxxHvTNQlbmzUnKETvjR
 YmLGlkNocsGpdUMVW+JhRrs2Ue40temCwRoaptGvIOcXFqY0kre7x9bokmb1OCwe3E4WPY8gJXM8Aj
 tCbVd2m8YkAYikrEY6LEu/Q2Tjqy0Gog43ab/+EUR4clrs39VU01owZsGsBXsCrnWyA3Zh7S6dx8/R
 N+TbGUWUZoad0m/qo4sJmJMJtV2BhRXcrdeCq4EpYbBjV/DlkF0KdTs4dyOl4tALY5+1IhZwkBCapv
 f52mls3sjPsW7u6Ktf/JHNEjmrDLiAQlL5w/2yzaMgQUA4zT7eKNUU7FCSm3YUNUGW06zBYUcJ0+80
 WABpVbOZSOEa0DANf5eogCJAtFkfU3bZYxRLCBOye2DUbc+nnkpBTC3BjkdpTr+vu2B9XFnjIzcCRP
 2GT9MoPStpR9Tv5WX4Fsm29njlV7LTqg2GacaMqKv33ErCIUCPdbZjISqFZQ==
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

Add a new variable to handle the streaming state and handle the
streamoff errors, that were not handled before.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Max Staudt <mstaudt@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 19 ++++++++++++++++---
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4d4c33b6dfb..1389a87b8ae1 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -840,13 +840,19 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_streaming *stream = handle->stream;
-	int ret;
+	int ret = -EBUSY;
 
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
 	mutex_lock(&stream->mutex);
+
+	if (handle->is_streaming)
+		goto unlock;
 	ret = uvc_queue_streamon(&stream->queue, type);
+	handle->is_streaming = !ret;
+
+unlock:
 	mutex_unlock(&stream->mutex);
 
 	return ret;
@@ -857,15 +863,22 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_streaming *stream = handle->stream;
+	int ret = 0;
 
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
 	mutex_lock(&stream->mutex);
-	uvc_queue_streamoff(&stream->queue, type);
+
+	if (!handle->is_streaming)
+		goto unlock;
+	ret = uvc_queue_streamoff(&stream->queue, type);
+	handle->is_streaming = !!ret;
+
+unlock:
 	mutex_unlock(&stream->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int uvc_ioctl_enum_input(struct file *file, void *fh,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..45310f55475f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -581,6 +581,7 @@ enum uvc_handle_state {
 
 struct uvc_fh {
 	struct v4l2_fh vfh;
+	bool is_streaming;
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
