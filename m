Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCC640BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiLBRDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiLBRDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F434A80A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n20so13045685ejh.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z0mke9x4z8GIO16lOl+BgRgkcVeUrWg/yLKPpvbpk0=;
        b=KRuFz2z0S00H+Jjqi+ULpUWR9oqEccGYNJsAXZkGZBhcf65dYLS+1T60tut2/084H9
         yFv8Ka0pIlw9bYdvYfPfIwQnaIMHbWOkBl+Jq/ice6ApLUxFH2OyJayzcbyfsoSRShMP
         mPkqZWZDlmcJ9vI5y6DfbmeuD9vPMDD0NZ0Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z0mke9x4z8GIO16lOl+BgRgkcVeUrWg/yLKPpvbpk0=;
        b=wzv6m4zasEUIIXVzl4aD3YafKY9fXjYF0nXT7QCkUxIGK961Y1TVEdOAuvvWvWO27F
         6uGwpOZAf+OoMxKQRjtGZXICYzTR0/7ZCEx8p+W4bfwFQTqaK3vsoudiCLfQNnXhzAUi
         fEZqK/1TODeKZAFBlDUh1JO1suaXAUtE5wWBGRhxcmjQYybRTSCzR95fbHNRZ+sN5QNJ
         mdosbbVrmsU3z8H4mrzPovoQOzYoierYyPkg9u84SW4wN2ipDrFs89K0e2TrmQZK5vH+
         7AWlTo6aaRg57X4TtEa7/ZdkJ4PJ7w1d/ZsaTdnLjBArMj7oTT3LdVFEWgIs3mq0+YfF
         xg1g==
X-Gm-Message-State: ANoB5pms+fs8ruHBkfSfSoMNvYIwRjUc2AR00fYBoHDtImUBmRU5gmkK
        X08esyMmQTthBRS7+PJ6qGa12w==
X-Google-Smtp-Source: AA0mqf4r6lyjL/nTXmoNE4mmFDtudjSLLgswHdy173L99fa3FCvYicPNl45W4w9oXR2zBxUxINOE7w==
X-Received: by 2002:a17:906:706:b0:7ac:2e16:eb05 with SMTP id y6-20020a170906070600b007ac2e16eb05mr63176435ejb.26.1670000586670;
        Fri, 02 Dec 2022 09:03:06 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:06 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:48 +0100
Subject: [PATCH RESEND v2 8/8] media: uvcvideo: Fix hw timestampt handling for
 slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-8-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ZqBE4dWRk0InSyAxEr/auCSM1bp+38IChW6qVFv0hng=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii/Bd0vLNfrMM135jh9PhB+8ydixKJHN5VNmGQ1w
 6MdQC8WJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovwQAKCRDRN9E+zzrEiGdGD/
 9DoAVTWVQznsEgzOwpYpRyWMCIQBxtwlwKzaq1BnTIWye0goRJf5CjrA9bRJu+Z6+rx/+lp/RTMufc
 MVg5aMuukcsBzqLmyag5x0oDtpufG/8q8n2V/I+eejUQIFhJ/WgRBeRArQaT9Ib0AKH9ZXcZt/uMTa
 yGrm+vuxIPwgV1SuSPB5rIxtxwyUAfiq7qlxJArP79mrahtKd78OmPqqKX5q0h64kJzurNStsVKwbw
 qigdhxx3mcd8ABG20FwkR2+uV72DJqtQxmTcFtiNkThYx9dAVGxnF+hi70ALb9Dt0KpiB+eXme+mzQ
 xpLSqnfBKJ0kUOikWg+horEpNYRqVMGp5DWgZ6Z0FDz6JfeDzu5/MbrQwUfr8MocQajT2SS5/+S7OI
 PHexHL/gL++hSerdMcUMIX0G3RxG+sAJHjcA6G97N0Qinm/yb6WuYKEDAp/PtldnBNrbFCe9aCEIbJ
 UmRo+SfzDzWrRpf1gxmME/bl68ZyQzBIiZMhajxdBi7VazfWPFNfmNcOKR/94iaIn/S1wmMpFCZUZK
 TG3CY6KD/rbVr64gJDE/XQMagdmzJFdtwG2F0SGjMp621qyhW6nIA3ZFpAhJreZkPAdoKlHaet+tAm
 XP6RlzuWoO5Ab/c4qButbsLioCEdGQd1KqvgIlt3Z0r9bJEbSeajw8QWfEmg==
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

In UVC 1.5, when working with FPS under 32, there is a chance that the
circular buffer contains two dev_sof overflows, but the clock interpolator
is only capable of handle a single overflow.

Remove all the samples from the circular buffer that are two overflows
old.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 16 insertions(+)

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
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
