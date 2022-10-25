Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7060CF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiJYOfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiJYOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDC9E69C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b12so36588710edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDM4r82Vu25XAn8FTag9RA1fMYhJwpZR6aZfJo/nKnA=;
        b=nIVyfuuLI2cY//5mXH5HGb5Gjqd/AcguOXfo5HF8Q8BDI7cOi75JXbGnOG3v+vIuz3
         mt1skZQQchxvpTC3zTEBetG8//LJ4N9Xl1oxUA3Tj98dynsanFBRDfN5LYrPR8TOVWal
         FXN3gLDVO7LtkrPcDknz18vwrl8Qhcxtgll4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDM4r82Vu25XAn8FTag9RA1fMYhJwpZR6aZfJo/nKnA=;
        b=kpCwiS6idde+QIGGqtigJE8nJVSULdGq7u58IoMn8j1kSwVS4eT5tEYtyjDTXl+hzH
         qQnHm17Hwdz53WwHYVFJtlTqzVIS5QMA0yKHYlmDi3KsX3kjAO5NqF0w9X0nxPqn3ETL
         7AL0YnS3uBMwcNw3Cq+Dl43JPpmzTwacUOWrir5lyQH5Mtiz1kNJino0gj44PwaOTk9O
         WLQWeEiWL6dc5kM4qrZposlmMBXRlZmTsesKrosxq9NmoqP1VoqgPRAvEsl8j1oNW2K9
         nD10N2J56tu2k1bSegGeXUKZXSvAfLCthoT3AqC3NO6TgQ2a7zue8pATdh0Rk933wIWo
         6d4Q==
X-Gm-Message-State: ACrzQf0Ned/ylPAJsMSegVXvO7afDVag3JYu8a8j/qu5TSjbqZMR0O7P
        i8lrC47t6DR0MDinGoavKOs++LKstp2Dosr4
X-Google-Smtp-Source: AMsMyM6ZxduJLpfqNo1FL1eE1kp3pE8jxsD/Mw6MleY81obi30oIH1q1NflkTjkUCgp4ZZhPnjBT1g==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr37136318edv.331.1666708520472;
        Tue, 25 Oct 2022 07:35:20 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:20 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:29 +0200
Subject: [PATCH v2 8/8] media: uvcvideo: Only call status ep if hw supports it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-8-5135d1bb1c38@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4002; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=IWi5UBoOQCglgZ8fk/i0G4nYeLqeSgpNrXbJjKKYXhk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QcG5LK6K0jUjnoGq8KBuuEpJ6sMYJlNi4Z99xs
 BCAWNeiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0HAAKCRDRN9E+zzrEiH3VEA
 CIqowtYcGGbBD5Wo2qirQ1FwAwCwchTq489hfSl5qGvsmBQohbYAFQDlUA7h2CRwwQnkU/vt3ZpFab
 8M1Rvi+rfRZk9bSrcvodaXlamQIAQvShxFKOBniermTFJ4WJwyTDboodQyCtnhkiVczysx0Tb7RcrQ
 dNH9Uw/2ttvLSclYZO/msOuA8XYz+64OWIoMVP6wkeimPHw+QXUq+aFmRaWeIwEsEU394owG674Ct7
 tvA72i0vlg3Ls3sA1vPavMa/RDwnR+Arx7wXHAhZEYoTHTrq7PBvhBXWaHhye3roTAQZBbokSTmKq6
 v8Byx7IpUaBSoURpqsi342uJU+kdU7Or4foGrEXvrM7s5O+O0EHeXGGw8JO4xVZeA/edYDcg5vQ6/u
 jnE5jYg5sm1mom3gG0sKQnWVxWw770mR+kgAM9eL5nlRqg15VXz/rRLPau8giNSudLk6bmw1bGysgt
 +eLWLT7vIBwUWfU7I0HPZ8hF8Hxz9I0n26m8VK1xQlP1VxxqHtcvJ85dkIckJ1P++hBOKH9kDumDNe
 C7NU709b8c9tWMVgdHsaOtB+vgT5t65tpN7+bplq6flFkkt9Id9y6RhD6IbvVzgvo5Zs7c1UsGz8rU
 03qsjRjeWNYJueL1GByAPAzYO+yRWATDEkzzZ+velzXiVLlbQCK4VKm1wxmQ==
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

Instead of calling uvc_status_* regardless if the hw supports it or not,
make all the calls conditional.

This simplifies the locking during suspend/resume.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f15fbdbcd8bb..d2841f0d9132 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1847,7 +1847,8 @@ static void uvc_delete(struct kref *kref)
 	struct uvc_device *dev = container_of(kref, struct uvc_device, ref);
 	struct list_head *p, *n;
 
-	uvc_status_cleanup(dev);
+	if (dev->int_ep)
+		uvc_status_cleanup(dev);
 	uvc_ctrl_cleanup_device(dev);
 
 	usb_put_intf(dev->intf);
@@ -1918,7 +1919,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		mutex_unlock(&stream->mutex);
 	}
 
-	uvc_status_unregister(dev);
+	if (dev->int_ep)
+		uvc_status_unregister(dev);
 	uvc_ctrl_stop_device(dev);
 
 	if (dev->vdev.dev)
@@ -2222,7 +2224,9 @@ static int uvc_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	/* Initialize the interrupt URB. */
-	if ((ret = uvc_status_init(dev)) < 0) {
+	if (dev->int_ep)
+		ret = uvc_status_init(dev);
+	if (ret < 0) {
 		dev_info(&dev->udev->dev,
 			 "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
 			 ret);
@@ -2274,6 +2278,8 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	/* Controls are cached on the fly so they don't need to be saved. */
 	if (intf->cur_altsetting->desc.bInterfaceSubClass ==
 	    UVC_SC_VIDEOCONTROL) {
+		if (!dev->int_ep)
+			return 0;
 		mutex_lock(&dev->lock);
 		if (dev->users)
 			uvc_status_stop(dev);
@@ -2308,6 +2314,9 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
 				return ret;
 		}
 
+		if (!dev->int_ep)
+			return ret;
+
 		mutex_lock(&dev->lock);
 		if (dev->users)
 			ret = uvc_status_start(dev, GFP_NOIO);
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index cb90aff344bc..627cf11066e7 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -277,7 +277,7 @@ int uvc_status_init(struct uvc_device *dev)
 	unsigned int pipe;
 	int interval;
 
-	if (ep == NULL)
+	if (WARN_ON(!ep))
 		return 0;
 
 	uvc_input_init(dev);
@@ -312,19 +312,23 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
+	if (WARN_ON(!dev->int_ep))
+		return;
 	usb_kill_urb(dev->int_urb);
 	uvc_input_unregister(dev);
 }
 
 void uvc_status_cleanup(struct uvc_device *dev)
 {
+	if (WARN_ON(!dev->int_ep))
+		return;
 	usb_free_urb(dev->int_urb);
 	kfree(dev->status);
 }
 
 int uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
-	if (dev->int_urb == NULL)
+	if (WARN_ON(!dev->int_ep) || !dev->int_urb)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
@@ -332,5 +336,8 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags)
 
 void uvc_status_stop(struct uvc_device *dev)
 {
+	if (WARN_ON(!dev->int_ep) || !dev->int_urb)
+		return;
+
 	usb_kill_urb(dev->int_urb);
 }
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index c250b628fc4f..2861ab122beb 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -44,7 +44,7 @@ static int uvc_pm_get(struct uvc_streaming *stream)
 		goto done;
 	}
 
-	if (!stream->dev->users)
+	if (!stream->dev->users && stream->dev->int_ep)
 		ret = uvc_status_start(stream->dev, GFP_KERNEL);
 	if (!ret)
 		stream->dev->users++;
@@ -66,7 +66,7 @@ static void uvc_pm_put(struct uvc_streaming *stream)
 		return;
 	}
 	stream->dev->users--;
-	if (!stream->dev->users)
+	if (!stream->dev->users && stream->dev->int_ep)
 		uvc_status_stop(stream->dev);
 	mutex_unlock(&stream->dev->lock);
 

-- 
b4 0.11.0-dev-d93f8
