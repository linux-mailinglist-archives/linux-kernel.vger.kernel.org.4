Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A06265AA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiKKXmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKKXlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:41:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42D814FE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:41:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so5946319pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQhDM+RPGT3h0ZStdNTell0VImm+UlnhHeN2vcaUii8=;
        b=klz3JVtfcvTRwuDP+4+oxgOyHSg2TYq+jTPR514iHObdH7rzSlm/lCzKajMkEhygo+
         goVood1ozNl500eJtvbqvMT6TXroWuEE2D8rSRD7PO9w+ofoi0Uup61y4SBdfWM5QwrX
         D3k0d7NulGLWNvfvc47sYAc6o8LIpvk5siwAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQhDM+RPGT3h0ZStdNTell0VImm+UlnhHeN2vcaUii8=;
        b=ulZ2FO82nLI1CYHXPIEcoDCuNk6jiSeBQvL3HBsdk+PJ2LJ8F5I8XAgud2WyolPk0J
         +TjQfv/O9qufMRGTzDvqeVw6x8wxT2igflzpxC8o+6X1ONKa0JpmDpNSNKnqaB4rEUXt
         thomKUcRFsNyz25BBsGJ2RbhvU81y3fOfsmbepjLSn/vwHNjMs6r7z7WRuwe5jLJuOV7
         Qu1pr+22YcEQcUTNESX9NC5OjQxn9h490ltRM/mtR3ehWKRiuWcYcdH+dI9yuvr7Ppm5
         Q1Gx0POFtvzt5EBZCiY0eOAPqo+bfJVwhM5By6nGnLAw2ylgwWGgY+yiimb7aXB8fG+W
         TYuw==
X-Gm-Message-State: ANoB5plFF6kYTW7DL7C3Cj2K2zdqFN5tIwfSrms6ZniA06efYgnHnguL
        2r9CAex19Ng2vxirQxC/s7KWTA==
X-Google-Smtp-Source: AA0mqf5uH4H6XdCUZsV/+8pU6vprIQO8EHckXG3RMlHRGoJuFzZxeejG6iwWk67HuWEuXO+aQubIVg==
X-Received: by 2002:a17:903:3308:b0:186:d89d:f0bc with SMTP id jk8-20020a170903330800b00186d89df0bcmr4696841plb.19.1668210114051;
        Fri, 11 Nov 2022 15:41:54 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:a816:a4bd:3250:5678])
        by smtp.gmail.com with ESMTPSA id q101-20020a17090a1b6e00b002130ad34d24sm5421826pjq.4.2022.11.11.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:41:53 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] bfq: use configured slice_idle in bfq_bfqq_is_slow
Date:   Fri, 11 Nov 2022 15:41:48 -0800
Message-Id: <20221111234148.2608273-1-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing a bfqd->, so we'd only ever use the default value here.

Fixes: ab0e43e9cea0 ("block, bfq: modify the peak-rate estimator")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 267baf84870f..827b878a0266 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4160,7 +4160,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  */
 			*delta_ms = BFQ_MIN_TT / NSEC_PER_MSEC;
 		else /* charge at least one seek */
-			*delta_ms = bfq_slice_idle / NSEC_PER_MSEC;
+			*delta_ms = bfqd->bfq_slice_idle / NSEC_PER_MSEC;
 
 		return slow;
 	}
-- 
2.38.1.431.g37b22c650d-goog

