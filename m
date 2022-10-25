Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C160CF23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiJYOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiJYOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA38E457
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt23so7466045ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw978dyctQKYz24O/MzUIY5FG9WdD7MbzKHKlFXG3Qw=;
        b=bmLkeE92rI1LV5eRKtnqFtVtKlsxbsg9ecVDft0DT/GIwpvbLDl01gJxig5T0jNIyd
         +4diSJLScqdvKuCMrCzoJ6SVfJwYuoKr3pk2VSYImmhZg3sPEgPNTlRUslJw0hjj+iVZ
         Bn/Frf/KpoKM7o1+hOrk1+ZKYfI3YnRw5QZ6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw978dyctQKYz24O/MzUIY5FG9WdD7MbzKHKlFXG3Qw=;
        b=KEa58kaTBlLySDGjUJ1oN3E4sgwgsKmmYcb3gAOaX/HP2AURdOXeTt/QK1Hr6C6biK
         U13eYAm4CuCtUr9Q/nDEQ8PcGNVby5DZcRNufmRGuDFiudazP4iTkI35fKPR99WtVVDJ
         swV+MKaRuwfxHhMWA2XpoAbaUmxCsKu+7NTCJosjlWErI7M1gZvri9rGZ+kbXdBRVT5a
         lFvBiCxnGsyzVdddNoJNDVkRbPcsdbpFXfuglFmXiPxMmrbqwPUnFRAuCWrIgw+GNBQu
         7nsVlSxcjcEPR5E1b+OrEoKDxeHgFFSE+lJUEGGHFn8uF67ImyApSKIpqn5eiDsp5x6/
         nYQg==
X-Gm-Message-State: ACrzQf2Nm9BctH5nJG0QV/x592F8q2EmeW/C+nuG2SdjAngHQyv+D8Iy
        bUx0d3T8yVUSVe114m8PQGfCCA==
X-Google-Smtp-Source: AMsMyM77Li5Xvdjs5rOn2zK1EnbtQexTxS7e0kamFnWqQjkI4wBzvSv9N/PFgWWQnxoEHdC0ebsEHQ==
X-Received: by 2002:a17:907:c05:b0:73d:6e0a:8d22 with SMTP id ga5-20020a1709070c0500b0073d6e0a8d22mr32994041ejc.646.1666708513448;
        Tue, 25 Oct 2022 07:35:13 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:23 +0200
Subject: [PATCH v2 2/8] media: uvcvideo: Refactor streamon/streamoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-2-5135d1bb1c38@chromium.org>
References: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
In-Reply-To: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=NB6aEyZdAyQsktG3au/4ny2fc8G0li6jsr2nryh8gpk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QR6p/N/GSdWGniClNtVwAPcJBAGTXLWJoRKpUt
 0WA3K4yJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0EQAKCRDRN9E+zzrEiOeREA
 CB2VW7wYO9JmilaSY15eLOYmFRdBeDHrKtiMPi7vGit/vrZQEdlX1GkhsmvhtFQOYf5X1bOWzEDFHz
 39J8jZqoLIVNkQF7KiyserEfeAtCFaqOYTvNCmGuCmp1tUUTqgdPkTRDlwUOM26FfSuYhaVWcGLdGW
 QSEZp993O0oDkpfsmCXenx6Vitop2NCT5NOKguJqTb9nCzbp5aSQcWkKvRZmlQvCjsq/gtrViy+161
 /gY254FN95KzohXog9BodoFz7nmTGWnscVRdbDsBXA7+WwwkKwMQVec35X+JFHPOywWv9SYOv6ZnXE
 DUBu1WYi5mqLgpQ05jBw3JPliocxdZ23k4pK05ekZuHOeRlvwlrF5PIfXPmV+5AX/5V3Z+ZD5wthHu
 fsLk7e+9T7E6pDPpu2DemRO9LS4INVocaafzIeqPYTXors63sWqCr+4Bbkb2CE9qU1ASM+he5ObXfg
 rAyBA3gQpaU+Ry6/WafZRN6s3wI/xp1XBpW69C/4moCMe9hIUlo5bSFz++ISYR92oDoRscFSH5UKYi
 QF/Az9KgcfKi0SoR19lfI8dEuYTp+1SfyqYfcx5zZtQsU9DXcaJ+N7IKpwyv+25MIJpsTdk9pdGyJt
 gWsBDMvV9C7H/vtIemgsOBpTVkq8eI7JnG++g0M7TXp7869qJxxLniTlKzOw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable to handle the streaming state and handle the
streamoff errors, that were not handled before.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
b4 0.11.0-dev-d93f8
