Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9369F65D0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjADKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjADKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:46:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A5E68
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z11so32155461ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvhfEUmWAxT7YLgkjs7oKY+EYBIYLwJw8UyNAJpHRQo=;
        b=dISK5CQL6NuEAor3u8/gYBexo7B1bhbMOVEmYZZpAoY5p1A/rUPYMT62DxJMx90Npx
         7rXQ7lCO+LPb/N0a54iJvyLbDia1pfLndow16zI2lueMd7ZvNURImkDJfvnVfuV0tz8B
         BiM9S7QYLRWy1MzNC1hV6N7ho/LSBWnBX6ktM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvhfEUmWAxT7YLgkjs7oKY+EYBIYLwJw8UyNAJpHRQo=;
        b=BV2QEQskl3U2+gENIABUtJGuIP42y6QnRCMNSb/UAgR9L1ky5qUoANsxRdl/kvD4Lm
         s73G459n2/xfp82SmkYnwWQawVNpDH3YIY2BvBIT4cdU72xkR0Sj3vBy3u+De1EfyR/J
         u2spb4w93RQcFC7IqP+Wyb7LjILQ6TuGvx7bMu+7nkN6ndxHVZBTCOgrEiwp+cWpupv7
         ECSzqweIa2qAfPF2c7kIlV/X0jmmdjQCRqRvIUaf8ufY0lj4ud7244CKOMO4YWT0eWFh
         1eX/0UkUIpVNmewDbQnjjrtwwOnbDC5+VQS5V6zw+rW5o3ERERQyC41IkW9h/ldECLvU
         K5IQ==
X-Gm-Message-State: AFqh2krfcVMFkIGBb50bBDa8V+Iy+TeHUQl5IbOG4jgXzJwTt6B17Pj+
        IJfmLx0MTOGYl8CYzaEdJNWxOg==
X-Google-Smtp-Source: AMrXdXtK7yXq+Wrbdg6sTDOqQv2bKxvETVGBpupTcfgjXYK/Ufcf/+6DgdanTuYYxfCr3lXrtcQM3A==
X-Received: by 2002:a05:6402:2932:b0:47e:bdb8:9133 with SMTP id ee50-20020a056402293200b0047ebdb89133mr46484720edb.38.1672829156878;
        Wed, 04 Jan 2023 02:45:56 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:56 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:26 +0100
Subject: [PATCH v3 8/8] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-8-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=tXnPsHtSlRO20+xxBqG21iV1cCKWm3KfmKl4+olKPes=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjb523K5wvvjKlkHqfOBA3pdJuwddqB6BwLexTj
 vGE39kGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY2wAKCRDRN9E+zzrEiKnpD/
 4uI3pEVUaMQ/JFUCpFt+c9XzJcropqqB0VOrgtG/fXURnKGs1j6GDsXgAtvOn2QxdUsoGaTD6E4hz9
 9Am7G8HYbalb7qr/C3+9vk8+oFDx3KurgkXqv2vt/W3rLFg+QwOtU50Dkj5xz9E5xcwa0C487LmVrA
 QsW8i/rVc/Y0n6UUa/nAOYsSKJAGbtjOnhhTmdQNRgELSJpbuRJ7I6ZwrM2JYuaJx1+zU1zpjsiyoL
 yceYVrSYI0Z/EZYliOn+SZ402dhYEoSwlWjvSRFLTIbYHy6qXIl+XiAVuqC82nxXXcKEtBYGcmRLfW
 L8IIdihEI7llbp06mYaT7BXkn33P2x4Io+9abzUcqiYLeL7/MVtyUO7XQhA+0SbAOVDkqiiPesARON
 7TAS+8G2u3o6PmoFwEaPcTcCgi5rZb1SDYgmMXB9nORZFIrXioAUZi21Hk3Ii5H7QdVLydpJlcI5HT
 5aWWv0vhy7do7RWiWXerW9vVzuprZm5Zr7WXQd6j2xm869vM/gaoIGpT+Uw9/8sUKVxq4/iLQKK+i3
 mrJj0BoBRgLvjkkyeanNOeJgvfycD0SPpgRY6J/13D4FGO5ImLuJoxPTJWLUagCbgG9zqK0/pIP8Yr
 k3YnrNzt7kwAlv4xk93YjItVzm0Jz9oOVQS0fIYlEw2AQpSUgV8DzqEg+hhg==
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
index 2c6da49ff84b..b0b93e218288 100644
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
@@ -595,6 +609,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 24c3e9411415..6dc015754e99 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -503,6 +503,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
