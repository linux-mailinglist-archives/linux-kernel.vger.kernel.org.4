Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE858671579
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjARHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjARHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A15085D;
        Tue, 17 Jan 2023 23:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674026700; x=1705562700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rs0p7J65P5DaU8eumyIPyYV1lHhrG+9oA++7hTvmEy0=;
  b=lYD88QSlYTZib24UP4RlYcbl9BJjnBGPOb/Syw9XkRJBeW8i0p2Rusue
   CbaTpQhro9l8CjzIOlxkKL6pQ9GwR9jHYyt0OdmGDNlN+zaSwO+oUG89J
   h1Vebe3FCTWuf0UM+0oZMPNMOaqmbNB6xC8RBEONIRiqILEJsBtjap/5V
   CB3vnrWiVK83hCFMAG6Ze8Tf9kWZzndEn1qV1oQdDvhRgHr25BgW+Xvsj
   qhxOO8cA6k4NBof40E+/5kRFJpOl5rApR8y0kjP8FSNmKMRvKwsO7BVWr
   fnMFR8I8u0XHb0T40dDIofqFYZOHxoR8lSfsyhMy/AUzxrDRe0oOW9+A9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308483251"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308483251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:25:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="661612076"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661612076"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:24:58 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action from rcu_report_qs_rdp()
Date:   Wed, 18 Jan 2023 15:30:14 +0800
Message-Id: <20230118073014.2020743-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
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

When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
grpmask has not been cleared from the corresponding rcu_node structure's
->qsmask, after that will clear and report quiescent state, but in this
time, this also means that current grace period is not end, the current
grace period is ongoing, because the rcu_gp_in_progress() currently return
true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
to return true.

This commit therefore remove impossible rcu_gp_kthread_wake() calling.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2c204529478..0962c2202d45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			/*
+			 * Current GP does not end, invoke rcu_gp_in_progress()
+			 * will return true and so doesn't wake up GP kthread to
+			 * start a new GP.
+			 */
+			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

