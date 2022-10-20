Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28160647D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJTP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJTP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4D91E09AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so1949199wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCbyLMSIwCFaLYXKLCOo4G7nJD5L3ekihEuWwF8mvwE=;
        b=AHsOeapv1EyxJ+xdz0WzZjvTMxMBeHTZ6UtguuVOJ9Gl62qUZIjrdJXYVqjBjsPcxF
         f16HghPj2YMDQLefKmMlvFLbbnCklef/5UMFwyeMQTshmiGIQHTiHxPYF0JpdZtEgmli
         VpP63PsFk+o24RwaMpCIgvGuHiwwNik0jpvKhKjurFhVXiVG/mRDL5WJuQakZD7vPEF4
         gIs+wcfl3q/KZs91d/k/Ki4xhbabkzGORwbNI/mR07UacD5pEFAgFG1bTgaaa4Ke6pfV
         5uQVFXgAWLkFvoM9rJIfeVg8yT8zLHQfqxXDjE40eMRdxweRUyM3dNyrQWdfC4qiog3U
         hLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCbyLMSIwCFaLYXKLCOo4G7nJD5L3ekihEuWwF8mvwE=;
        b=RoUW2ytHOJg1H6HfXX6S9l195+zjoUIuPj0uGq2fIm7gfb9Jws/zkVpB47GK7eU9ov
         CrQiho/G9TTl5rcHVx4Pc+unX0TfQx/bdwpvOw7XEABc5ywIX2t/QaBtfYt/GEaxvXTT
         no2K8qS5f0VvVWEMeG+P1Fpu/NpoBWgcEPOAW9m+PEh7ogaHCZ76W/eCVszEUro6cOxV
         qT+aO1yHC6QBnZbflC8G0PdRorKlmUNPdPt/vnWEcJ4V6gFYcZnI72d7n/0Jxz/66xKK
         dInfmLXQesJLq1iuTGbTKT7DLbItdKSW0uJbo+EPNylGTmkPd/TiZW8VorE26rvCqFJq
         ikDA==
X-Gm-Message-State: ACrzQf06y1hzL5eZdXHbx38QlbN66DeNZyHJ3asW2bo0+RbMZAHjiOQM
        6+LvgcfZ98+PPdiuc+zHfFyJBg==
X-Google-Smtp-Source: AMsMyM6T/Q23E1nYwJNyAnSSIRY+OeFn/EWUv8rRi4c/ox7+0bnVyTjq0llT45iQOJ9xvo+3ghTMkQ==
X-Received: by 2002:a5d:64cf:0:b0:231:2e6c:7609 with SMTP id f15-20020a5d64cf000000b002312e6c7609mr9115673wri.172.1666279623573;
        Thu, 20 Oct 2022 08:27:03 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.27.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:27:03 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V4 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu, 20 Oct 2022 17:26:43 +0200
Message-Id: <20221020152643.21199-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020152643.21199-1-paolo.valente@linaro.org>
References: <20221020152643.21199-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 77d3ddabf059..b178dfe8a5c8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4819,10 +4819,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
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
@@ -4830,7 +4836,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++)
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

