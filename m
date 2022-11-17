Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25B62D943
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiKQLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiKQLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:19:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB972B251;
        Thu, 17 Nov 2022 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683967; x=1700219967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R7Tw/bo/e0ph1HCAxMg1wWzO55ZqQuYAf2pd0W+MSkw=;
  b=FrbBE4mbJXnFogg+pl0S1qnwtECG82+HREd9SjRsRyzkf8cwRaHzMCBK
   uJ8T/zWZJyUzPUkcJ81QaNyMg6DRa+Yx2LC7OtImv5yi2I5xVIyPxl0KN
   3RQaDtwlE/DT6ly++h4Bzu5apV8XLowwoOsD2fwdZD6rwOqktQ3snfFvH
   tuMx0thSkdKgN6i/e5b2laXdeBkmt38pluteCuI3glEy+qP8bTyFM5UxV
   RU6LfYqPzz2aw/YUes10B3Xk7ouQiyYS50UaTxsXkJAEvGbUyFZYN/LU2
   9MKBTBj8FUImBr3Yy8b0u8/i+0mBIUyB1uGwRK+ZcBPUERpvWNeI264to
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="377090197"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377090197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:19:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="642063469"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="642063469"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:19:24 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, thunder.leizhen@huawei.com,
        akpm@linux-foundation.org, frederic@kernel.org,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: Make vmalloc_dump_obj() call in a preemptible context
Date:   Thu, 17 Nov 2022 19:25:20 +0800
Message-Id: <20221117112520.3942618-1-qiang1.zhang@intel.com>
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
a preemptible context.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Add IS_ENABLED(CONFIG_PREEMPT_RT) check.

 mm/util.c    | 4 +++-
 mm/vmalloc.c | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index ccaa461998f3..018e417b12d6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4034,6 +4034,10 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
+	if (!is_vmalloc_addr(objp) || ((IS_ENABLED(CONFIG_PREEMPT_RT) &&
+				!preemptible()) || in_interrupt()))
+		return false;
+
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-- 
2.25.1

