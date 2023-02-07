Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FC68CE60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBGEvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBGEuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873B44BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745449; x=1707281449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gCAF3pOvYu6INyXHaG52RuEfLVgO2TXZcOSdaT+lLxQ=;
  b=i7xL4ERpfSQxN0FM17Jn4FDvGddQB0cbWybKTC36I9Bxopqo6Djxlth1
   rY/kArRBYkugTUHFt0ZgTANUhRgfFR7lMrAiIXZy2QKtyh/fQrW5tKWYO
   4+mW7EZeeZyF1d0nl6dZUglbWppevqgTjl60OA21QqTHLtDgz6i0p3kiw
   9gCpI93vZwLOV24ixa1tuSmMX/Nsgi6uGiG42mGPKhwSc0vkrdVRa21f1
   JqTOR+T2U9uyGrkw1/R42gQtNSSLGLXo+zjtTwI4I36TxbRt3GkvRsb3g
   H7kVvmabjF/sZeE+Y5QLO5r+V4cAEnp263NaMZ7/uPH109n0GG2mJhLfi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624041"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624041"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653802"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653802"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:48 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 08/10] sched/topology: Remove SHARED_CHILD from ASYM_PACKING
Date:   Mon,  6 Feb 2023 20:58:36 -0800
Message-Id: <20230207045838.11243-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only x86 and Power7 use ASYM_PACKING. They use it differently.

Power7 has cores of equal priority, but the SMT siblings of a core have
different priorities. Parent scheduling domains do not need (nor have) the
ASYM_PACKING flag. SHARED_CHILD is not needed. Using SHARED_PARENT would
cause the topology debug code to complain.

X86 has cores of different priority, but all the SMT siblings of the core
have equal priority. It needs ASYM_PACKING at the MC level, but not at the
SMT level (it also needs it at upper levels if they have scheduling groups
of different priority). Removing ASYM_PACKING from the SMT domain causes
the topology debug code to complain.

Remove SHARED_CHILD for now. We still need a topology check that satisfies
both architectures.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 include/linux/sched/sd_flags.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7..800238854ba5 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -132,12 +132,9 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 /*
  * Place busy tasks earlier in the domain
  *
- * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- *               up, but currently assumed to be set from the base domain
- *               upwards (see update_top_cache_domain()).
  * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_PACKING,  SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
-- 
2.25.1

