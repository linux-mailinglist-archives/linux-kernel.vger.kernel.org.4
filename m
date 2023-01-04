Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0965D5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjADOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjADOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:37:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7EE2DDA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672843039; x=1704379039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HtQ0/PIlNHRHOzAOijbMWgzI9+6drMS+LW1td1A907w=;
  b=AaookK6FBW806U/I9cE/w+TtrsY3/B4JeARGcNuIz4qMr2GujsF+PR9J
   y6DL7BmRb9jXRkmB4ZyXRLLOJFg+3RrG+nKiqPPyFuq4qYI0hWhe87i8k
   MLZ7BsJLEVMrtgyvP/iFSAew3ayEUUgyJNI8XZ6jdMnrz7T+eqpFUICKH
   7d3fj/0LDiAZafmurjF/WEaT6Y2SlfpNvLTx+1suVjpU6i1yts/30GY2I
   bIp7IgkaoGlT2gr74Z7LrLdNAaahTqr4QVs7Aw0wBQfgzSQ9mPfUSMDO+
   CMvoBob042Uy6sWf4BehxWh1z2jMxBV7atvUCIaHYerzA7UKAy/S/Qiy+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="309713798"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="309713798"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:37:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657128659"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="657128659"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:37:05 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] kthread_worker: Check all delayed works when destroy kthread worker
Date:   Wed,  4 Jan 2023 22:42:30 +0800
Message-Id: <20230104144230.938521-1-qiang1.zhang@intel.com>
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

This commit add a check for delayed works, when destroy kthread worker
if there are still some pending delayed works will trigger warnning,
this remind caller should clear all pending delayed works before destroy
kthread worker.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Only add WARN_ON() and function description

 kernel/kthread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..7e6751b29101 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1382,6 +1382,10 @@ EXPORT_SYMBOL_GPL(kthread_flush_worker);
  * Flush and destroy @worker.  The simple flush is enough because the kthread
  * worker API is used only in trivial scenarios.  There are no multi-step state
  * machines needed.
+ *
+ * Note that this function is not responsible for handling delayed work, so
+ * caller should be responsible for queuing or canceling all delayed work items
+ * before invoke this function.
  */
 void kthread_destroy_worker(struct kthread_worker *worker)
 {
@@ -1393,6 +1397,7 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 
 	kthread_flush_worker(worker);
 	kthread_stop(task);
+	WARN_ON(!list_empty(&worker->delayed_work_list));
 	WARN_ON(!list_empty(&worker->work_list));
 	kfree(worker);
 }
-- 
2.25.1

