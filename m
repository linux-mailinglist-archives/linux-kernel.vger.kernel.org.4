Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F76B24B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCIM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCIM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:57:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6CF2093
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:56:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so6625579edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678366569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMAXkHtzZVXUIYSgEhnqVkH5iil6F/pIxroVXvOBotI=;
        b=NsOgtDKW0v1J0PerqA4rmY1XfO0Y8aYIdvklcqGgVCvR83ZRI+T1ckbqPde7SpjItx
         gZBAl/dC9Zp70nsZFHjiQVXQV31jLl2CZih4ew9OnpLk4msTY5L08R6EbSweVigzk4/x
         zBv0W9g7zPyO52SzdBC3UUZIkoKolTMa/huaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMAXkHtzZVXUIYSgEhnqVkH5iil6F/pIxroVXvOBotI=;
        b=RTZ9tnEhxQr9qR+UOF43VIzsKBOAz8X8RKATuoQJc9lj26Ew4ATvPrNmbuP4kmDwvx
         +UNsKLxujc5cojxqEGQtokK27mQA6CU19b3I3eYA2lpQtd7hppdZ46ePPXRGNfwaFsCu
         fx2nuPgr5QEqODljI2X+hGHxp7893GcN4i95L4A/TBvrkw+gHomMXSY5rMtgGPVoVfbJ
         FaFRvrm+7onHVv9Gcu/UDzK022j29Khx2IoxE3zvg/hUHxFU8vaj16SMzDQTz8OB5T6i
         ZTykhC1w3d3S9VP6zvISamQ7JKNClfiKfIFu6mG2w8AC//iLdHmoW2SbroIVQA8ZCfeX
         RxSA==
X-Gm-Message-State: AO0yUKWTRKUFxQXdwJpy4oiGNAC1Lu/nr9QcHHWwQV3/uhoieH9eCYXO
        cPciESmVTf4jixfvsQQWw0YdfarsNREwdy2txHygPQ==
X-Google-Smtp-Source: AK7set8hnCjeT/yiz3LZDqdTB5UAJ3v/QGaUt9MRSSOzmg2epU1SY0oae/2ce+pf7J87ffwSh1sE2w==
X-Received: by 2002:aa7:d357:0:b0:4af:6a7e:9218 with SMTP id m23-20020aa7d357000000b004af6a7e9218mr21053463edr.42.1678366569494;
        Thu, 09 Mar 2023 04:56:09 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm8799523ejc.37.2023.03.09.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:56:09 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 13:55:19 +0100
Subject: [PATCH v6 5/5] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v6-5-c7a99299ec35@chromium.org>
References: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BkEYNPgQFikUx3ehYbVZ7ucDEzERBb5OFmbVLs51fjc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCddiI0AjI40kE9YpN74xp7ZzsdAfpfwQMB18nkKv
 Rnn7RxOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnXYgAKCRDRN9E+zzrEiJLqD/
 9Sln6eswFHpBkcgQ7zVvZmsAAMSt6u2TvjDhNj+uKGB3T7NgPECGoScjtN6mQ/ALrk9TjEQ5cA/zpy
 syX5uFtWEb00ZX0Jz1E4F5Vg/tUXDRrhqxiyf+p50JolqVhmronpTAnxq7loh8HDgEVGaMyHSSXx2S
 urhUhVwW8ztFtlSvK1Nfn3FXjg/tunhga7KHWkvPBLQdIPBtgnx3fnO8TnYGx/WDn9C2ra/kbJ9sU2
 8ByWavtyo3znu8CE22D6RQ+NHo120lJO3A4ctKUFfqUb5hgWpPbOzRzci76B5FExqpe9RJsEzQLD04
 /X+6M0be/U0DS+zfTFFcEraXCaclrhPakiNTEcwQOat/Z5APbkXtlnnRtLjulysbS6fQdoDiIdMk8Y
 jNpi1djE7ExfSaZsHCKkI1fO29wWF2dkvqk43GFLyaxuTGdShzgaorgDjK/pawjFbNrqDuXG56eOYl
 RK8vNpdGgP+TOk1uIOKGCNvFuxUqy7zAXWuZr07tIGdncn49OAdtqPRKitBTJsGKOJBhaqojBYRK5Y
 tGLnz05oQplnH+gVAL/hCqxWUMrjxqpcM8+3ng/LqZUqs7M8noVEVMQBBjooqIwyMNN2lZJmawR5wZ
 ewqPjGqziCT25lsatxFJRGbL2ABYf/x/jwQ7mw8VTHGAI0KjjtCcx3zq2KzQ==
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
index 0bb862e8c803..6f2bb0dc991c 100644
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
@@ -605,6 +619,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
