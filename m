Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4663AED1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiK1RZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiK1RZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:25:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9880233AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669656304; x=1701192304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jM89lE6rjf88aw6NXlicZPVGvuaPiJwb6m41+v6zBRU=;
  b=n8rgN38CCIjwtEQsa8XFXIwLd6DB1gQIS7J17kDhDMNdygb+6H1VtWpz
   MUTjAXXqptgh9TlrVNSQ49NaahJDYPLIIkgebuw1G5T5mW6S4CLxINgLz
   JFVnSM7AREKC6LAyUx2KIpDP1T85xhXkeyOr2ly+WLcP961NLUP4qPhvW
   sHcIcIxeMgaIBzU2tRgtVJFXPKED5M5BDG63LYuijn9wOt9mUv1rmnaXP
   DflYUXAU8TdhvD8qevNkpJ78EjBueQHbkmazoLCzJmF/dBM2+DQiNZJjh
   n8m86qoXU/HHO7H00BoYy9rWsOKbcZK4VZKLq7vDMbBh5bP/Q9HSvhweN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316730738"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316730738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:25:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="817901830"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817901830"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:25:03 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH] x86/cpu: Remove redundant extern x86_read_arch_cap_msr()
Date:   Mon, 28 Nov 2022 09:24:51 -0800
Message-Id: <20221128172451.792595-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
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

x86_read_arch_cap_msr() has now moved to arch/x86/include/asm/cpu.h.
Kill the redundant one in arch/x86/kernel/cpu.h

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/cpu.h  | 2 --
 arch/x86/kernel/cpu/bugs.c | 1 +
 arch/x86/kernel/cpu/tsx.c  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index a142b8d543a3..727ef3268ffb 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -82,6 +82,4 @@ unsigned int aperfmperf_get_khz(int cpu);
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
 
-extern u64 x86_read_arch_cap_msr(void);
-
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..a632fa07e93a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -33,6 +33,7 @@
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
 #include "cpu.h"
 
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index ec7bbac3a9f2..667b25936818 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -11,6 +11,7 @@
 #include <linux/cpufeature.h>
 
 #include <asm/cmdline.h>
+#include <asm/cpu.h>
 
 #include "cpu.h"
 
-- 
2.34.1

