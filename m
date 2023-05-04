Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EA6F65A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEDHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:21:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B572128
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683184896; x=1714720896;
  h=from:to:cc:subject:date:message-id;
  bh=hl+FtDOwmA1lTmww4PEh2u/673uzerCHCGbZfck4WLY=;
  b=WW2fbCiQ6ws2uvTS7+Fj5K2aiI1CzZBrOwT+2bvdZPyfSwUiNk5+ISLM
   mE5BZYcQk7rnH8HKsziTA3eqdYmwmWgphF5dSIMAb3w+g0vejxHHYPqJz
   ZS3YK6AQ2aPQOv60+AW3yEI0oI2PcEoj1Mkkm2/iMjlq2Wbc5hIB0wJsA
   +yvtcXSimwFqCVaVKsNSAqWUlHvFn6HTZgktyMn3KSMYVYhUL7It5Y2Ai
   xYrYjCC7aohZz7pAEOxhAs1sJCTpmSZtt/ZVrppiz1gPExOI11n36glJO
   tnosr0MHNZSPy2nbmUG+N97tkyDfWW5a/Y1WxbZicL4HvguaUhkJHTPQ7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="414321662"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="414321662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="674432459"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="674432459"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:21:34 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kernel/smp: Fix comments for smp_call_function{,_many}()
Date:   Thu,  4 May 2023 15:20:50 +0800
Message-Id: <20230504072051.80480-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'wait' of smp_call_function_many() is a bool, not a
bitmask. smp_call_function() has no return value. Fix their function
comments respectively.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 kernel/smp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 06a413987a14..ee4f3439b7d5 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -994,10 +994,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * If @wait is true, then returns once @func has returned.
  *
@@ -1019,8 +1017,6 @@ EXPORT_SYMBOL(smp_call_function_many);
  * @wait: If true, wait (atomically) until function has completed
  *        on other CPUs.
  *
- * Returns 0.
- *
  * If @wait is true, then returns once @func has returned; otherwise
  * it returns just before the target cpu calls @func.
  *
-- 
2.17.1

