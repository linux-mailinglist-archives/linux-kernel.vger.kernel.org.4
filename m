Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847876A4C36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjB0UYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjB0UYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:24:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27D24121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677529474; x=1709065474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iTd/k0mMIIx7db8A87KH6nHt2zM3+2Nlr7MQUFWEhqs=;
  b=YKUzseU8yeMmf5ko34GlDFeBmwtW0yKOS2CAKc5FxUCdZIYf+owL73gk
   MdsM9InJiCj46mSTR3sueJSbVI6c6iKr1SDpO+lAZk3YZxb6VlSwP7Xnz
   YyRlZcI5d/2aQqGt5wexs4q4fO6rk27WU40mh4WCf06Q0pb4nNYl8bwph
   391f+GIFcP3HE8/mA0j1gaN07QQaJ5IFSRPRBvBUxboKsjyiGorDshI0X
   ChDFhUuVUwIhvsY1MjCloOtxViaA3T43S3HkcOuUsX5IMGT4wSbOAzzKq
   0NVsEF64ixkyY/QLpS/9erzSnBKR04RGhifIR5slT/lO6SpTO03OLrAmK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="398736688"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="398736688"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 12:24:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="1002936862"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="1002936862"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 12:24:33 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: semantic patch to check for potential struct_size calls
Date:   Mon, 27 Feb 2023 12:24:28 -0800
Message-Id: <20230227202428.3657443-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
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

include/linux/overflow.h includes helper macros intended for calculating
sizes of allocations. These macros prevent accidental overflow by
saturating at SIZE_MAX.

In general when calculating such sizes use of the macros is preferred. Add
a semantic patch which can detect code patterns which can be replaced by
struct_size.

Note that I set the confidence to medium because this patch doesn't make an
attempt to ensure that the relevant array is actually a flexible array. The
struct_size macro does specifically require a flexible array. In many cases
the detected code could be refactored to a flexible array, but this is not
always possible (such as if there are multiple over-allocations).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org

 scripts/coccinelle/misc/struct_size.cocci | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 scripts/coccinelle/misc/struct_size.cocci

diff --git a/scripts/coccinelle/misc/struct_size.cocci b/scripts/coccinelle/misc/struct_size.cocci
new file mode 100644
index 000000000000..4ede9586e3c6
--- /dev/null
+++ b/scripts/coccinelle/misc/struct_size.cocci
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for code that could use struct_size().
+///
+// Confidence: Medium
+// Author: Jacob Keller <jacob.e.keller@intel.com>
+// Copyright: (C) 2023 Intel Corporation
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+// the overflow Kunit tests have some code which intentionally does not use
+// the macros, so we want to ignore this code when reporting potential
+// issues.
+@overflow_tests@
+identifier f = overflow_size_helpers_test;
+@@
+
+f
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on !overflow_tests && context@
+expression E1, E2;
+identifier m;
+@@
+(
+* (sizeof(*E1) + (E2 * sizeof(*E1->m)))
+)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@depends on !overflow_tests && patch@
+expression E1, E2;
+identifier m;
+@@
+(
+- (sizeof(*E1) + (E2 * sizeof(*E1->m)))
++ struct_size(E1, m, E2)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on !overflow_tests && (org || report)@
+expression E1, E2;
+identifier m;
+position p;
+@@
+(
+ (sizeof(*E1)@p + (E2 * sizeof(*E1->m)))
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING should use struct_size")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use struct_size"
+coccilib.report.print_report(p[0], msg)
+

base-commit: 982818426a0ffaf93b0621826ed39a84be3d7d62
-- 
2.39.1.405.gd4c25cc71f83

