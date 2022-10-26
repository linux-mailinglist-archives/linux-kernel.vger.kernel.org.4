Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21360E045
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiJZMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiJZMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253B9186E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i21so19997793edj.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMLlFka1I97WBpNYC6a4inYcni8WZqVzi63jLlkZWi4=;
        b=AH+RmoooS8UaFLHJXXnRxoJ2Jc5GkSas4KiebXOgW+50b9uocgReMAHmfeETP4vfif
         6cWO0JIubDsaPFSSSR3FWtfmO8uWHTBSjdgOouYUwEz4MgKGonVtZiPXH50VnoRM1cjR
         Kv8MBusAP9Vj+S091rh8Fg0CUefagSrpnVQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMLlFka1I97WBpNYC6a4inYcni8WZqVzi63jLlkZWi4=;
        b=1GZcVBsriib0sOccQs68+JbmpqDhU9WhPDqGs18fkqPHI/Vd08C/W1CpSwuwpkDeVK
         FmioV1jhhpYNwO/gpucuk3KYA3Au1WlEX2enUYGBpm++PeYJYZm9CNxpvy/sZH6iRLrm
         rNe6JoHfO2LCxiJaHMNtkxjE1wSIQsJlnSpO8UNUyoSakkvNC/x3Vz7XQX3+m3Z2Sae/
         d2ZIWqQl8OBoAL4r3Eno808JWUTqW6616QPni4wYnKEiGleMt2D5GuF3hxlCeuI0DE1U
         Xd5tyQmegbdbREm050vG/Sp3GCvha/cWdNxuEuU4cawrSQd+eAun8N9poZsTj20cm7VS
         P4VQ==
X-Gm-Message-State: ACrzQf2Rz0WL/I0rw4e1I0ry4gcWrFAeGMyhk+6eVlK4fwKAQE0E629L
        h6sb+5ZkuA4rG2gxIGIdtwyuo77kjjBYk55x
X-Google-Smtp-Source: AMsMyM71cXxPxEDN4di7luqAVwmAUP4cd4/J6qh929jB55KOHr8jSvnqbgnRmH5SgiyYjmioTaS62Q==
X-Received: by 2002:a05:6402:1a42:b0:458:b430:7e70 with SMTP id bf2-20020a0564021a4200b00458b4307e70mr40565070edb.293.1666786000295;
        Wed, 26 Oct 2022 05:06:40 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:39 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:12 +0200
Subject: [PATCH v3 7/7] media: uvcvideo: Protect uvc queue file operations against
 disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-7-c47856d8757e@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VNSZpEP9LE78JkEZDvuh4x3SXN68AOH2OfrHeEklewU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSLFnSJAN39YLb7VMCp2rSXdTYaaZXR/J234HUWm
 EacyWCmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kixQAKCRDRN9E+zzrEiCngD/
 9F98Rbghu+qvDGozMAenv8X0YPJt3WGjVSRv7vqfD+7VROtJ0PmclxYDizlw8tSkb8SiuPz7gTFdmE
 QXET5tNtKjC2A0qaUcyUkzmazEFQwFH6+rJHM1Ays6mCMVOIK3u0sGcaqyxhdynjybu0JJvjDLUdGi
 bnIKhzNc6ggNQrqNj90kaX1W2oAhYnMDlIpEygimeopmgJfEhLZ8Tsu4f9mb0brrKv6ztPsj8oatZ4
 O96cFr0yYZ1D6ET68CpiJwSYWl0/a8fPSwKxzedb2SN1LUC70RMcb1cJWeJ+0n3iSRPTJXYBclQMf5
 YmW0ns5APcng52VNrX6fSOpXHgmxhjTv/d95yw/n7vsMm6ASJ46itjKOBeZuhCB/Sy1Mc4j4g/d7XX
 YM9mWiXgN9WaXciV2/3h60xPsmpVvDAnWdVIf+aGkJZwJXuo+vvtp7tcYJyo6VsK8j9QTF61hV2HzS
 DX25L3L14xQ+5K9IUmBVgI3zBL/ovTPo/b0CMr2vgBbTB3/inFi6BfuUH161eBHd4W3Fw4DqmThiXr
 eMLhMhv9zCMlw17sJD1s2nBDtMsGszIc0nPuwXkgoVbH2IJPqLPaWcKSJvi8nFNLVSECU4MVaRhtsD
 H+LABx9UrTM9FrrjM+3f7QuLVw6G9/PuCGPBE6qT/AutyhY2z4b9i7DdlFVQ==
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

From: Guenter Roeck <linux@roeck-us.net>

uvc queue file operations have no mutex protection against USB
disconnect. This is questionable at least for the poll operation,
which has to wait for the uvc queue mutex. By the time that mutex
has been acquired, is it possible that the video device has been
unregistered.

Protect all file operations by using the queue mutex to avoid
possible race conditions. After acquiring the mutex, check if
the video device is still registered, and bail out if not.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 16fa17bbd15e..aed45cbc814e 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -354,24 +354,52 @@ int uvc_queue_streamoff(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 
 int uvc_queue_mmap(struct uvc_video_queue *queue, struct vm_area_struct *vma)
 {
-	return vb2_mmap(&queue->queue, vma);
+	struct uvc_streaming *stream = uvc_queue_to_stream(queue);
+	int ret;
+
+	mutex_lock(&queue->mutex);
+	if (!video_is_registered(&stream->vdev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+	ret = vb2_mmap(&queue->queue, vma);
+unlock:
+	mutex_unlock(&queue->mutex);
+	return ret;
 }
 
 #ifndef CONFIG_MMU
 unsigned long uvc_queue_get_unmapped_area(struct uvc_video_queue *queue,
 		unsigned long pgoff)
 {
-	return vb2_get_unmapped_area(&queue->queue, 0, 0, pgoff, 0);
+	struct uvc_streaming *stream = uvc_queue_to_stream(queue);
+	unsigned long ret;
+
+	mutex_lock(&queue->mutex);
+	if (!video_is_registered(&stream->vdev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+	ret = vb2_get_unmapped_area(&queue->queue, 0, 0, pgoff, 0);
+unlock:
+	mutex_unlock(&queue->mutex);
+	return ret;
 }
 #endif
 
 __poll_t uvc_queue_poll(struct uvc_video_queue *queue, struct file *file,
 			    poll_table *wait)
 {
+	struct uvc_streaming *stream = uvc_queue_to_stream(queue);
 	__poll_t ret;
 
 	mutex_lock(&queue->mutex);
+	if (!video_is_registered(&stream->vdev)) {
+		ret = EPOLLERR;
+		goto unlock;
+	}
 	ret = vb2_poll(&queue->queue, file, wait);
+unlock:
 	mutex_unlock(&queue->mutex);
 
 	return ret;

-- 
b4 0.11.0-dev-d93f8
