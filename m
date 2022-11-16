Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D826D62C090
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiKPOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKPOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:10:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85051FD0A;
        Wed, 16 Nov 2022 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668607757; x=1700143757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1OaOIu1mrFQ4zu6rv6sozmi4ljbU3P7SVUDNEHsGdgY=;
  b=APgYikfU4pRYnFkFlzeAVLk7WIx5bduobAqn5JPXoLAdis8nxfpgnn2R
   s4GBaSVR4ERyF3xWBEJpQrXVsk/fxbgZWbIBIdwIunnM2tARGKWJlUpuB
   zwU3C8/6LKcX9DkvnOCaJpRLa5uScVaaREJ4gaFq2GY9AH6qDYSiPtvmH
   DmgPt3lC+Z1sRq7WW6axIra+tGvqVq3d+1MYtZJu/y2bv+V1VHIicF6v+
   KuBWfPK10xRexvEQmKGk7hdz+VcdAkJRi3UEwyTpaAUHLPZXpdMQXxx2t
   CkXUAUXPgwdDRcPvi1TV+HzDyUqXn7iQTesb5GatFaFJ4LGkxsJjOtOO7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312556931"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312556931"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:09:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="814096692"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="814096692"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:09:15 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org,
        thunder.leizhen@huawei.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Make vmalloc_dump_obj() call in a preemptible context
Date:   Wed, 16 Nov 2022 22:15:11 +0800
Message-Id: <20221116141511.3695680-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
lock, it also make vmap_area_lock spinlock can not acquire in
non-preemptive code segment. therefore, this commit make the
vmalloc_dump_obj() call in a preemptible context.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 mm/util.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 12984e76767e..465f8b8824ca 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1124,8 +1124,12 @@ void mem_dump_obj(void *object)
 		return;
 	}
 
-	if (vmalloc_dump_obj(object))
-		return;
+	if (is_vmalloc_addr(object)) {
+		if (preemptible() && vmalloc_dump_obj(object))
+			return;
+		type = "vmalloc memory";
+		goto end;
+	}
 
 	if (virt_addr_valid(object))
 		type = "non-slab/vmalloc memory";
@@ -1135,7 +1139,7 @@ void mem_dump_obj(void *object)
 		type = "zero-size pointer";
 	else
 		type = "non-paged memory";
-
+end:
 	pr_cont(" %s\n", type);
 }
 EXPORT_SYMBOL_GPL(mem_dump_obj);
-- 
2.25.1

