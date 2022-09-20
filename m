Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA35BE82F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiITOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiITOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B645A885
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f20so4012238edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=2m5NjiSQ3UFcFg+RUZgWJGP2l7gs/3+ArugwLslOKeE=;
        b=Qog8O021pF2YpCNSfKIFSrzglOkUJfYjp/+iykdEDhA2rUzeTskHBghLNIn667tEIx
         YRjgd/2WjIW8lAE5Te5Yd/KuQ6nhDQh3n/Gy4igXH4sV1xPYrK3VLZWa7iDQxRFkKDny
         LNH7AtkR12pvioQ8Xepwi/BClUJDOUtspbh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2m5NjiSQ3UFcFg+RUZgWJGP2l7gs/3+ArugwLslOKeE=;
        b=Np1bMmr0tX13pxTCoRtPixa/I6tq7Ge5DnB8utW1uL0g4yjm+GUWkCMmEy18P/Zzsa
         TkdmWu8LNJjERu/ZwTKfSKSHq/Qbya45yLm4UGx/8SLaNWqpZTjvmq7f3Zpk5b6aVZRx
         xOxgAJiu8/yHSPpIXn1b+xbxbeIFUO87At3MJt1ywl3ar31ieYJsd5CVKW/lFS+FOeX+
         JjdiyuePXsevcfum5Q5YFaXPV0hZQ7t17KZLNwyQMWM3cDty+LImdR9PGM5iLYmW6ULw
         fcCc7NAYZVZcSz8v+bnXp9sRxwxvxOEj7nj3UQkU/q5KcBIuTcXvcPYhOGnkfH9ByRhH
         YR1A==
X-Gm-Message-State: ACrzQf3WUMwYTEMCL8tFjWbRdhUb8jRqguNsob6MrT2sJWSRBDSIA1Ha
        1VAb0m75oifPfHNSpFQ3ial8kw==
X-Google-Smtp-Source: AMsMyM7Kttfu3Wsv8rxi19u3YeiT1tiXz9wHrvoFQFz4kKSYvS3PuNb1O521uebjBc0XlYZE2HrKoQ==
X-Received: by 2002:a05:6402:1b06:b0:44e:a073:1dd8 with SMTP id by6-20020a0564021b0600b0044ea0731dd8mr19527488edb.391.1663682913102;
        Tue, 20 Sep 2022 07:08:33 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:32 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:12 +0200
Subject: [PATCH v1 6/8] media: uvcvideo: Allow hw clock updates with buffers not full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v1-6-e9c14b258404@chromium.org>
References: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=e4J+nrDAhgtu8XgKC9q34sJueku2ku3RgCFGTHQq+rM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclVPstkH2tqWY0nEWxBnkdg51HwzIUCHCT2SJIh
 90evtTuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJVQAKCRDRN9E+zzrEiMh4EA
 CMsLkuVpPkdk5Dw96HZtyoD4QFh88Ekmm5Ugj05gyKL5+RNVrwIuaEvTQgneLKQ5i2ARyq2ZdnWmFt
 Lx/d+P7OXGibbi38Jqllt19Jv7qtFI0eD/ldJ1FuLDPsz/sYBgrD4yNQqHlSTlHoX6rN6FHCKVpG+f
 QXJeagc1ChxU9gIb+P0lGvomrAq1qIO3RHjipwd2d4Qnyr5GQ7hXxlw/jmHK0HpbJQXG8wp7iotWVU
 bhwQY9WXeHJEZ6K4I345bFFpeQGQw7y+koAtpdO2wcCdYT4NnIVMBZELONHgKilYgd9mA3skOzMRir
 u4j1W0faE/Ml5Wq8BnrtUNimXrfLGebTUNTVl7bxrARfeH7H/Caa/VAuEesHrH2OICMEsxVlwzM/hW
 J4XRPzEaoTgMlRBouzs6x+YbOMSb/l/SHIEQxywDiRSOom87Dfvacqxrdmgczi8e+AWtsUW6/wkhpE
 EY5EqMze+HehXjoPJvHKYAwf/SPtbeNSH06aK8LTRrF46l5QR9AY6+nTt8eViEH5b2HG0O7wFG2nFN
 MjsbObx7yVgT1OPC2rG9YRCrmjfYrpvu2wm9oUFW5iBs/jJjE0zOPXiLh8aXJc4tweTNMN8zDAixm1
 4kKV9lMekTN3+T72giWH24O5uVNd0PTBlP/VRrDq+wARMBD0qUj1h298kOvA==
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

With UVC 1.5 we get as little as one clock sample per frame. Which means
that it takes 32 frames to move from the software timestamp to the
hardware timestamp method.

This results in abrupt changes in the timestamping after 32 frames (~1
second), resulting in noticeable artifacts when used for encoding.

With this patch we modify the update algorithm to work with whatever
amount of values are available.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 75c32e232f5d..7c7fb478aef7 100644
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

-- 
b4 0.11.0-dev-d93f8
