Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18C646A10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLHIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:04:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814642F4B;
        Thu,  8 Dec 2022 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670486678; x=1702022678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1pFvOsRkGtabANKsYx3xAqx/MQZ2T6uHV8P/PaccLHU=;
  b=TceCVayJwHNNz3D0qb5In4i+MyuoCnxImRMqIbO4WXZ/f+w+ORqlJMB2
   W84ATqr7xFbSeUabrBMJq9EZQYNS3p8h5qWMqcEJXETDjLtl/rVnycYRa
   WBdbvECzknRTAMRuVC8OdgcGsdRnpfmKvfOwV1n+8n7wqR//Km+2c/uc+
   dNK+jQoKAi0b8pqFRkhIx1xHIxiDwsFyWsEYemWg1dsyE0aXIUyJsKJnl
   9pEnmqKKUClTWfzse63pO7lwlCQyQF6g+EPHgZ4/1Y9B9Nuj/CbPloL2t
   cRXuFdN0SpyWvFe2WctBdUkYvk1RA92BqsN4+Vo1FLX2w3yGhzsPhFHrz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379272841"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="379272841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 00:04:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="640539187"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="640539187"
Received: from junxiaochang.bj.intel.com ([10.238.135.52])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 00:04:35 -0800
From:   Junxiao Chang <junxiao.chang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, rostedt@goodmis.org, junxiao.chang@intel.com,
        hock.zhang.peh@intel.com
Subject: [PATCH] softirq: wake up ktimer thread in softirq context
Date:   Thu,  8 Dec 2022 15:56:04 +0800
Message-Id: <20221208075604.811710-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.25.1
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

Occiaionally timer interrupt might be triggered in softirq context,
ktimer thread should be woken up with RT kernel, or else ktimer
thread might stay in sleep state although timer interrupt has been
triggered.

This change fixes a latency issue that timer handler is delayed for
more than 4ms in network related test.

Fixes: 2165d27554e8 ("softirq: Use a dedicated thread for timer wakeups.")
Reported-by: Peh, Hock Zhang <hock.zhang.peh@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 kernel/softirq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ab1fe34326bab..34ae39e4a3d10 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,13 +664,10 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt()) {
-		if (local_softirq_pending())
-			invoke_softirq();
-
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
-			wake_timersd();
-	}
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
+	if (!(in_nmi() || in_hardirq()) && local_pending_timers())
+		wake_timersd();
 
 	tick_irq_exit();
 }
-- 
2.25.1

