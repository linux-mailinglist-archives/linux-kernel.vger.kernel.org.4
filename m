Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0B7393E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFVAh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3E1995
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687394208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1r3PzJd7BfuII/LkCpH6/mpfYzdtX6yj52D21WLcU08=;
        b=JnMEvTkrg9O4FTHMjgw6pdIYN9sw2NB8XV6yeXj0KdSuDVFu1+VeLFGexBC2J6thqWhQJa
        O5asFZBhXXqKeQU/F/XUdU8E0KWYSm/45IVq7fP/0VajY7J6vOMKr3jPQDqbPhI2C7Rcl2
        MrBB5/6m2t9gKlotCK9ZF7r7Ahpvj0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-Wf_xTA3DNyOMMsljI4GqDw-1; Wed, 21 Jun 2023 20:36:45 -0400
X-MC-Unique: Wf_xTA3DNyOMMsljI4GqDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66929800193;
        Thu, 22 Jun 2023 00:36:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8FA8112132C;
        Thu, 22 Jun 2023 00:36:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 3/3] intel_idle: Add ibrs_off module parameter to force disable IBRS
Date:   Wed, 21 Jun 2023 20:36:03 -0400
Message-Id: <20230622003603.1188364-4-longman@redhat.com>
In-Reply-To: <20230622003603.1188364-1-longman@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the cstate is 6 or lower. However, there are
some use cases where a customer may want to use max_cstate=1 to
lower latency. Such use cases will suffer from the performance
degradation caused by the enabling of IBRS in the sibling idle thread.
Add a "ibrs_off" module parameter to force disable IBRS and the
CPUIDLE_FLAG_IRQ_ENABLE flag if set.

In the case of a Skylake server with max_cstate=1, this new ibrs_off
option will likely increase the IRQ response latency as IRQ will now
be disabled.

When running SPECjbb2015 with cstates set to C1 on a Skylake system.

First test when the kernel is booted with: "intel_idle.ibrs_off"
  max-jOPS = 117828, critical-jOPS = 66047

Then retest when the kernel is booted without the "intel_idle.ibrs_off"
added.
  max-jOPS = 116408, critical-jOPS = 58958

That means booting with "intel_idle.ibrs_off" improves performance by:
  max-jOPS:   1.2%, which could be considered noise range.
  critical-jOPS: 12%, which is definitely a solid improvement.

The admin-guide/pm/intel_idle.rst file is updated to add a description
about the new "ibrs_off" module parameter.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
 drivers/idle/intel_idle.c                   | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index b799a43da62e..8604e6d1fe2c 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -170,7 +170,7 @@ and ``idle=nomwait``.  If any of them is present in the kernel command line, the
 ``MWAIT`` instruction is not allowed to be used, so the initialization of
 ``intel_idle`` will fail.
 
-Apart from that there are four module parameters recognized by ``intel_idle``
+Apart from that there are five module parameters recognized by ``intel_idle``
 itself that can be set via the kernel command line (they cannot be updated via
 sysfs, so that is the only way to change their values).
 
@@ -216,6 +216,21 @@ are ignored).
 The idle states disabled this way can be enabled (on a per-CPU basis) from user
 space via ``sysfs``.
 
+The ``ibrs_off`` module parameter is a boolean flag (default to false). It is
+used to control if IBRS (Indirect Branch Restricted Speculation) should be
+turned off, if set, when the CPU enters an idle state.  This flag will not
+affect CPUs that are using Enhanced IBRS which can remain on with little
+performance impact.
+
+For some CPUs, IBRS will be selected as mitigation for Spectre v2 and Retbleed
+security vulnerabilities by default.  Leaving the IBRS mode on while idling may
+have a performance impact on its sibling CPU.  The IBRS mode will be turned off
+by default when the CPU enters into a deep idle state, but not in some
+shallower ones.  Setting the ``ibrs_off`` module parameter will force the IBRS
+mode to off when the CPU is in any one of the available idle states.  This may
+help performance of a sibling CPU at the expense of a slightly higher wakeup
+latency for the idle CPU.
+
 
 .. _intel-idle-core-and-package-idle-states:
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 07fa23707b3c..8bbf1e6d845c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask __read_mostly;
 static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
+static bool ibrs_off __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1907,12 +1908,15 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_xstate;
 		} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-			   state->flags & CPUIDLE_FLAG_IBRS) {
+			  ((state->flags & CPUIDLE_FLAG_IBRS) || ibrs_off)) {
 			/*
 			 * IBRS mitigation requires that C-states are entered
 			 * with interrupts disabled.
 			 */
-			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+			if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
+				state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
+			else
+				WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_ibrs;
 		} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
 			state->enter = intel_idle_irq;
@@ -2165,3 +2169,9 @@ MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
  * 'CPUIDLE_FLAG_INIT_XSTATE' and 'CPUIDLE_FLAG_IBRS' flags.
  */
 module_param(force_irq_on, bool, 0444);
+/*
+ * Force the disabling of IBRS when X86_FEATURE_KERNEL_IBRS is on and
+ * CPUIDLE_FLAG_IRQ_ENABLE isn't set.
+ */
+module_param(ibrs_off, bool, 0444);
+MODULE_PARM_DESC(ibrs_off, "Disable IBRS when idle");
-- 
2.31.1

