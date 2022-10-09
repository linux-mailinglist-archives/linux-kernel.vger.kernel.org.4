Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2E5F8969
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 07:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJIFMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 01:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 01:12:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFD2A26D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665292340; x=1696828340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GwYosVc5vcm+WIpP6B82f0V3owyyyFeqQBnkDnFRTwI=;
  b=cknz/3v3jui429OLbKSmK7m8fcg931Enyz/M4/+NYMGMxZPbON054IqI
   7hmgxCYNjIZft/K16yPsenGyk7+OVbq6DpDuwFG1drKB8lAF4LoPhoqj4
   qTU1yOJvmFjwHmGgFOC+Gw61s/Aft5C9suRXbulIRLpNjIvsw1edJUrzZ
   xB5JkVCSfYucU4HySp1lHLvwShXCMBYzO5KHda2W+0UtTgJPOwq+jS99d
   pRZuHoX5W/7iZTnJm3u/0+utC3Rd4Y7swGB9Kq1Pyoif3DFnlEmJ3naft
   0q9JY/ETH4ZlQOuuissqNEyE2/SQWptotb/DRYf3lQviTScpE1n8kyGBf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="305612367"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="305612367"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 22:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="954540165"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="954540165"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga005.fm.intel.com with ESMTP; 08 Oct 2022 22:12:16 -0700
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
Subject: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S machine
Date:   Sun,  9 Oct 2022 13:12:09 +0800
Message-Id: <20221009051209.393377-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is report again that the tsc clocksource on a 4 sockets x86
Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
and disabled [1]. Also we got silimar reports on 8 sockets platform
from internal test.

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduce to deal with these false
alarms of tsc unstable issues, covering qualified platforms for 2
sockets or smaller ones.

Extend the exemption also to 4/8 sockets to fix the issue.

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
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..b4ea79cb1d1a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nr_online_nodes <= 8)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.34.1

