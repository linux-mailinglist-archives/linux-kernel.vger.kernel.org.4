Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB963482A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiKVU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiKVU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576A17055
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148895; x=1700684895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vXIaD/zsIWPHn5n3olE8jagfMylwb+X/0KOXnCS5E6Q=;
  b=ezwAMMGqxlaicR1khS+T/6eMe09a2oG4+ubhca8mbuxeAjebbBBQvccE
   yzAEvaI1egytNfUP8SgWJBb7VEL8ioI+Tz1KLvCUnlhHstuikCyyrzj7P
   ziiLnTyZ2qqndpeHd7fW90As0qVFZKL9ayyWp6s4rnQfvVsYS1GPU1ScP
   tMKKJds2SCMB58oLW3toHRRzpxH9YwcTbI2jGCtxXd+kKO5ZxvH/NwzdI
   NZgL9e+EEUdUUislcc9xH6c+EExe3QlcVv07D3Lz3K2YFBGJ0WonXyCXs
   8Neit6x8iKNal3IW2uBcWWK2VMF6J5l0k5wIZVsj/BwshL8RHETA7PZA1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616511"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616511"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228141"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228141"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:14 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT" domain
Date:   Tue, 22 Nov 2022 12:35:30 -0800
Message-Id: <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no difference between any of the SMT siblings of a physical core.
asym_packing load balancing is not needed among siblings.

When balancing load among physical cores, the scheduler now considers the
state of the siblings when checking the priority of a CPU.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Introduced this patch.
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea0287f69..c3de98224cb4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -545,7 +545,7 @@ static int x86_core_flags(void)
 #ifdef CONFIG_SCHED_SMT
 static int x86_smt_flags(void)
 {
-	return cpu_smt_flags() | x86_sched_itmt_flags();
+	return cpu_smt_flags();
 }
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-- 
2.25.1

