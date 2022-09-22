Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B95E6CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiIVUI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiIVUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:08:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115DE6A39;
        Thu, 22 Sep 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877312; x=1695413312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bfiBHovbm2wDNN6P4ZdJLa8C4JX44HUaHdUbsr9EAAI=;
  b=StamXPj5GCyrJn8eVaMhZehkyzFYXSgikGSx9INMwoGsV8EkNQQIT5w8
   wlreABxo97Sf5IDdLzfpF6SobfHfpYCQvZWLDiFZ9JuNWr5IEVDcpTEvC
   0E6e04FrGsKst6wm8NicGd4/O1bp0dmhn7/sZRVi14mVa77XPSYY+dCTP
   0nSm5pYlczjQovNLcDej/pe9lUXZ79yww5e7WnwsSkg4JjEEGUJ2libEM
   ApXSvXC7xD6MrYx906Fkigl6AS/c4nr/YhiNvAcu73xKFYUQKAI+nqNC3
   wGHir00JFWltNmzwVY8QhrViYwBklqeRROQCYhHsRuG1d8ynG33IgHHdN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362221578"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362221578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571117140"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 13:08:14 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 3/4] Documentation/x86: Add the AMX enabling example
Date:   Thu, 22 Sep 2022 12:58:09 -0700
Message-Id: <20220922195810.23248-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922195810.23248-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index e954e79af4ce..23b1c9f3efb2 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -80,6 +80,61 @@ the handler allocates a larger xstate buffer for the task so the large
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

