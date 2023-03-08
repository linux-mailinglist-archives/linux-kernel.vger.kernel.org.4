Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920F6B157F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCHWqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCHWpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEFBC6C0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so71798249edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nAAE1hEWYCr5Pmk00qC9NxfHeEjmY265EAWnttnUqA=;
        b=DrRi816pfrsFJZsHdqlKl9NY/Ojqj53zXsA6juTnL7As94dK+3MfqUGe6pNg5IcoAM
         QXjmOU3i4zOGv+E6dUaJ2Pd3o3UL1d1Ci2CLhso8Lfh+RHEzjVGnh8VSWO1oXadNysXW
         jn8JG32Fc/63Zm7VB+0xDTPmCHCy0jxMgQjDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nAAE1hEWYCr5Pmk00qC9NxfHeEjmY265EAWnttnUqA=;
        b=IY4yFZDwjmSJfQnxy7anFPOssjnLpZr1hHFcZcmwtvgpTQvr1PQ+MRvLaqPBapBJBS
         73koxmB2nt9ephu2C0IlrQm6EmdTHaDgTuoEifmKBlh/XXqXEarLFTYEHJtbmwiMtuYu
         P+I03lOqyIDO7q+LYvM73wbM9e5/YPf0oL4O3PMgkcarQrviyNOXB1Y1/77jlBsaAwOU
         xR+I/VE3jUUd9zavHy6X2pWPYc9O94O4gdiwPHQ/kZqWIoDDpwxMgBXDDBeahHcMYvGz
         d3/WDE8e/zPB86qiDKX6WP4orW+s7EGuug3IIMxy4GF46AYTklhUvMylG6b2cUHtNVSw
         gmDw==
X-Gm-Message-State: AO0yUKXGlgnpIOZpE7r5A+W4Dvqit0gRK3i50rOUBGxJYYJ2bZ6aXK4p
        4/lO67CX9yecI+KHpuVJDPMV7qdRVnFbMqg4AN4cHg==
X-Google-Smtp-Source: AK7set9obC+TPt3MhU2dsJ75Dc72DIClOFTLEl3termnv2GIo96iQ+aDeb6mOTTHQX/76o5Wcw5RZA==
X-Received: by 2002:a17:906:6c84:b0:8aa:33c4:87d5 with SMTP id s4-20020a1709066c8400b008aa33c487d5mr18188780ejr.10.1678315547309;
        Wed, 08 Mar 2023 14:45:47 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:36 +0100
Subject: [PATCH RESEND v5 5/5] media: uvcvideo: Fix hw timestamp handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-5-139d1a144614@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=8oy5jraGEK21FgogoPTHRpnEBLvJaCndlyuKgZhZ4ZM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRAWwM+vnZz8D7hi2QHfLJNIXdM2uj8xqqrGEuM8
 GWfHQ0WJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQFgAKCRDRN9E+zzrEiGVnD/
 0ZZz+qXtOEMfCgF5HlAwc1Q+RLZCxf4ZO1YCYRL8HAtJRfGzegNQnua+/fEJDCLoroLU/vgRHINUw+
 ev/eB7oK2cab4EFihmX1Lwu1F5VbMpMmgkGK1FjScREm2180fNAzYdfM6gh4c2B/iz5cKKWkfgljwP
 GnlZdnQ2mhu8VJj3URRAwNBtG6qDujoqq6e0Gf116eJPThgv5MK6KwH95gIO89xz35Lhy6kckvJF1K
 4QxFFq21iP4+zogTXqKxwJOsfbPSLy7smLy/gv8uC2+AkK9Z7nC0XZJKpeCOP8Bqp7v6EMgYmCRpXV
 lnJ/t6z2r5jTazn3SHFqq+gtQQBNxZqVkFGTdTY4JqV7nxlEzxGFimwJmK315PO4mjYgyNB33myuM4
 sGaOBYl8MyjzD8yDupsokZhCP5d4g64MO4Xe6zs3HlfEl7FJcniTvsdMtNq9omiRnvw4gkgw8EzzE4
 kcMqamAOB8gcP5xuaimAKMFppqQknbymb+jFW2wPDzOd48qA8+jA3vw4PkRpQF1fWejvoX7aDV6Yop
 EmBYeitH54ZLLtZmAGzhVomyHEnr/uWFqGgM4ETNNX51/4tr6RLjmMRbtoQOjc3EfoGvD5vRvHdpHJ
 t2OMLBjrJuj2oIgK4b14TYNJ4LT7CRlOhgQCaJ/runUpCIEFrb9sSFn0Y6GQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 22255bfa7db9..ae692122d5dc 100644
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
