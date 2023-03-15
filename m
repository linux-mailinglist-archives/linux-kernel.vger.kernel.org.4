Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975E16BB4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjCONar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjCONag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1A3253F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x13so28232775edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN9dk0TN64Mo7WHVhpVGbABaRx7Q/q6Pwknupu3adDk=;
        b=ToM7VD9X/aUdz9PzNycBJiRnRHWzb+x6BnG96KWk4BmxIrH4T4KmFE9CHYb8s0VIQb
         OXJrtXCcNpDCC2BcstyhWQMdvHXz1ec6jeO9iUDX3jRzzCHZ2nkxemOfvvAmRudJiLyN
         QwCf1/RCkIN4DcBlo5NFxOciPrhEqFsLnP9Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN9dk0TN64Mo7WHVhpVGbABaRx7Q/q6Pwknupu3adDk=;
        b=SMx+69WyDj58X/8p16J3w1cAjpzql8ACPrLX4idMUfl5l9CGgIDu8JXUMlXuKj//oA
         N/qhY3+ZQ1VbOGjfPoQqkT4IlRxvydSDViKL5+h+UKDWcb/dhElAgd8/uLvSluDR10CG
         /No89gRTLKEJcj8mDxQcAqAk9zZWPqE6micLimszdp94EtEzt6CTdTS5PDmnbRYjAzAX
         swY40yKsE2tbfaDeXuvS/SLUHSAaatbyFaMZwO/VkElZIfRCyQrZ90LHBLsHpGrwOw55
         gFohcmOhOcETjh22vo7Y98iyFhmL65SIEPE4YQOatpynDIPO+6WHoQWem1/NQ758BC17
         yC5g==
X-Gm-Message-State: AO0yUKVMg5k4/zE7P+CC6/KN5c++M/griNSb7Oiw9ritMk7/57sIov/j
        K2QnYT0P9GXQoKeALRVWJLGkYA==
X-Google-Smtp-Source: AK7set/fJXVFSOeuzgSQe2PXs17EDRO4AzvG7/0F1D6ZRxbUxr2mmqfPwktNoM57GF3T5AggYyqHVQ==
X-Received: by 2002:a17:906:7fc2:b0:8b1:3002:bd6d with SMTP id r2-20020a1709067fc200b008b13002bd6dmr7662768ejs.31.1678887028676;
        Wed, 15 Mar 2023 06:30:28 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:28 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:15 +0100
Subject: [PATCH v9 4/6] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-4-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Ka10ItjemOVlrqrWVbbdhzTBAJcpymfvLrHEyyU17oM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchrnf062mGexzCcK14u+qoHjARmKRwxGuNN3as8
 6ad6scuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIawAKCRDRN9E+zzrEiAKEEA
 CG9+cG77r2uDQOhqdDXHVs4vEnubrbB26q41MZuaEbFiuy6ZLyB0Gx0uGOFciMs5BEi21K0hMNBCwz
 ZDbm2aZqPJH3kHIYClkiI90s8hmPQSCHHLCHZZkvrjm7Le8uEjQBSpdP0b7rCghccnwtV8U+nLcY3s
 q1niE+9G7ga4UY0JYZZO5AQdwpVv+FA0fTnMLEb6ovIo5K8mSg+O2u0OzwYFPEvtbZ9FflragtLgJk
 M40o7QlRBq5TcweZHWTImH5jw4a3Qjjt5ceK2rnY10y6OGduFSlDREJxuGt4HVA8N0pCMTNDNELPeE
 ABXNbWzuvNMwbYyRLTnFhSE+SS0efBoi1ibGRP/nXo/T1ou/4i10HKxxi6Zh8MCxBv3A8TtxcYwk9p
 PyqYlZhLNsrKJ6xOCWz0hMcRerkUjiwEbb5s3opkvBBahno6UlrNttSK/iDvILAo68oPbkMXG6kBmN
 +ccwfqLVr99EbK4g/+OafbkXQpePOJxwXbbqXLZNZ8O7tYE0n4BQ3ececLYeOuJuaU7JVyA9MSBOa8
 QvmO18/mJmNMBHn4gX6AFytKK4KzYTLkmBfSJCulz8MvLsMD14QiPaNwaDiP2h/clJiwcK/TYHYwmc
 0mru1B96URZdV3COUAhLsFhCedb0O+ayyf1AUGf/4CsD/q+P7GmIErKutf2A==
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
