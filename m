Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F865C210
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjACOh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbjACOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8DFD30
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so44028468edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAHTPeQigGkzAZXe4x+9ro8RmOt+dmg94cg1cPhP7q8=;
        b=lCMlC2H7baya2EyugYe/2t2UaN7sn8tQn32AmADW0/1KCdyNmlv2+0Mekp8k41K5yT
         mvy3hOn4QpdSu3vaAm3MdG3b5/kXSaK26E9zfMW3A8qAxNesfF7NEvvHmxAnkEyxh68t
         9zdzZGfngI+UcZNpOb8nUyddtcMJjx9OCEFE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAHTPeQigGkzAZXe4x+9ro8RmOt+dmg94cg1cPhP7q8=;
        b=HytRPvk/OqYMepHMPOBkioHYKJVs5qlGIEvmBS4uaK9ECRFuCQypJeTTcjXdFzQ/F7
         aD8xL3BeimaKZPlitO8ZAYtBtT1Et8Hcyvvut2X/njwlUD9exgzD5QPs9slZTLZJyL1S
         pdWLLPjlymlOi4TW9gjn+8MeJJ+FRVNrSResrh4g01r8eENTxv7y/006Ewr865LcDDr/
         F1EmYc3FWKDgPYfwoKw4zA30JjmC3ALsQ/wOfkR/gElRk9iHcGXacadPbB0/d4252/JE
         Y/tGp88KKCX9DziVB0kB87Xi9dSPWtXOsKRJ3cV9dWGtCd1q4hL3jAtzdohYRU6GC/eq
         qpPg==
X-Gm-Message-State: AFqh2kpZZ+qSWh/PA3pRqvkLB0mUSQeXYTDMYVx1gHBq5MxQAleCTRch
        soaTCKP2f55br7oREWE2aUfvMg==
X-Google-Smtp-Source: AMrXdXtIN8CqG89gterCPYxDiV7mGaPjoYpdJlVvRTWUMCDZhukW4fxIL9Xmzr4HfCa781HO9n+IZQ==
X-Received: by 2002:a05:6402:f04:b0:46d:ca42:2e59 with SMTP id i4-20020a0564020f0400b0046dca422e59mr42519239eda.11.1672756609473;
        Tue, 03 Jan 2023 06:36:49 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:25 +0100
Subject: [PATCH v3 7/8] media: uvcvideo: Refactor __uvc_ctrl_add_mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-7-598d33a15815@chromium.org>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=9TceltHofxTy9VGQ6b063wegxNqLkTD5czVh+mkaViU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD12Pm+Pt4NYHp6kgsePzovAUC+g8qNSkc2d44eM
 mgFKrx2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9dgAKCRDRN9E+zzrEiNEpEA
 CLEufUPLQ3HTohZFgOdTqMvgKnnLNzS546HhLprD+bwAmbmQyuwqcepai9q5vjvPtbN9fCCjm01jPN
 v+iPwpjQvze6uxrrxJFhXjiyJdouV1Pc9vqF1djm082BwEVPpIzF4ICWKHj7xApvPYjRV+6L4mrDGk
 bcXcKxfyXSmBcWtKdv7g9OoMxRV9/AvwjpUMvMhKu7cIMo1f9pJXkk4CaaJr626OEEvfI42KktXyrs
 7ep14IospObdVV09J1ASUr8i3OGswy3mnNypVG5QiejKZyqmR0aEZJo6sIkIr8GYHMW8GzW6IRQDiI
 VAz6Ewg611KDHSOMz2Sx+WLRHZCg8ZFB/XMumsExn1vH2bJ5T/UZ+HZDeBfZn/bsG72kUCIA94YO0O
 3TwQE2vwjtMiircrGpMAzJbgagjKJZKmsGHl90IBbSY35Kbwe5uvgbr5oU4ipu59Cg6mzTbwcbqI0J
 FFLIITuGx/vAUwY7g5aNxUDZFAJBhrrSKGU6/PkdsXqwZRju6OSXGbkAM/hCrkIQ9ciDcbMT4rH4GS
 v7HtSDIlvsSwGPvjR2LV0ECLiIONo6Qu4VgmaGepFBIueklxEiE8JMsvtOjvKEPZdz3KYpfQf035eV
 P4eQX9l0pg5V5O8hAyJ1QaTNz3u5sJlj0JJnaLpuUUVcHkgTtIrU5//wkGuA==
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

Simplify the exit code with a common error tag freeing all the memory.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index aa7a668f60a7..4830120e6506 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2296,32 +2296,30 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 	unsigned int i;
 
 	/*
-	 * Most mappings come from static kernel data and need to be duplicated.
+	 * Most mappings come from static kernel data, and need to be duplicated.
 	 * Mappings that come from userspace will be unnecessarily duplicated,
 	 * this could be optimized.
 	 */
 	map = kmemdup(mapping, sizeof(*mapping), GFP_KERNEL);
-	if (map == NULL)
+	if (!map)
 		return -ENOMEM;
 
+	map->name = NULL;
+	map->menu_info = NULL;
+
 	/* For UVCIOC_CTRL_MAP custom control */
 	if (mapping->name) {
 		map->name = kstrdup(mapping->name, GFP_KERNEL);
-		if (!map->name) {
-			kfree(map);
-			return -ENOMEM;
-		}
+		if (!map->name)
+			goto nomem;
 	}
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
 	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
-	if (map->menu_info == NULL) {
-		kfree(map->name);
-		kfree(map);
-		return -ENOMEM;
-	}
+	if (!map->menu_info)
+		goto nomem;
 
 	if (map->get == NULL)
 		map->get = uvc_get_le_value;
@@ -2342,6 +2340,12 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 		ctrl->info.selector);
 
 	return 0;
+
+nomem:
+	kfree(map->menu_info);
+	kfree(map->name);
+	kfree(map);
+	return -ENOMEM;
 }
 
 int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
