Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153F60E038
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiJZMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiJZMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384248FD5C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i21so19997308edj.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw978dyctQKYz24O/MzUIY5FG9WdD7MbzKHKlFXG3Qw=;
        b=RNEWO8yCqIDykMwTYHMv+kJVII6rNKH4/P/QPL/q6horof/ZVy7k5E+Ma6ijN5FZT7
         15Hz+LQn182NqAizezzVe12b8E2TcHlZ8UUeH5FyDycQZSMucG2V5Gr3cU+9JEvtJGZp
         tEzlJwyl/DwxrWQSyYJ5ns/LBFAR1kaoiyTlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw978dyctQKYz24O/MzUIY5FG9WdD7MbzKHKlFXG3Qw=;
        b=eKxQjG6z+iQE1lfkexoJ9V9sasY2zZMyvekwv0TTbFl+RZHc+Mo4e1FWF2VNB1uO1z
         O0gcLDE3CBEJpjUtiBtvpt1sQHXE/127PdSMTeC00+mb24Unky2UVPBuA/jjYLiVBTQY
         h20dVDyJrt7Ees78nPeqNbn7/2pTijPhl5I8pWooEA5X6OV8h63xdAkiyiPb5QlJJw+/
         tq3JJzuqqQceJnNfT+oaYnYUnRbGr7Q+DgEJieFcawq7OqltR5ffE6BgkqJPXUeqY1go
         sM+AHsSx7k8hXQve8oWWFy+1PQ8IsLMxJk8QDpu/qGHypeyQtYrBNIzO7UJ8DH6wOUzj
         rVAQ==
X-Gm-Message-State: ACrzQf34h15zUViZDluoEEIbre7p3cwd0SlNr4smFAdr+4IyJlmpDqa2
        NFxsw402MldubgSB8wDpneJFBg==
X-Google-Smtp-Source: AMsMyM6Xj2p6hg+jvEJSya5BuwT4Kpx4qv8a/7+7k8P8wA5vbIE5slKApQ8bk9uGkNaEKuOKdjWM2A==
X-Received: by 2002:a05:6402:550e:b0:456:f79f:2bed with SMTP id fi14-20020a056402550e00b00456f79f2bedmr41217834edb.106.1666785993850;
        Wed, 26 Oct 2022 05:06:33 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:33 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:06 +0200
Subject: [PATCH v3 1/7] media: uvcvideo: Refactor streamon/streamoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-1-c47856d8757e@chromium.org>
References: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
In-Reply-To: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=NB6aEyZdAyQsktG3au/4ny2fc8G0li6jsr2nryh8gpk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSK7fJwo06bKVIb5CIAm+Y73zwAAOjAjBzBn92Px
 23qElF2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kiuwAKCRDRN9E+zzrEiISqEA
 CbHxpyUE2B5x4mM0Jf0jPg9SdgW+xI++1ntCUxoIRnXqxPMmXIvKLdeSh84cYwk0Tba8PEn987ucuX
 cOHnIiROzdBvCHx8/sos6Xwq27u15CW+h57TKUu8DMiZsns2Cs/RZxt429+WvWcBaoK1ZxKS9//yoU
 HG41ExZRMxLuM1CicJfeRuX5Hjct00ITxOEpnMTMKgTEzdhBabLPZi3AhsGOylblf/VlZetxkZJo+d
 XjZlh3t52MfQ08uePxFSFVk1/HcK2s3ameYdCM+/PUBk1mkKrfLyqwrPGvMle+Dos+8nZKpw1hMFxH
 Tt8SUkAvIVFbyic4pi40EVk4aEQc4wQ2UcRn9MdniJd4TBgzrvoYgrF0xNnWGEiV7CCrPMQjDJOLSl
 KFs3drtskxxw/rwCbY/pVbeeBOua2fLa9rVpEsmifcybknI0Ycr48fZdLa7VZ4JztxYpBJN8PbMWsa
 /QhxRRqlkzNVa1CnjZaQrY6WCMp0rjeePxnlxrCTI4eK9T5bqlYHjOvnB8m9hlMmEU96XaO72ExYyp
 N+laziNK4zI/MqMDrIoV33iuGAqOyAWtMkpMZXcEzH2wxiIlxLSPp9osWvIXPu4uGYnVNd/VMI5mbH
 6EF/xKxx7/oduzVEpAab17WU+7T/CGfN2KIXkNNMXG4i2PLvvDwIF1XuE1eA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
