Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC866129DE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ3KEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJ3KDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98F1F2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt23so22774426ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM3QRj1EVjuG2HTGTPAAvacJgPBGfkkz821afQrSz+o=;
        b=PbgYJjGDH30zX4rdDzg7LxIyS9IvehyrFKlkCIMb7d38wicDPUuQlJrs0rlAyP5U5e
         gF2SvDn3urpigL1xA5RxlXjyWPOb8UoVzphOzXCUHrUdDoFVoc/hmGnszls6M1uxXFgr
         Beu4AjvpK5w1rgouIZ/uj4IBPDJkajcSKV90jRKzTRKOEgshyukaP6xnaFU20bw5DUnh
         lQnkNUR2CkKgR/utbea9eMQDriAxG5DFHGumBuVHbJfAXR3yzws9cA+NZgkib7aIOfOy
         I+7kNFs35qV3dXazGpwls6/22scL8c5Bwqmypqnvt5o5KODldohefOy5FkcF8RSNnunE
         OBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM3QRj1EVjuG2HTGTPAAvacJgPBGfkkz821afQrSz+o=;
        b=3uYPFuOoYsOZmjySCWQI98B1b9bWK/pctMGMnrsO68/a3V+8TFnLZyLeJcegxVy+Rw
         moK5Ew3qrk+QOx5q0FqqRRx8A3L55oQWYyFffBWJp0yHYmTKxVayJkwX1BYW4Ht15gPR
         seBCumD2MBXXsiA9SUWVixP14RiI1xDUBrmgbvYU3Xi7NYwN7TyZm0LqC3BoDwrnuvkx
         TG39QGfAJumaPHrhrIgufJZddfShGpEU58XLdUupGRtCdIlM0DTbIyZPceMObz8EcrRc
         VrS11LmQcXOk3Z3S9Wq1ZRKv3JqvLSqKKn4gGVgCG+SGvUMuZQkdHFZI5F3xqUiJOtvs
         ujog==
X-Gm-Message-State: ACrzQf1okYI9eepY+rqoAgNK9BXAtc0nSmoIq8StRiZSehJAu5cBeAfQ
        MBZXRTeXPqlMqak/5dz2eJkUFA==
X-Google-Smtp-Source: AMsMyM6fbaBOfBdgC1p/YVbYOgFLA6QW5gQGUIuMqKBDjre6T8fNB3ltyv24Cap3GQEC5UX5mFb8IA==
X-Received: by 2002:a17:907:761b:b0:7a3:86dd:d330 with SMTP id jx27-20020a170907761b00b007a386ddd330mr7454455ejc.34.1667124223196;
        Sun, 30 Oct 2022 03:03:43 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:42 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V5 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Sun, 30 Oct 2022 11:03:00 +0100
Message-Id: <20221030100300.3085-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221030100300.3085-1-paolo.valente@linaro.org>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
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
index c9af17a36219..77002ebcab39 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4822,10 +4822,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
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
@@ -4833,7 +4839,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
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

