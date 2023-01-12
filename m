Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D396667CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjALRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjALRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:37:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E86B5E0;
        Thu, 12 Jan 2023 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673542692; x=1705078692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NGQdLseU9on8kCCt5npAv0n5O2aYy9kAJl8WQz1nfc=;
  b=epWOJMX4pODVf5W2OjmbAPODe+PoIABTVedKsdq6JhwMtvBwm64amXLT
   W8wyt9M58srE62CsultszOlyUEqLJ6XCcjT0CjB0bZc9ifMsA9vLQIOaL
   QjYVJQFVo6/ro+A78XFPvUJT2l+93DBJ/lkVDu1ks1jxqFm2yewN0uAwG
   +CC62HdImiFKw3LFqlxKfvCkz6Y9zRPPAARGOSvJTSt/bF7M9xbp1R0Pp
   c+v3LXj8tuDrL7l2NzIcGIjzivAIqDh9bW8LIa1iARDGD0ic/vPXx7luP
   6WxASSHXI3kvcri63V3ppV7Wm8WIcicwnW8q8skMbLsAaw0yxXkQk7Z42
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325016567"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325016567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:57:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651232926"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="651232926"
Received: from jacton-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.195.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:57:03 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 10/12] cgroup/drm: Introduce weight based drm cgroup control
Date:   Thu, 12 Jan 2023 16:56:07 +0000
Message-Id: <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Similar to CPU scheduling, implement a concept of weight in the drm cgroup
controller.

Uses the same range and default as the CPU controller - CGROUP_WEIGHT_MIN,
CGROUP_WEIGHT_DFL and CGROUP_WEIGHT_MAX.

Later each cgroup is assigned a time budget proportionaly based on the
relative weights of it's siblings. This time budget is in turn split by
the group's children and so on.

This will be used to implement a soft, or best effort signal from drm
cgroup to drm core notifying about groups which are over their allotted
budget.

No guarantees that the limit can be enforced are provided or implied.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  37 ++
 drivers/gpu/drm/Kconfig                 |   1 +
 init/Kconfig                            |   1 +
 kernel/cgroup/drm.c                     | 506 +++++++++++++++++++++++-
 4 files changed, 541 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..9894dd59e4c5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2407,6 +2407,43 @@ HugeTLB Interface Files
         hugetlb pages of <hugepagesize> in this cgroup.  Only active in
         use hugetlb pages are included.  The per-node values are in bytes.
 
+DRM
+---
+
+The DRM controller allows configuring scheduling soft limits.
+
+DRM scheduling soft limits
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Because of the heterogenous hardware and driver DRM capabilities, soft limits
+are implemented as a loose co-operative (bi-directional) interface between the
+controller and DRM core.
+
+The controller configures the GPU time allowed per group and periodically scans
+the belonging tasks to detect the over budget condition, at which point it
+invokes a callback notifying the DRM core of the condition.
+
+DRM core provides an API to query per process GPU utilization and 2nd API to
+receive notification from the cgroup controller when the group enters or exits
+the over budget condition.
+
+Individual DRM drivers which implement the interface are expected to act on this
+in the best-effort manner only. There are no guarantees that the soft limits
+will be respected.
+
+DRM scheduling soft limits interface files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+  drm.weight
+	Standard cgroup weight based control [1, 10000] used to configure the
+	relative distributing of GPU time between the sibling groups.
+
+  drm.period_us (debugging aid during RFC only)
+	An integer representing the period with which the controller should look
+	at the GPU usage by the group and potentially send the over/under budget
+	signal.
+	Value of zero (defaul) disables the soft limit checking.
+
 Misc
 ----
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b56b9f2fe8e6..0fbfd3026b71 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -7,6 +7,7 @@
 #
 menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
+	default y if CGROUP_DRM=y
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI
diff --git a/init/Kconfig b/init/Kconfig
index c5ace0d57007..304418674097 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1091,6 +1091,7 @@ config CGROUP_RDMA
 
 config CGROUP_DRM
 	bool "DRM controller"
+	select DRM
 	help
 	  Provides the DRM subsystem controller.
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 3e7f165806de..527b7bf8c576 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -8,14 +8,43 @@
 #include <linux/cgroup_drm.h>
 #include <linux/sched.h>
 
+#include <drm/drm_clients.h>
+
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
+
+	unsigned int weight;
+
+	/*
+	 * Below fields are owned and updated by the scan worker. Either the
+	 * worker accesses them, or worker needs to be suspended and synced
+	 * before they can be touched from the outside.
+	 */
+	unsigned int sum_children_weights;
+
+	bool over;
+	bool over_budget;
+
+	u64 per_s_budget_us;
+	u64 prev_active_us;
+	u64 active_us;
 };
 
 struct drm_root_cgroup_state {
 	struct drm_cgroup_state drmcs;
+
+	unsigned int period_us;
+
+	ktime_t prev_timestamp;
+
+	bool scanning_suspended;
+	unsigned int suspended_period_us;
+
+	struct delayed_work scan_work;
 };
 
+static DEFINE_MUTEX(drmcg_mutex);
+
 static inline struct drm_cgroup_state *
 css_to_drmcs(struct cgroup_subsys_state *css)
 {
@@ -29,10 +58,355 @@ static inline struct drm_cgroup_state *get_task_drmcs(struct task_struct *task)
 
 static struct drm_root_cgroup_state root_drmcs;
 
+static u64 drmcs_get_active_time_us(struct drm_cgroup_state *drmcs)
+{
+	struct cgroup *cgrp = drmcs->css.cgroup;
+	struct task_struct *task;
+	struct css_task_iter it;
+	u64 total = 0;
+
+	css_task_iter_start(&cgrp->self,
+			    CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
+			    &it);
+	while ((task = css_task_iter_next(&it))) {
+		u64 time;
+
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		time = drm_pid_get_active_time_us(task_pid(task));
+		total += time;
+	}
+	css_task_iter_end(&it);
+
+	return total;
+}
+
+static u64
+drmcs_read_weight(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	return drmcs->weight;
+}
+
+static int
+drmcs_write_weight(struct cgroup_subsys_state *css, struct cftype *cftype,
+		   u64 weight)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+	int ret;
+
+	if (weight < CGROUP_WEIGHT_MIN || weight > CGROUP_WEIGHT_MAX)
+		return -ERANGE;
+
+	ret = mutex_lock_interruptible(&drmcg_mutex);
+	if (ret)
+		return ret;
+	drmcs->weight = weight;
+	mutex_unlock(&drmcg_mutex);
+
+	return 0;
+}
+
+static void
+signal_drm_budget(struct drm_cgroup_state *drmcs, u64 usage, u64 budget)
+{
+	struct cgroup *cgrp = drmcs->css.cgroup;
+	struct task_struct *task;
+	struct css_task_iter it;
+
+	css_task_iter_start(&cgrp->self,
+			    CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
+			    &it);
+	while ((task = css_task_iter_next(&it))) {
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		drm_pid_signal_budget(task_pid(task), usage, budget);
+	}
+	css_task_iter_end(&it);
+}
+
+static bool
+__start_scanning(struct drm_cgroup_state *root, unsigned int period_us)
+{
+	struct cgroup_subsys_state *node;
+	bool ok = false;
+
+	rcu_read_lock();
+
+	css_for_each_descendant_post(node, &root->css) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+
+		if (!css_tryget_online(node))
+			goto out;
+
+		drmcs->active_us = 0;
+		drmcs->sum_children_weights = 0;
+
+		if (period_us && node == &root->css)
+			drmcs->per_s_budget_us =
+				DIV_ROUND_UP_ULL((u64)period_us * USEC_PER_SEC,
+						 USEC_PER_SEC);
+		else
+			drmcs->per_s_budget_us = 0;
+
+		css_put(node);
+	}
+
+	css_for_each_descendant_post(node, &root->css) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+		struct drm_cgroup_state *parent;
+		u64 active;
+
+		if (!css_tryget_online(node))
+			goto out;
+		if (!node->parent) {
+			css_put(node);
+			continue;
+		}
+		if (!css_tryget_online(node->parent)) {
+			css_put(node);
+			goto out;
+		}
+		parent = css_to_drmcs(node->parent);
+
+		active = drmcs_get_active_time_us(drmcs);
+		if (period_us && active > drmcs->prev_active_us)
+			drmcs->active_us += active - drmcs->prev_active_us;
+		drmcs->prev_active_us = active;
+
+		parent->active_us += drmcs->active_us;
+		parent->sum_children_weights += drmcs->weight;
+
+		css_put(node);
+		css_put(&parent->css);
+	}
+
+	ok = true;
+
+out:
+	rcu_read_unlock();
+
+	return ok;
+}
+
+static void scan_worker(struct work_struct *work)
+{
+	struct drm_cgroup_state *root = &root_drmcs.drmcs;
+	struct cgroup_subsys_state *node;
+	unsigned int period_us;
+	ktime_t now;
+
+	rcu_read_lock();
+
+	if (WARN_ON_ONCE(!css_tryget_online(&root->css))) {
+		rcu_read_unlock();
+		return;
+	}
+
+	now = ktime_get();
+	period_us = ktime_to_us(ktime_sub(now, root_drmcs.prev_timestamp));
+	root_drmcs.prev_timestamp = now;
+
+	/*
+	 * 1st pass - reset working values and update hierarchical weights and
+	 * GPU utilisation.
+	 */
+	if (!__start_scanning(root, period_us))
+		goto out_retry; /*
+				 * Always come back later if scanner races with
+				 * core cgroup management. (Repeated pattern.)
+				 */
+
+	css_for_each_descendant_pre(node, &root->css) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+		struct cgroup_subsys_state *css;
+		unsigned int over_weights = 0;
+		u64 unused_us = 0;
+
+		if (!css_tryget_online(node))
+			goto out_retry;
+
+		/*
+		 * 2nd pass - calculate initial budgets, mark over budget
+		 * siblings and add up unused budget for the group.
+		 */
+		css_for_each_child(css, &drmcs->css) {
+			struct drm_cgroup_state *sibling = css_to_drmcs(css);
+
+			if (!css_tryget_online(css)) {
+				css_put(node);
+				goto out_retry;
+			}
+
+			sibling->per_s_budget_us  =
+				DIV_ROUND_UP_ULL(drmcs->per_s_budget_us *
+						 sibling->weight,
+						 drmcs->sum_children_weights);
+
+			sibling->over = sibling->active_us >
+					sibling->per_s_budget_us;
+			if (sibling->over)
+				over_weights += sibling->weight;
+			else
+				unused_us += sibling->per_s_budget_us -
+					     sibling->active_us;
+
+			css_put(css);
+		}
+
+		/*
+		 * 3rd pass - spread unused budget according to relative weights
+		 * of over budget siblings.
+		 */
+		css_for_each_child(css, &drmcs->css) {
+			struct drm_cgroup_state *sibling = css_to_drmcs(css);
+
+			if (!css_tryget_online(css)) {
+				css_put(node);
+				goto out_retry;
+			}
+
+			if (sibling->over) {
+				u64 budget_us =
+					DIV_ROUND_UP_ULL(unused_us *
+							 sibling->weight,
+							 over_weights);
+				sibling->per_s_budget_us += budget_us;
+				sibling->over = sibling->active_us  >
+						sibling->per_s_budget_us;
+			}
+
+			css_put(css);
+		}
+
+		css_put(node);
+	}
+
+	/*
+	 * 4th pass - send out over/under budget notifications.
+	 */
+	css_for_each_descendant_post(node, &root->css) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+
+		if (!css_tryget_online(node))
+			goto out_retry;
+
+		if (drmcs->over || drmcs->over_budget)
+			signal_drm_budget(drmcs,
+					  drmcs->active_us,
+					  drmcs->per_s_budget_us);
+		drmcs->over_budget = drmcs->over;
+
+		css_put(node);
+	}
+
+out_retry:
+	rcu_read_unlock();
+
+	period_us = READ_ONCE(root_drmcs.period_us);
+	if (period_us)
+		schedule_delayed_work(&root_drmcs.scan_work,
+				      usecs_to_jiffies(period_us));
+
+	css_put(&root->css);
+}
+
+static void start_scanning(u64 period_us)
+{
+	lockdep_assert_held(&drmcg_mutex);
+
+	root_drmcs.period_us = (unsigned int)period_us;
+	WARN_ON_ONCE(!__start_scanning(&root_drmcs.drmcs, 0));
+	root_drmcs.prev_timestamp = ktime_get();
+	mod_delayed_work(system_wq, &root_drmcs.scan_work,
+			 usecs_to_jiffies(period_us));
+}
+
+static void stop_scanning(struct drm_cgroup_state *drmcs)
+{
+	if (drmcs == &root_drmcs.drmcs) {
+		root_drmcs.period_us = 0;
+		cancel_delayed_work_sync(&root_drmcs.scan_work);
+	}
+
+	if (drmcs->over_budget) {
+		/*
+		 * Signal under budget when scanning goes off so drivers
+		 * correctly update their state.
+		 */
+		signal_drm_budget(drmcs, 0, USEC_PER_SEC);
+		drmcs->over_budget = false;
+	}
+}
+
+static void signal_stop_scanning(void)
+{
+	struct cgroup_subsys_state *node;
+
+	lockdep_assert_held(&drmcg_mutex);
+
+	stop_scanning(&root_drmcs.drmcs); /* Handle outside RCU lock. */
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(node, &root_drmcs.drmcs.css) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+
+		if (drmcs == &root_drmcs.drmcs)
+			continue;
+
+		if (css_tryget_online(node)) {
+			stop_scanning(drmcs);
+			css_put(node);
+		}
+	}
+	rcu_read_unlock();
+}
+
+static void start_suspend_scanning(void)
+{
+	lockdep_assert_held(&drmcg_mutex);
+
+	if (root_drmcs.scanning_suspended)
+		return;
+
+	root_drmcs.scanning_suspended = true;
+	root_drmcs.suspended_period_us = root_drmcs.period_us;
+	root_drmcs.period_us = 0;
+}
+
+static void finish_suspend_scanning(void)
+{
+	if (root_drmcs.suspended_period_us)
+		cancel_delayed_work_sync(&root_drmcs.scan_work);
+}
+
+static void resume_scanning(void)
+{
+	lockdep_assert_held(&drmcg_mutex);
+
+	if (!root_drmcs.scanning_suspended)
+		return;
+
+	root_drmcs.scanning_suspended = false;
+	if (root_drmcs.suspended_period_us) {
+		start_scanning(root_drmcs.suspended_period_us);
+		root_drmcs.suspended_period_us = 0;
+	}
+}
+
 static void drmcs_free(struct cgroup_subsys_state *css)
 {
-	if (css != &root_drmcs.drmcs.css)
-		kfree(css_to_drmcs(css));
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	stop_scanning(drmcs);
+
+	if (drmcs != &root_drmcs.drmcs)
+		kfree(drmcs);
 }
 
 static struct cgroup_subsys_state *
@@ -42,30 +416,154 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
 
 	if (!parent_css) {
 		drmcs = &root_drmcs.drmcs;
+		INIT_DELAYED_WORK(&root_drmcs.scan_work, scan_worker);
 	} else {
 		drmcs = kzalloc(sizeof(*drmcs), GFP_KERNEL);
 		if (!drmcs)
 			return ERR_PTR(-ENOMEM);
 	}
 
+	drmcs->weight = CGROUP_WEIGHT_DFL;
+
 	return &drmcs->css;
 }
 
+static int drmcs_can_attach(struct cgroup_taskset *tset)
+{
+	int ret;
+
+	/*
+	 * As processes are getting moved between groups we need to ensure
+	 * both that the old group does not see a sudden downward jump in the
+	 * GPU utilisation, and that the new group does not see a sudden jump
+	 * up with all the GPU time clients belonging to the migrated process
+	 * have accumulated.
+	 *
+	 * To achieve that we suspend the scanner until the migration is
+	 * completed where the resume at the end ensures both groups start
+	 * observing GPU utilisation from a reset state.
+	 */
+
+	ret = mutex_lock_interruptible(&drmcg_mutex);
+	if (ret)
+		return ret;
+	start_suspend_scanning();
+	mutex_unlock(&drmcg_mutex);
+
+	finish_suspend_scanning();
+
+	return 0;
+}
+
+static void tset_resume_scanning(struct cgroup_taskset *tset)
+{
+	mutex_lock(&drmcg_mutex);
+	resume_scanning();
+	mutex_unlock(&drmcg_mutex);
+}
+
+static void drmcs_attach(struct cgroup_taskset *tset)
+{
+	tset_resume_scanning(tset);
+}
+
+static void drmcs_cancel_attach(struct cgroup_taskset *tset)
+{
+	tset_resume_scanning(tset);
+}
+
+static u64
+drmcs_read_period_us(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return root_drmcs.period_us;
+}
+
+static int
+drmcs_write_period_us(struct cgroup_subsys_state *css, struct cftype *cftype,
+		      u64 period_us)
+{
+	int ret;
+
+	if (css->cgroup->level)
+		return -EINVAL;
+	if ((period_us && period_us < 500000) || period_us > USEC_PER_SEC * 60)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&drmcg_mutex);
+	if (ret)
+		return ret;
+
+	if (!root_drmcs.scanning_suspended) {
+		if (period_us)
+			start_scanning(period_us);
+		else
+			signal_stop_scanning();
+	} else {
+		/*
+		 * If scanning is temporarily suspended just update the period
+		 * which will apply once resumed, or simply skip resuming in
+		 * case of disabling.
+		 */
+		root_drmcs.suspended_period_us = period_us;
+		if (!period_us)
+			root_drmcs.scanning_suspended = false;
+	}
+
+	mutex_unlock(&drmcg_mutex);
+
+	return 0;
+}
+
 void drmcgroup_client_exited(struct task_struct *task)
 {
-	struct drm_cgroup_state *drmcs = get_task_drmcs(task);
+	/*
+	 * QQQ/TODO - Skip if task is not a member of a cgroup which has a
+	 * DRM controller enabled?
+	 */
+
+	/*
+	 * Since we are not tracking accumulated GPU time for each cgroup,
+	 * avoid jumps in group observed GPU usage by re-setting the scanner
+	 * at a point when GPU usage can suddenly jump down.
+	 *
+	 * Downside is clients can influence the effectiveness of the over-
+	 * budget scanning by continuously closing DRM file descriptors but for
+	 * now we do not worry about it.
+	 */
+
+	mutex_lock(&drmcg_mutex);
+	start_suspend_scanning();
+	mutex_unlock(&drmcg_mutex);
+
+	finish_suspend_scanning();
 
-	css_put(&drmcs->css);
+	mutex_lock(&drmcg_mutex);
+	resume_scanning();
+	mutex_unlock(&drmcg_mutex);
 }
 EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
 
 struct cftype files[] = {
+	{
+		.name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = drmcs_read_weight,
+		.write_u64 = drmcs_write_weight,
+	},
+	{
+		.name = "period_us",
+		.read_u64 = drmcs_read_period_us,
+		.write_u64 = drmcs_write_period_us,
+	},
 	{ } /* Zero entry terminates. */
 };
 
 struct cgroup_subsys drm_cgrp_subsys = {
 	.css_alloc	= drmcs_alloc,
 	.css_free	= drmcs_free,
+	.can_attach	= drmcs_can_attach,
+	.attach		= drmcs_attach,
+	.cancel_attach	= drmcs_cancel_attach,
 	.early_init	= false,
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
-- 
2.34.1

