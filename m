Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C4640BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLBRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiLBRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70FBC27
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so7225451edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzFzDnnX9pi7g8WQvEiGHdhzPZgy4R7i/X22w+LEdMI=;
        b=ZJW37MUF8AZ6gWULeaZCcqG6uUEz6GiDhcUhr3cuJ0TXqjmGQGQ/KaERArPSMmZYVQ
         v5NuRaE9CAuAEJk4+fiZAb3B1M/Uhb+ROQ6H7e+5zjdE42H2+rFoSmDtlIcorXvviC/o
         BoTkA6Z7SzYy+iuJ9UYXh4+8sw3+x7MODEjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzFzDnnX9pi7g8WQvEiGHdhzPZgy4R7i/X22w+LEdMI=;
        b=ZQJhCQ1jDOqAgdEbgNMfZ/CUcU0eiDqxHxnlxcDd/mgUkeOU7nMdmE2f6CRPB+ykFL
         6n5v2IGVFC1kLhySkBiUAPSPDwmnBjoHzBBQiDM68ZECtmYpcRwdLjAxjT79eqIhpx4M
         amRen/YLV0khnMtrWx/MWq8Ja6Q1Gdmrnm8yy5VMGuRwtM2yHazudI37piAZgXR1SNeb
         4mkqQyy0QivArgns2K+3E3MgamwIIis/Me1LXasvn5kmhR2vcd/WvOv3OHv49ujDxpAD
         94lImm0xYiJPti6bzE5fjaFCzwXZ5tF7/MfEv7tBUe5nJtQc4gtgXCcH6+a+J4I5tyLi
         HC/A==
X-Gm-Message-State: ANoB5pkgiOhI4MquQPf6O/iJCptzaMWhKAvaSPnSs+5ph5jACawuWK5o
        Db/uT4W6QAzIUvYX+vMH2Yjhfw==
X-Google-Smtp-Source: AA0mqf7lHA+y3zQtGSgQQEOsOTynBhg3rVkN8KO3h1NcrWakisbHptVDJ4C48OnjG+xDUKY+RrqzHA==
X-Received: by 2002:a05:6402:5405:b0:468:4cd4:f133 with SMTP id ev5-20020a056402540500b004684cd4f133mr50745505edb.18.1670000584730;
        Fri, 02 Dec 2022 09:03:04 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:04 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:46 +0100
Subject: [PATCH RESEND v2 6/8] media: uvcvideo: Allow hw clock updates with
 buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-6-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=3Fs3H+ze+0F22wwrtRMwFmFB8rGrRyFOzQuhxGsMqbQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii++aFV/k9m1GdsfCWkMCRxITd6LDxE6DJa5Uc8e
 mePmB3eJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovvgAKCRDRN9E+zzrEiGCRD/
 9rwsjQhtVhBi0S2pt0k3Ny+IWzN/fublTh3yfjMsIAlrEucBUf88I9uq7z7D9OGqfqOs9R54/imZnS
 IRo1BrgKSqPK12ZuHcEDh/f2LP69JM9q9F9SYw2RN2mG8zi8YwO/BT5OP2qSFgLZLHTikUSuWoHuaF
 wUFN60AKltKKp48MCA/KTTH+XH28nx91yVyWJ5QaN2UzNIhOoA1U270tXxAsgwjxiw+68DghRTXqJ6
 84ericULGTZtwenLdIlkHcw6ggOSIhJLTJPsT+J9aqizin7S/Dizv4pM8JaOlrynZHl/AWqc4+TT1F
 nC9h3DocTnNLizd3/vj/+hLFGnszvcZZJFwdhSrlDfkCNUXPBExLBTHn4s819WDGori6goKfZsj/zW
 vf7euVAUB3AcojasWJCoipCGIsGpT8fXw/24ko2BrSp4da1c9dm5QYItjdWE+nu5fHS9qNQZzAEhBx
 +x9750sF/rm7sAPW7IZ/uxRmrmLfHOYbkkCT/eAPUWVqzfFO0Xc3md0yuR6twJ1qX0LAjPzk5TT8Z8
 F+ClhgplynV1MT0IVTeW/sO747rJZY1rRlu7gJGtpIV5dCkaFemOnlAy/+mxu3cEpSsoCw4JqFxtRf
 PUp4TWs3VGwSKH9rEs/pIAQIoZh0AFj/T7fpozfVUWYI8JMKAF1MxqRmsw0g==
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
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 75c32e232f5d..7c6448c6d706 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -742,10 +742,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
-	if (clock->count < clock->size)
+	if (clock->count < 2)
 		goto done;
 
-	first = &clock->samples[clock->head];
+	first = &clock->samples[(clock->head - clock->count) % clock->size];
 	last = &clock->samples[(clock->head - 1) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
@@ -760,6 +760,14 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	if (y2 < y1)
 		y2 += 2048 << 16;
 
+	/*
+	 * Have at least 1/4 of a second of timestamps before we
+	 * try to do any calculation. Otherwise we do not have enough
+	 * precission.
+	 */
+	if ((y2 - y1) < (256 << 16))
+		goto done;
+
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
 	  - (u64)y2 * (u64)x1;
 	y = div_u64(y, x2 - x1);

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
