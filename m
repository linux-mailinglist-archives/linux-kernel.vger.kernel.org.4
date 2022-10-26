Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633160E03A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiJZMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiJZMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFC8E9A9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id 13so20633003ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqAVGKJsGpAiDy8QH7vQCuUMfc+5BKxsR+DFSmRJpWo=;
        b=XDmKR2Z7KTJnbUjGeC8zmqBt0V198AEmIzxVjLZBBIVqjc+O5gri3l4XhykXTAfV8u
         vmAgUG4pNEciPdCyVOpgoteEN1gcSfQDBahjX6SkliA+Dz+P3qHnPhIZ+OleY/IBQnep
         QO40c8bISPt8xTR9RCsBVtOG/obMhv9CXcXBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqAVGKJsGpAiDy8QH7vQCuUMfc+5BKxsR+DFSmRJpWo=;
        b=aPIWKzu6ClY3P4xvxTa2TE2pQKhi9vcbhCLKo/i5YbEhVT84l2CHBMF4U7oaaXOCny
         TLoEN6lyvgumHoEBst2OvxVALUU7tHKJWiwus+mBC2sDoUfOaJWXqoXhu0Tr+KhhZJIZ
         /rcGSma9U8dDXZ1E0TAZOqmAGc2oEZj8XjxxQgUpbk2vlJSL2ot5kv66rHKeJ83grO1y
         TpdKlwUSyhozL2lWnXoqyIh4lPUq9HFl0OqqNvGSFVTs1bEqDDNtRJYK1Vxh+1imIDiQ
         q+ADqjKHQlH4hFizf5HeJ0sRUvWeXUVnALOdri9nTGeiYhtxCwHgEXo62/7YWDOjHdcz
         WlcQ==
X-Gm-Message-State: ACrzQf37zmhRjglBOKWTC/9z061TBd5MjYXgtZ8ZN6ezSyWqYm95rH9f
        taEBSkO/4LlKiXbq18TZvKCqo1bmDtss/nm4
X-Google-Smtp-Source: AMsMyM6pqwAq908Ifv/m8kcz/Hpbspm4mdhnPlreUe33TEqSOqF0j0v+5feOzeQ2AFKSCo+e3EQLIw==
X-Received: by 2002:a17:907:3e85:b0:73d:60cc:5d06 with SMTP id hs5-20020a1709073e8500b0073d60cc5d06mr38359298ejc.722.1666785996191;
        Wed, 26 Oct 2022 05:06:36 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:35 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:08 +0200
Subject: [PATCH v3 3/7] media: uvcvideo: Only call status ep if hw supports it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-3-c47856d8757e@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=F8pfFKADrjPOkMpJU6y1lLHTtr/oz5pvCH4FNibFbG8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSLAurZv8vh+QEbWr0OdhYu2rsG6+WOCxbGXwS+m
 ez176O+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kiwAAKCRDRN9E+zzrEiF7tD/
 9ybn2voA0FAQGMcdiNEyxfLo+fjDkj1uSkmMHeoaYff48tRx0DaeQSsKFvyx+49aeafZK/t8ENhe3w
 WDzbLNac8KSI4hm3dmnDIO6hW7XzPUFX0hBHeAwvd4+2EizI+Ygg4nnG6uShEuUv/Wj4ELtwHUiTYI
 D+KrUErS4MTv5/x/Wyo7Ze4Uv+hv7IFr99slHLK+ObaGmSyJ8FWdp3OKadu0mNTKeiqHJgUpbWlT32
 ODjIed2UZpL5A3JF4nG1DYhFPpAUxrA/xfsx3JM1wprfA2uVKJMdX9GcPaxBPaxEl8zW9NS0IiEW9p
 a9Pr0I/qFX4swCzz2Pj3xX3IUAG7qacFt2zj5CK8tzduxJpsgzhOL7B+7Gj0CHZUDNNtD4DrAObXh/
 mGnwIAY9O1p6MaqfhygTrYEQb3OpUufC4rbDDvO4J0Y7106rKZflHf/7AGLi98Pjn82qb4Ouh7HNaI
 vYvE998QjUFRijxkqSGP+yP4W1FTsluiUTawzv9RmmG9KpjOAo3ak/nNH6j2J6WE+XswQ7EI0WWdAk
 PBju0sU7WmVsJAxz7Ori1HbLY0pUTkWxo/VI2B373jPmYID2/5cIhj9nzWna1stHzGZicB3irin0Vm
 zpjU6rcaRZPQtHJlKH09PCNb1Wy+D5uz6okKF120YbTC8kq5GLiYYkbcw4TQ==
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

Instead of calling uvc_status_* regardless if the hw supports it or not,
make all the calls conditional.

This simplifies the locking during suspend/resume.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bd3716a359b0..ac87dee77f44 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1837,7 +1837,8 @@ static void uvc_delete(struct kref *kref)
 	struct uvc_device *dev = container_of(kref, struct uvc_device, ref);
 	struct list_head *p, *n;
 
-	uvc_status_cleanup(dev);
+	if (dev->int_ep)
+		uvc_status_cleanup(dev);
 	uvc_ctrl_cleanup_device(dev);
 
 	usb_put_intf(dev->intf);
@@ -1898,7 +1899,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		uvc_debugfs_cleanup_stream(stream);
 	}
 
-	uvc_status_unregister(dev);
+	if (dev->int_ep)
+		uvc_status_unregister(dev);
 
 	if (dev->vdev.dev)
 		v4l2_device_unregister(&dev->vdev);
@@ -2199,10 +2201,13 @@ static int uvc_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	/* Initialize the interrupt URB. */
-	if ((ret = uvc_status_init(dev)) < 0) {
-		dev_info(&dev->udev->dev,
-			 "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
-			 ret);
+	if (dev->int_ep) {
+		ret = uvc_status_init(dev);
+		if (ret < 0) {
+			dev_info(&dev->udev->dev,
+				 "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
+				 ret);
+		}
 	}
 
 	ret = uvc_gpio_init_irq(dev);
@@ -2251,6 +2256,8 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	/* Controls are cached on the fly so they don't need to be saved. */
 	if (intf->cur_altsetting->desc.bInterfaceSubClass ==
 	    UVC_SC_VIDEOCONTROL) {
+		if (!dev->int_ep)
+			return 0;
 		mutex_lock(&dev->lock);
 		if (dev->users)
 			uvc_status_stop(dev);
@@ -2285,6 +2292,9 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
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
index f5b0f1905962..77b687c46082 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -37,6 +37,9 @@ static int uvc_pm_get(struct uvc_streaming *stream)
 	if (ret)
 		return ret;
 
+	if (!stream->dev->int_ep)
+		return 0;
+
 	mutex_lock(&stream->dev->lock);
 	if (!stream->dev->users)
 		ret = uvc_status_start(stream->dev, GFP_KERNEL);
@@ -52,6 +55,9 @@ static int uvc_pm_get(struct uvc_streaming *stream)
 
 static void uvc_pm_put(struct uvc_streaming *stream)
 {
+	if (!stream->dev->int_ep)
+		goto done;
+
 	mutex_lock(&stream->dev->lock);
 	if (WARN_ON(!stream->dev->users)) {
 		mutex_unlock(&stream->dev->lock);
@@ -62,6 +68,7 @@ static void uvc_pm_put(struct uvc_streaming *stream)
 		uvc_status_stop(stream->dev);
 	mutex_unlock(&stream->dev->lock);
 
+done:
 	usb_autopm_put_interface(stream->dev->intf);
 }
 

-- 
b4 0.11.0-dev-d93f8
