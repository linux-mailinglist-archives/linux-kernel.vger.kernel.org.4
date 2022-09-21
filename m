Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87205BF694
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUGrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:47:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAC77E87
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:47:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so5464210pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YKmiNCL23WE57xBpMjvetlOGzH6dcSznAfjUp/F/KjI=;
        b=S/OWLpu8/5jFvci3PF6KKFjZAWV8sfpD6EB2HvvJtYHmbS1wDhf2tqEqrHhsxPdznr
         7Xl63Ro2rdWamL1oT8uEx/ZrWq2QnonCQijnSrGXJjznTUy+kMnvk5GmBUWryYjemC/T
         iF7482K53z7grnG8c8F87VkM0VIX164G7R7/xsKj6HuMAhwa4+0vM7D9+TCKrltHyEWx
         HLWv/DHgAtI6Sp9HJH6wCX/sjVQkaPS6sn99HM23MxS8s3XiJY15q1EaTL8YqK21MBsw
         Xr6SIM+1oU7JDT1DQiyRAewiPqdocLGFYdjYpzNi/PrqNFsKD8jowDT8NWtIiKLW4gaX
         Jy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YKmiNCL23WE57xBpMjvetlOGzH6dcSznAfjUp/F/KjI=;
        b=eINNqCKx7gEPTRVUOqiK1Kl9gZ1FKiRli/FrR6ASpsZXr/diORjhDdxxB+Dj/9MGpe
         i02REUSBncoIIh9Me3uiP4Fm0ISBzeE3pig1E7nqKLTafqD4lbfSOTR++SM1xPBW2mbq
         dd3QBCtcvQndzk5fTHvRGtRB/ZFkIjMsA1zB0MKvCz/8ET3m93q1SYzf/k+J1LmIiGiM
         APFxA2IHpVUaV6CnpvUNC1QpHdhFJBoGhebUxNpe9DS21BrZg7ibLF3Vr9uWLCyY8EOA
         oLjAqjQE6/f20Fxw2El5FopMPbUAntXjN3JjNti7aPyIxBTELNBWgwPJRSpcw20cTg4X
         tQEA==
X-Gm-Message-State: ACrzQf0coQB8weo6XealcPfTDb7bZCcEOG+mbfBki2HL6mjob1X52tfl
        fGTc1O3AWrFze47hJ/xoNPtuEA==
X-Google-Smtp-Source: AMsMyM6IYXtcl8JigvWFGHGaYTLwP/VPUq1AhrmnirNeyBBNcQK9GdMREOc7AKVTMzq+4eU0rtnu4A==
X-Received: by 2002:a17:90b:3811:b0:202:9e26:bc00 with SMTP id mq17-20020a17090b381100b002029e26bc00mr7971482pjb.223.1663742840298;
        Tue, 20 Sep 2022 23:47:20 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b0017825ab5320sm1067802plk.251.2022.09.20.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 23:47:19 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v1] mm: oom: introduce cpuset oom
Date:   Wed, 21 Sep 2022 14:47:09 +0800
Message-Id: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
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

cpuset confine processes to processor and memory node subsets.
When a process in cpuset triggers oom, it may kill a completely
irrelevant process on another numa node, which will not release any
memory for this cpuset.

It seems that `CONSTRAINT_CPUSET` is not really doing much these
days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
killing by selecting victim from the cpuset which triggers oom.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
This idea comes from a previous patch:
mm, oom: Introduce per numa node oom for CONSTRAINT_MEMORY_POLICY
https://lore.kernel.org/all/YoJ%2FioXwGTdCywUE@dhcp22.suse.cz/

Any comments are welcome.
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 17 +++++++++++++++++
 mm/oom_kill.c          |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..7475f613ab90 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
+static inline int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	return 0;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..1f1238b4276d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3943,6 +3943,23 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
+int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct cgroup *cgrp;
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	rcu_read_lock();
+	css_task_iter_start(&(task_cs(current)->css), CSS_TASK_ITER_PROCS, &it);
+	while (!ret && (task = css_task_iter_next(&it)))
+		ret = fn(task, arg);
+	css_task_iter_end(&it);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /*
  * Collection of memory_pressure is suppressed unless
  * this flag is enabled by writing "1" to the special
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 46e7e073f137..8cea787b359c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -367,6 +367,8 @@ static void select_bad_process(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_cgroup_scan_tasks(oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;
 
@@ -427,6 +429,8 @@ static void dump_tasks(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_cgroup_scan_tasks(dump_task, oc);
 	else {
 		struct task_struct *p;
 
-- 
2.20.1

