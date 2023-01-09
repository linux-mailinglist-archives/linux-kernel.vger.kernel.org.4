Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A27662266
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjAIKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjAIKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79738219D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:01:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lc27so9402063ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEk8qL9j9GreB3Z0ydDIFUEO1M43420PznTeKLvJ2ps=;
        b=XJdAfwMn2pdrHDGnck6otnv5zpVNRzetTCVSx3svDns+hEt7NRPRjuZU5/n1/4DEry
         qYMp/ALcMh4pyjuFAGTMebOItpWF2ck5JPg401/Lj/EmksS/RmU2qTvukRvpUfHR0HTP
         UpXGSc4G5XhCG8BxGNVwfu4cLxLOfI/C3NwaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEk8qL9j9GreB3Z0ydDIFUEO1M43420PznTeKLvJ2ps=;
        b=6UGC0ZQIPic6Va4e6Un+M47zO2Mg8og5H0mlK9OJoTDD0XURCVbgHfLMTC8o0ra0Gn
         DTY26GByTtMCKZS10ns1IREFKMqkz2RZcjxnQYL7//al+ErHt+bFTvoM9OCQwcRc+gD1
         E4vY2s2DY3LQ1wy7hKJDBSzPpVKfsY7C7IlJ1rnInYRqjhiuzsSovdcnGmp9adoxtyg6
         krBm9ARdfIxaqL2dK/g21fO1y/opdiMMXvjYNQFrvyo0bSCoXpCNvBpiRdlQ59AVCQcj
         mGy2XsCp8uaiHuAXlshS2JcT20ou5pqM75W1/bFzujiof/hw+a9mZXMlhNmk0AOq/wB4
         mMsg==
X-Gm-Message-State: AFqh2kr0IQJGl7SAFu+w1uOCpwoBBAzTCb8jZIlXxopeSXHfVB0jIsjj
        Q8ql5jliZ8eMk1iOXQYzdP2paeYC6JZHHZPy9Tk=
X-Google-Smtp-Source: AMrXdXt+cdk401kONESTSPjEYgIGnYuxQwDlwGBJnnHTo6bmZ4OVgf9TqPGgpBEh06udvqQyEFuwVg==
X-Received: by 2002:a17:907:c606:b0:84d:456f:91b7 with SMTP id ud6-20020a170907c60600b0084d456f91b7mr3477815ejc.43.1673258475483;
        Mon, 09 Jan 2023 02:01:15 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:cd22:9dd:6d54:8488])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm3557548ejb.76.2023.01.09.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:01:15 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 09 Jan 2023 11:00:50 +0100
Subject: [PATCH v4 3/5] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v4-3-a8ddc1358a29@chromium.org>
References: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=r85cn+Y4mbCQMerG0X3MvBxTRSX4Epxv+PdQFezSnqU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBju+XkSYv+U+WUJBpzTWS/iUEB+jp4iL++42VSNaHb
 F3WjEWKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7vl5AAKCRDRN9E+zzrEiOmDD/
 sFXcwgZPzie69FGlZ6jzRbqrsZu35Zb2W740oOyD+CPsUTEepeeX90a+7X7cRI6JzTc6ZZ+j8nayJT
 /dC/3QpQLu4lVU+7PX0iewavI2oDS/v+fOi5EhFhuVFfzwFTr1yjaUNC68cIwOZOYKxWduDJQWm6ww
 cw5sEORRp2GQTZ3PSi1WAIlRdeoHuSv9ZeCk/Q2CO69kVruldiJfUSdtoBl2Lt+kEvozGmQRecZWN7
 SnALGg4C5y+qrOKqsN9fdX+g+hpAqmqZowi3qGAeGllEWYsrhptbff1FvY58C1AVMqgF+nxvoDe7Cy
 3DdXwNvpFG9IiDh/cC0gY8+1Qup/qISQaYEp7j7yajxjpUYk8mAx6BKZ6GBLt2SJjc3J6BHnmVdnPz
 ay3SYd4yq/NR642BGH91b+zvFOe8fw2trbE3GxvQAQ3Wko89zJ+iS5BVzumDarQQouXynqIhF+tTEX
 XW6exrvXYAAlEizpOc2UazbPvCJV4hyY3Hom+QXkxV5esksW9J/0ARCA0i+olCdkz5KfKCngco6oYW
 dYL3mSwLDggoIh/32GsH6Pmm7Oz2iptHT9gO9gmek2oizXdGzHJxxik8a8vn88JwE8dw/h5zv881/B
 E2hJQxZVIZNNzbKupjuKdom3X4zUvzshKQUnjKHjgr/rYcFWwcvEH7R0P8Iw==
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

With UVC 1.5 we get as little as one clock sample per frame. Which means
that it takes 32 frames to move from the software timestamp to the
hardware timestamp method.

This results in abrupt changes in the timestamping after 32 frames (~1
second), resulting in noticeable artifacts when used for encoding.

With this patch we modify the update algorithm to work with whatever
amount of values are available.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index ecd3c1292182..ee0f40b9eae3 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -747,10 +747,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
-	if (clock->count < clock->size)
+	if (clock->count < 2)
 		goto done;
 
-	first = &clock->samples[clock->head];
+	first = &clock->samples[(clock->head - clock->count) % clock->size];
 	last = &clock->samples[(clock->head - 1) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
@@ -765,6 +765,15 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	if (y2 < y1)
 		y2 += 2048 << 16;
 
+	/*
+	 * Have at least 1/4 of a second of timestamps before we
+	 * try to do any calculation. Otherwise we do not have enough
+	 * precision. This value was determined by running Android CTS
+	 * on different devices.
+	 */
+	if ((y2 - y1) < (256 << 16))
+		goto done;
+
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
 	  - (u64)y2 * (u64)x1;
 	y = div_u64(y, x2 - x1);

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
