Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E41E6A8153
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCBLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCBLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:38:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F17285;
        Thu,  2 Mar 2023 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677757075; x=1709293075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwak2C4DI1aammiFaZMv5N9CnNE3MgLfUDixbsPuack=;
  b=h6S0SXSkv2p7hLQH7gf8h9Kv/paJRoUwC4kWCyUF3Oatmp4JDJ3md7pZ
   RUVb9RPUolj4fXTW1HJZBnhcQEPqdexKLN6bmBNE24JoracR1cxvhq7lC
   98dvwjT9lmpRdo+gXWjIKorXrSHu6F7Y7CPYTLN0unnKtgyxT/h9JjPnf
   FmFWA2V73ijdgXIHfdUFoN6vravzOMeq9D2uLG8A5rP/pcbJnRwyVH/vD
   vbzOuRs+bqPw4zxjjQgxrzQrlOfsPuSsduiPSE/VQHSw/qNmmgYFF+Jxj
   +6fJ6zY9cip6nEh7kZhLmThudeNIquYqT4JlOu5l96pF7G9b26UCMHWRr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336195444"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="336195444"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:36:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="668200905"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="668200905"
Received: from pplank-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.217.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:36:56 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] trace/hwlat: Do not restart per-cpu threads if they are already running
Date:   Thu,  2 Mar 2023 13:36:54 +0200
Message-Id: <20230302113654.2984709-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the hwlatd thread for the cpu is already running, before
starting a new one. This avoids running multiple instances of the same
CPU thread on the system. Also, do not wipe the contents of the
per-cpu kthread data when starting the tracer, as this can completely
forget about already running instances and start new additional per-cpu
threads. Fixes issues where fiddling with either the mode of the hwlat
tracer or doing cpu-hotplugs messes up the internal book-keeping
resulting in stale hwlatd threads.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 kernel/trace/trace_hwlat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d440ddd5fd8b..c4945f8adc11 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	/* Do not start a new hwlatd thread if it is already running */
+	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
+		return 0;
+
 	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -584,9 +588,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 
-	for_each_online_cpu(cpu)
-		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
-
 	for_each_cpu(cpu, current_mask) {
 		retval = start_cpu_kthread(cpu);
 		if (retval)
-- 
2.25.1

