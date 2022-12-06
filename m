Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94AA64454E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiLFOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiLFOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:07:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B332C136
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:07:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e13so20383027edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v922E8rGIq+J6c2NFWWh/FTpBlx2qJ3ei+I17h7c0KY=;
        b=i1nxMvPHlDabz6DB/ZDB4DLZ++C5eSH/pTS+6ad5I9zeCth/s4B5y9kaXF+n9bS9jA
         85o8vRWo2sotVXwhqkxcaZwjmKdNJvXnJUAgKFn/nPVf6bEk8tbls7/2WdbqGR7be0ov
         UcuJrE5WCwUgHe6uLPl7mqIqC5J5KRgi0TBfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v922E8rGIq+J6c2NFWWh/FTpBlx2qJ3ei+I17h7c0KY=;
        b=Ag2/oiaOVM2cMFIkEOI56sKiHmXVuEDkEYeuHnYNnJUKilj0VIz5SOqInpMc6ZtZv4
         2VcbNkq47qqXcGDy+b6NLw1cbXlolT3SeUxeCQdHCD7ByiZFk9kG6kB3tbzRZdpCVwRr
         PtgBsksGWBMPkgL+7vPLeW22+ci2iFEk0CEoWhS9LYY5LWR3wJd7MnMibwUSCK156hrv
         2PP/UNZEIv3MOKXWNncMQ/jDd/qYbSdHFdf2z5CK8wEGSbIfIzgO9Yylif2o7D2updIu
         K6r0xCG/oMxc+WPuW36ChWQ+O1HvrHd6qDgR60pLi5C+cHr+1vAst0d51MY9pXDXkWYX
         f/ug==
X-Gm-Message-State: ANoB5pn+gUUg4ofh/rP+Tj15iMW8YcRvZQdSIbewwcd1/h+aZqtPxmvK
        9TIy21nr9qk32oyQlWiNBl5rgw==
X-Google-Smtp-Source: AA0mqf7bynqfFzWNLfauj2B75UCoT+TjyhjEdSvmkFtWEAWic7P7oI1FLskZt5kFQaznTrGXPL4HCw==
X-Received: by 2002:a50:c012:0:b0:46c:8a01:748e with SMTP id r18-20020a50c012000000b0046c8a01748emr10487378edb.48.1670335647228;
        Tue, 06 Dec 2022 06:07:27 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c82e:c2a2:971e:1766])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906305500b007838e332d78sm7388027ejd.128.2022.12.06.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:07:26 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 06 Dec 2022 15:06:55 +0100
Subject: [PATCH v5 1/2] media: uvcvideo: Refactor streamon/streamoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-powersave-v5-1-692e6df6c1e2@chromium.org>
References: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
In-Reply-To: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=3zL21RAbBxmG4E2HOs2gfeCBQ6ad2Y/PmET8pDsI6gY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjj0yYhBTCOiWFAyR0y9jsPMHUNKLOA8XW6o9YGKlT
 ZJOtYXmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY49MmAAKCRDRN9E+zzrEiPT0EA
 CZDXXB1W0la3ow1s4PyTtnqRtbPpiootFJP+KJNbTQszfQa7tJHmoxC/DYQ352INFaBrqoyDf5sqGb
 r7jB48gVcodGQrF8jMKlLz27aVN6pACG8xewG6j+TlHeMKwP/+JrhtCZa2aHsNhvCuH/PLjMmTOvJR
 zQ6fOt/7ZjgVnTLh5xq9WelyLQoF3239mwEJpGP7KtIT/uyQuwODpkGRv8F1+4ifAzK4cU6kxzImHC
 CDTDpGo45EFSGnJv4i/s1rUUgz3Qg6IknVMD2rm+Gq+TsFAhAH9XMSMyL0IcfTWZL388AwQ00I1NYN
 nChutEOzQ90P9Fy53NgY8zQODuWrV00aKtrwshNgsdcIsxXIhEaKOHj4Kgw9wSLz234AW4pOmCH2IU
 b0AaMopzbWgnA8QjFPDTSe9Fda5hNfQKpW3bMX8LsCyEfFWWBQgOJQmzOuHkBw5yp4bHvjpZ+MISVF
 ckjqglMOWFmorf6cBOGIEDLmx4cEGZsK+wWd49VxcGFHAHP3G2YTQeFJEjNA5Sb3d4yjlI5qGmKHP+
 GLOQKz4e06va61m1q5+gYfOdbt0xRe0HqCPcMwxStBgALlFDdN/BWp8BPApYSzNwAmyom+wT4uqZCL
 AnE7+kfyLZ0QVkYzMRDelr4MxcIdoxhokCPK7o+6gRMn9aCDsob0bTYrT4XA==
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
index df93db259312..0d9f335053b8 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -584,6 +584,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	bool is_streaming;
 };
 
 struct uvc_driver {

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
