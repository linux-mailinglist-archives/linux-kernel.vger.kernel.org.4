Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3006550BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLWNKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLWNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:10:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE682EC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671801030; x=1703337030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tV8wUuZIsiyTKBUsG9YZqXJnycLYvbf9P55YbqnPIaQ=;
  b=jo7eK5tX5jkYBYTGtKAkHNxS3d4aeTFD1XPP8aYLwtqqThFb/70hPbRb
   Z4LKTvvTsC4u/sRUZHO+BbzRZeHg8ODCbcjJcE7DC+EBvbRqdrO0nbIiB
   l8vxjQ7QJ+IY1XY9RZrIr+7VBGHjBiV/iVnobfFbDhjjN/kpz+4ZzdpPl
   wkoxgKtLGomQC6vaCHxJKcv/F+ZSTZsZXKB4IhguTzNOxHMtb5cUNlL9f
   IT5Ub2Z2t3Y9ploiIGT3mXW+Jy5HPNA3PAoCkvkBzMD3BA31j4DdNq7fq
   96kaDk8IHtfJYY0QSEKN8XW6T3dVtfOboBIT1+qxx3sY+H36y4YM1xKPk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="300003075"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="300003075"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 05:10:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="826292911"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="826292911"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 05:10:28 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     pmladek@suse.com, akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kthread_worker: Flush all delayed works when destroy kthread worker
Date:   Fri, 23 Dec 2022 21:16:01 +0800
Message-Id: <20221223131601.237244-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When destroy a kthread worker, only flush all current works on
kthread worker, this is not very sufficient, there may be some
delayed works in the pending state, this commit therefore add
flush delayed works function in kthread_destroy_worker().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec81d2b..8616228abb3b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -206,6 +206,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 
 void kthread_flush_work(struct kthread_work *work);
 void kthread_flush_worker(struct kthread_worker *worker);
+void kthread_flush_delayed_works(struct kthread_worker *worker);
 
 bool kthread_cancel_work_sync(struct kthread_work *work);
 bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..2744f6b769d1 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1375,6 +1375,35 @@ void kthread_flush_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL_GPL(kthread_flush_worker);
 
+/**
+ * kthread_flush_delayed_works - flush all current delayed works on a
+ * kthread_worker.
+ * @worker: worker to flush
+ *
+ * Wait until all currently executing or pending delayed works are
+ * queued completed.
+ */
+void kthread_flush_delayed_works(struct kthread_worker *worker)
+{
+	unsigned long flags;
+	struct kthread_delayed_work *dwork;
+	struct kthread_work *work;
+
+	raw_spin_lock_irqsave(&worker->lock, flags);
+	while (!list_empty(&worker->delayed_work_list)) {
+		work = list_first_entry(&worker->delayed_work_list,
+					struct kthread_work, node);
+		list_del_init(&work->node);
+		dwork = container_of(work, struct kthread_delayed_work, work);
+		raw_spin_unlock_irqrestore(&worker->lock, flags);
+		if (del_timer_sync(&dwork->timer))
+			kthread_queue_work(worker, &dwork->work);
+		raw_spin_lock_irqsave(&worker->lock, flags);
+	}
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
+}
+EXPORT_SYMBOL_GPL(kthread_flush_delayed_works);
+
 /**
  * kthread_destroy_worker - destroy a kthread worker
  * @worker: worker to be destroyed
@@ -1391,8 +1420,10 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	if (WARN_ON(!task))
 		return;
 
+	kthread_flush_delayed_works(worker);
 	kthread_flush_worker(worker);
 	kthread_stop(task);
+	WARN_ON(!list_empty(&worker->delayed_work_list));
 	WARN_ON(!list_empty(&worker->work_list));
 	kfree(worker);
 }
-- 
2.25.1

