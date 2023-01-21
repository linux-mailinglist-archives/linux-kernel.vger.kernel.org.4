Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EB676278
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjAUAcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAUAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:32:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E1FF0C;
        Fri, 20 Jan 2023 16:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674261097; x=1705797097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bfiBHovbm2wDNN6P4ZdJLa8C4JX44HUaHdUbsr9EAAI=;
  b=Jt2Miv2IuFhXXku+yj1pyK82QhvcnRHTGJRLD3ToCZc+mmaT8xva+7ai
   QpeVP5Uym7PWp+xD4ozWK1zqFbKeuuDAOQSva/0GlaPsx/9mStORVClpX
   37wozEfGWqMNpdsk7ofWaKWVf5WFMgVdIae8k8aIq7STqEJB6rdZlGyql
   sYcAt8QJMDbRy3ws7lPgUWQ4r4ZZbNBrzwTta0hK2ndAEIXi5K3w0vS0q
   ditPlBRh26oSNVON7vwSQ+DXp8ddE2GVi5RAWq/1pWQQQj2oEo9pQ4yqD
   P7vyNpQupnVXDS6GNJu6/Mt4xGeQYArvw+5tQ4Eocr9L+w+vRBlpcrfuo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305404631"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305404631"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="784729495"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="784729495"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 16:30:16 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@linux.intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 RESEND 3/4] Documentation/x86: Add the AMX enabling example
Date:   Fri, 20 Jan 2023 16:18:59 -0800
Message-Id: <20230121001900.14900-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230121001900.14900-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
 <20230121001900.14900-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

