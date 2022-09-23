Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8565E815D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIWSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiIWSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB32DF6AB;
        Fri, 23 Sep 2022 11:01:51 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Li8pAkwglZYyRS/J517vlEY2TKtkkBCB4c1uyllFKWE=;
        b=oWJV6DnmojLLFC2O0nXPqnFO8JAQnN+vuMxLpKz30BEDbNZVPrJtxILKjCwoR2Pc8brjvp
        ENt4OSX7pLb5N756QJxq+O52ehgPIoFbfq/9xMUSsoOAJKXBobVT8TgCxREV6vioTv/Gy6
        FKBz389uDLRYMUsIS1VkYB9/uz10riWzmUjSLRmt7BzPW3ll4K0YKQ+yV7q49LHGwfiCSt
        ZH35aEaSLgm1jxv2HXC+Jaru4yBW9n2REZ3vgJKW2m6t2F16PVxOUKR2Rxbw+Qe4rH6bKw
        BAurigtwwGeJwfoq1V1K3AyEUy/m1lKY0C8F80H5tKTzRKuermbbBchqVilMLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Li8pAkwglZYyRS/J517vlEY2TKtkkBCB4c1uyllFKWE=;
        b=G+hBM6JpzF+95Urk5eQdwBuxb/Q+V6U7aaW8GZphDCV91+2vs1+bzXwD9zo3pZIcwHs+ed
        1XZGcXxgdpsHT9Dw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add per-rmid arch private storage for
 overflow and chunks
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-14-james.morse@arm.com>
References: <20220902154829.30399-14-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610853.401.13795446222171166361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     48dbe31a243d5fc7c07b7f03b48e95ec4696b118
Gitweb:        https://git.kernel.org/tip/48dbe31a243d5fc7c07b7f03b48e95ec4696b118
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:21 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:46:09 +02:00

x86/resctrl: Add per-rmid arch private storage for overflow and chunks

A renamed __rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a counter. Currently the function returns
the MBM values in chunks directly from hardware. For bandwidth
counters the resctrl filesystem uses this to calculate the number of
bytes ever seen.

MPAM's scaling of counters can be changed at runtime, reducing the
resolution but increasing the range. When this is changed the prev_msr
values need to be converted by the architecture code.

Add an array for per-rmid private storage. The prev_msr and chunks
values will move here to allow resctrl_arch_rmid_read() to always
return the number of bytes read by this counter without assistance
from the filesystem. The values are moved in later patches when
the overflow and correction calls are moved into __rmid_read().

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-14-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 35 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h | 14 ++++++++++-
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 90ebb7d..de62b0b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -413,6 +413,8 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 
 static void domain_free(struct rdt_hw_domain *hw_dom)
 {
+	kfree(hw_dom->arch_mbm_total);
+	kfree(hw_dom->arch_mbm_local);
 	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
@@ -438,6 +440,34 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+/**
+ * arch_domain_mbm_alloc() - Allocate arch private storage for the MBM counters
+ * @num_rmid:	The size of the MBM counter array
+ * @hw_dom:	The domain that owns the allocated arrays
+ */
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+{
+	size_t tsize;
+
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_total);
+		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_total)
+			return -ENOMEM;
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_local);
+		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_local) {
+			kfree(hw_dom->arch_mbm_total);
+			hw_dom->arch_mbm_total = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -487,6 +517,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+		domain_free(hw_dom);
+		return;
+	}
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4606209..4de8e5b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -304,16 +304,30 @@ struct mbm_state {
 };
 
 /**
+ * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
+ *			   return value.
+ * @prev_msr:	Value of IA32_QM_CTR last time it was read for the RMID used to
+ *		find this struct.
+ */
+struct arch_mbm_state {
+	u64	prev_msr;
+};
+
+/**
  * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ * @arch_mbm_total:	arch private state for MBM total bandwidth
+ * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
+	struct arch_mbm_state		*arch_mbm_total;
+	struct arch_mbm_state		*arch_mbm_local;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
