Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728CA6D5E60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjDDK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjDDKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:55:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E293A9C;
        Tue,  4 Apr 2023 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680605643; x=1712141643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdsDSL0FM4cOW58nPFQAA0OCrgImaKiH8KbKpW/8YIw=;
  b=jabhYiQgBmG028+fXjKXvV2YbG3CIj7jEC1Swq9UB2MGmQgBzJVsITbZ
   WheoPAsx+Rxz60jwTPmpFRdV9sWwNf6m5VWGxMhTZS+TRrMbIjmAjAIyc
   P+q9Eh9HlkAuFdFWqjjEd9Z18TbY+AxV/sMJG279CgYbt5C1sn5e3Btuo
   L9NqkunQZU+3QHqPl/S2rOWkNw7as/Z0puedUmZTUhmA+z44N3soxbLmG
   KzJRNm911arwRMZQ729vGZ/JCHLdqssLuU/dCmsPl4V2WCl66KJ4O6jGg
   v3ovUT/EOS1RzzH5u/IctXDLr9vMLk5z8h8Ppx2m2YiLEMyJ9aNKLKVbc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330734187"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330734187"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 03:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775597856"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="775597856"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2023 03:53:05 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com, jiangshanlai@gmail.com,
        shan.kang@intel.com
Subject: [PATCH v7 26/33] x86/fred: allow single-step trap and NMI when starting a new thread
Date:   Tue,  4 Apr 2023 03:27:09 -0700
Message-Id: <20230404102716.1795-27-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404102716.1795-1-xin3.li@intel.com>
References: <20230404102716.1795-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Allow single-step trap and NMI when starting a new thread, thus once
the new thread returns to ring3, single-step trap and NMI are both
enabled immediately.

High-order 48 bits above the lowest 16 bit CS are discarded by the
legacy IRET instruction, thus can be set unconditionally, even when
FRED is not enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/fred.h  | 11 +++++++++++
 arch/x86/kernel/process_64.c | 13 +++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index c5fbc4f18059..f7caf3b2f3f7 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -70,6 +70,14 @@
  */
 #define FRED_DF_STACK_LEVEL		3
 
+/*
+ * High-order 48 bits above the lowest 16 bit CS are discarded by the
+ * legacy IRET instruction, thus can be set unconditionally, even when
+ * FRED is not enabled.
+ */
+#define CSX_PROCESS_START \
+	(FRED_CSX_ENABLE_NMI | FRED_CSX_ALLOW_SINGLE_STEP)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/kernel.h>
@@ -133,6 +141,9 @@ void fred_setup_apic(void);
 #else
 #define cpu_init_fred_exceptions() BUG()
 #define fred_setup_apic() BUG()
+
+#define CSX_PROCESS_START 0
+
 #endif /* CONFIG_X86_FRED */
 
 #endif /* ASM_X86_FRED_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2bea86073646..c732d9dbff3a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -55,6 +55,7 @@
 #include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
+#include <asm/fred.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -506,7 +507,7 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
-		    unsigned int _cs, unsigned int _ss, unsigned int _ds)
+		    u16 _cs, u16 _ss, u16 _ds)
 {
 	WARN_ON_ONCE(regs != current_pt_regs());
 
@@ -521,11 +522,11 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 	loadsegment(ds, _ds);
 	load_gs_index(0);
 
-	regs->ip		= new_ip;
-	regs->sp		= new_sp;
-	regs->cs		= _cs;
-	regs->ss		= _ss;
-	regs->flags		= X86_EFLAGS_IF;
+	regs->ip	= new_ip;
+	regs->sp	= new_sp;
+	regs->csx	= _cs | CSX_PROCESS_START;
+	regs->ssx	= _ss;
+	regs->flags	= X86_EFLAGS_IF | X86_EFLAGS_FIXED;
 }
 
 void
-- 
2.34.1

