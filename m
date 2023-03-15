Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA596BB2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjCOMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjCOMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F39FE6E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so74878025edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN9dk0TN64Mo7WHVhpVGbABaRx7Q/q6Pwknupu3adDk=;
        b=Gq2Mx9D8fuLbueJb+f/zY1iLDil4UkqfW0MMwJ5IKoCwEcDhtr9BNZ8ysOnMrtg0yH
         G6hfWYP2T9NqIELhpG4wmR6FJ6SSczOsc/h5ETKoH3EQC1QV8sKPIjvR7uj9hR9QaY4A
         f2b6c1LEnY5wdGNriKYYvjdHLpUccVPydEPEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN9dk0TN64Mo7WHVhpVGbABaRx7Q/q6Pwknupu3adDk=;
        b=Wh7lGBK3FNsZi23dbDvxBvpk9LdkncquADfv5Zg4vhW83vjWCv5/WdhIALHlgD4zRx
         F5t/0LqufVv+lk98y3mRITPAAQDuENIhYrMHJef1vqHKLzi65nGCHuuj7hQZuJsLMmih
         1IsWS3QVsYuxf2PrwHSrqQsAw+qKXd75bheCWIKDbSeqf/79PgrKJhHB6ISLbQRlUsJu
         nMLrR1WYfgt2+kf5AeSZe0mXjf2LIcqLTs9V+Y19RA6peCMJJ4/CNLwvO4bWGrHB7F0C
         Z7Y0Zoqv3V8xMaa9Eb6Dze4hu9VFCG0Sby8ELFTRkixCyrLtoI1+G3aEHKT3ajmVRN8D
         3V6g==
X-Gm-Message-State: AO0yUKUCrTgxvAhVg1gpdPCt/aOBnSJol9ZomYCRkM8k8XDhm6c2GEcD
        AG82Nq3SZSQl2TijwzVKB4RkDbNRSgJmfTFRYqU=
X-Google-Smtp-Source: AK7set8Tjvu6jP4xr0zFUSFxzqrD6Be0Lk+05/sKpmLx1SneJD4uOMfFIa1n/infgUFg1bLbjzLReA==
X-Received: by 2002:a05:6402:1a27:b0:4fe:97a2:4b86 with SMTP id be7-20020a0564021a2700b004fe97a24b86mr2549451edb.8.1678883761818;
        Wed, 15 Mar 2023 05:36:01 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:36:01 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:40 +0100
Subject: [PATCH v8 4/6] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v8-4-0edaca2e2ab3@chromium.org>
References: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Ka10ItjemOVlrqrWVbbdhzTBAJcpymfvLrHEyyU17oM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbun/QBdadLNvepqccbbDRz3RNClgucR14+xqoG0
 FCPAZmmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7pwAKCRDRN9E+zzrEiBPYD/
 9Dp/6Sdm1tJh5mpdas5fMyoJI6E8BxLwH2bL4qlhWeJwcPAIG4B082jdRdDEmX/352uL9YZQ1KirlZ
 8CcgEqdCBBCG/LnS7ZAoPXGXJhcv+sJ+YW3OG/FZwzzaVYoFoNwY9Pn63qk5BioWJWYkE8Ga94/v9P
 NRwyc3ppw6MdSkNKcaCuFxyacB5723VvXTr8/gpbsMUkCq4vv/aneVhLmIWFJdW1Zf1gLO4bojKBI/
 SRhdnCdEKuG+Yy1MjuV+xV7GZJe9jgkK13z/nv9KK63x3mQCd0npDM0mfv0GiPwmUXiBtkANrULKQr
 aWTTf60BUgMc9EdxY7Dxm9Pry6xESQT7LxyzrkAsjs9FRAUkFbwj4R8I+QJWUEb38QOZQDaXiBZ3n9
 pNwSI/9giCudGV8QMSO/rrkss8LV5B/U6PyPHNSEvZIIbIOcsFHsBSuyRxU4kl12C/x7OJAuLfxZ7I
 Z6qKa6LYm7QIegzHi+uU0qkUO7qgEJYWR25bkyurZdLi2Io5FzsHiEzXOH/sq2cUUVQnFzz0VtVWBx
 HBpP3b3hfbg2qzdMv49jm+xtSF3Z8cuGGmDZItZ1nwKzMuCkE2FnUiKMSxRJA2iR1SXldym8SmWZKZ
 oD+G9b/UiEb+PXxtPCj4vqP3sPwd6rls6WudgMPR7eBlxSn8GCcFa27oAKSQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 4d566edb73e7..6d0243ea0e07 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -754,10 +754,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
-	if (clock->count < clock->size)
+	if (clock->count < 2)
 		goto done;
 
-	first = &clock->samples[clock->head];
+	first = &clock->samples[(clock->head - clock->count + clock->size) % clock->size];
 	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
@@ -772,6 +772,17 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	if (y2 < y1)
 		y2 += 2048 << 16;
 
+	/*
+	 * Have at least 1/4 of a second of timestamps before we
+	 * try to do any calculation. Otherwise we do not have enough
+	 * precision. This value was determined by running Android CTS
+	 * on different devices.
+	 * Dev_sof runs at 1KHz, and we have a fixed point precision of
+	 * 16 bits.
+	 */
+	if ((y2 - y1) < ( (1000 / 4) << 16))
+		goto done;
+
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
 	  - (u64)y2 * (u64)x1;
 	y = div_u64(y, x2 - x1);

-- 
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
