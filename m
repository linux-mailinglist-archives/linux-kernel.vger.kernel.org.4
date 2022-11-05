Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9791E61DC9B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKERkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKERkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:40:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92A1C91E;
        Sat,  5 Nov 2022 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667670014; x=1699206014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=R58kZibTx8A/+NocLamXGaVTjWYivBPJVxzc/oR6fi4=;
  b=GVUDOIyQu/8e5hUbu12NKWJ2KYrklvyi/AuWVYWkuJ7UlTMs0mBIjQgy
   Af08VUAh7Vt39csyNG7TjaGxLcp2d3MCd+a1HsgdnJNQjsE7IA8qZdDNR
   31U5KOaAaoVx0b75FULP0fc3bVRDvBQ2i+gJAggX2d5mr16w+LLiWLYhL
   MkjJR7bQJIENPPH4O2uB/0cUjvdw2Cd2b6HQBpjXDiAmZCXpPDTHEa9eD
   xtYpWwZw5ABWpOSp4PVVwNhFLyqnfpfU0B9d21Lhak2IXbUj3jBCCWx/o
   1LSBjF6wwhdSgbzbmrDl4JXr/jnBzglmEAGHyWr56zfvDmtilxjgMvKQf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="297672768"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="297672768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 10:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="666729785"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="666729785"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2022 10:40:12 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] cpuidle: ladder: Fix handling for disabled states
Date:   Sun,  6 Nov 2022 01:42:25 +0800
Message-Id: <20221105174225.28673-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221105174225.28673-1-rui.zhang@intel.com>
References: <20221105174225.28673-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two reasons why CPU idle states may be disabled: either
because the driver has disabled them or because they have been disabled
by user space via sysfs.

Handling for the driver-disabled state in the ladder gonover has three
main rules.

Two are introduced by commit 62d6ae880e3e ("Honor state disabling in the
cpuidle ladder governor"). The behavior is described as below

"The behavior and the effect of the disable variable depends on the
implementation of a particular governor. In the ladder governor, for
example, it is not coherent, i.e. if one is disabling a light state,
then all deeper states are disabled as well, but the disable variable
does not reflect it. Likewise, if one enables a deep state but a lighter
state still is disabled, then this has no effect."

So
Rule 1. when promote, only checks the 'disable' flag for the next deeper
        state. If it is disabled, consider all deeper states as disabled
        and stick with current state.
Rule 2. when demote, ignore the 'disable' flag of the next shallower
        state, because when a deeper state is used, all of its shallower
        states must be enabled.

The third one is introduced by commit a2bd92023357 ("cpuidle: Do not use
poll_idle unless user asks for it").

Rule 3. never demote to POLL unless the latency requirement is 0.

Handling for the sysfs-disabled state in the ladder governor is
introduced by commit 66804c13f7b7 ("PM / cpuidle: Make ladder governor
use the "disabled" state flag"). It copies the same logic as
driver-disabled state, but this might break because the sysfs-disabled
state has different definition and it can be changed at runtime.

Today, when ladder governor is used, by playing with the sysfs "disable"
attribute, the below behavior is observed.
1. After disabling a specific state, if the CPU was in a deeper state
   previously, it can still request for the disabled state.
2. After disabling a specific state, if the CPU was in a deeper state
   previously, it can still request for a state deeper than the disabled
   state.
This behavior is kept until it demotes to a state shallower than the
disabled state, and Rule 1 starts to take effect then. The time for
Rule 1 to take effect may be long, depending on the workload. For
example, on an Intel Kabylake platform, disabling C1E (state 2) does not
take effect after 30 seconds in idle scenario.

3. When all non-POLL states are disabled (or just with state1 and state2
   disabled), the ladder governor demotes to shallower states, and
   finally stuck in state 1 (the shallowest non-POLL state), even if the
   state is disabled.

So the previous logic for the driver-disabled state does not work well
for the sysfs-disabled state case.

Note that with commit 99e98d3fb100 ("cpuidle: Consolidate disabled state
checks"), these two cases are combined to share one flag, thus the
behaviors for handling the driver-disabled state and the sysfs-disabled
state *HAVE TO* be consistent now.

Now the question is what behaviors should be used?
I'm not sure why ladder governor handles driver-disabled state
differently than other governors. And IMO, it also conflicts with the
expectation of the sysfs 'disable' attribute, as described in
Documentation/admin-guide/pm/cpuidle.rst,
"disable	Whether or not this idle state is disabled."

So this patch changes the ladder governor to align with the sysfs
'disable' attribute definition.
This means,
1. when promote, always choose the next enabled deeper state
2. when demote, always choose the next enabled shallower state

plus, Rule 3 is kept and enhanced
3. Unless latency requirement is not met, never chooses POLL.
   (Previously, unless the latency requirement is set to 0, ladder
   governor won't choose POLL even if the shallowest non-POLL state does
   not meet the latency requirement)

Any comments on this would be really appreciated.

Reported-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst |   4 +-
 drivers/cpuidle/governors/ladder.c       | 149 ++++++++++++++++++-----
 2 files changed, 117 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 19754beb5a4e..be21690211ce 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -470,9 +470,7 @@ governor will never select it for this particular CPU and the ``CPUIdle``
 driver will never ask the hardware to enter it for that CPU as a result.
 However, disabling an idle state for one CPU does not prevent it from being
 asked for by the other CPUs, so it must be disabled for all of them in order to
-never be asked for by any of them.  [Note that, due to the way the ``ladder``
-governor is implemented, disabling an idle state prevents that governor from
-selecting any idle states deeper than the disabled one too.]
+never be asked for by any of them.
 
 If the :file:`disable` attribute contains 0, the given idle state is enabled for
 this particular CPU, but it still may be disabled for some or all of the other
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 4b47aa0a4da9..be8ddb792ad8 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -57,6 +57,78 @@ static inline void ladder_do_selection(struct cpuidle_device *dev,
 	dev->last_state_idx = new_idx;
 }
 
+/*
+ * Choose the first enabled shallower state that meets the latency requirement
+ */
+static int get_shallower(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+			 int idx, s64 latency_req, bool ignore_poll)
+{
+	int i;
+
+	/* Choose the first shallower state that meets the requirement */
+	for (i = idx; i >= 0; i--) {
+		if (dev->states_usage[i].disable)
+			continue;
+		if (ignore_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING)
+			continue;
+		if (drv->states[i].exit_latency_ns <= latency_req)
+			return i;
+	}
+
+	/* Choose the first deeper one if no suitable shallower states found */
+	for (i = idx + 1; i < drv->state_count; i++) {
+		if (dev->states_usage[i].disable)
+			continue;
+		if (drv->states[i].exit_latency_ns <= latency_req)
+			return i;
+		/* all deeper states cannot meet latency requirement */
+		break;
+	}
+
+	/*
+	 * When comes here, there are two possibilities,
+	 * 1. all enabled state do not meet the latency requirement
+	 * 2. Only POLL meets the latency requirement but ignore_poll is set
+	 * in both cases, the first enabled state should be choosed
+	 */
+	for (i = 0; i < drv->state_count; i++)
+		if (!dev->states_usage[i].disable)
+			return i;
+	return 0;
+}
+
+/*
+ * Choose the first enabled deeper state that meets the latency requirement
+ */
+static int get_deeper(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		      int idx, s64 latency_req)
+{
+	int i, shallowest = -1;
+
+	for (i = idx; i < drv->state_count; i++) {
+		if (dev->states_usage[i].disable)
+			continue;
+		if (shallowest == -1)
+			shallowest = i;
+		if (drv->states[i].exit_latency_ns <= latency_req)
+			return i;
+		/* No need to search for deeper state because latency_req cannot be met */
+		break;
+	}
+
+	/* Choose a shallower state if no deeper state found */
+	for (i = idx - 1; i >= 0; i--) {
+		if (dev->states_usage[i].disable)
+			continue;
+		shallowest = i;
+		if (drv->states[i].exit_latency_ns <= latency_req)
+			return i;
+	}
+
+	/* Choose the shallowest enabled state if latency_req cannot be met */
+	return shallowest == -1 ? 0 : shallowest;
+}
+
 /**
  * ladder_select_state - selects the next state to enter
  * @drv: cpuidle driver
@@ -69,59 +141,63 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_idx = dev->last_state_idx;
-	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
+	int next_idx;
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	s64 last_residency;
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0)) {
-		ladder_do_selection(dev, ldev, last_idx, 0);
-		return 0;
+		/* Choose the shallowest state */
+		next_idx = get_deeper(drv, dev, 0, 0);
+		goto end;
 	}
 
 	last_state = &ldev->states[last_idx];
 
 	last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns;
 
-	/* consider promotion */
-	if (last_idx < drv->state_count - 1 &&
-	    !dev->states_usage[last_idx + 1].disable &&
-	    last_residency > last_state->threshold.promotion_time_ns &&
-	    drv->states[last_idx + 1].exit_latency_ns <= latency_req) {
+	/* meet latency requirement first */
+	if (drv->states[last_idx].exit_latency_ns > latency_req) {
+		/* Need to consider POLL because of latency requirement */
+		next_idx = get_shallower(drv, dev, last_idx - 1, latency_req, 0);
+		goto end;
+	}
+
+	/* choose a deeper state because of promotion */
+	if (last_residency > last_state->threshold.promotion_time_ns) {
+		next_idx = get_deeper(drv, dev, last_idx + 1, latency_req);
+
+		/* no usable deeper state, use available deepest one */
+		if (next_idx <= last_idx)
+			goto end;
 		last_state->stats.promotion_count++;
 		last_state->stats.demotion_count = 0;
-		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
-			ladder_do_selection(dev, ldev, last_idx, last_idx + 1);
-			return last_idx + 1;
-		}
+		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count)
+			goto end;
+		goto remain_cur;
 	}
 
-	/* consider demotion */
-	if (last_idx > first_idx &&
-	    (dev->states_usage[last_idx].disable ||
-	    drv->states[last_idx].exit_latency_ns > latency_req)) {
-		int i;
-
-		for (i = last_idx - 1; i > first_idx; i--) {
-			if (drv->states[i].exit_latency_ns <= latency_req)
-				break;
-		}
-		ladder_do_selection(dev, ldev, last_idx, i);
-		return i;
-	}
+	/* choose a shallower state because of demotion */
+	if (last_residency < last_state->threshold.demotion_time_ns) {
+		next_idx = get_shallower(drv, dev, last_idx - 1, latency_req, 1);
 
-	if (last_idx > first_idx &&
-	    last_residency < last_state->threshold.demotion_time_ns) {
+		/* no usable shallower state, use available shallowest one */
+		if (next_idx >= last_idx)
+			goto end;
 		last_state->stats.demotion_count++;
 		last_state->stats.promotion_count = 0;
-		if (last_state->stats.demotion_count >= last_state->threshold.demotion_count) {
-			ladder_do_selection(dev, ldev, last_idx, last_idx - 1);
-			return last_idx - 1;
-		}
+		if (last_state->stats.demotion_count >= last_state->threshold.demotion_count)
+			goto end;
 	}
 
-	/* otherwise remain at the current state */
-	return last_idx;
+remain_cur:
+	/* remain at the current state but in case it is disabled */
+	next_idx = get_shallower(drv, dev, last_idx, latency_req, 1);
+
+end:
+	if (next_idx != last_idx)
+		ladder_do_selection(dev, ldev, last_idx, next_idx);
+	return next_idx;
 }
 
 /**
@@ -152,8 +228,15 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 
 		if (i < drv->state_count - 1)
 			lstate->threshold.promotion_time_ns = state->exit_latency_ns;
+		else
+			/* Effectively disable promotion from deepest state */
+			lstate->threshold.promotion_time_ns = S64_MAX;
+
 		if (i > first_idx)
 			lstate->threshold.demotion_time_ns = state->exit_latency_ns;
+		else
+			/* Effectively disable demotion from shallowest state */
+			lstate->threshold.demotion_time_ns = S64_MIN;
 	}
 
 	return 0;
-- 
2.25.1

