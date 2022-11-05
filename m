Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955261DC9A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKERkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKERkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:40:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0BC1CB13;
        Sat,  5 Nov 2022 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667670012; x=1699206012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UdMJwHAwQA1+imM7w6M6Py0x2bn4jGnAZ+JxoFIzVtw=;
  b=CmY8mC/SrzhxdEgJRq+uVjHIjTzUHngNp8K9SUQD43HVuU9ibfs4/2e8
   4b0QP5wx1nBmrUoibOBULVsLTijW+/Mg0GIvM+OFexiNkbXfWxowPfKnC
   vDpGhE6BaCCtMVHtbAFtuRYot1Ou6a8vN5lSVeMgU0jxhnbfH8ipBiJm6
   uwRBHcVJEOED+bhJ0rKw4uA2cEjRR0yxPwCIhFT9qKHoprxKRFX8a2kEk
   dqDqMbfIB8fssXB3VhzSVwh9Bu3YpYvMpU/hoILM1eGisQ8zlLoSy2oWw
   qjscBufQvNgaU1WEDy2J4igOMtoluhKVD3GVq4guR4PSep6lPhmRcHSUa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="297672767"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="297672767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 10:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="666729781"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="666729781"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2022 10:40:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion threshold
Date:   Sun,  6 Nov 2022 01:42:24 +0800
Message-Id: <20221105174225.28673-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221105174225.28673-1-rui.zhang@intel.com>
References: <20221105174225.28673-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After fixing the bogus comparison between u64 and s64, the ladder
governor stops making promotion decisions errornously.

However, after this, it is found that the ladder governor demotes much
easier than promotes.

Below is captured using turbostat after a 30 seconds runtime idle,

Without previous patch,
Busy%	IRQ	POLL	C1	C1E	C3	C6	C7s	C8	C9	C10	CPU%c1	CPU%c3	CPU%c6	CPU%c7	PkgWatt
0.30	2373	0	0	0	4	9	25	122	326	2857	0.36	0.04	0.57	98.73	1.48

With previous patch,
Busy%	IRQ	POLL	C1	C1E	C3	C6	C7s	C8	C9	C10	CPU%c1	CPU%c3	CPU%c6	CPU%c7	PkgWatt
0.42	3071	0	771	838	447	327	336	382	299	344	34.18	16.21	17.69	31.51	2.00

And this is caused by the imbalanced PROMOTION_COUNT/DEMOTION_COUNT.

With this patch,
Busy%	IRQ	POLL	C1	C1E	C3	C6	C7s	C8	C9	C10	CPU%c1	CPU%c3	CPU%c6	CPU%c7	PkgWatt
0.39	2436	0	1	72	177	51	194	243	799	1883	0.50	0.32	0.35	98.45	1.53

Note that this is an experimental patch to illustrate the problem,
and it is checked with idle scenario only for now.
I will try to evaluate with more scenarios, and if someone can help
evaluate with more scenarios at the same time and provide data for the
benefit with different PROMOTION_COUNT/DEMOTION_COUNT values, that
would be great.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpuidle/governors/ladder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index fb61118aef37..4b47aa0a4da9 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -20,8 +20,8 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#define PROMOTION_COUNT 4
-#define DEMOTION_COUNT 1
+#define PROMOTION_COUNT 2
+#define DEMOTION_COUNT 4
 
 struct ladder_device_state {
 	struct {
-- 
2.25.1

