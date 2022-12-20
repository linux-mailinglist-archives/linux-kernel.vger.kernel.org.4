Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D09651E10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLTJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiLTJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295216596
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so27960599eju.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrmisNdFh4dnt9ytoeo+6poFPTzYMLU2CG2aCASb5S8=;
        b=ZX0sUBUOD6mPT1AjhAZd7kvr1+ZWD9nSdZjiZGFC/svzDQfSnRl4W9n1U/QeXgs7EV
         qQN8PCBGt04xy/2ftpEWFicBC5qKiM97p9wgw5uIZ0ZnRCrENJx45pvrj0Xr8nhxWDSC
         VrJ8SWgtKkNRlFi7sVuOI2qZyEvg59yg9hljAT3AydDMdGUOY0WFjrcwI0zk8tIIf45G
         JYtpJkUl+YqkVkFnCQHIa43fO5Vu2fOVMrTBSx+XjyRUemA1RCx30YRzpVvwXhW1v9zx
         8k1WzVqKTuMupdET2wCUpjAUgm3Jsuksi0UhVy2NAdM+PeIg+0DhbKMXK87CZzTHpGD8
         UVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrmisNdFh4dnt9ytoeo+6poFPTzYMLU2CG2aCASb5S8=;
        b=qcmWiQFhLgL5B1JnCEnx/nvWfVCrH8DhO+ZQGxTt3+DfmgvyiXxne3a9ihzIIIMMDh
         xQvaisE2dSh700osBb4/82D1Yv7uXPv1q1tXqoR6SsNtGcJZwsXPGrrB+8vHWSnX1Gdn
         y8s6fc8DtCl4F+9AY5xrkD4v85Bmc34FD7891FF/pu+nsUraAxtTh+jIVDnrMZ/U/a02
         8Rgfra8bxB+7XI1BEXrwujWC0NzCCFDQ55XtNq7C0JhvUOg7CvQhEwK5DFX6a7czo11W
         LL6AO3rUOezfCTfIuGPg3Rv1TgvyJpvDcvxjZsDGEbvOg1D+ab52vxXHeSgMFefIMaqw
         Tvog==
X-Gm-Message-State: ANoB5pkh1stdPcXeyPAnJ0gHsqeyt/Vhru0F83A8HWfy13BNbogdfysx
        gsxjZrRvu6B7dhBf1nf9XcpeqA==
X-Google-Smtp-Source: AA0mqf6Bo+WQfwOiqLeFeZbWG9C1okNWBOzgG3xfzENouUIanG47suRpxj5JcgziewuIdwN+229BQQ==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr38470939ejb.74.1671529829849;
        Tue, 20 Dec 2022 01:50:29 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:29 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V11 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue, 20 Dec 2022 10:50:13 +0100
Message-Id: <20221220095013.55803-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221220095013.55803-1-paolo.valente@linaro.org>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c46f1f81e65b..35d7b8123501 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4761,10 +4761,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
@@ -4772,7 +4778,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
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

