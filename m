Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C5606FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiJUGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJUGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:21:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451F228CCC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333299; x=1697869299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j97xvK9t++xli12verMTAsYTdoFDdE9oHAeuOe31Zps=;
  b=cqRyEv+yuOYL6IJQPIXC/OMjAUgmcQucvyA1K0v7ls/tIEFftq9N2+L8
   FpTGjk3FEpQp1w3TRI6M954iOiPbbPZ/LxyVD6QSIN8nQDuzxIQcN3IlJ
   SO30puLbznZFyUqwQ/ZxiK64GRSje74xkhxpuhSC51nMEBT2hflCHgTIx
   YoY17OQP4Oy0IHk18IKMC+eWOnbqt7z1NE3pIF5XReyw7izeFuRbuNyai
   JVjfjrLjaiX4SVeOFSfI5Da5id5tbsEmlvuTMEFvl1K3K6Jxq2YbaYrNg
   kkX04gNljCjrhlIBXbwnirgSXW0f3tON+OmGyRxUji42VX1IeWbaSPgFp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287324653"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287324653"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755625363"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="755625363"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2022 23:21:36 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v1 2/2] x86/tsc: Extend watchdog check exemption to 4-Sockets platform
Date:   Fri, 21 Oct 2022 14:21:31 +0800
Message-Id: <20221021062131.1826810-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021062131.1826810-1-feng.tang@intel.com>
References: <20221021062131.1826810-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
architecture independent way, with one limitation that there are
also some tsc false alarms which were reported by other hardware
watchdogs like HPET/PMTIMER, while 'jiffies' watchdog is mostly
used in kernel boot phase.

[1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
[2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/

Reported-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 178448ef00c7..356f06287034 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1400,7 +1400,7 @@ static int __init init_tsc_clocksource(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    logical_packages <= 2)
+	    logical_packages <= 4)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	/*
-- 
2.34.1

