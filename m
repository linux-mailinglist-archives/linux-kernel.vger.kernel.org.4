Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4876BB29F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjCOMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjCOMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD78DCD4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd5so41013657edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Slr8insJSfdVwUEe6a4Q45sxgJgXgNMm8KOz43OQ0Xs=;
        b=hPo/Ij9nLWTtUQSsbtjFexaK3g4XS2eGln6DMJTGpi81jxwhlLYpKvkq9hQt8s93nj
         /vMoVz27dDsz/ad6t2CL2wIPMH0QbUabJVKHWSTTCDKb2PSpf/4rmwNhlR7FDNQjZwzO
         DKoHRP6PoQgF4WSXYXRyv45kPQnir+Kgx9Pvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slr8insJSfdVwUEe6a4Q45sxgJgXgNMm8KOz43OQ0Xs=;
        b=hZF551cjeJ4/RXu/qak0g7VpzgcyrFsCFdsF1xDAxDkEr01EU/9bxM8FjkbGYAD5IT
         JELglVjuu8fjBo0fKo5b5vPIeXTfyPKizkrWvRrD2SH0KH+HPeMouLUO7gRXNtoTePJg
         xIHroAGTViX1KCBE/8bicJFFPbfRrBJYj3yLVSRNleyas1/ukC07xERftK6h4XH0Ubfg
         Eqj0FmIEBiMCMH6FiZpby2ODtfjD+JHO4ysSl6Me9xNVX+jYSIyV/YGCt3ECz1kk5svV
         3QoRpM74hym3gmyyRxVayaj2Cabb8i67Yoh3CyEDZ3RRAtOdl835CENPocH2etXboM8d
         9hhw==
X-Gm-Message-State: AO0yUKVCIvlGInzAtEe2PHGE0fgsmwOfwxCKL2MLfoAL297y23hUm3/3
        RAkf9o/K1kHqmAt+80J+LZkuCdQ6yblrn7VzKbc=
X-Google-Smtp-Source: AK7set9FBp/UmKRbuWD+Un8VtXIddfT8fAfO9cMf6inOx7rg165hd0WFhx2gFsJwhOzI4nRLwpDVhw==
X-Received: by 2002:a05:6402:7da:b0:4fc:709f:7ab0 with SMTP id u26-20020a05640207da00b004fc709f7ab0mr2649570edy.0.1678883763573;
        Wed, 15 Mar 2023 05:36:03 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:36:03 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:42 +0100
Subject: [PATCH v8 6/6] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v8-6-0edaca2e2ab3@chromium.org>
References: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Ty1KoivoioozZ3NBkNDmXru636l8jRamYBpo+xJR4aU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbuqlDTPFsO/18/Z48RLg4lqEUsea5FnBqwmSpeP
 J+oaq7qJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7qgAKCRDRN9E+zzrEiPO5D/
 4lnj72B6VaxjI5uvp71oauX164kDEc/X8VnFOlQlmHxYA4mHPmQqEbubV7m9340IrWFJJj9ei14TcR
 EoYTbkqKDtfSjI7egi34LF+3iceVqGsL/3/0DdAnaiEbgcJkakeukZYBoKAn9hCu8x0Wa5P6nK6Tp9
 HoTQH41nLU5Tpjvxwvu7cY+VhLzuiMpqSEU94jZU3yA70+2Rl0sJ4VMmCr6w4SS3Z6V7eFj3sc3j+e
 kjVIvn5z+NmNvzarwrFB69luw6vRhTBEHurAL4SpqmeqVfGppBCJrXmY7Z9KN2+pDELSGHd1hoDR4Z
 sgC+95AYMRnp5lviTtJ8gSkinHlKWy46QEquSnFoywWUQoJp31AzQuvEdEcSbbsPlBu422m6jdXk9q
 uOiYqUV0Q4AxOihfROe0Bul9gS/0AEdq5IEY5KRwLTQToOdkWXnd74SJZd8bZDnE/jDIBmz0meGjG+
 7DMxdhyDzPzNrr454/Ye7lYCEBtCIfERZzKoBcIAbeFodWT16IbadnqpPgOsqZOkDeed0OfeDyaGvq
 F9o98zXQ2ryUlKbT535a0EMfQr42Zp2ANpGvy/0FglQv/KovbfAWXz0Uw6KRlIBsfUIMr8kFiJm10D
 HoFFEq6eHBy/ZcI7jRKwmISlnm9TVguGempFrz78Su7oexe7aByvItlKxD4A==
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
index df7c400fe82e..1b5510c41e6f 100644
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
