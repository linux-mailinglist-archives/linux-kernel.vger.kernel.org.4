Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9442464D9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLOK56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLOK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:57:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615D26C5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r26so26464148edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVpkR7nzdDvqq9ThIq7raRqr04KfTuTxFaaMR2ZBzxs=;
        b=kpjvcXC8ePJw1pblrCprk4rmsoduvzf4teubLQ6D9CFIXkwkFWSlCGNktOxDHjcdow
         dMhQLEJc3eEZ/cjATyakfNmQcIZNJVpBUXDdKctRPXhqUr+1IdLZlFagmALGowIhHQMl
         dwtXqQf6s+J6KqZIShzzYC3PftLV25ub9tOcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVpkR7nzdDvqq9ThIq7raRqr04KfTuTxFaaMR2ZBzxs=;
        b=xVuA9fFGWuTZWEe1geBc9N55gstA7agiZY6nCveF15PQ9JZT7XN6rjHmgPkUUPoPzc
         bG5P/6J3iGk/OAdAuePji3IRr3iUsml46GfXebawkUyhiYIxTJKT2h5kys418SqmpqCN
         XcN2K9zOuFLcoTREH0+ayEueALnf2l08ezHk+fVePy/8XDlkUGP9M5gbx4U0dGSfQKZN
         CjG1VCmRpcKOMEoNJtYp++jX2wjTuaeVKsA8N0Jd3Na0q7HMLzmF5Ei+cNk5UrCTMotz
         UM6DlgyCYlrYGUif6kAyM9vJp/AiJHa72kfUzL6R8bSd31ncnNKyg8QpTAvzzXZbKEIx
         1RVg==
X-Gm-Message-State: ANoB5pkmTEnA3DXFeegxRxBLs98V0lH5lcs241Y/p7MMc+ZkIVMc5KZO
        QZTQC0tsQ18eqyq4JphXV1jUew==
X-Google-Smtp-Source: AA0mqf5eS3fBHMNRNRCLiTXjs6BcVvuQc9tbALuA+jTHpQIEfBU03ivY0xsHBGHOm9/5eK0+PUnKXg==
X-Received: by 2002:aa7:d48d:0:b0:46f:9fa5:ec14 with SMTP id b13-20020aa7d48d000000b0046f9fa5ec14mr17682649edr.35.1671101856038;
        Thu, 15 Dec 2022 02:57:36 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0046c5dda6b32sm7339381edv.31.2022.12.15.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:57:35 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 15 Dec 2022 11:57:19 +0100
Subject: [PATCH v3 2/2] media: uvcvideo: Do not alloc dev->status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221214-uvc-status-alloc-v3-2-9a67616cc549@chromium.org>
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
In-Reply-To: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
To:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=3ziZXBiTod/vgWEUcMgPrcOKQxKsAh+gKxICZKDjQIg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmv2aAadu/Gf1dCOFnLIpwOuKRuBSaAieIESTtWaM
 suZFPbyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5r9mgAKCRDRN9E+zzrEiKRPD/
 43yl2W6E1uT891+8t8ZsBebhq3k9+Sl2usBDut2XK6HffRg1/yNaJCBeBq4EmfovAzUmt6sTKlVVUI
 qSKMvsZF4aXqcdgPxo5dV0HJjjQrkMPXe5jP/j7PWLY9I7d1PHmwSVjk9DGPQyXYDBVXbNlw9N8y1H
 GHojNW227hCZY5IQflihYSLnU9RBdnUR80/kGHJXK7mbiwt0YYXAuxJG7AjcR4An45jcvebm/y8ReD
 WzxfuftwZYN1PK6jLtBr/ZKWEBw2+gTOxpBnfAnkn/1HTTp/fy8sNVd35cLIONFy0SiHCgjb+1uRBk
 ++chwrQCX7v2yQNIuyDXxaW8zQ1tgTV5FTDWhXx6JDJkbtbvQao7NT5kCTJcJqAbXT8ISRVJETdD2S
 NpOjEGa6Ky9Bz2WnFgzKC+JgYXJy8C5grfZeIm3A2ARQWZAa2ewSruW86+nDrbivlzOtSREFj1lkfM
 /q9K5Cz/Nb/M1p9O3nnGEd4TsQI+ojUwLWN59b7KrulNeKE5r/BjRV6p3/jLRs8gzeXY8REZ+eJiYm
 eKvQ56hDAb4uEgDD50EYbkktr1jqnDEjfpTRC961hsEbi5xB6ekkGdBKccjjfVHFdND9yJqLiZCYr5
 wweUUmjkWA0nP/qVEOt04KYT13LvAYE/sTAgmzIPVSTn5uAIChMF31DzhuFA==
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

UVC_MAX_STATUS_SIZE is 16 bytes, it makes more sense to have it inlined
than dynamically allocate it.

To avoid issues with non-coherent DMAs, give the memory the same
allocation as kmalloc.

This patch kind of reverts:
a31a4055473b ("V4L/DVB:usbvideo:don't use part of buffer for USB transfer #4")

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 19 ++++++-------------
 drivers/media/usb/uvc/uvcvideo.h   |  6 +++++-
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index dbaa9b07d77f..adf63e7616c9 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -200,22 +200,22 @@ static void uvc_status_complete(struct urb *urb)
 
 	len = urb->actual_length;
 	if (len > 0) {
-		switch (dev->status->bStatusType & 0x0f) {
+		switch (dev->status.bStatusType & 0x0f) {
 		case UVC_STATUS_TYPE_CONTROL: {
-			if (uvc_event_control(urb, dev->status, len))
+			if (uvc_event_control(urb, &dev->status, len))
 				/* The URB will be resubmitted in work context. */
 				return;
 			break;
 		}
 
 		case UVC_STATUS_TYPE_STREAMING: {
-			uvc_event_streaming(dev, dev->status, len);
+			uvc_event_streaming(dev, &dev->status, len);
 			break;
 		}
 
 		default:
 			uvc_dbg(dev, STATUS, "Unknown status event type %u\n",
-				dev->status->bStatusType);
+				dev->status.bStatusType);
 			break;
 		}
 	}
@@ -239,15 +239,9 @@ int uvc_status_init(struct uvc_device *dev)
 
 	uvc_input_init(dev);
 
-	dev->status = kzalloc(sizeof(*dev->status), GFP_KERNEL);
-	if (dev->status == NULL)
-		return -ENOMEM;
-
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->int_urb) {
-		kfree(dev->status);
+	if (!dev->int_urb)
 		return -ENOMEM;
-	}
 
 	pipe = usb_rcvintpipe(dev->udev, ep->desc.bEndpointAddress);
 
@@ -261,7 +255,7 @@ int uvc_status_init(struct uvc_device *dev)
 		interval = fls(interval) - 1;
 
 	usb_fill_int_urb(dev->int_urb, dev->udev, pipe,
-		dev->status, sizeof(dev->status), uvc_status_complete,
+		&dev->status, sizeof(dev->status), uvc_status_complete,
 		dev, interval);
 
 	return 0;
@@ -276,7 +270,6 @@ void uvc_status_unregister(struct uvc_device *dev)
 void uvc_status_cleanup(struct uvc_device *dev)
 {
 	usb_free_urb(dev->int_urb);
-	kfree(dev->status);
 }
 
 int uvc_status_start(struct uvc_device *dev, gfp_t flags)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 84326991ec36..b0abc70ca58e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -577,7 +577,11 @@ struct uvc_device {
 	/* Status Interrupt Endpoint */
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
-	struct uvc_status *status;
+	/*
+	 * Ensure that status is aligned, making it safe to use with
+	 * non-coherent DMA.
+	 */
+	struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);
 
 	struct input_dev *input;
 	char input_phys[64];

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
