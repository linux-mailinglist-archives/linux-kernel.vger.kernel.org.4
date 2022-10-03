Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF49F5F3035
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJCMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:21:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6FBF8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:21:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso8404042wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ISDBNtk9AqrLC0VmrKPgoTR8aPulRadxduWSlp1K3as=;
        b=yYlC/+HfGVDkU03dbR4rFdlbMXWCK+9I7h4fsF5/jBRFi45LyRuCt7MZzt63SFF78J
         505ay98sRbrSqpR32aj20yPxrXS3EbSddeNzFuA0KAKFUo2U7dQUBM3zO5z0tAQ5ahXf
         OUhJsV20x6Fp6J4bGcJhpaFM0zXcUaPzrwC7IqaW5GW+kV0jDgmUNppjYkNCVnePjBGg
         yKwaIesZ0Xe8rFbOi23tHGjibWXub63G8RB7EC8HtX9EfXm1KmRDW1mDv8M/C9RhmJND
         3fYl8jCw8lu4HiBT6MRKiPd/UV1gbawGDChfJDMU6LWAvtokib76pkIn1xzQ2qbuGZue
         8hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ISDBNtk9AqrLC0VmrKPgoTR8aPulRadxduWSlp1K3as=;
        b=FEHMttXsvxOVRVZTvL0W7mU58UmmGfVkE8IpaPhwfa2uAwyvdyFCQLxkuEJHU+9Uez
         yVcqJgApmEv33Fx1OtcHD4r8dB94RdqsxH8iZkEsBoH69sSkJgL2Nd8Go6L3ByJKKMzv
         NB9lzM29rxyP6u/avdZ/iInAnXaWMU5kKhI/FxW9tYH//cjmzXI/pquhG+Cr/2C8KDU1
         gx8FVJc3qMsdqlnheNxCGCcoOCRCqs4TsCoAjH5M7jrDwxE/0nH2krOilrXReMjpN2e5
         iJav7md9gEmL5BcYzjLc1zk97K43hCG/6r4vdQW5NG02I2sFma2dodmYrEGRFypK2sVV
         Vx1Q==
X-Gm-Message-State: ACrzQf3yp0opHXBUwAiXPZlCp+npuJArzZJXowaEeJtZHE7QLckjpmvW
        CDOCZb6piP6p1GMpCa+VRNJYig==
X-Google-Smtp-Source: AMsMyM4LMyR4Scv/AReTojDNnDLNQ2dop+CQoNPCP2wxCr3f6Z0GB6ZZekf+GEaNIVUE/5UfWyXFIA==
X-Received: by 2002:a05:600c:3d17:b0:3b4:adc7:976c with SMTP id bh23-20020a05600c3d1700b003b4adc7976cmr6517632wmb.108.1664799675339;
        Mon, 03 Oct 2022 05:21:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8c93:bcad:2cd3:a7ad])
        by smtp.gmail.com with ESMTPSA id l22-20020a056000023600b00225239d9265sm10016173wrz.74.2022.10.03.05.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:21:14 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: limit sched slice duration
Date:   Mon,  3 Oct 2022 14:21:11 +0200
Message-Id: <20221003122111.611-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In presence of a lot of small weight tasks like sched_idle tasks, normal
or high weight tasks can see their ideal runtime (sched_slice) to increase
to hundreds ms whereas it normally stays below sysctl_sched_latency.

2 normal tasks running on a CPU will have a max sched_slice of 12ms
(half of the sched_period). This means that they will make progress
every sysctl_sched_latency period.

If we now add 1000 idle tasks on the CPU, the sched_period becomes
3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
It will even become 1500ms if the idle tasks belongs to an idle cgroup.
This means that the scheduler will look for picking another waiting task
after 609ms running time (1500ms respectively). The idle tasks change
significantly the way the 2 normal tasks interleave their running time
slot whereas they should have a small impact.

Such long sched_slice can delay significantly the release of resources
as the tasks can wait hundreds of ms before the next running slot just
because of idle tasks queued on the rq.

Cap the ideal_runtime to sysctl_sched_latency to make sure that tasks will
regularly make progress and will not be significantly impacted by
idle/background tasks queued on the rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v2:
- Cap ideal_runtime from the beg as suggested by Peter

 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ffec4370602..c309d57efb2c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4584,7 +4584,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	struct sched_entity *se;
 	s64 delta;
 
-	ideal_runtime = sched_slice(cfs_rq, curr);
+	/*
+	 * When many tasks blow up the sched_period; it is possible that
+	 * sched_slice() reports unusually large results (when many tasks are
+	 * very light for example). Therefore impose a maximum.
+	 */
+	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
+
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
 		resched_curr(rq_of(cfs_rq));
-- 
2.17.1

