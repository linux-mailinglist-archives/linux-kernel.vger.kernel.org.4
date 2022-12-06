Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AE643E47
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiLFIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLFIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:16:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33918E19
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:16:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so4434834ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIGTr+7euArpiTpzI80FpH3/QoI1PLTpeFSiS7XZzKI=;
        b=GYETnHd8eiTTncZxQpBvSQi3BbYW5rDLYYzD0TtKTJUNRDDyx7OpK61BXwV1+m5/KE
         x7XlImUAj4Kor/DOnJasoxIKA/Md4cVrClTSQ1eKB+gumO3q1/Yp5IpFra5zOvenEjXO
         QZ4hSr2E1Q8Uz4UcaKiFDsmqRZ8CygCmpdpW1eDfMFY9sZxiEmJrVXAudPg0gXPcOySt
         UINzhec9E+UXobJootA84YNLede5ynABmRH7wylw50EvJgrE91G0U0j+Y/gBnnFOV2Gw
         gYiRbEl76gwbKwlcxqWmGB0Z5pNczxZ7GOsmYCyzifM0+JJ6dhFy5SgZAET/K/dSm6Tw
         yxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIGTr+7euArpiTpzI80FpH3/QoI1PLTpeFSiS7XZzKI=;
        b=Wf2+4z3VC8/ZN473LhmtjqatuVyDOO1H8N1nmm0auX7PumInLagu1klvzL8y9CESyi
         7JIiHcWapm8e8vSFvYUfyTBiXXsdzfVoseKHOGqy7D1buB61bHwRd3BfovN3rYIMKUIj
         mqpEV5LjD730bR8d1gHDyvLCz91+9tPAPsaOkuNbeXKCUCCs2BtYoNNE5jxOwUaMMab1
         DCex+nhLLMWzgORsH3LuWRWqZOEnxfXLRiSIPxGDuITTCB5jLCUcMgGWZbmxHXaEEKxU
         5LPKGtOn6W0t9Ayra26+hF07XuSUC9A6i6X/trm/mBqXmy2loDiMHrZ9q3jXKJaBwceM
         brCg==
X-Gm-Message-State: ANoB5pmg5FpEiLTcz14jiauL8NKbHiolizfoSXxijTi1S80hNASw1UN6
        c9LmFL99xCRV9Bg+hCVE8RbIuQ==
X-Google-Smtp-Source: AA0mqf5x7UfKblxILdjxFcL99wCRjpiXgBQhZSMMA3pY9x7wwQdFIA0HpVKTxUADHfv/po1dpUmF2Q==
X-Received: by 2002:a17:906:2599:b0:78d:474c:2a59 with SMTP id m25-20020a170906259900b0078d474c2a59mr72397901ejb.759.1670314565487;
        Tue, 06 Dec 2022 00:16:05 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.16.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:16:05 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  6 Dec 2022 09:15:51 +0100
Message-Id: <20221206081551.28257-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206081551.28257-1-paolo.valente@linaro.org>
References: <20221206081551.28257-1-paolo.valente@linaro.org>
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
index f4df5710b648..6a360d5bae1c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4830,10 +4830,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
@@ -4841,7 +4847,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
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

