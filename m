Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590BA617E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiKCNlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiKCNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C17E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i21so3020432edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD4SwW/08TmbG3Vp1P7f9CQbz5/bFAEy8m9eJlUaWww=;
        b=Qr9h6PEnZlcu+XDMmTzhhYTvomnhPQ9Q5ly8uYSeLXTt4hXyNuwsP0KthXzhUM5E7a
         GtJg9RRizND0RQKwpTVv3qyBsyY1gQwakebOUAfyO2jW1Iv2dkydwut9fDwVMq59LaFQ
         ZpuqzbxEB2gaL1FwiNJxFiLvkURhAXu5lIpS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD4SwW/08TmbG3Vp1P7f9CQbz5/bFAEy8m9eJlUaWww=;
        b=pvxuO9PNuIyLF38XBmsBCyK7ABmWoqT7v873BmmKyuTxXVSUYfTnB0kZrUHxPE9Rf+
         EKikI6CCsSVz7LZBm3BZ92IBFJ6Yy+CHi0FF3m2GjKY9WpvjQQ24NqBfDsa5aYEFRtIY
         coUHUoQY7qe5bAy2hwbBx5Ftn791KWmj0mWZj44hS3pO/Pd46D5grLdTwcuMwmykIK2Z
         nqT31YhvDTYFcKhgsKi39ULCFGKbSuJ0xcbbULztY3TA4SwXY2kvoHQFbBhg7RDMgAkj
         tDzUC356wYpoMveYoaJ3Rtu5ErvK/jI9ersf4Brpfu/YrDKQzVagCt430FJkerx8Gv7s
         U7fA==
X-Gm-Message-State: ACrzQf00MCYSfZbe8kCXCDfy1OHqrz+596qn/bdlmoPDgmoAXyEUTn0T
        DYEthV5Ey6jGLOz1rQea5uRbzIkblUiQdWrn
X-Google-Smtp-Source: AMsMyM6C+uXqSRa6v/Lh1nrmMfvYL4L82CG4FOVpMzx+ON0la8OmkpEEYGszbZBI1GCWzU1LzR55Cw==
X-Received: by 2002:a05:6402:22c7:b0:463:cc1:42a2 with SMTP id dm7-20020a05640222c700b004630cc142a2mr26917506edb.217.1667482871219;
        Thu, 03 Nov 2022 06:41:11 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:10 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:47 +0100
Subject: [PATCH v2 6/8] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-6-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BH9PcY7Nw7PbJJTAOdY6AwyTSedyQ+9jvfKW8fLkjJo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8TsRxi5Vy9wQ2nxxtG48pDSu6Z6ueZod4h/Px6r
 cobTdYWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE7AAKCRDRN9E+zzrEiIWiD/
 9MI3xwHTwNC0n6AVmEkxTioQNbbXrXLYUtOfYpxt+Vku0wLgCx3rO17nNMWONCGdTOJhviIIydnDX6
 8qwXc158BX8d1PAtGE+7Gcvdr4B5w8whE2Qbgp6cbE0mBJzW28uzLMj8Ja7nLREBXxKCmvyArIy5gs
 M5khQl5peJrQU8C3KnJufMuGPeBepFdgentCuWyK2r4BtHervXB4s7whVt2ho7Mc01YgMBNf84rWTu
 icDld4uSn6XYZZfnY9yABC5XWExub6kM1MYLfOX5x+fF2JKJPG1BG8oLFsSxWQ16BbyAPmH3pX9YKg
 dI2Jkg7owGCzAraNbt77wx5Q1ec3NefFP18Mo713MWUX7XH6f9OOTK+dKaf8UktUv8JmxRH/vhBWFR
 uNeJz0AK5USbYJelnz2mVrdMxVGZ/a1rZVY2Idw7Li4AuQhBZvCqVHQr0BM+I9eI0iBhP7L21WnElr
 NYUryHWyU+LaRJXjPDrbm+NYHkz89oUJbTkQCKRgUhbyoM9ON2hn0LTkcPBKOS2N00zqiVAWzkKJEU
 F8CwD0wpTLxM0Jzeyh/Xwnnd1ve3ewvQpgbyg0igJhY7gyIb/wrjFEYZQ5A+gtR8nCZfv5DusK7zu4
 SsTnJv9QMRkI63/zuBnUvuATOG7xFjK2xvEv4wCDpohdYVpwydJE+kOSHmyA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
b4 0.11.0-dev-d93f8
