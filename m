Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF45BE846
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiITOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiITOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:11:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7561733
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so3999643edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=otqXP3UDAqjwrNkT6tbklT3BOOMLMfKuSbWuAvIyB3Q=;
        b=TKweVFOpI9p8Vp6cWi7bgg8pot60gzt7WyOsIDFJBOKXjv/Dxi76vEV5vHkzFwy2G/
         hLuxoIe8ZirS54WicUWmdKasZAmOpA7VuTZ7F3wNQYz96YFVQGns5d3fxNEmf7EuZ9jQ
         PUGIcJlCbdXxID8v/LQWwu3cViuIFsZr61MaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=otqXP3UDAqjwrNkT6tbklT3BOOMLMfKuSbWuAvIyB3Q=;
        b=v94Q0cf9D+Z9qHFTbiO+eS1vlcmEn2ZwBLP2ma1tbtxptvE5pS9ImsR9Mx9UGBGKq6
         mMk/bhmcBo+Op5MOmQvyDdP8z44XEqiQpNx/Rt0nLvZu3yRUZP0f7BtZbzgKuCnek+79
         ViWHOlM5mml32BqaGADRvyttjJs0W8J/g6Ds6MZfh2higCS8e5NXyZstDIQIC/JTapkP
         DKjOFBCY8u0DhuwNlvxGa+c9t2D5Qb2L/HuUUrohvioZTpG+QGWvVC4Wte32RqjFKMyp
         aiA7V+SwD8gjv3Bdw7WJZzLC29YCs3heCNpmSMGG+NVaDLUBH1B/hv+o1UaY7FQuD6ff
         6uEg==
X-Gm-Message-State: ACrzQf0EbIWRlUMS1rXdhYLx3xCmywpvGViUc7jObDt6EdsnxQD+UnFF
        f2UY2UF02e7nXK35sAbWeHIN+3HHG4lmllIoe+c=
X-Google-Smtp-Source: AMsMyM7/9So581DszjW7TI2lyf+LCAyaJaM52nLK0K9iZADI/LHlSWWt8mKmZvlo8xCP+Iu3whr24A==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr20086554edb.102.1663683004230;
        Tue, 20 Sep 2022 07:10:04 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b0044e796598bdsm115488edv.11.2022.09.20.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:10:03 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:51 +0200
Subject: [PATCH v1 2/3] media: uvcvideo: Refactor streamon/streamoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v1-2-123aa2ba3836@chromium.org>
References: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
In-Reply-To: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=UulBAVr6hwSvCunfG42JRX4U7c6yd+7PeOGh82DVhYA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcm1f3I0JQPFAaDRAu32YgWda+JXBaESB3kn+i5K
 Fl280rqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJtQAKCRDRN9E+zzrEiIikEA
 CcqM30IqIshzzupb/gzLBEe8bV5HX1JYiWHwQ65tPSYrweN2UVoKqaf/xjlRrvPqvjS3xgU1autuHb
 9kGaWj1A422CNNvfsHGNJv/KAvdq8Hs4lqZVagMOUvcq3qH71zqb7AL8iZ9I6B+/mbzo0sPQhzPMLJ
 S+NE+lGguNa+bQge1C5sMPyHGF6Lrs1vGJARkkh/KllZVptUNCHqd6A5eLOVpxuFAabUkwDvkCTeuA
 lkOE7QHmTugDrB8Ht79T0lr60ztlEsDPmqaSIaOnQMXRGS+t++7WJhmHvAFwK/7IE0+1vKdsWcaPHA
 4inVOMbLjxECNxVMHP3X2PPYU83sDepicCabL7+oQqqfdgP5uirEeYWFtxfCMcs4eFMWS5mDhpnT4q
 sDuCwJn+FHJ7wm/zOGnnYesQWo7pfDmMiBMFfGoKv02PdKpMG2dofSireqhQlBlOLj0rKZKpiPkQ4D
 e8Iza9wNrRC8rwBYc/D5qQ8Ba4dGqkW5Aj09fqaBWneRiHX97Yr5kZF7Hn/zBhYkdEHZ2WqVuvwviK
 BEuwzLaq4CKvFmZaSvd3MXaM2QSM7Dzq/ffRfUkifKmvUMBU2Ng8YuG2CQIyWPlyXfoYD4/7BRG2Sp
 mmo2f38YAzzStrHHIcptB0OuDtng2P/iqTUXCMDptwDz4LcXccvC6DSQxu+A==
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

Add a new variable to handle the streaming state and handle the
streamoff errors, that were not handled before.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 4cc3fa6b8c98..8d5002543e2c 100644
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
index 24c911aeebce..caf74c87aaf1 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -725,6 +725,7 @@ enum uvc_handle_state {
 
 struct uvc_fh {
 	struct v4l2_fh vfh;
+	bool is_streaming;
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;

-- 
b4 0.11.0-dev-d93f8
