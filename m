Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7E62EA44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiKRA3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKRA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:28:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263B70A1E;
        Thu, 17 Nov 2022 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668731327; x=1700267327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GmWPbqaX/RKcrEpQEce2Uo62AEQ/ECmJrcr2BAPP4A8=;
  b=iVV7oBaGYvAam04asypzkbV9TfS4KzilAvKhSlCR5HYMHFFamYfoq0b4
   6XHU65iJtxNM4zmWXgX4CJ2C44guf6u7QsBvY8K+N4e+ShK7zMVmGVJ9P
   d1aryDNWJG1dmCb1m0IaLGqr3d1fkJs4iiqu+seyaDUOQmgJM3sXo+Im2
   Iwk+Z4K+7lsjfA20K9ox0IG0hUdeSA14h2q7LlwfrJUfWh7Y5a6w9Jx07
   PWMLAde+ZLq5MH2RJcc2nqwpgmtn/nUcOaT/3sgYSLXHSnqCJK8ltOUzb
   719mkgK35+/bWkPGqJPKZ7HmhQ0zOH0BSILxNCvQwvN5gXSMnsWA/Zsdd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311716973"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="311716973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:28:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703539952"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703539952"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:28:45 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, frederic@kernel.org,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
Date:   Fri, 18 Nov 2022 08:34:41 +0800
Message-Id: <20221118003441.3980437-1-qiang1.zhang@intel.com>
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

Currently, the mem_dump_obj() is invoked in call_rcu(), the
call_rcu() is maybe invoked in non-preemptive code segment,
for object allocated from vmalloc(), the following scenarios
may occur:

        CPU 0
tasks context
   spin_lock(&vmap_area_lock)
       Interrupt context
           call_rcu()
             mem_dump_obj
               vmalloc_dump_obj
                 spin_lock(&vmap_area_lock) <--deadlock

and for PREEMPT-RT kernel, the spinlock will convert to sleepable
lock, so the vmap_area_lock spinlock not allowed to get in non-preemptive
code segment. therefore, this commit make the vmalloc_dump_obj() call in
a clean context.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 add IS_ENABLED(CONFIG_PREEMPT_RT) check.
 v2->v3:
 change commit message and add some comment.

 mm/util.c    |  4 +++-
 mm/vmalloc.c | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 12984e76767e..2b0222a728cc 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1128,7 +1128,9 @@ void mem_dump_obj(void *object)
 		return;
 
 	if (virt_addr_valid(object))
-		type = "non-slab/vmalloc memory";
+		type = "non-slab memory";
+	else if (is_vmalloc_addr(object))
+		type = "vmalloc memory";
 	else if (object == NULL)
 		type = "NULL pointer";
 	else if (object == ZERO_SIZE_PTR)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..4351eafbe7ab 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4034,6 +4034,31 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
+	/* for non-vmalloc addr, return directly */
+	if (!is_vmalloc_addr(objp))
+		return false;
+
+	/**
+	 * for non-Preempt-RT kernel, return directly. otherwise not
+	 * only needs to determine whether it is in the interrupt context
+	 * (in_interrupt())to avoid deadlock, but also to avoid acquire
+	 * vmap_area_lock spinlock in disables interrupts or preempts
+	 * critical sections, because the vmap_area_lock spinlock convert
+	 * to sleepable lock
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		return false;
+
+	/**
+	 * get here, for Preempt-RT kernel, it means that we are in
+	 * preemptible context(preemptible() is true), it also means
+	 * that the in_interrupt() will return false.
+	 * for non-Preempt-RT kernel, only needs to determine whether
+	 * it is in the interrupt context(in_interrupt()) to avoid deadlock
+	 */
+	if (in_interrupt())
+		return false;
+
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-- 
2.25.1

