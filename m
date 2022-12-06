Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F40644948
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiLFQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiLFQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:32:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D22F388
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:32:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so7477265ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwWeCBK43lqRezZbDDRSdpdYH1vk8ywm/zjLwm/Qfxw=;
        b=auJ7V7z0YebffYVmzZQ99Qw4tT9ufy4EmsjOHqc5Is4FHD2aJLjzbJRYHiz2f0G5oi
         0aRsHlraZjxIyJ1QGQPmuPXyRLT8Y5MWqqpiA9PKa57eUn0CWD57R2/9bWHEATjYwQYJ
         fhXMOXS/C5M4WX/eygKgbDh7U5UA6Cc1fFxlVhOFwOuDZP+LgthkaFZTYDi+qAzgCFRB
         sn7K8F/oQ+kuqJQw2gpgDlORlHLhhw//ju6Hf9PKmBD7mPMms4vPlF8q91k8TSC5ixY/
         y8ilB/sdqKI3FXaWWT3GQneTnQ0sbIN6OQqJzX9a3nwSaTj0cDe4+hYNdx95wqiG09D8
         G0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwWeCBK43lqRezZbDDRSdpdYH1vk8ywm/zjLwm/Qfxw=;
        b=KPoF80X3i9Rx4bo33hvcZCeBCrEnlO3fXbBkMo6OY4oq2tBzmvr9I5/AmLnHipc7bV
         qyFq9bNu8XmTH6diHRqy1zRZcJs0H0ktL4NMnJlmbU0xyhlSxlud1Clwx4rFjTiZUr9m
         esxl9hr7Pl96B9nWl2kpwwHaonwwG8r3xpKoYm6/zwYyrpgqSgerGwkV5iUNI33RG6cr
         +KnOEwQ6wv7Z4daJAnvtFdIHA8SWLvNNoT4eQO3fOExRE3ZaPQo9NVUZdwLCsEZQhITb
         ETNdgrrMhn9DFefgThtgwUXFElcU696cyF/R6HhkK6dm1esWw6msHSwsgp1YamYwCtFy
         ouNg==
X-Gm-Message-State: ANoB5pmyGVjWe4CZ5N08bE2YWzB9VLawVnpTLvc6p/BYGhMQ/biwzi7i
        Xwl+BehEGPG+0lV+592URh8GPg==
X-Google-Smtp-Source: AA0mqf4/xeR7KGwkhWhtcMes0clyGddLrkI/riVSAzjl6HhVZouW0/bktjZRFmtlAb+3UQEKVM9Wuw==
X-Received: by 2002:a17:907:8c8e:b0:78d:4167:cf08 with SMTP id td14-20020a1709078c8e00b0078d4167cf08mr25860144ejc.337.1670344338265;
        Tue, 06 Dec 2022 08:32:18 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id t5-20020a056402020500b0046ac460da13sm1170104edv.53.2022.12.06.08.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:32:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V8 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  6 Dec 2022 17:32:03 +0100
Message-Id: <20221206163203.30071-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206163203.30071-1-paolo.valente@linaro.org>
References: <20221206163203.30071-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5854f37ccb2..76301b5148c5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4831,10 +4831,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshold
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 static struct bfq_queue *
 bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
@@ -4842,7 +4848,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++) {
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

