Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461165BE828
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiITOJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiITOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C335A3DF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so6365228ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=zfUVo5J8a2Bc8Duiv5hBpojxqjiC6LXnccd1O1p7p0U=;
        b=GGSkGcugjAI5yDMtvFFgQZkoRn1WsWjHTUuM/wR3ngskRt3eWvwItbKa1C5Q+L1inV
         4gImBazugpqgfchUHois0K4Xhm26uFHIzzZwG8LZ5GGUI0TU7e0vcKnYJTNBGr1Wv92w
         YO7zb8fc1OjtlRmBG7Sxiv+3Neq9fur8nxyjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zfUVo5J8a2Bc8Duiv5hBpojxqjiC6LXnccd1O1p7p0U=;
        b=BJ2DlVgOi00h4oX+BXjU8eAnm+wlnRmStkNGdJX84OBOilWb0NMBZr9GwRhocbvCUB
         Wsi100oPfmTtnxAwa7nnhVjVxBqwV34uf43nE9eUmi8bZ5FtmE2UZbvJpPZVMD2g0YIM
         27qWVwd3El+Gim0NIedEDJr7im7iI/xsJ8mJTn0lJCsLJ+OhjS8r+cYNsvvNW1U2uMuC
         kEYDUdvOlkghcqYWc473JDNIOn04x2LkInpSEkdFPfXmqdD2iz2kdTNJ+a21qYRtUFjD
         VxRgEhOCsupsTGt5kCdZuGfYjEhjDncYP8owS5B4HNp5cBa425Ms1sbVs1uqy6nwiTgv
         ib1g==
X-Gm-Message-State: ACrzQf3CLlZ+f1vSsbtUse4tjm24lADvZ1MgmH2nCEoDh8tQREVrChBQ
        WHYG2HfoEWsfcg7X5jFFrdUM8Q==
X-Google-Smtp-Source: AMsMyM4yFtq+9sFEZcoug4XGhgUUbnOXsp0PEFnO5fzU35xBZ0cm2kU6M58aSrde7nxwrtUO8SgePQ==
X-Received: by 2002:a17:907:d04:b0:76e:e208:27ba with SMTP id gn4-20020a1709070d0400b0076ee20827bamr17762019ejc.652.1663682914733;
        Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:14 +0200
Subject: [PATCH v1 8/8] media: uvcvideo: Fix hw timestampt handling for slow FPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v1-8-e9c14b258404@chromium.org>
References: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=7rcJtAlLWDuwlqgI5NuBwa+lBBH+2hhnt1cWwbcRz7A=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclX0W5Uzo50SekqUWJQMW9HQARbEzF6bZlFifz5
 eUVVjXeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJVwAKCRDRN9E+zzrEiGY7EA
 CLeJzonsNH3rsNFk/G7xmiEGJKmENtbohahM5F9b+cxF9DKX57xHTN3schTpSqhAdkKq08aW2QdxX9
 7Id04JlIgVqAL3oPx3XVkipHwBPT61KSHA4uDnREhNviHlWoKktIb/FwWuwH2ikUr0wMfGHOOt7fi1
 Wg/PAgUtDwcB6+qDDX3bI1oUQF5A67NqEkxUcdGZ/SQwGun9ZQv3nITw4DaWi6r46yCP1AdepoQYfd
 MnShHEpvagb4GCLIBTmF7wUIGlBTe8V3Z+3IWAkShGJYJyagEkjlTuLu/R6ZKCqjJchl413f0ovW9C
 8xBB1ZGdN7BHdCzs0+ENhhRJcBzv8KI8QdPJqWsG57fMNTKw1/8/FhZWG0BL+xztdweSBFpZUurBpY
 2w2SByJ+84QUK0QheTPgPRzERimPauY33ipXIRHzIvB1rTiEKPC1mvqXGuBqiXPkOv6h0OFWSDHDgK
 aarHabyN5Tpe89Si9cBovsm+6zo7cPJxF4CyhfYq5SkCLaTXw/UH67YVblaO9J2o2qlgHhznrjkyix
 hEVSDbMI4LLAvM1gx0PHgv6OiftNzVQ/WGX+MkiLgi5agEj8lLzlBoIaQNWC7FU+1SKCIUkTymavEW
 KqR7iYlBqQikL1ugS7XQguaBaDBnRa77yx8hsIQ8cRTATeR/AkvcwgBwy/lg==
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

In UVC 1.5, when working with FPS under 32, there is a chance that the
circular buffer contains two dev_sof overflows, but the clock interpolator
is only capable of handle a single overflow.

Remove all the samples from the circular buffer that are two overflows
old.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 9e7ab7ef8624..25e1f4e115c2 100644
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
