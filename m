Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76C669921
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjAMNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbjAMNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:23 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DD69525
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:09 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk9so52475021ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDfjDeTst6OQxRVhR2qypSB7k7XxFsYPOvv4qs9VTxY=;
        b=knAfm9vHU6HiEfv+gWrWbwIGU0C9RXL7SSqRpLkf//zZYBgXkmztEsQYrNOvz6nSuU
         Mnc9MPPtOhSg+BV/ZLQP05GW1CQRoEIjJYyUZUVyyyT9qaajgokS1qEcINf3xr6eOjoB
         ekkr2py3iWWrMxt39pNGi55cyzez2HzjOUQXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDfjDeTst6OQxRVhR2qypSB7k7XxFsYPOvv4qs9VTxY=;
        b=lB2N7WdjFDXyaPnz6JR7euRWtsg/uYWGuWw7OzehQr2vapjIjvMy2Q+EYVKRXr1MDo
         oZZJECmZbcF+pkSYN1IecQ1SeB30FxrvH8ecL0eog4MNvHcY8Yqy3XWS+CjfzmULrFYh
         LYLBPFRLUTvD6pJKMCexTvnQnYKHS5btYAkqzg+IVaxJF7bj56p4WnHbH8F1iGu2Z4u4
         3KG4V4wq7eYK09sBUeraXMsQ647Mtuse1oBLd/hnDTnuiOPWqBiAriu8rVscbsybMWKZ
         x5uE7wKiNk0ZD/wBmZLSuUZI8djROGgkTbPnKBqqS89avcQnhfLWu3ZCU+eTfu5FWYwj
         Vicw==
X-Gm-Message-State: AFqh2kq6c5RlW5mY7FpBd3PAzq9tz7i1m9dPIFeasSxXxID3OZrUJOgO
        DxP7nd5+xmrE/V7CekAvYAWF3W0dRxVJSJx07DE=
X-Google-Smtp-Source: AMrXdXvBPvBk9VIhr4SxUH4aKpo9zMpYGavW7m8bpOGxZyp5UOcKx++aEXxOYY14/dZka+TAryI32g==
X-Received: by 2002:a17:907:d312:b0:84d:3543:fa7b with SMTP id vg18-20020a170907d31200b0084d3543fa7bmr22367374ejc.54.1673617747573;
        Fri, 13 Jan 2023 05:49:07 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b023:4272:bddc:acf2])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm7072888eji.142.2023.01.13.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:49:07 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 14:48:51 +0100
Subject: [PATCH v5 5/5] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-5-660679c6e148@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=78AsqBPCn9SSTg96NmP9pgJexa1mmA+uxtg7QUEhcrg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjwWFLQMt/hm9dgwBbvtkC6/YYapOI4tQlTEdEbj/n
 BT8kx8uJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8FhSwAKCRDRN9E+zzrEiKteD/
 4pR6X/2GxhnuA2bKPD6ZrG9DiHOPaonuT/jZsm6Wj7UCTOJsQ41RCFqfLkdl3DQ4xuERRvjkHcTznj
 0CcJ8p6yhO6GGa4NctZGXAj3MBSsRUVkeeHhCd5VCGaYfBcuhLbHJIljtgValjqnoh7IuTqxgJPWKw
 j172qlY7ZysYOcQGX5Pj/WZMyHA3ZBQTVx3voDEmG0StmdlbCq8d0D/C829plELKJ7DFlsqNapEFQC
 uKauAa/6tgSpd9QEyeqTJ+eGVGO4YD1CAikeQlTOVSujLFUUeMkOFQwlGyi+m8ROcHm2E9bUMn6TOy
 xhgIO0F14fClachp79yCkO+uRvhNq51OlcLDZ5uOtlY4CaSN9NfFnI3FSjqJRcDko//WRW4Sru9hBP
 jwKONpryM3GhC4VUbW5r5gnwB4OPSEZ2sHKxL5i7Fkzoapzi5R7SjA8dyrMBL6u14apAA7I12IAA9J
 NJzOc781CxMGOZh2gP0WwFZs6Yb7BKY0nbS2BYCPYyFzYy0i8uf26GCB7SmXu4WKhcYEZ9zpHm5yqT
 QeO1vfzwk4WTbBTs6IpW4kswrKJ2Wc4V/m76Mlh/LH/tccCnBgOY+LL+hMphKwep4Zf1ZUV9debsUB
 vy0hwGe5pDX/ZNdJRE6Yt0F1pBASpnMVcyur7+vWzz6nvB/G4coLVIaSbqwQ==
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

In UVC 1.5 we get a single clock value per frame. With the current
buffer size of 32, FPS slowers than 32 might roll-over twice.

The current code cannot handle two roll-over and provide invalid
timestamps.

Revome all the samples from the circular buffer that are more than two
rollovers old, so the algorithm always provides good timestamps.

Note that we are removing values that are more than one second old,
which means that there is enough distance between the two points that
we use for the interpolation to provide good values.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 22255bfa7db9..ae692122d5dc 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -473,6 +473,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
+	/* Delete last overflows */
+	if (clock->head == clock->last_sof_overflow)
+		clock->last_sof_overflow = -1;
+
+	/* Handle overflows */
+	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
+		/* Remove data from the last^2 overflows */
+		if (clock->last_sof_overflow != -1)
+			clock->count = (clock->head - clock->last_sof_overflow)
+								% clock->count;
+		clock->last_sof_overflow = clock->head;
+	}
+
+	/* Add sample */
 	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
 	clock->head = (clock->head + 1) % clock->size;
 	clock->count = min(clock->count + 1, clock->size);
@@ -600,6 +614,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 699c33bc24ed..f2a7e1507492 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -501,6 +501,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
