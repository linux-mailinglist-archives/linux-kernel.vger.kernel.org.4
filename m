Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E885B379F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiIIMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiIIMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:19:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4F1451CA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662725858; x=1694261858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msZeq0/MS9e5G6s32J0p8vC6jZqtVCX7tRSfsEvQZPA=;
  b=a7Yz/ZnOE0VMbEpp0qweR2Zu9GKlj09v+pYwHWTacdM9RikWf/X66X30
   W+FPboyzf+vKznFEVMWN9EuYxGg48Q+i7J15STMNZmt/7SjIug1ITY69b
   PJjio96o/HblbX2DVRstVxt6Heb3VxUlVx0ARnongfuMO3rpZTjPa/JrU
   tJ8x+Nv2c8RVzluxB7aXJlPvQrLVGGvBSstfFmoqiR7HCITJI6mtmCp8Y
   4SLnG6SSff+MvdLD8nnUxOG+DCBoC59dpFYfKYLiil3Ce5fNGXPMS6Z/v
   Y6Gi82lcnrZdRlKZw7Xjo/vefArOnm5+NwKKbHQzEmf0T9NdnyffOP9VH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="361416762"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="361416762"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 05:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="645516067"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2022 05:17:34 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v5 1/2] percpu: Add percpu_counter_add_local and percpu_counter_sub_local
Date:   Sat, 10 Sep 2022 04:36:35 +0800
Message-Id: <20220909203636.2652466-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909203636.2652466-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220909203636.2652466-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The batch size in percpu_counter_add_batch should be very large
in heavy writing and rare reading case. Add the "_local" version,
and mostly it will do local adding, reduce the global updating
and mitigate lock contention in writing.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/percpu_counter.h | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861eebed79..6dd7eaba8527 100644
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
@@ -56,6 +59,27 @@ static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add_batch(fbc, amount, percpu_counter_batch);
 }
 
+/*
+ * Use this function in heavy writing but rare reading case. The large
+ * batch size will reduce the global updating.
+ */
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LOCAL_BATCH);
+}
+
+/*
+ * Similar with percpu_counter_add_local, use it in heavy writing but
+ * rare reading case. The large batch size will reduce the global
+ * updating.
+ */
+static inline void
+percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add_batch(fbc, -amount, PERCPU_COUNTER_LOCAL_BATCH);
+}
+
 static inline s64 percpu_counter_sum_positive(struct percpu_counter *fbc)
 {
 	s64 ret = __percpu_counter_sum(fbc);
@@ -138,6 +162,20 @@ percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 	preempt_enable();
 }
 
+/* no smp percpu_counter_add_local is the same with percpu_counter_add */
+static inline void
+percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_add(fbc, amount);
+}
+
+/* no smp percpu_counter_sub_local is the same with percpu_counter_sub */
+static inline void
+percpu_counter_sub_local(struct percpu_counter *fbc, s64 amount)
+{
+	percpu_counter_sub(fbc, amount);
+}
+
 static inline void
 percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
-- 
2.31.1

