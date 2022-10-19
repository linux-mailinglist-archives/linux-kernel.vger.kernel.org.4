Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6F603884
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSDQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSDQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:16:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB31D259C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:16:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 3so15987535pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83J0FWeQ22MhRLlQnaI+JzsDt7vTIzx9w1sgOTApdqk=;
        b=1fwPqOJJ2N6WhOI8lMbkbqGZPwTcxZEmQSEj4yn4JR09qobPUr715RcR1jNSC9EtBY
         t49JAd312c6EIDDGtwL+ANn/vL9LTubcnia7gIPmE809/e5J2v9MmL9yAwMXGOkh98Ip
         BElTm90OcMgZ/aECd2iSFsYOftV4ZKfGzYxDYUZexz9JJtZ6XSFyClV65p6iXKTuvbug
         ORjkBIR7FpnpCXfxdFBDNuWbNN+hCc5XQ2ytR2TQlKo6n4U7LnEt9NFxjfm/0DiqQ4ZZ
         6LLkVYGokcldu400CAfoV5LdvpUFTaaQousEfu2CNvfrAp7/uLTDzdE8S8zN+rPyisp5
         Oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83J0FWeQ22MhRLlQnaI+JzsDt7vTIzx9w1sgOTApdqk=;
        b=kuwzutkw9BkmKoluXHYdTudHCtOM6220yh/7c5vKERsyixj6voOwxHbSSXr+41vYYu
         W/qnz0BrkasS6Uz3gdjufAirLLPEo2Zed7LNAsGOoZyXhDq3f5jIz+AMbPgypIfWCbpc
         1IbVgWtqHlr17aVicaWfHB5JFjZ65AYydlwdjcF/91nKxIq/NwL9KEdzH73iQ2f+BjPe
         /7WzLM7sJajae7N4/wgmCOutFt2ckq1ZfwuIbbnh3HicrTy/LdCjp6ReRBJr5YSYgubt
         bmRjcFM9Jp1JAzuJUtihkA5bkxhswKfhj3NRSMT0a7gnFcP9KfwZ/4bOsUABX5PpfFok
         cjFw==
X-Gm-Message-State: ACrzQf2CjmoFmpFINOEqQstiy4u6xgEpxZJviFMylW7c82zqA+EtcQ67
        TdDBn8t5++kIa4KXdYXUv8jEyw==
X-Google-Smtp-Source: AMsMyM7MVlXJ20rcoJ2zc1Oa70fPiGAo5jqt14ycMiQ9FKiJntMamEfErQwEklnafueys/wR8loUPw==
X-Received: by 2002:a63:6b09:0:b0:453:88a9:1d18 with SMTP id g9-20020a636b09000000b0045388a91d18mr5285511pgc.41.1666149370436;
        Tue, 18 Oct 2022 20:16:10 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b005631f2b9ba2sm10284984pfb.14.2022.10.18.20.16.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Oct 2022 20:16:09 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, htejun@gmail.com,
        lizefan.x@bytedance.com, vschneid@redhat.com, bsegall@google.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
Date:   Wed, 19 Oct 2022 11:15:51 +0800
Message-Id: <20221019031551.24312-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Tasks may be throttled when holding locks for a long time by current
cfs bandwidth control mechanism once users set a too small quota/period
ratio, which can result whole system get stuck[1].

In order to prevent the above situation from happening, this patch adds
sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
the minimum percentage of quota/period users can set. The default value is
zero and users can set quota and period without triggering this constraint.

Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/sysctl.h |  4 ++++
 kernel/sched/core.c          | 23 +++++++++++++++++++++++
 kernel/sysctl.c              | 10 ++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 303ee7dd0c7e..dedb18648f0e 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -21,6 +21,10 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
+#ifdef CONFIG_CFS_BANDWIDTH
+extern unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
+#endif
+
 #define NUMA_BALANCING_DISABLED		0x0
 #define NUMA_BALANCING_NORMAL		0x1
 #define NUMA_BALANCING_MEMORY_TIERING	0x2
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..8f6cfd889e37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10504,6 +10504,12 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
+/*
+ * The minimum of quota/period ratio users can set, default is zero and users can set
+ * quota and period without triggering this constraint.
+ */
+unsigned int sysctl_sched_cfs_bandwidth_min_ratio;
+
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
@@ -10513,6 +10519,20 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
+static int check_cfs_bandwidth_min_ratio(u64 period, u64 quota)
+{
+	u64 ratio;
+
+	if (!sysctl_sched_cfs_bandwidth_min_ratio)
+		return 0;
+
+	ratio = div64_u64(quota * 100, period);
+	if (ratio < sysctl_sched_cfs_bandwidth_min_ratio)
+		return -1;
+
+	return 0;
+}
+
 static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				u64 burst)
 {
@@ -10548,6 +10568,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				     burst + quota > max_cfs_runtime))
 		return -EINVAL;
 
+	if (quota != RUNTIME_INF && check_cfs_bandwidth_min_ratio(period, quota))
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 188c305aeb8b..7d9743e8e514 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1652,6 +1652,16 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+#ifdef CONFIG_CFS_BANDWIDTH
+	{
+		.procname	= "sched_cfs_bandwidth_min_ratio",
+		.data		= &sysctl_sched_cfs_bandwidth_min_ratio,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+#endif /* CONFIG_CFS_BANDWIDTH */
 	{
 		.procname	= "panic",
 		.data		= &panic_timeout,
-- 
2.20.1

