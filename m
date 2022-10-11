Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF825FB212
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJKMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJKMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:08:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F920F45
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:08:42 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l5so15622380oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GX/EVFZiDxV5YSrMfs5F2mJclGh31BfpMrxb1LPPV+Y=;
        b=3kYvrRBTFFUUgZ0iHmJep7Nu1IpnKtjUnjDZw8fMnomUqEbBMZr5ShjPgJLuX7bLH1
         vOm16xyYEwloNVbeW5mYjHbRWJFLqled7//HvS6OX0m5+YBRzQ45szPg7fouyGpIMfWF
         0Yud7NPFgHln2oV6Uw5pMTEEOqI/7x8PKlk9i3jvSjpqIqkm7fLNVqa7roIn37TbZTD3
         CNVDyQD9WtVzgX3TaxluwqIc0PAPlJybnKOKdY1c6oQUbzpUfnEeDxoQQr9+pHEhdD/w
         YFVlvdsysBzLT3fgP8lfVhCPHQl0ffjeW2bZtzUsmR+RTNo4SvfGnYHQXxU1QxdGe0HF
         C17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX/EVFZiDxV5YSrMfs5F2mJclGh31BfpMrxb1LPPV+Y=;
        b=0hHGs29BVKya4klQXaJtlbpi3KuBA+0D0HaOSpUMU5t01QJV+LHd1Z3zn7TAYC/oBV
         f4A7Aconguk2ipBkCfQfKwiimbhII57ZySfa1zjz5u/PMe1lJLv1xrcXyNi4sQypdyEm
         USZYSVzg3Zc1RNIX4vSEKE3JsIRsx5uYSSIFvIrhheaKgbGNRdriZ8auBK1nnrgi3ElB
         oBHQS/XGo9E+D3dE/qXxGuqhLM+TaJNkQv3OUHouUJiaW8yAjJ3/fIRnQ7p9aDMHC5hy
         q8vN40qutRQuHdKLeLjwQfWs5hV+OOrAHHD4qCLPGRiulU6OqgD5AK20uWBeWu1hzOMB
         3R/A==
X-Gm-Message-State: ACrzQf1iu1nSjmaiZ+PWWYPb38XiRsX6v5fPH6MKez9sNNa2UhjGhtyM
        ucoP/KSxM/M56MB9MbpNQ0SxhwXl4EuIPQ==
X-Google-Smtp-Source: AMsMyM6ircMtQ5ZqI9p9hkbo0tneftBCJsQcBMgW9dQcu7mjSwjajFsAYp0mILRbqgMTmn1Qd1x6WQ==
X-Received: by 2002:a17:90b:3555:b0:20a:c2d5:d361 with SMTP id lt21-20020a17090b355500b0020ac2d5d361mr27220661pjb.50.1665490110596;
        Tue, 11 Oct 2022 05:08:30 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001783f964fe3sm8563372plh.113.2022.10.11.05.08.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Oct 2022 05:08:30 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     peterz@infradead.org, vincent.guittot@linaro.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH] sched/core.c: Add min_ratio for cfs bandwidth_control
Date:   Tue, 11 Oct 2022 20:07:21 +0800
Message-Id: <20221011120721.46288-1-zhouchuyi@bytedance.com>
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
index e650946816d0..375c14f8fca9 100644
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
index 60fdc0faf1c9..fc5b6671154d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10541,6 +10541,12 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
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
@@ -10550,6 +10556,20 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
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
@@ -10585,6 +10605,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				     burst + quota > max_cfs_runtime))
 		return -EINVAL;
 
+	if (quota != RUNTIME_INF && check_cfs_bandwidth_min_ratio(period, quota))
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 205d605cacc5..26f05ec7d9aa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1642,6 +1642,16 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_FOUR,
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

