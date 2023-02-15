Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF069761B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBOGFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOGFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:05:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133A7AAD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676441138; x=1707977138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bFqPJSqonIBo3Z3voAM+KmohKUwQr9Pn+pbWpPvn+dg=;
  b=AQwm1Q7w7ef56AoJSbCQ7bdoWmlaBUKsHsj2iVwH0k1sF+52GJqqQ2S0
   8xSaC4UTuNbVwaFd1VXNmXtXtzj71nxYSGKfif2xUqxmx/ii43RbnXqqL
   M+p1mTCarTGOim8Wz/28F5GojXcF2lPKX3wPk964s1fIUo3k4FKqHPzab
   +6ogzm410vqjPj2Ulk5QaBDymtyXAicfiu6sobptpuKh+l3fOX+93vcLr
   /1+w398c+wpUhNPa5iVFpP1xk7xOTIZ6lbI5t0p0axJjkwYEDigjVAjBO
   0ibCdV6vSBVv6hNy+yMdvMhLBKOs5bI5AO151tMvF4ufb/TpnwGStn8/Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311720966"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311720966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:05:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733153530"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733153530"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:05:36 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
Date:   Wed, 15 Feb 2023 14:10:35 +0800
Message-Id: <20230215061035.1534950-1-qiang1.zhang@intel.com>
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

For PREEMPT_RT kernel, the spin_lock, spin_lock_irq will converted
to sleepable rt_spin_lock and the interrupt related suffix for
spin_lock/unlock(_irq, irqsave/irqrestore) do not affect CPU's
interrupt state. this commit therefore add raw_spin_lock torture
tests, this is a strict spin lock implementation in RT kernels.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/locking/locktorture.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9425aff08936..521197366f27 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops = {
 	.name		= "spin_lock_irq"
 };
 
+#ifdef CONFIG_PREEMPT_RT
+static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
+
+static int torture_raw_spin_lock_write_lock(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	raw_spin_lock(&torture_raw_spinlock);
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock(&torture_raw_spinlock);
+}
+
+static struct lock_torture_ops raw_spin_lock_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock"
+};
+
+static int torture_raw_spin_lock_write_lock_irq(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&torture_raw_spinlock, flags);
+	cxt.cur_ops->flags = flags;
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock_irq(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock_irqrestore(&torture_raw_spinlock, cxt.cur_ops->flags);
+}
+
+static struct lock_torture_ops raw_spin_lock_irq_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock_irq,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock_irq,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock_irq"
+};
+#endif
+
 static DEFINE_RWLOCK(torture_rwlock);
 
 static int torture_rwlock_write_lock(int tid __maybe_unused)
@@ -1017,6 +1072,9 @@ static int __init lock_torture_init(void)
 	static struct lock_torture_ops *torture_ops[] = {
 		&lock_busted_ops,
 		&spin_lock_ops, &spin_lock_irq_ops,
+#ifdef CONFIG_PREEMPT_RT
+		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
+#endif
 		&rw_lock_ops, &rw_lock_irq_ops,
 		&mutex_lock_ops,
 		&ww_mutex_lock_ops,
-- 
2.25.1

