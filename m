Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231E45B6C35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiIMLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiIMLHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:07:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662C05F9A3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663067216; x=1694603216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiEDfww/B/2De+3MVM2YwC08RnmErrMIpkB17KjlA6Y=;
  b=Y5yjog+L8vTo3owYBw8Eob7QTbPIHQpdBw6ao1ZMOL0pybaL359rl5mR
   FRFPH1FHrMwQFQ9lUYZIixboV5U0LolUDo/GL7XqnHfBh4ujsOHcylsRb
   qAMekPV3Qp8ADJ2tSnvaYcoc1YmxSFsMgFdrq1+D7Rg9B7H6IShq1SPoK
   r72WTmKI6LBapT3us6qbTzkaGj5UWcf3SaPIfOjeQkQ3qlDkhFR6PxJvH
   2E/dYB/PodtVRMFkEPHCtgQdQHznNvTt3XJTjikRuhoTzmn/Xhdd3cQQW
   oOfYqOPyHC/Jx6C3vSBnNdvaM3M/03RopBajF0kcY1/NkfU4ncPoHuzFq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285130178"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="285130178"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678522192"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2022 04:06:50 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] percpu: Add percpu_counter_add_local and percpu_counter_sub_local
Date:   Wed, 14 Sep 2022 03:25:37 +0800
Message-Id: <20220913192538.3023708-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220913192538.3023708-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The batch size in percpu_counter_add_batch should be very large in
heavy writing and rare reading case. Add the "_local" version, and
mostly it will do local adding, reduce the global updating and
mitigate lock contention in writing.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/percpu_counter.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861eebed79..8ed5fba6d156 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -15,6 +15,9 @@
 #include <linux/types.h>
 #include <linux/gfp.h>
 
+/* percpu_counter batch for local add or sub */
+#define PERCPU_COUNTER_LOCAL_BATCH	INT_MAX
+
 #ifdef CONFIG_SMP
 
 struct percpu_counter {
@@ -56,6 +59,22 @@ static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add_batch(fbc, amount, percpu_counter_batch);
 }
 
+/*
+ * With percpu_counter_add_local() and percpu_counter_sub_local(), counts
+ * are accumulated in local per cpu counter and not in fbc->count until
+ * local count overflows PERCPU_COUNTER_LOCAL_BATCH. This makes counter
+ * write efficient.
+ * But percpu_counter_sum(), instead of percpu_counter_read(), needs to be
+ * used to add up the counts from each CPU to account for all the local
+ * counts. So percpu_counter_add_local() and percpu_counter_sub_local()
+ * should be used when a counter is updated frequently and read rarely.
+ */
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LOCAL_BATCH);
+}
+
 static inline s64 percpu_counter_sum_positive(struct percpu_counter *fbc)
 {
 	s64 ret = __percpu_counter_sum(fbc);
@@ -138,6 +157,13 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	preempt_enable();
 }
 
+/* non-SMP percpu_counter_add_local is the same with percpu_counter_add */
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add(fbc, amount);
+}
+
 static inline void
 percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
@@ -193,4 +219,10 @@ static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add(fbc, -amount);
 }
 
+static inline void
+percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add_local(fbc, -amount);
+}
+
 #endif /* _LINUX_PERCPU_COUNTER_H */
-- 
2.31.1

