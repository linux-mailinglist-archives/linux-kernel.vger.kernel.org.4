Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01E766991E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjAMNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbjAMNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:21 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A26951E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l22so22742678eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIYSq+SG4WtbilzNOWYagt4DvEBoOwZmBVCbkxWrmdg=;
        b=Psf7tBaJ4kUzf0xvoPiWTIUp/xnmYxZevQ6ZlF2RYXkljmHGkAyZ+3rU/Ykwng7MeL
         GFT4jRKvJT/LUY5LDmcTukJ5b68E0ywQG+6EQDR6J4Rw9zbm2ROUc7by6meEkx+aOmTE
         /q17Fpsz/BPRntTDr6/imThxAf80cbNjjx+hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIYSq+SG4WtbilzNOWYagt4DvEBoOwZmBVCbkxWrmdg=;
        b=FUwpqdkP1r/3CDPLWb726EIyXlwLA/fdiZOT6dLh1QaOFh7V3zTPoi4jceb4sKRevc
         1eYjGVCxrYzLINXUT2mThXQK7m9w4P6m1FF4yi6bea8/dQaz9wOrXSeeG2omAdTI/slK
         OK1ubmgGAepgsH275gIzuXUYsgX/RliRfVK+QGhnqmrdW07UdieBiL24tJ3/+9F9jhBU
         8cC+KI57fJJ4nGH8JWiJ7XmB7fl68pGk5ehvBt/uPdcPxCpqXEqC5wctDYZYNQw6fJV5
         udXLocAOk7Nmtg5JRnV6QwM+WiELwub0BgKgGdVtFDhHQCADLJ2rDyTKvhTEEnrnDjEg
         7b3Q==
X-Gm-Message-State: AFqh2krMM7v2NfVrVOBP+q3CGikd8wk7buB8xkp/2Tw+2/wlr9J6gSe5
        4JHJ3sxPLtedF/dPQQyQzQLEOpdDs3rEJ8WNJ/o=
X-Google-Smtp-Source: AMrXdXvVSF0aOYTYEszDFBVHm+AelHcJuzDS6lm5uyEPGb3LPwSyG+qOfiy2Gr75vPbH5JS4td16ZQ==
X-Received: by 2002:a17:907:8b1a:b0:84d:34a4:46fd with SMTP id sz26-20020a1709078b1a00b0084d34a446fdmr3495226ejc.71.1673617745694;
        Fri, 13 Jan 2023 05:49:05 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b023:4272:bddc:acf2])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm7072888eji.142.2023.01.13.05.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:49:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 14:48:49 +0100
Subject: [PATCH v5 3/5] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-3-660679c6e148@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ze5myykY7IWxFl+shu/B7fsc0sNffBzVSl+RqFnttm0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjwWFJsRwW22gkHsLnSkRocTuSoJA32f8kqplaGddG
 N4YwKziJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8FhSQAKCRDRN9E+zzrEiN9VD/
 0XTWp1wD61yuxVx7AJoIHnpjTRZO9X/JAVF2G2p0qj14/oeLVkL9YnLryvrkdYmxnPAIzJUtkroCiN
 X/eegUJgccziHt2GXqQVm7oBEcOehw2R5WKkoUT5WY7cXOv5rqfedIya76MxqGcpAQfa4KVkX4eBQm
 QqUvRqBKcBqKryviL9KXUA1zKfRx6PaMMIV/5/OXU2pztfzXjlFIKlntYu08rLeKVR/8upJlEdN0+1
 XrfjPHP/PKM2qCY5bTV2siH7/y/QJJ68VFxFLkylkRWjIwgIZP3k0BAYiiTAStlQAz5Lqu7ia/Xg6p
 g+tc0xduyHVY1fOTWTf2TYdeaaPiBVFdP0R1m+8ubQ+23SNo56/0TEqywOgDkrgT6cIoZWE4XKyI/Y
 0cEkwuMnBbL7rGmTi4HMFsNKapWZrtBZW2YRe9MhUNQEtl0UFt3SpQiCimuu1ECSX3N3hQkofgop8B
 DqOKbGlbhdoyeNgk/HSx1AX6/4Zn7NHUC4YYoFYw235Xr5NCItFs7aUESZl5U3r8nMPsubCpsWHjCV
 rZRpLurXrSJISxwTCX7OH32f45YY4ImJQWhKJlAQEBsBugv7ClLGfvi9nQybHr+VNTMZmJVUK5w4HO
 1MZIksNsbbQ7l+iYvFa4z2exrsAbDlPWclFqxV0GCwCZI9ysjawGZrsZ3k9w==
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
index f4470f6df45c..21985598ff5b 100644
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
