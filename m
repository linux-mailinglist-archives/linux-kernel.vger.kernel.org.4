Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4386B157B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCHWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCHWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E339CF995
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a25so72161506edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMdYT/zbSZA3E8+R7T9MF7OcQdFrwVCCCcqy5A5lCk4=;
        b=Q23G6pVR/WsOKo+PmR4hp36VqZh8nLBH7Tgt4YdUprU8jj0VnABcgtJCNMEJa3ZTAq
         yPi8xu0QgAaGpimR7FEg0VjdyxA2edMragBClg3rWxRCKPyJSfNXH0GlLQ3wJJk+gXnk
         hbYA81jpEiP/JPXTwpmrKzHVCKX8wb+3fDD4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMdYT/zbSZA3E8+R7T9MF7OcQdFrwVCCCcqy5A5lCk4=;
        b=IpbxI374uPSXnz30waKLMnwGDPXtKi2pmvicUn7HMKnAfwkDUyM+Koy6vyiNGIPPwc
         K6fATRWPAfalPJFwOHgXl1g2FzDSjMNPjSwLJrGfUp9J4D6nmCz9pZxmIr5/JrMua83p
         oAbQ/kVSpBuiNBnHB1nM9gT00iInhUZ1jLh34uAwSVp/QpWWnUN86P9fx00CKYms9r3T
         84fGDYQ51/5C+JStegfT2WLuxLkmWJqbMpeWPH6AqAY2z268/yJQ2pjKvnxs8bdM5tRG
         DEOcLPSO20q38IpShzZfilWMeeJqsKi9Ob5JEscDnJXNhz86580wnoahAST/wMuUZY5c
         NA6w==
X-Gm-Message-State: AO0yUKVwX5j+FpsQooeIWLhASw24J2sYGEWkCOZQQuliE11YwifAri/B
        qxhzkahW/60hyFsQEgaozaR8iQ==
X-Google-Smtp-Source: AK7set84d9bGXxeVmnPNsD/aOqMFooqfbTe506uLzfl20XoEYMYMukKCu6t4RK0ZrYCJ/F0xET3YiQ==
X-Received: by 2002:a17:906:5857:b0:878:81d7:9f77 with SMTP id h23-20020a170906585700b0087881d79f77mr17970945ejs.34.1678315545875;
        Wed, 08 Mar 2023 14:45:45 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:34 +0100
Subject: [PATCH RESEND v5 3/5] media: uvcvideo: Allow hw clock updates with
 buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-3-139d1a144614@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=PZOTcR3pwQYe8Ltw0Z0lyFaWOwnv+LZC3UYi+bWPKCc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRASErSRJgfDOO7lKM5eJqZBa9zHpcnxk01Yd4tY
 J0praimJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQEgAKCRDRN9E+zzrEiJRmD/
 4v91HV2A+PNK/jQriBaQGZ5qhE7+5CYSM4Gtq9IJ40TCH3yqK/mi3paLYTY8wZIGtaQKD1PJ0MLBEW
 /VUegsIPFTjGN/KCAymE4j5YmVHjCfCtjVcqEPE/V0ZHYn64aaQRdo8qwwd2u7l2i497Y5bgUEbE8F
 /u1VHwY8TwT42v7Vub52ssvPIO4iBhiHhCOGhqIlNQ9lCc4/J01xyURmCp2QcYpUNeZqv6oVcPXSQv
 YMydw+ozcKqOACvNoQmyKA42kFY3X3Q5xLabOdhGjLh1DJnCmo45o5YAaO4Ywva4VrRxUDZwgcOZzu
 Fj5BgYNl8nvOJx1njv0vIHVFwjAgC1USACiMEJ2iIk3oxPQdszf0VDUdB1OyCZHqxgJo6ty6z4tYd1
 AOiw7gbtS/qu2DnOsltb671Ij7f0ONmWvCprgMfXG6Chch3TSUhlnkO0lMs8+bjPTcBhyKa0wz2Oog
 MqlD0rccnpRkmHyF9M3coUgT1oZzosM4nfzVk5k7jklXPsksQ0qw9J2NAD5mUAUNRhIX7QxbddLy4D
 L+BTruZkZ4mjlcw1S2V0TA+FEkYSRbXnRyB9VISL9uiE2lum+F5fZO9ttieG74+Um7GEv0KsmT4BpP
 WDkjA3v28uhgXr3Xs5+yQzue1gmgL1yyM/1QSqxv/yNnf96GtycJd9USUoNw==
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
