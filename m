Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0B66D424
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjAQCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjAQCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:14:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E311EFF8;
        Mon, 16 Jan 2023 18:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673921681; x=1705457681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VXpsPYKez3Jyml+yygKHWnUH1klujIbfV60IJCU7RIM=;
  b=i5R3k2wymEI8bAbCoayPGXScIXoB8HkyZjzb01Pc8ieCZX/glUK9cWmr
   HKoA6bBurck2lAmI5xCzGWqqzlBDbzgQa6eNH/xupNtRhCc9TPIktvzsI
   BgW0zamA4r0BVbsNkGtLIgXFPRDjkUPS1822OJgisVdxePgwFwRHDgsId
   coetSAZUE/DB1pgX8moqXRqjsdRT11m7seusBSJNQlvMNl8m9jQOOZ+iP
   YU7uvVnIoXHoi5WAqi9Z5hv81Pu8He9Xg62uy2zrWvDRbL2yOC+ggeOd9
   4nYiccSUHdxahW6jBheawbCxjzxzGECTlWijU7/Ekbkce3gOkGtSOwTPb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351839787"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="351839787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:14:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="691442801"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="691442801"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:14:38 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Remove impossible wakeup rcu GP kthread action from rcu_report_qs_rdp()
Date:   Tue, 17 Jan 2023 10:19:55 +0800
Message-Id: <20230117021955.1967316-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 kernel/rcu/tree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2c204529478..477eb1a374e5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1988,7 +1987,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			rcu_accelerate_cbs(rnp, rdp);
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -2000,8 +1999,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

