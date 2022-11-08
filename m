Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4764621B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiKHSK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiKHSKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:10:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25153EE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:10:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso18649596pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doefm16lSnPXsJmoD4HfwCSvjxjKuEr5Qsn95UJjEvs=;
        b=iWqJN2aTT85XOWY8kqWAzz6nDxz79xyLSl9V9Go+paQEpkuEzdzQQJ0UrLhmGmD/IB
         mZtuMuH1CGWHSYGAThg7Xm282vcRJlk45sKx07CmtvpsiXsV3YHnrkTXuiu1C4HRwuyR
         Lz0jPfUPhf0DogtOkredrzdlTfzSCGY7HuqBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doefm16lSnPXsJmoD4HfwCSvjxjKuEr5Qsn95UJjEvs=;
        b=Wf+BtMgZfpPaCQv1gXhrhK2K5nHNhGfz/mQj/SXqs99iMFXHu8yW/9MAMp48Szfg6R
         /yiUNH3UFdkfRQ0Unmql7+yGQFdBDHzleBcxachp+NCSsRvj0Zha+J9Gntj9WKCIYJbc
         AsV8TOgAGmI3qrQI7c9dM+E+LDcBnaR+GC9eil6g+x55zzFhKtEsdhdpd5K6Fpe3UjMD
         GSxMkZ4/gov2/Un3gaWLQBy7g+4SzuX1PSry1Ai5PMuxKyhi64gb8K+21kht7IaclFoG
         eMgdKpfWF4djSpuBeSdqj1q02oD/cb+wk62FjRlUtR8Pbx+6w6qTSdvgqAAaCrP+TDu1
         vbdQ==
X-Gm-Message-State: ACrzQf1VqfjPeDpvGGKZGu8EjOX/oO2KK2vuvaS5mXR/L78OEpPKyhJH
        QBNjU2MtmcOHHlq1o+n2FjwKPw==
X-Google-Smtp-Source: AMsMyM68HhKupkJBpyvCvguW+US1Mfr9RRdIRyS8SygEK6NABnZyhxXZkaKBENdkw6H30lJ+neDBGA==
X-Received: by 2002:a17:90a:c592:b0:213:9c65:b78f with SMTP id l18-20020a17090ac59200b002139c65b78fmr57515431pjt.14.1667931048089;
        Tue, 08 Nov 2022 10:10:48 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:21f:525:beef:f928])
        by smtp.gmail.com with ESMTPSA id h3-20020a63df43000000b0046fd180640asm6048754pgj.24.2022.11.08.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:10:47 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 2/2] bfq: ignore oom_bfqq in bfq_check_waker
Date:   Tue,  8 Nov 2022 10:10:30 -0800
Message-Id: <20221108181030.1611703-2-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221108181030.1611703-1-khazhy@google.com>
References: <20221103013937.603626-1-khazhy@google.com>
 <20221108181030.1611703-1-khazhy@google.com>
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

oom_bfqq is just a fallback bfqq, so shouldn't be used with waker
detection.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ca04ec868c40..267baf84870f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2135,7 +2135,9 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
-	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC)
+	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
+	    bfqd->last_completed_rq_bfqq == &bfqd->oom_bfqq ||
+	    bfqq == &bfqd->oom_bfqq)
 		return;
 
 	/*
-- 
2.38.1.431.g37b22c650d-goog

