Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B46BB4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCONbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjCONah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17537B58
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so75449475edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5B0qoy4xzYyHKiW419Q3keWH8TLfCy2QqjxB+rQKmY=;
        b=eDuZrMTZQRkFCCKAVBZ1yDVVPQuq+yVVR1dwL33dDy6kjAY5yuDtq1vMJ17exZTVvT
         nPgfXww6zGjvgRadPsNBxLbs2IglY2laD0zpXV5nP6i9Kvbv4VIZ1ZO4IlprXACuUA5z
         ZNVVurZs3N6YgnTj9oKH08G7QK+blLduri9Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5B0qoy4xzYyHKiW419Q3keWH8TLfCy2QqjxB+rQKmY=;
        b=lRnhsRkJV0u7K/4g7SP4rgZOWUpNINjcjJkZZlxzPUHJxksfSN4ak/vfD6VknTMY7y
         D/mYzspRNK+FsQCJeG5oNNTxw+jQ0Pu+ogait/iVrlToCW38UVwZxG22y5/e7BlmGHrM
         somJ8B2IyWDEgyE5EPMTMbP0kc6eH0HDn1dCCTEw/0Wnw5gBXpblngDix7YVD3U8XTtN
         VBvkFvzVoVZbRR/ARBfrnWxo7dEdG36uDFrMOqCoSlbIRCbnIAr0PGMcMtNJYi41tpJz
         H2CMQZZlHoDir8Soon5PRvmxbJWYnn7z+1azdQebtwBk7RfvJT93ELEYs7h99mHr51TV
         N20Q==
X-Gm-Message-State: AO0yUKX12ip8dYaCunj7z+IWkm+JHLCC1r4pJlm0gnNG+ZEvisAi9GqL
        wIzyfcoX7D/p1o0Q8iy5rj3iEQ==
X-Google-Smtp-Source: AK7set/0Gqcp0PUhCw2srN5+7w90EXouNyEdBKyHEctHCAQW2NuynKrzEXN6u63V1fR3kTO2uwlp5A==
X-Received: by 2002:a17:906:bcc7:b0:88c:4f0d:85af with SMTP id lw7-20020a170906bcc700b0088c4f0d85afmr8035808ejb.75.1678887030229;
        Wed, 15 Mar 2023 06:30:30 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:30 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:17 +0100
Subject: [PATCH v9 6/6] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=fCG+oG/6p/tn1lzkSxpwZk3Rj+eiISLy+hRedLVdGsQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchugQqeZNyZ6DJj1IZ/0buGF2GeBZkLFQVks2eb
 gBmN6LiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIbgAKCRDRN9E+zzrEiPkZD/
 4omsHCqeQYnAUSpfL3GnIT2BJqCAunmwFKnHdD0FB9IzhfTUorQnctbqToZlfjD6XHniSX+wkRddXm
 7HhDjMAnSLYLWCNkRv/9Qpw2590qvZ6cE2OYWwOM4ZDbDlbH4NjFkCSusH1urP6Y9sN1Y8hh6g2fsv
 WKfqMTCMUdD13JdTyUBpO/FeOFnkZe9UKRsIzP+0kpCyIKJti4RrRthD+qyO8ll5eIoNjxwDVLfMYS
 j0i3/Io3XK64BdHkkWrROqhHfZ8kqVVExPA6p7cBz6NEmby2WiOY+5ad+Dl8McF3KUBF9H8gtChv9g
 eGayxIFoJefeJy7u0ZnB1L3otr5j0h9311axpx2XIEYtWHgAKIWjp436t5A9FYDiBYNvx7j0vS6WSM
 WDY5MWHUl2m2OyjbA8lXlKTaO3Ga7vJUCdcSsW0SAiKWzkt+6ORAVvcYk3Mt1d7w83J6N3Uc1CYWxG
 ppn6CjkgloIawA+YIsuWFYaSmQCUfQl89ttEgDYvbUVZEySSjHfyPnIPR8NWCCy0GykTlsT28LCnMk
 vyqfBS5waUf+xBW5vZJZVqWhDsnhmrPhCz84TtIUhZDyD+oJh6hPZHQTO90FmdLo6/kKFLkzgjOX9a
 V8DtBU+G4AS1FeNsqdOpCogLNXRwuoNJ5ntpOlm3MgZYsvwo59bCNmRqtrqg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1db0d1bc80e6..c58b51207be6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -471,8 +471,31 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 {
 	unsigned long flags;
 
+	/*
+	 * If we write new data on the position where we had the last
+	 * overflow, remove the overflow pointer. There is no overflow
+	 * on the whole circular buffer.
+	 */
+	if (clock->head == clock->last_sof_overflow)
+		clock->last_sof_overflow = -1;
+
 	spin_lock_irqsave(&clock->lock, flags);
 
+	/* Handle overflows */
+	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
+		/*
+		 * Remove data from the circular buffer that is older than the
+		 * last overflow. We only support one overflow per circular
+		 * buffer.
+		 */
+		if (clock->last_sof_overflow != -1) {
+			clock->count = (clock->head - clock->last_sof_overflow
+					+ clock->count)	% clock->count;
+		}
+		clock->last_sof_overflow = clock->head;
+	}
+
+	/* Add sample */
 	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
 	clock->head = (clock->head + 1) % clock->size;
 	clock->count = min(clock->count + 1, clock->size);
@@ -605,6 +628,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07b2fdb80adf..bf9f5162b833 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -499,6 +499,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
