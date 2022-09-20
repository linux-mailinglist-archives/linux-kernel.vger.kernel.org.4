Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF05BE83F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiITOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiITOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:11:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524245A89E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b35so4117215edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=EPUsq9ry6a/B8ysE7p/Gp0RizcV4HTBL3tocv0bMA9I=;
        b=D6YdCv4mIHMH6WUGhaC4ew992gGtns2XIA/d91zBkIBOhFOAApfyUVJ7u90gjTZLTI
         Rp96PSPU/6h2IeYAoU0gLDQNygbS1Yo3vhYsFFvd7GiY7OiAPwO2b/9xOsSoJvts15QW
         3EIx+d7lXgAoPPknMH5EjIwPNQpbhdREjfc78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EPUsq9ry6a/B8ysE7p/Gp0RizcV4HTBL3tocv0bMA9I=;
        b=PVWWnlbQOrm8EI54atVOUiW9JnDisWusI0qCHLvI/pmovnkoCf5VhvDOwX444JP2VZ
         +dn5fConGznaWr/qRFAaRb7Fq5MBPDAiBEWQ1xjxrawtIbyCsN6wtCqdn/LPWA2rvHsR
         KWCILNBATleRCiknZx6DYni8vxnGKCZF0TQzycbt6+KCsfvCVydCKRlSOvirbm2k3xa4
         +CvMb/BEEVt2Bj0N+8tN3T92V0qIiSuhr9JN0Ia7kGt5V3HJ1DX9FDrqKGkTVjq4EG+b
         knHS16hW9236KmgcFK4NmIphXchmi/6zqyam8ZPAkIzEmkwzxaJuDZLKMAeoyohNKd12
         GtYQ==
X-Gm-Message-State: ACrzQf0HHM3Y7tnQI4N6KaJfP8nprNk2ZwEcWfa/srEbYQhT3ju6ccBF
        rYsRyDIe/lU2GQXj6bzr6PscUPBgsWVtktP8QLs=
X-Google-Smtp-Source: AMsMyM5wPtDcu8QXUO6uylKIX1BTWHWtLISuou3P2vKderFo8+B4PNZ+iozWx2NHn94BaeiRsgPV6A==
X-Received: by 2002:a05:6402:50d3:b0:451:42e0:a0de with SMTP id h19-20020a05640250d300b0045142e0a0demr20892479edb.185.1663683003237;
        Tue, 20 Sep 2022 07:10:03 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b0044e796598bdsm115488edv.11.2022.09.20.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:10:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:50 +0200
Subject: [PATCH v1 1/3] media: uvcvideo: Only create input devs if hw supports it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v1-1-123aa2ba3836@chromium.org>
References: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
In-Reply-To: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=3NadNTBF4BvX9SA2sRowXe1SUqwds9fIYTSwvXBWhlY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmz5RRiV4EaA9t4Tc8kWTv6qO9FnISyOHjoftgI
 WP2JC8CJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJswAKCRDRN9E+zzrEiPm2D/
 9sCFizIFdBzPnHR+0raeehQ71UIHKmGBvoOLkJXkGnzDXKRvwp9b9FMak4ByuuHqViLH+zBFQLfoDF
 2zMxpoL9jf4Spjm8kGWPzwlFqGqhXw8KddPg2TEGD7HGsgb+/PMKeyi5ek9KQSjTg3jzQhlMT6+FTw
 /KWeBB+3hFnJCvpKsBsA1QJA5zjhU3F95LWZDYeGSd58vrbYV7Vk3YikFGPlqlCmOpp15XjPTD41u2
 P837hzTgA/6OY+bEHJh9zXJjVS0hQiNB5N59a/Usbq7cxfed/Vnb0dmfPddnPjHhh1unK/XyxEiEVI
 DgUyIce+OOi4bYi1u6TG1VunxT+/jeuOl7SFBjerJZ1KFHpqKhY1n3rpzunOqCrcNDz1GO3D/6i5ee
 i08PaX7it/STPZs0HQCiRboX0j9sTY4PjvX8liRH1VMiO2qCoHS6WZeRFjbkFxv61zGBiID6rUN2Fo
 woEo0Li4VvKf0SIfaMmYqWdYjxnX1TpxYNV9YVWJ5SmGE76jjT9voCdKDrkKFfhNyMSXff2d2o7MxL
 n0bd2Y4g2xJAL/gzWJ9tlY8LO8VulOkpmq3Y5f3QaS74S2rsm5jNfNed6G/mZDdbqnGsWAhqjGkt++
 QmHxKLZrLN/Rtt/PZeIp3iqyVc/h50yb4QS6RQWI9vya8MwvDsvnJjJ6JGag==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Examine the stream headers to figure out if the device has a button and
can be used as an input.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 7518ffce22ed..cb90aff344bc 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -18,11 +18,34 @@
  * Input device
  */
 #ifdef CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV
+
+static bool uvc_input_has_button(struct uvc_device *dev)
+{
+	struct uvc_streaming *stream;
+
+	/*
+	 * The device has button events if both bTriggerSupport and
+	 * bTriggerUsage are one. Otherwise the camera button does not
+	 * exist or is handled automatically by the camera without host
+	 * driver or client application intervention.
+	 */
+	list_for_each_entry(stream, &dev->streams, list) {
+		if (stream->header.bTriggerSupport == 1 &&
+		    stream->header.bTriggerUsage == 1)
+			return true;
+	}
+
+	return false;
+}
+
 static int uvc_input_init(struct uvc_device *dev)
 {
 	struct input_dev *input;
 	int ret;
 
+	if (!uvc_input_has_button(dev))
+		return 0;
+
 	input = input_allocate_device();
 	if (input == NULL)
 		return -ENOMEM;

-- 
b4 0.11.0-dev-d93f8
