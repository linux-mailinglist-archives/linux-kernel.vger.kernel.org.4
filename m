Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A165D0DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjADKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjADKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:46:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D819C0F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l29so40935428edj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi0DwAZll32eIad2Imhk1W2tOAIqK4+yUvq5hehYizE=;
        b=XUGMCvUZpPHu5JfUsPHIp5UtuySYQQ3ZfTycNgzh4mj/V20ITnQtNomVDsuiaGJaT1
         oyXvqyxXOzPSCjI19RAp1geECA+s+BlCE4fESF9UnhdxUtljbZ6F0XRdnfRq2SLJUfo3
         pEh1nr6/VLLy05jXwqcFO3AOWX0vYQpAwjwB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi0DwAZll32eIad2Imhk1W2tOAIqK4+yUvq5hehYizE=;
        b=Jbx09rKiyB3dc1PeGuU/XgQ84newufL5cNQ605BNIEXXYdZ0M2QeJqSYro/ePq3YhL
         UrwiAfLW+mXbTknnCXzcr0V29Up8Vm/momRCYhO/1r7XZ0YsI2lPf0lr7QhPmBdrEKKn
         lQyN7v0iF08BDEo2JDfWq0cZ+5PZ2rivvYCsgCX859skjBTBjTH91JWSaQukm7Q2N08l
         H9WFw/XP9tAcIpYYtlS4UDeJCPYvU8hfGRlDMQi57CxBEQjNHq/h1fxtm+RvAvJzJQET
         +d4H/sQenlagRbym5uS9ljHiW+jdj7pM+WpUg1uAN9wkfBwHzssIWYHMndeLj14EejW2
         PfVA==
X-Gm-Message-State: AFqh2kqRZxiJ1Gcpkm1qs0QUmGmumrFlI00PVg9t6zkVJ9OEMcu4SX4n
        SPPe3RJcBrhWy1AyOWaqubNs4fAUYer28Id4ht4=
X-Google-Smtp-Source: AMrXdXvwsKG211BYtshW9rWO2NXmxw73UOy+Sy1aOwSFvVVkQWotsKMhdnScrv560S+ZILSBfnCdAA==
X-Received: by 2002:a05:6402:538d:b0:487:2ce6:2b80 with SMTP id ew13-20020a056402538d00b004872ce62b80mr25256957edb.8.1672829155133;
        Wed, 04 Jan 2023 02:45:55 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:54 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:24 +0100
Subject: [PATCH v3 6/8] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-6-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=A2mJudG+6/05Ux5SJhclsJyARWI+ebtKxr7o7Rpc9H0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjYRSolvHGNsAlK8u96MVXslFe5ioZa0X5tQYeg
 GorUlXmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY2AAKCRDRN9E+zzrEiICuD/
 sHUGrAeWicUm6+W27wgC2bTF9F1cAqj5AXqQ3hu4pmQK+0BSNSMIMxUWPLfp0VeT6BgeSsTkrf+MeJ
 THid/fK4hxg9E2JIYOLYRAa1FK9H/bUbLBl5UlJr2/p74Q9AsF+CuPBFbiOMIHXyLug9hKPzQ0FhaB
 82T33bbRv/p2zlaZ6GyAWafawsT3d/4xZH/Evd+2oW/u0SKSINCcdIW8RtZQeDkEM/W4/W0CbPNt2R
 AkjLHTgG2MO/KQx6Yo4/SIiEbTI38VR/l61+hct7UDdf3n+BliR3cLaljBfgili9qjSK33T31FC+HB
 IX+MjqA/7XMUy+VUpC4xIBu+i4BuHEvsDiPXHIKUOVPi2kZa6iNy8UMdDapJ/eHe2hLlisGfb1illj
 SSf8Nbmc/7HSDgvKEZYTAfqizaEa+JxN5Uxir1q5FS0vlvnea9164Vw/aqIPbhPwEx7oRYPC3Uk7WZ
 3Wy3AbLEucFFFNB6iSDVhbNlBvmCN7jJjzBirgUIUrSY+mt9f1Pk010/hlcI3K2FZWAOPsqXP4jzXR
 GkOqa1/oQkXwLz3sC45FE/zNQsDSTrU83mbG0ka8f0Aq7tdd5IDfUy7NlrocgKB6A3Ap6YI+pI//fv
 TFrzNcXbjAmoWDG5RcekvZRgQU+HRRCp2wpkksqvE6cTo8uLc+nWDnjTgnyQ==
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
index fe5c7b465adf..5c37b080e0c6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -743,10 +743,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
-	if (clock->count < clock->size)
+	if (clock->count < 2)
 		goto done;
 
-	first = &clock->samples[clock->head];
+	first = &clock->samples[(clock->head - clock->count) % clock->size];
 	last = &clock->samples[(clock->head - 1) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
@@ -761,6 +761,15 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
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
