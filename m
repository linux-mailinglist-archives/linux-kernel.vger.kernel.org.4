Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2C66225D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjAIKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbjAIKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABD12A89
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:01:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so18714552ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyPGVf1IA+R6W+BsSMF5B8bTb9iyrBrQc1FUkhnDkgs=;
        b=UjwDJhca+rSCU2rIuiVC7dEcBv08I2zcp7ic+9MaK6LlNKz3C70l+p2vosFLBvv6R2
         OGFMKB6tPRSyFRPnHXwdkuzowgisl9ZIctjtSQV/Qog49caGMRLbdautE+72tyFQeuOH
         POBOSfs6K4fxYna9uzn0pyUh08VI/mpyWbGHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyPGVf1IA+R6W+BsSMF5B8bTb9iyrBrQc1FUkhnDkgs=;
        b=Njjhhlz4AT3uFyKsrlDCQjEvYEGX1RdwGH/AuBIm+CzBFx2JPvo159XSKkeJUX9bkE
         3DtgVhVg/VTsvNTVfy2ZGI54yC4R0YiN8eVbg9J62x2D5+QiGT44toVIc0MN9GoaX02t
         JXrGieE/y6B41SAi3W1UZ0rkoZanVNbGDjqqw23y1VLZjZJ/H+avUxKLnHqMZlsmKqB5
         ZnrjWHAjC84HwQuIu3rgkUMsQIN0dpv8Ax206rfUb2TFc8uFHJGE8+sz2fgC1d6iQYlS
         OHIY8Z6202zfCapQ2PaBX2FSrpkp/Pbgil0RXaVa5krJ4IkLfYdDImmXzXIFL7WebNgZ
         46FA==
X-Gm-Message-State: AFqh2kqcowmivBFzB0ir7UeizATE1RmTtZ5GqZau9AuV8dE8mYSWkDDG
        l5JdczW/PwoJlIGubrwgvtFUeA==
X-Google-Smtp-Source: AMrXdXsiLpNbgHJnmcE9ua6HmBX7TPv/kKdK4Z59oxWNT03YKIM6qLuqS0l6SHOhNT7mqVBXHt82Ng==
X-Received: by 2002:a17:907:c68a:b0:84c:e9c4:5751 with SMTP id ue10-20020a170907c68a00b0084ce9c45751mr20704462ejc.74.1673258477023;
        Mon, 09 Jan 2023 02:01:17 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:cd22:9dd:6d54:8488])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm3557548ejb.76.2023.01.09.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:01:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 09 Jan 2023 11:00:52 +0100
Subject: [PATCH v4 5/5] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v4-5-a8ddc1358a29@chromium.org>
References: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=d3/yxcuzrSsjuCAsXjVx8zgkh4Z01muFu99m52Mqt+Q=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBju+Xmus5qwiM+bWh3XmGUFTqq8M16JB31p20MD+uH
 OlLPKEmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7vl5gAKCRDRN9E+zzrEiM7VD/
 9bKbYtjzUsl9za5kNhGVS3+IUFvGg4JO/yvugtLoQfDMSl5vY1dRQGU5BiLNwoF0u6zltN2+7RbLDg
 zMvxiNuBs1pH55ubB7wgCtvUJmW8WMUMUpddrvhb2P6w6aYqGTthzg07Yji5aDoySqjVHYdmKOm0sw
 VMNCDpeK2MGCjpw+5nglsWb6TAfMdiz9Q7pPNs2V30GgcqtdZ2f09oIh25/xAXSkXfpKAx+EnZ7+q5
 TbuqW6BC5AopWpwdu0Mwlmz40Jz+IUnDuigBl5AUaHV05iJ4Assr+pwo60iquRf4QYd4TYjnTsqhet
 DQcGz+Kb4VXBtvvxVNoWDzbceEq7teHvT6RRJS0wcYopENhMkYts8nlfzBTlQ84Q+V6lzIbr0jd9kx
 BEvFZsv6lmFKwiZAG8x7F/ljVB1MJq9whuoowr/JmjQDotkUiLpVyAdbweIiwtamXdKs+NBsKUYcB3
 3HRGudm67BzKvZqWlFahr22IgW2x5YN+e5u3hZbHd6afzNRmh9Kwyunw+yWTfesChVAGje3+lxAFXA
 mXOsA8YLNN+4djBH2QcwIDipQF+9XTM+jZd+9l7hAcNYYKYgA5ofA6/dIMG9lMeDKXBWTI8jVgZEa0
 C8HZjtclgV6j8It7KnZkoZ9LI5XKMKueDgJJ9MsSIR6BmJXHRfCU1b1sswJQ==
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
index 02831cf0a00f..04f452d95fd6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -473,6 +473,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 
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
 	clock->head = (clock->head + 1) % clock->size;
 	clock->count = min(clock->count + 1, clock->size);
@@ -600,6 +614,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 699c33bc24ed..f2a7e1507492 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -501,6 +501,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
