Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6F6C5D71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWDsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCWDsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:48:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CC8A4E;
        Wed, 22 Mar 2023 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679543308; x=1711079308;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ucl1BpduzkXe47qrwgSVs43AuH0kYk2zpUQdgR5up+0=;
  b=Ew2n1o3ck458qapGQk1grYjYYtQw0Vsf7608NQvEBZ1M2PCffvG4yg6x
   FkMiZRu3qwmCthzEmVjd7M6GSK+6MKy9ybIkWJ/DKtl1GTZzfsDYPe8kk
   Nf7mVwL4yJsfqHRA9OQwic7G7v1Q4lV3iAYU89IiS9L3QzOsDCX166faJ
   sJ9S+nkf1ymUlW3SHtOjkbvoFNlci2LkMB8Rc5IHxWNbLZCgK4rwEyK/9
   sKBK7GQAiYLaTK9H2BYDgK0tRsPS2qtzJdQMe9QZa+0WJZ5xX8IRfdUzK
   hnh6II3r6W/7ZcRFTal2rLl3Pgk5jQrjWCugS43avuvzeVtYexv4DCSNc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319778803"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319778803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856342368"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856342368"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:48:26 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Make pr_info() output more clearly in cblist_init_generic()
Date:   Thu, 23 Mar 2023 12:00:11 +0800
Message-Id: <20230323040011.143884-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit use rtp->name instead of __func__, and output the value
of rcu_task_cb_adjust in pr_info(), reduced pr_info() calls.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 397309da3446..0cf958db4e44 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -270,10 +270,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
-	if (rcu_task_cb_adjust)
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
-
-	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
+			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
 }
 
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
-- 
2.25.1

