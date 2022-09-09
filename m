Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FCF5B40A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiIIU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiIIU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:26:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1455F0AB0;
        Fri,  9 Sep 2022 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662755142; x=1694291142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1XY8cQGeld5MP2iyj2lZROHf1+xibPBu6JwFM5Lnkew=;
  b=IyOOsUXeDdTcKrlq5nlEvwK+W2jjGdgQGKHtwnkXea6xgk58/uPL8MYi
   6d3Wj6cjQXa22B+XfllwcyCT6ekNiWr/PZm8RvnP3WOXUziD/9maAjnF5
   NekCrlRE1HtQwPyaSoK73Ss/5JCkD0L9kAw5VukE8yM71bS+NkRDIq1nB
   jDrfWlUBV0y7UHIw75ZOU2qTpD5xYNz+GhaHE2QIt/eYY6heZf1yXOF8k
   oUa71DmXMMfIgh7pTNcJsOwrV8rGuUk+7bRHbWxt6LC83Wf4GKwzgDR4v
   xguNsL8gBI8E52/sWOxwsHLey3z2puovK7FdtMlbqDgqiyy1vaoMG3QU5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280584702"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="280584702"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="611163001"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2022 13:25:36 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v4 3/4] Documentation/x86: Add the AMX enabling example
Date:   Fri,  9 Sep 2022 13:15:39 -0700
Message-Id: <20220909201540.17705-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909201540.17705-1-chang.seok.bae@intel.com>
References: <20220909201540.17705-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain steps to enable the dynamic feature with a code example.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes from v1:
* Update the description without mentioning CPUID & XGETBV (Dave Hansen).

Changes from v2:
* Massage sentences (Bagas Sanjaya).
* Adjust the example with the (future) prctl.h.
---
 Documentation/x86/xstate.rst | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 2577b28ad942..f7aad2241d32 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -78,6 +78,61 @@ the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
 
+AMX TILE_DATA enabling example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Below is the example of how userspace applications enable
+TILE_DATA dynamically:
+
+  1. The application first needs to query the kernel for AMX
+     support::
+
+        #include <asm/prctl.h>
+        #include <sys/syscall.h>
+        #include <stdio.h>
+        #include <unistd.h>
+
+        #ifndef ARCH_GET_XCOMP_SUPP
+        #define ARCH_GET_XCOMP_SUPP  0x1021
+        #endif
+
+        #ifndef ARCH_XCOMP_TILECFG
+        #define ARCH_XCOMP_TILECFG   17
+        #endif
+
+        #ifndef ARCH_XCOMP_TILEDATA
+        #define ARCH_XCOMP_TILEDATA  18
+        #endif
+
+        #define MASK_XCOMP_TILE      ((1 << ARCH_XCOMP_TILECFG) | \
+                                      (1 << ARCH_XCOMP_TILEDATA))
+
+        unsigned long features;
+        long rc;
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+
+        if (!rc && (features & MASK_XCOMP_TILE) == MASK_XCOMP_TILE)
+            printf("AMX is available.\n");
+
+  2. After that, determining support for AMX, an application must
+     explicitly ask permission to use it::
+
+        #ifndef ARCH_REQ_XCOMP_PERM
+        #define ARCH_REQ_XCOMP_PERM  0x1023
+        #endif
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, ARCH_XCOMP_TILEDATA);
+
+        if (!rc)
+            printf("AMX is ready for use.\n");
+
+Note this example does not include the sigaltstack preparation.
+
 Dynamic features in signal frames
 ---------------------------------
 
-- 
2.17.1

