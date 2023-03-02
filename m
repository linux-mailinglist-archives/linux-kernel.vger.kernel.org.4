Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D56A7B05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCBFwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCBFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:51:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7D521D7;
        Wed,  1 Mar 2023 21:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677736261; x=1709272261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJAIMdwNFTUrVjDLTbKC/eMN5WktrEucLVbwGrEfGpc=;
  b=cIlkQVWdtm12nZHIzbdnCkuv+FxLTsigcMK9m/FibReBdMaQEt5Qg37K
   wqsQradwVOf2OhGH4zFw/bKWfVrzd7HloWozzzqOb0dRmfC9qE3VPMgAi
   WtEaQZV4yZYBHYOWr+bS0ML1c/zNgsjRC7Jm1e6HDWDwLZmIF55WXqGn3
   OC9YgwvD0q9LuyHNo5P30NEnfp1l6aEU79b/y6sXCDausr4SbfKHXNtPU
   JybKcj29w67aKj53Cm9ZjdnlTCbK7lcocq4w0vMg1aAFhOMu6S4SXYeQO
   A7CEIfkbpIz8p9BR255Z63gkjiIPKWylgp+y3n2z390BfyT/z35OESU/P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420887206"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="420887206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 21:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920530914"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="920530914"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2023 21:50:48 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com
Subject: [PATCH v4 14/34] x86/fred: header file with FRED definitions
Date:   Wed,  1 Mar 2023 21:24:51 -0800
Message-Id: <20230302052511.1918-15-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302052511.1918-1-xin3.li@intel.com>
References: <20230302052511.1918-1-xin3.li@intel.com>
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

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add a header file for FRED prototypes and definitions.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/fred.h | 101 ++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 arch/x86/include/asm/fred.h

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
new file mode 100644
index 000000000000..2f337162da73
--- /dev/null
+++ b/arch/x86/include/asm/fred.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * arch/x86/include/asm/fred.h
+ *
+ * Macros for Flexible Return and Event Delivery (FRED)
+ */
+
+#ifndef ASM_X86_FRED_H
+#define ASM_X86_FRED_H
+
+#ifdef CONFIG_X86_FRED
+
+#include <linux/const.h>
+#include <asm/asm.h>
+
+/*
+ * FRED return instructions
+ *
+ * Replace with "ERETS"/"ERETU" once binutils support FRED return instructions.
+ * The binutils version supporting FRED instructions is still TBD, and will
+ * update once we have it.
+ */
+#define ERETS			_ASM_BYTES(0xf2,0x0f,0x01,0xca)
+#define ERETU			_ASM_BYTES(0xf3,0x0f,0x01,0xca)
+
+/*
+ * Event stack level macro for the FRED_STKLVLS MSR.
+ * Usage example: FRED_STKLVL(X86_TRAP_DF, 3)
+ * Multiple values can be ORd together.
+ */
+#define FRED_STKLVL(v,l)	(_AT(unsigned long, l) << (2*(v)))
+
+/* FRED_CONFIG MSR */
+#define FRED_CONFIG_CSL_MASK		0x3
+#define FRED_CONFIG_SHADOW_STACK_SPACE	_BITUL(3)
+#define FRED_CONFIG_REDZONE(b)		__ALIGN_KERNEL_MASK((b), _UL(0x3f))
+#define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+/* FRED event type and vector bit width and counts */
+#define FRED_EVENT_TYPE_BITS		3 /* only 3 bits used in FRED 3.0 */
+#define FRED_EVENT_TYPE_COUNT		_BITUL(FRED_EVENT_TYPE_BITS)
+#define FRED_EVENT_VECTOR_BITS		8
+#define FRED_EVENT_VECTOR_COUNT		_BITUL(FRED_EVENT_VECTOR_BITS)
+
+/* FRED EVENT_TYPE_OTHER vector numbers */
+#define FRED_SYSCALL			1
+#define FRED_SYSENTER			2
+
+/* Flags above the CS selector (regs->csx) */
+#define FRED_CSL_ENABLE_NMI		_BITUL(28)
+#define FRED_CSL_ALLOW_SINGLE_STEP	_BITUL(25)
+#define FRED_CSL_INTERRUPT_SHADOW	_BITUL(24)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/kernel.h>
+#include <asm/ptrace.h>
+
+/* FRED stack frame information */
+struct fred_info {
+	unsigned long edata;	/* Event data: CR2, DR6, ... */
+	unsigned long resv;
+};
+
+/* Full format of the FRED stack frame */
+struct fred_frame {
+	struct pt_regs   regs;
+	struct fred_info info;
+};
+
+/* Getting the FRED frame information from a pt_regs pointer */
+static __always_inline struct fred_info *fred_info(struct pt_regs *regs)
+{
+	return &container_of(regs, struct fred_frame, regs)->info;
+}
+
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
+{
+	return fred_info(regs)->edata;
+}
+
+/*
+ * How FRED event handlers are called.
+ *
+ * FRED event delivery establishes the full supervisor context
+ * by pushing everything related to the event being delivered
+ * to the FRED stack frame, e.g., the faulting linear address
+ * of a #PF is pushed as event data of the FRED #PF stack frame.
+ * Thus a struct pt_regs has everything needed and it's the only
+ * input parameter required for a FRED event handler.
+ */
+#define DECLARE_FRED_HANDLER(f) void f (struct pt_regs *regs)
+#define DEFINE_FRED_HANDLER(f) noinstr DECLARE_FRED_HANDLER(f)
+typedef DECLARE_FRED_HANDLER((*fred_handler));
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_X86_FRED */
+
+#endif /* ASM_X86_FRED_H */
-- 
2.34.1

