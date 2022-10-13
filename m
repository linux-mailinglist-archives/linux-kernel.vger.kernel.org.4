Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827115FDA05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJMNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJMNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:12:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D26DFD0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665666729; x=1697202729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fV/3WfZrif5mBWCPnpUmqi6jTjOvsWJITNohD01iWcQ=;
  b=O4+/NK5CjhJlZc6PwrYCY/eISP7NRp+C8/Whlzz8PYgzp2bSUZHn6UcY
   ltF4JsfbD9ssYVYvawgYgRTMF+TfTU2rXCbOWs+vSr85sS3MuL7CN5hvS
   eyrr9trSlTnhdPXfI6ocT7IKjMsOQ1fXwD7STz9iKRvc3QSBTY92vNmTa
   6uP48q5DE2TrmBWvRwKGnqBl70k4r3DOOn1uq60/LrxIVuJO8qbD24Dfo
   wbZPtPfsZ+UWlzySqeqEc/TJzKfsoP6/JQ6o9pUjsVNSXGVDlc7G5fF/F
   sdu8xsr+uDMzSjBc4gwIcCSrPns04UotroEyRBL3iyxDUZNNOQm886OE3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="288344195"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="288344195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 06:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="658178256"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="658178256"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2022 06:12:05 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Feng Tang <feng.tang@intel.com>, Yu Liao <liaoyu15@huawei.com>
Subject: [PATCH v2] x86/tsc: Extend watchdog check exemption to 4-Sockets platform 
Date:   Thu, 13 Oct 2022 21:12:00 +0800
Message-Id: <20221013131200.973649-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is report again that the tsc clocksource on a 4 sockets x86
Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
and disabled [1].

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduce to deal with these false
alarms of tsc unstable issues, covering qualified platforms for 2
sockets or smaller ones.

Extend the exemption to 4 sockets to fix the issue.

We also got similar reports on 8 sockets platform from internal test,
but as Peter pointed out, there was tsc sync issues for 8-sockets
platform, and it'd better be handled architecture by architecture,
instead of directly changing the threshold to 8 here.

Rui also proposed another way to disable 'jiffies' as clocksource
watchdog [2], which can also solve this specific problem in an
architecture independent way, with one limitation that some tsc false
alarms are reported by other watchdogs like HPET in post-boot time,
while 'jiffies' is mostly used in boot phase before hardware
clocksources are initialized.

[1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
[2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/

Reported-by: Yu Liao <liaoyu15@huawei.com>
Tested-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---

Hi reviewers:

In the v1 review cycle, Dave raised the issue that 'nr_online_nodes'
is not accurate, and could have problem with fakenuma (numa=fake=4 in
cmdline) case and system with CPU-less HBM/PMEM nodes, which we have
discussed in https://lore.kernel.org/lkml/Y0UgeUIJSFNR4mQB@feng-clx/
and will post the solution as a separate RFC patch.

Thanks,
Feng

Changelog:
  
  Since v1:
  * Change the max socket number from 8 to 4, as Peter Zijlstra
    pointed the 8S machine could have tsc sync issue, and should
    not be exempted generally
  
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..1fa3fdf43159 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1209,7 +1209,7 @@ static void __init check_system_tsc_reliable(void)
 	 *  - TSC which does not stop in C-States
 	 *  - the TSC_ADJUST register which allows to detect even minimal
 	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
+	 *  - not more than four sockets. As the number of sockets cannot be
 	 *    evaluated at the early boot stage where this has to be
 	 *    invoked, check the number of online memory nodes as a
 	 *    fallback solution which is an reasonable estimate.
@@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nr_online_nodes <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.34.1

