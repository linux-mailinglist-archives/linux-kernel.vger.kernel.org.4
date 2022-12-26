Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D71655F53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiLZDK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiLZDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:10:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0138B9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 19:10:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w37so6556293pga.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 19:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ji0q1Z4WQS4zGRjkvxdgaO9ivOvKJ8OfhlNxwlytbYA=;
        b=67EB5v1XnyKVCzNkmJNYKTX8RvLqkX5GuB4Q0cfiuAb8HX29J0G8DRqpk76aSVCVK7
         YQ3STjhgBwkunn5yQ4wlnPgFxfL05OXn0HHnpVb3Y4gSkBQ5dV392GAH2swhqd2dkCK8
         7gTFXf3jnXtG+rDcxbs2L/p/nWInUf0sO7PIXu6EaKPx25HCx/1oM8vgliklcy0Q/jqY
         zxOYACTFzskenXp95XGG9xTSiSHcrgBoIxF8U+jo8MtRMd0cASe6rinbRyyp2Ar3XoMd
         Vf9xYg05aX/DY1xrqiVTc/wNBMNJ+oxTX4r5iAm0P6CRKbOE5ZwbPR/nOxMEolPaBZ7l
         /NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji0q1Z4WQS4zGRjkvxdgaO9ivOvKJ8OfhlNxwlytbYA=;
        b=HULNl6WxKszR4bHH93RwFi4AfP+EQb0Ohv6UQMvYU3Io60bgGcUzIw594SFmKgqMOe
         1DicQmbYkXq/dA1dbuvSJBMkSeJvdkERJJ8Lmih6HTa2ciqDhot3YWagYCG6YS9a0Iki
         UhaYoe85NkBHcu3hfPUOrsVSpnwFCQYm1bByUFGE8nds0nQMY6/96dYLbjIOGxHr7EfL
         kOUyLNjCqTuhHWvRfeWfASU8z44WOrYFIWE2OPkWn4SQZbc9qKbjpjFCajMXibWxfGTo
         3LQ2+OWYESE0E//Dl3snFTJCroPGXRIkzEOsiL6FjJ9NO+T6foSG/6lYQlcARoiOpdoc
         LBew==
X-Gm-Message-State: AFqh2kpQa5rSQ4ke8U8QpKhDIh7sByTk3R6BlIZjwQcSsVKS83DRRolW
        pnIEtNNJxO2DhI5CkG5sxLSxLQ==
X-Google-Smtp-Source: AMrXdXs6TF0idbfM7gip57fyBicXpp50m1VDkTMQcUB6REVFcZydXL8ZKFS89kdGS5+FAO9QlMZNVw==
X-Received: by 2002:aa7:84cb:0:b0:57f:de9e:5e85 with SMTP id x11-20020aa784cb000000b0057fde9e5e85mr29340297pfn.20.1672024220071;
        Sun, 25 Dec 2022 19:10:20 -0800 (PST)
Received: from n137-027-198.byted.org ([121.30.179.157])
        by smtp.gmail.com with ESMTPSA id e63-20020a621e42000000b00574866d619asm5876831pfe.119.2022.12.25.19.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 19:10:19 -0800 (PST)
From:   Ma Xing <maxing.lan@bytedance.com>
To:     maxing.lan@bytedance.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cputime: Make cputime_adjust() more accurate
Date:   Mon, 26 Dec 2022 11:10:10 +0800
Message-Id: <20221226031010.4079885-1-maxing.lan@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current algorithm of cputime_adjust(), the accumulated stime and
utime are used to divide the accumulated rtime. When the value is very
large, it is easy for the stime or utime not to be updated.

A better and intuitive way is to save the last stime and utime, and
divide the rtime increment proportionally according to the tick
increment.

Signed-off-by: Ma Xing <maxing.lan@bytedance.com>
---
 include/linux/sched.h         |  2 ++
 include/linux/sched/cputime.h |  1 +
 kernel/sched/cputime.c        | 38 +++++++++++++++++++++++++----------
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..41b69ea8b717 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -325,6 +325,8 @@ struct prev_cputime {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	u64				utime;
 	u64				stime;
+	u64				utick;
+	u64				stick;
 	raw_spinlock_t			lock;
 #endif
 };
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index ce3c58286062..db5c32d4a467 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -182,6 +182,7 @@ static inline void prev_cputime_init(struct prev_cputime *prev)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	prev->utime = prev->stime = 0;
+	prev->utick = prev->stick = 0;
 	raw_spin_lock_init(&prev->lock);
 #endif
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 95fc77853743..d94e9a306478 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -555,6 +555,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
 {
 	u64 rtime, stime, utime;
+	s64 delta_rtime, delta_stime, delta_utime;
 	unsigned long flags;
 
 	/* Serialize concurrent callers such that we can honour our guarantees */
@@ -575,22 +576,36 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	stime = curr->stime;
 	utime = curr->utime;
 
+
+	delta_rtime = rtime - prev->stime - prev->utime;
+	delta_stime = stime - prev->stick;
+	delta_utime = utime - prev->utick;
+
+	prev->stick = stime;
+	prev->utick = utime;
+
 	/*
 	 * If either stime or utime are 0, assume all runtime is userspace.
 	 * Once a task gets some ticks, the monotonicity code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
 	if (stime == 0) {
-		utime = rtime;
+		delta_utime = delta_rtime;
 		goto update;
 	}
 
 	if (utime == 0) {
-		stime = rtime;
+		delta_stime = delta_rtime;
 		goto update;
 	}
 
-	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	if (delta_stime <= 0)
+		goto update;
+
+	if (delta_utime <= 0)
+		goto update;
+
+	delta_stime = mul_u64_u64_div_u64(delta_stime, delta_rtime, delta_stime + delta_utime);
 
 update:
 	/*
@@ -602,21 +617,22 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 *            = (rtime_i+1 - rtime_i) + utime_i
 	 *            >= utime_i
 	 */
-	if (stime < prev->stime)
-		stime = prev->stime;
-	utime = rtime - stime;
+	if (delta_stime <= 0)
+		delta_stime = 0;
+	delta_utime = delta_rtime - delta_stime;
+
 
 	/*
 	 * Make sure utime doesn't go backwards; this still preserves
 	 * monotonicity for stime, analogous argument to above.
 	 */
-	if (utime < prev->utime) {
-		utime = prev->utime;
-		stime = rtime - utime;
+	if (delta_utime <= 0) {
+		delta_utime = 0;
+		delta_stime = delta_rtime - delta_utime;
 	}
 
-	prev->stime = stime;
-	prev->utime = utime;
+	prev->stime += delta_stime;
+	prev->utime += delta_utime;
 out:
 	*ut = prev->utime;
 	*st = prev->stime;
-- 
2.20.1

