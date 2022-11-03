Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04661617E31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiKCNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiKCNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35A13F47
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x2so3080056edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBTXj0Mo20+lqPJvJbV07DHgoZv0TgJ6xnkWV3WDOVo=;
        b=kpJ+DF6PjVbaFJFClIwC2LT+GMwpgkrYik0GCWpQWnEDyK5RHeaEmgpN1H1m4pbPO7
         iukhRLpcj8n97CqE4Q7s2Ho/Kzw1UDSm6WdoUl9u7ERHkMtxySQqCpCXMFwVduVwX5Qj
         ucny/W6XGe89qBRpKfMowg/k6LTpMzF00Z1Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBTXj0Mo20+lqPJvJbV07DHgoZv0TgJ6xnkWV3WDOVo=;
        b=qZLEMbarZl5b18imtW77lqJE9StEmZdpt8Z9ERyU59CwVf47Nm8jb98LYzjCn7YwI7
         BpeKPiG3AsOu84FMflbKi42yn17ZpZ3FKWOs2ON6PRbdhM7wxA24rN6a7dlvsA60dIZq
         M+r4yzk0+JpAhPo4z6yXDRVoryEAZv3YLMPMEm+fvQK/2seivNBizZAOsK14jTtJo/Fb
         UvftyHpi/uhIjgDhkVwCpg4FpZ0JLPlhje87TrXueYq0KTC8bYJNxFsdQtC17ODY7Elc
         hmfOpK02Pl3FYlvtRTdMQuQrELUzkJcb66LvPLMg/JpRZgbP0qSoJbYKcZzPMj5wSAyD
         rHjg==
X-Gm-Message-State: ACrzQf3kjt+FJQ6+PnxU+digiH19gZB6ojMNmtK68PzDbC2UJ4WNRm7k
        KQLbOJrIXohmyzX/3e8U9Wu4SzHGCZ7xsKgI
X-Google-Smtp-Source: AMsMyM6cDOmJqgaysevnZNDkDtF8b0cTaF3lEiUh8+ouWSe3DB0h3ADd+SGhgAkOfYJYGKJR+pqsWg==
X-Received: by 2002:a05:6402:274c:b0:461:9921:60cf with SMTP id z12-20020a056402274c00b00461992160cfmr31079740edd.353.1667482873385;
        Thu, 03 Nov 2022 06:41:13 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:49 +0100
Subject: [PATCH v2 8/8] media: uvcvideo: Fix hw timestampt handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-8-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=pNerfrtBJbE7z0e3sYuUA+5U9LQzvOcTp5yM8ujyuVs=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8TwN3zXisLOmlBMSPM91NI1ZKp/+UQ2K81uRsDG
 O4RuhOeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE8AAKCRDRN9E+zzrEiDeXD/
 9II30l2x2EBLHN1QVJa5o/1HeUqhrKrd81xF7n/aHdzfnYDRZnyNZ477pPsKiLmvjWhf/9hzCl5Z21
 NCgJXb6jHEaegZPKkVuIFjidXdx2NW1UPAYBNfk/fPH35+FxX8cVnTKFfna10nIb5OjAQ5133ksSKn
 jMgF5tvLQzL1/+9XMRTBOru1sXl9QF1sP1QrPRyCc5+KueXH0cNelcomv8L9PDQLpSCXy1WRVbJgzm
 Z/KJEqsnvW/ERAJpT46Rx8MJP97Xi2lokEtvGGGhA0a9tDP0Zn/IXm8k99kMniK02qt3pZ3OVmi05F
 aadaxwSOBus9ZD8BTYmrVqX1ruw+grTT+KuZ0dP+zWMk4juMkbqoWoxqkYz2sjAdN6wKG74ZT/hdnI
 MrTFEs5BQl5P90SI3SBdEa5iV3uZ/IfLqzF31qpegSxzDWqERNjNgT7j7RFAQl5eaWSZtJK9s7Bz2U
 7YXwt+i0h4NItmLSorZUqn0M7bpT3cWPkCvcw+0c4j41M8FysjckCgHnlBdraFpQawANbSmsX1l0Pj
 iLsc4FMZQq66GQKq87BODBJ3KDMs8kj1YHT9pTCs3KJifowILFBmA2GS/N8cOHLO6O3DqJnC+6WsUm
 kwujlSEBPKCnr1uIcVzzZLXgCum1ZErNMqG/JF+O9YS9XLsyNJ5LfdXMN+wA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In UVC 1.5, when working with FPS under 32, there is a chance that the
circular buffer contains two dev_sof overflows, but the clock interpolator
is only capable of handle a single overflow.

Remove all the samples from the circular buffer that are two overflows
old.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index c81a8362d582..6b6bd521d6c2 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -471,6 +471,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 
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
 	clock->last_sof = sample->dev_sof;
 	clock->head = (clock->head + 1) % clock->size;
@@ -594,6 +608,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 14daa7111953..d8c520ce5a86 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -647,6 +647,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
b4 0.11.0-dev-d93f8
