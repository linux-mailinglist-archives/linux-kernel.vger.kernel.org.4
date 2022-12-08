Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3C646D89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLHKtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLHKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:48:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530D554FA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:44:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c17so1492959edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOY4Ejzg/9nAKzPYo9tETGRaOoSPvAWifxplSzBGXYw=;
        b=cDvtWPvf3S8NQ0fSkfns/Z6fkpvUbHGNiMlgP5rHJmAIJJ3gdhSwr+Ct+fE6bKpMyH
         Kyowaj7BdY6BUilN+ffaZ4FZr/895aMTTysEHE517g0mCsydJxDpfHxD9/gN9fpwmHHY
         o+vfejQrND/Vc2WPHgebfl+3y0sLQHLoW+kaR+PRnkEL2cnIpjpneq9jEDLcvYLcl4X9
         kwiMJAQI1/WsxSUi1sGBOgRdwADaoQQpKB6Lm8f7Lp8iCMrTd24/rsv04FdEM30l/Gba
         QZCZtWtShZLblG4OfO9JO2qGGQc7en+24D3ol/7+Fme1C+wxJqzYNEDswr2uO/J8WMZz
         2w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOY4Ejzg/9nAKzPYo9tETGRaOoSPvAWifxplSzBGXYw=;
        b=40viGIg4JAIT/BBSKMaZcKnVzHwvclpUHUlL3FjYtmIyKSOhQuUA5XgPRHHlBnkaW3
         1xiynBGIivQQdNvT93IAGRwI77pWXwguj8YhMkrD6px+8Jzu7KNIZt/ZkDpRf3EEMIki
         8E2gMWCDMkqUP+iurdM1EbbeaDiI6H/Pco4/6k+rhyyPfkSpQ4+SkfvJHYSUT1PJ7JqV
         g9fWo5xs+2JP65lpVdxhZlNAxDY8gJGQhLSeEE9soJMsln81XRQwCiZG1qIjzy71y7Ha
         zsUry/Y1IxQEoloEvAauXlc8F5PX1uvO/Xn/9bavM95br1gmsW8U20DEW7VqL+0LY/R1
         1HMQ==
X-Gm-Message-State: ANoB5pkJoKMAWj366bDIWztRjOFQFV71vEdUBrTMYaEGBVZgTwWarEaW
        MlF8PKs5tejoZDMsxb20lIOulw==
X-Google-Smtp-Source: AA0mqf5DbytpsRHY37Acv77YDMF7k+SRvEDaeQeJULi7KDFF/PCAnkZWmS7C0RPVZkyH2ROxgNsXHg==
X-Received: by 2002:a05:6402:2946:b0:468:febe:ebab with SMTP id ed6-20020a056402294600b00468febeebabmr37209892edb.337.1670496245540;
        Thu, 08 Dec 2022 02:44:05 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.44.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:44:05 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V9 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu,  8 Dec 2022 11:43:51 +0100
Message-Id: <20221208104351.35038-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221208104351.35038-1-paolo.valente@linaro.org>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
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
index 16230a9cf794..016b1b73aeb2 100644
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

