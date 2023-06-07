Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B07256B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjFGIBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjFGIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:01:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B808E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686124906; x=1717660906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e8MTFcSll/wbxcfO1IjSS7T6C650r/6+xSXMzyq2gZA=;
  b=BNiGR1kwHOIBLRnkJSXnpTrfL49+jvGDm4jNTgHuSLLzMeHvWAL++TG/
   rlP8bgrC2/TKMz478GzxcIFBnKR2ou/yVYg31R1GtBfSn4easK9FSLmqm
   2RIO4gkakvlSA981EBP7tVXO7vgJTK6ao0/LvA/razaSw5NHFsXuShXER
   jaCETr+McZDQN1oBhMi428teWmBs3FgWw4+ShxYMLrAyblxhng2PmtBJ2
   zU3fj5SinMW7PPCZastEiiBDiZqsP1mGnS11qkpTL04ZQLPXpiuiNl8PU
   vTcf9iMqnz/aVM/ukGOAOh+uM0KcXn/ZACfgwgSpoo1gdRD34rHq50/HV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="360245238"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="360245238"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 01:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799202916"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="799202916"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2023 01:01:30 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Cc:     rui.zhang@intel.com, Feng Tang <feng.tang@intel.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: [PATCH] x86/tsc: Extend watchdog check exemption to 4-Sockets platform
Date:   Wed,  7 Jun 2023 15:54:33 +0800
Message-Id: <20230607075433.387075-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were reports again that the tsc clocksource on 4 sockets x86
servers was wrongly judged as 'unstable' by 'jiffies' and other
watchdogs, and disabled [1][2].

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduce to deal with these false
alarms of tsc unstable issues, covering qualified platforms for 2
sockets or smaller ones. And from history of chasing TSC issues,
Thomas and Peter only saw real TSC synchronization issue on 8 socket
machines.

So extend the exemption to 4 sockets to fix the issue.

Rui also proposed another way to disable 'jiffies' as clocksource
watchdog [3], which can also solve problem in [1]. in an architecture
independent way, but can't cure the problem in [2]. whose watchdog
is HPET or PMTIMER, while 'jiffies' is mostly used as watchdog in
boot phase.

'nr_online_nodes' has known inaccurate problem for cases like
platform with cpu-less memory nodes, sub numa cluster enabled,
fakenuma, kernel cmdline parameter 'maxcpus=', etc. The harmful case
is the 'maxcpus' one which could possibly under estimates the package
number, and disable the watchdog, but bright side is it is mostly
for debug usage. All these will be addressed in other patches, as
discussed in thread [4].

[1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
[2]. https://lore.kernel.org/lkml/06df410c-2177-4671-832f-339cff05b1d9@paulmck-laptop/
[3]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
[4]. https://lore.kernel.org/all/20221021062131.1826810-1-feng.tang@intel.com/

Reported-by: Yu Liao <liaoyu15@huawei.com>
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..f15066a1d473 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1238,7 +1238,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nr_online_nodes <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.34.1

