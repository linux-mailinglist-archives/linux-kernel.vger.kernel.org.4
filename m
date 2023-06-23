Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC173BDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjFWRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:31:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E452129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687541517; x=1719077517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xg06mLwyuYOnrVMaZvi1VkV9aKC889ZSsBT8Qaml1Wk=;
  b=XdqigKSK5vb72UJ2G6P7PujaG63PnSFDluPNDxGNHmPQOruouu5oonL6
   IIas9IGV4lboCvg66bRfXZHidvHkoX6e9fqZW23sf9kN5n50EzSwzqjDs
   9tcjBdg2MqilXSUMG8oRDLf/Ble0GC2OuIgRey6fOULIlquZCZ2aWtXF+
   q2JSp9INrO3hkQqGXu/gQZE5p2ay3g2NJNpEj9aTYxe2RTgdSvqSu+Ix8
   petvS6SZhjWzYwXdQnUKr97mQV7J3GaoRJeCsALOD2f4CyISNLtgQBHXB
   b3CVpYQEwab5v1Jyi6QraMG40REC7G8qajDi/U+vOkUqe4gutDxg8zRu9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340414839"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="340414839"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665557857"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="665557857"
Received: from rbanda1x-mobl1.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.212.18.180])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:31:00 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc:     pawan.kumar.gupta@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/msr-index: Fix MSR_IA32_ARCH_CAPABILITIES bit ordering
Date:   Fri, 23 Jun 2023 10:30:29 -0700
Message-Id: <20230623173029.822153-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the definition of ARCH_CAP_XAPIC_DISABLE was added to
MSR_IA32_ARCH_CAPABILITIES it was incorrectly placed at the bottom of
the list instead of being inserted by bit order. This means
ARCH_CAP_XAPIC_DISABLE and ARCH_CAP_PBRSB_NO are now swapped and any
future additions may look out of place. Move ARCH_CAP_XAPIC_DISABLE to
its correct position.

No functional change.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3aedae61af4fc..76b154e9aebaa 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -151,15 +151,14 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
-#define ARCH_CAP_PBRSB_NO		BIT(24)	/*
-						 * Not susceptible to Post-Barrier
-						 * Return Stack Buffer Predictions.
-						 */
-
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
 						 * supported
 						 */
+#define ARCH_CAP_PBRSB_NO		BIT(24)	/*
+						 * Not susceptible to Post-Barrier
+						 * Return Stack Buffer Predictions.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
-- 
2.25.1

