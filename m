Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84C6D5FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjDDL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDDL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:56:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6140EF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:55:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ml21so8284341pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680609318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZYpEiXmAQmikuks9KMMpXu6elZlbF1nKUjvillJPpY=;
        b=lbazhyBfq7jbbyxm/9fkElTeNmdjbJUD8gWVnHI5C9Blp+OoQLsEgg4ZOqFJMMV3v8
         IorhurWEFzdZK3MRzjpLSNFC0Eev8lUx3qgtqFwEuIioejSQw/XnS4eeW/x7v9ZkGnIc
         f3e74QQR//XqXcuANnuhhmg0sE3fN6yz9bPe9hAAleTYVzWI2oFeqjg918FRYHZqG99K
         QxBCI1VgwQzL++cxY29BmxpMTBcA45UsdJWbvhVk7Qn8rIngbGG89QPH2ivDViZ0JPRZ
         FbWDcu2jfIFBrk+WGX9oIt6yxF0q2yaXqG/Mip448t93QUYj0DAkRUs+AbA24tpXz6VM
         puQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZYpEiXmAQmikuks9KMMpXu6elZlbF1nKUjvillJPpY=;
        b=3RJaRGHYyB0pOYb4hXNPo2//mMP07Rbvit+FrI/cfS5qAlH/Z51Mn27W5SMHjT3cco
         zMq4PW4sGijgGM6vXXMl951ZemLhe03lxGgylimXpq5n3OwTrfNuox9WAU80y02B6ZTc
         vIQzB4kp1/Y9THUscI8xSoSJTzBFntDtSIxCPAZFmeepDAoODHbXJPPAGtuCQaGohgTN
         nAHXGyBiuHl8ziyiDDCj8FwziTD6TLbEjDuq+tU0GkF9JH4UpHP6rSkA1/Rf4877YKTC
         WrqYcyTYkleiFouPEXSFk7SmLiPO38wUiPq8biN7uV07vm8fdPGsMz0BFamSCiN6K6rN
         pbyQ==
X-Gm-Message-State: AAQBX9eY8DTZSK0XgGd1mvioiL/1WIPT1nE91SV/H5dW6yZPDhktSmcr
        BGd3bk8Ct4NogBni1BKa+2PdTw==
X-Google-Smtp-Source: AKy350Z2LUIJo+yqjapjIZnTSq5B7kzAkgao8HKbK9Xo7wJRarCRAqqm86/seC4JlPeqDGPgQRLPsA==
X-Received: by 2002:a17:90b:3889:b0:240:b3ae:d881 with SMTP id mu9-20020a17090b388900b00240b3aed881mr2706336pjb.5.1680609318070;
        Tue, 04 Apr 2023 04:55:18 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id q80-20020a632a53000000b005141568e322sm1248062pgq.81.2023.04.04.04.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:55:17 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, rientjes@google.com
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: oom: introduce cpuset oom
Date:   Tue,  4 Apr 2023 19:55:09 +0800
Message-Id: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process in cpuset triggers oom, it may kill a completely
irrelevant process on another numa node, which will not release any
memory for this cpuset.

It seems that `CONSTRAINT_CPUSET` is not really doing much these
days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
by selecting victim from all cpusets with the same mems_allowed as
the current cpuset.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
Changes in v2:
- Select victim from all cpusets with the same mems_allowed as the current cpuset.
  (David Rientjes <rientjes@google.com>)

v1:
- https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/

---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++++++++++
 mm/oom_kill.c          |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 980b76a1237e..fc244141bd52 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
+static inline int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	return 0;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bc4dcfd7bee5..b009c98ca19e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4013,6 +4013,34 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
+int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct css_task_iter it;
+	struct task_struct *task;
+	struct cpuset *cs;
+	struct cgroup_subsys_state *pos_css;
+
+	/*
+	 * Situation gets complex with overlapping nodemasks in different cpusets.
+	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
+	 *
+	 * But for now, let's make it simple. Just iterate through all cpusets
+	 * with the same mems_allowed as the current cpuset.
+	 */
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
+			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
+			while (!ret && (task = css_task_iter_next(&it)))
+				ret = fn(task, arg);
+			css_task_iter_end(&it);
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * Collection of memory_pressure is suppressed unless
  * this flag is enabled by writing "1" to the special
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..205982a69b30 100644
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
