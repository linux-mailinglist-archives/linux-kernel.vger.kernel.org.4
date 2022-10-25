Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042F060CF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiJYOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiJYOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933497EED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so36488987edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMLlFka1I97WBpNYC6a4inYcni8WZqVzi63jLlkZWi4=;
        b=Qfx1Bj1JK4e65/6R6MgGPuZBNlmRrurek97IQhmwS7ceqdGvFOmGBXWflS5Vd3NqdV
         6iHkNVHzo3C12kEjve4QbVskgamxt0uKBkixiQ3UM/8EOccBLC71OkDBWpxiRqYdOBH5
         mx9SSGbDC2WSkZFqEc+VOYvHzPLJ0OrYbE19g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMLlFka1I97WBpNYC6a4inYcni8WZqVzi63jLlkZWi4=;
        b=wwzjXCrAngBBbatyBCI8YRHXWw3loeiFUzP1DuCj9nNNGw3yWn2quYxOCi9D3EdMo5
         yHWs28wu2WLHCe3+fdLwB0Edk8HdpM8WbyFzeuE0LAbPTY/MMQtqPeLf3snP85ljFgmA
         dCn9rmK1vz6YXUZoUX1Jjx/DYhVMzGP5w9xTQW770iawZ93WFMSjNIe1AjJA98PyxDrs
         lWb+W1lRIc1HL0mOo2J8AlyfXUviF+ljxiUK/ZhugHoxLMSc6YZQ3ZENklmvBCvOySQa
         yL6TydvgX65A//4EDeVoGWXOceoAdjfiI7nAjOj+OdBtmMifnV793cWr0EoJS3IvtUPp
         WkGA==
X-Gm-Message-State: ACrzQf3WM7sKvquGBR62L8A/ZCkyzRbzpMQHLFHyXjJSIO7YJRJOdqir
        HrcUC7Bzw+/AtQaUPgUd26/pRg==
X-Google-Smtp-Source: AMsMyM6FQBVzRSrfYqYI4K+zQsyvap1uAg7GY4Wor8zwg61CEy1cwP5rbvR3Fl0VoLOrK9Bkb95w9Q==
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id o4-20020aa7c504000000b00461122b882bmr25086551edq.14.1666708519387;
        Tue, 25 Oct 2022 07:35:19 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:18 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:28 +0200
Subject: [PATCH v2 7/8] media: uvcvideo: Protect uvc queue file operations against
 disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-7-5135d1bb1c38@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VNSZpEP9LE78JkEZDvuh4x3SXN68AOH2OfrHeEklewU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QaTdNr8W8xCBJiosDRFO8HU1dfVbh3902iej3P
 m8gzCRmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0GgAKCRDRN9E+zzrEiBnhD/
 9wmBIBsC055I344aXmhM2aHVv1TK7xU8KToLtryYZk8LQNH9y8Ig9+QVK+r4QJg4ospiMPZD1SOawX
 VUnsDnvOceokhNWnFuKYgUecVqEOlqR8hw7dAbgnyVD1bwj4a5sehLIb3zPikjifZQfMK2dhCNJaYM
 e5SpvDDj0ovqFzeAwm8Zu93D+SBeW/XQ+smypqV5/Yp2mAf19HpqWLc9BibgpyJvxsMrAEm39EkPg1
 BSStVdabcgeVmokFb7QCjTcKgAPCXxICwDljQcdTR3cUt3Vw6N0j1iIenekVpOgh2f/F9N1T6TF6wR
 GVf+cLl4t6MnSAGEXL8xWpqx/zZZ+CfO3B0ofoLxFvdhiGa62Igbi2uRGnpzlZdoYmg9vINVdXu1EQ
 neRRkAB0kBEdWswz5RDsfNVsq+OoXGfqfmOFLTVIzZbf+oPDGQPJWmH30b/TEZeruDwMu6LY9/Izhp
 JTiNsIf7/m4wFbBFXgYs3dy5trr4OpkvQfdgXcbgn/L/c5Uc0GqH4Z1nHko560Uduxpr2z8xXUOWfo
 G4yT1y48Ct0+i4CXNaN5aBgMg//PdRCdCSnhrvZBly9WPcsGrZZCtRl7skmukpShQbdCewb1KkvYdt
 h3FS7QlmqZ0RuR8pFcjWvmgk1nIFnfgUm0p6wsRhwxCimvmyV5+2hXDo9ndg==
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
