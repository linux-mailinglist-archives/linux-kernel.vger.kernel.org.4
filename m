Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29B6B39A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjCJJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCJJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:06:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9880F112593
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x3so17575252edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678438936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xnm0YfgvCV+Ipm6xs9Mtjl0Q+VTBw28sf5U+arx5bb8=;
        b=MZri77WSkYEyxC5HlP1IFuaW3AYi3chr9mQhghCiMLqfSj8Op8753JyQ+sP6jCVbBX
         X6WYRTE7y5kJ5xuHCV/CMqVloSssG0qaTpCBjWmwXRK98gc6FwdVjWIF0SHnydheijRA
         IPXW2HPRgLVpdx9k8ktWDKm3hDi2bmGFYaf/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xnm0YfgvCV+Ipm6xs9Mtjl0Q+VTBw28sf5U+arx5bb8=;
        b=b5ewiCi82BC8bgOzi8F7jnboA7PmtM2q2U9PHNp2n3hTaORZORpKmtHF9HmUHUQLvb
         sDOZH4RRWjpEji3PiszD2fo47cxOm0lbdvFdpFzkLrWTXXVEywJ2fXue5UH3eWBpyd+C
         n0uWQBGp2+2gE2aJCrbCTLKN1p0JLyBjZZZExg9xkLvA3Ya8tUm/3X14ziURgcemg1bv
         TJ5FumVLmHs98vLiX3HUeZt/7rOVgqWuLUaJVuSXkDwBzDmcUZDpKZuLyuxAzOBZd7D+
         YsKPLKYrqe6m7U7Mz+WbkP5LASKdb/dBjTP+0vznxkgGyhJH2sEiG7Eiv/ZgqcteYd9R
         wvjA==
X-Gm-Message-State: AO0yUKV1o9AOQDATJCrUUCgDjxAl9Xn3lhYBkhfqareV0zLoN7psKep1
        JjrH8+RdgAjpz5ystXOJ/OGP/A==
X-Google-Smtp-Source: AK7set+GWN0YNI3hB6snrIv4co9cLgbNHNwz5c1pc74Nkl8Zth62IfdQcLIoOo5krx7RR2duasVxWQ==
X-Received: by 2002:a17:907:c0c:b0:8af:2cf7:dd2b with SMTP id ga12-20020a1709070c0c00b008af2cf7dd2bmr31570396ejc.13.1678438936082;
        Fri, 10 Mar 2023 01:02:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef69:7ab6:87ac:99f])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b008b23b22b062sm692931ejq.114.2023.03.10.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:02:15 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Mar 2023 10:01:33 +0100
Subject: [PATCH v7 6/6] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v7-6-cf1d78bb8821@chromium.org>
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=QSOtDi8Lpp1WwCcscneU3GgnDWNqfm9La5ACGKDE/1s=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCvIO/4kYmLvH1iiWCJT+hFKLcOK8Wi79IHBtmT/M
 xtdiMKmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAryDgAKCRDRN9E+zzrEiLBTD/
 0Ryz/FeiC6LVOp07enO0v9qf4Yw+/Lu6WjBWFsRm1oOxcANF9lL/mkE2Qd6SqcXJf1QXdBfy7udIUe
 iwVaULNUu/VVWWskPMDTqswdyiqbHHf4+B5BHzWTteEvlmipjYbHcmsRxh7i8IJBBMDiE7vIJ9WXd4
 uoD4xc05qskdOKx0lYis65D7w3y6LY5jL+GmXcJdYtu9dYYXYcakIfS9XoMGnMyip4yiBTgsRvXTGM
 NH49PIao1aOkOoX8vDCo6R650JNDAq0B4Pgz0hiwgg8r/CpVp3vGAKD1nItbVV9XFcrUPXwK5ecxjv
 eQpK2zsvMm+11YYPEWQFsO/u08HcQhw9t6fg7/zGUUrfzfilL+ajc7P48vHpY5LNBSBh9B6am/JOCc
 e390J6WA5FMP07H5LlchX1ssgjSAh4u7bIGcXprxx2OzOwGgad8y3feYSZ5GSGhmRE/3cU2+DFky1F
 499RTkiyJQ/C5QEDoxJtslOqo9yxOa7hMpBEWJ2+cDqdW/E31+AxPizo0RqLYZWgmrVpk3PIG12AOd
 4jg90tUWWXxTde+4qr08qyWBE8L8doLVWrZOgc9AAqwPptrURcfjm1ckTSPDYbj/UOTTxGpnehQFYR
 bnbq0uhBZnz/Gkqxge8yvbDbZpfmISWGF1eslE0oy8a3E1TvPH4ipZYIV8CQ==
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
 drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 8156efcf48ac..eb1165366fa0 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -473,6 +473,21 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
+	/* Delete last overflows */
+	if (clock->head == clock->last_sof_overflow)
+		clock->last_sof_overflow = -1;
+
+	/* Handle overflows */
+	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
+		/* Remove data from the last^2 overflows */
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
@@ -605,6 +620,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
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
