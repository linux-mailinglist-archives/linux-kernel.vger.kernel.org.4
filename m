Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461C7249B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjFFRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFFRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:03:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C6139
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686071000; x=1717607000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6pKwiszJntG3zBtoC+pH5OQEf+ynVtjhOU3bUuV3DA=;
  b=X6+hZSZe+88zNsNJoYC3uUW0ljrf+aCb3GIvKmV8uHkyx5GMdL0ZkSt5
   ks1/ovJTNSdS53fGJxgj9t/tEnpsznZV32SUsQ6F+WUVVRKVJjgP5Ye8+
   2ViEOw1OsEw3marQV19cOZsARh0Vp6rxt83uF+xtQbEqKzK2sd+28sYY/
   U0BSoeg59nxHmZmhRml6swt5die9/yTBWfu+r+C1C6nsIRal/sTtfcCPz
   Fy5f1fJ+GOatWghzbrxuCclU4wo3xZJO66Mo0Bl6NnbMys8cwMXVOow9Y
   w5uLT8JlULT9tBdGQYc8LWn/mZGU5yExvU68282IOkAem7pzDx6kG160X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420282351"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="420282351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 10:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883413242"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="883413242"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Jun 2023 10:03:19 -0700
From:   kan.liang@linux.intel.com
To:     tony.luck@intel.com, peterz@infradead.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH] x86/cpu: Update Intel model naming rule
Date:   Tue,  6 Jun 2023 10:02:57 -0700
Message-Id: <20230606170257.3213720-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Intel model naming rule doesn't reflect the current Intel model
names. For example, the code name of processors is actually used for
hybrid products and the latest Atom and big core products.

The patch is to add the code name of processors into the Intel model
naming rule. Because
- For the hybrid processors, it's impossible to use the code name of
the micro-architecture. A processor has multiple micro-architectures.
- For the big core, the code name of processors is already used for the
products after Sky Lake. Before Sky Lake, it seems the code name of
the micro-architecture is the same as the code name of the processor.
- For the Atom, the processor name is used since Sierra Forest and
Grand Ridge. Both server products have the e-cores with the exact same
micro-architecture. Using the code name of processors should be a better
choice to distinguish them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b3af2d45bbbb..d79447749b82 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -10,13 +10,18 @@
  * that group keep the CPUID for the variants sorted by model number.
  *
  * The defined symbol names have the following form:
+ *	# For old atom platforms before Sierra Forest
  *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}
+ *	OR
+ *	# For big core, new atom after Sierra Forest, and hybrid
+ *	INTEL_FAM6{OPTFAMILY}_{PROCESSOR}{OPTDIFF}
  * where:
  * OPTFAMILY	Describes the family of CPUs that this belongs to. Default
  *		is assumed to be "_CORE" (and should be omitted). Other values
  *		currently in use are _ATOM and _XEON_PHI
  * MICROARCH	Is the code name for the micro-architecture for this core.
  *		N.B. Not the platform name.
+ * PROCESSOR	Is the code name for the processor
  * OPTDIFF	If needed, a short string to differentiate by market segment.
  *
  *		Common OPTDIFFs:
@@ -112,6 +117,8 @@
 #define INTEL_FAM6_GRANITERAPIDS_X	0xAD
 #define INTEL_FAM6_GRANITERAPIDS_D	0xAE
 
+/* "Hybrid core" Processors */
+
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_N		0xBE
-- 
2.35.1

