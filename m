Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC66A7AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCBFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCBFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:51:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF014ECC2;
        Wed,  1 Mar 2023 21:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677736258; x=1709272258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tP9iIQUbrhMc+5l0AHCXnkXnhn3TgNNmkDoitFhCFbw=;
  b=kQqfNGTIOwujFAgDZd9vgSioCXQY6Irir5a+8NUl+mmcYcYVmvo20Nhy
   0mEgpyi0YUOxTa1ryjxIrgDDYdkzlAMXbchwJT3Ng50AiCXJW3ZVM+QIN
   LsztLpzUSidDHqOaTi4CiH/WU17HyTtlEpEz13Uw+nbUUcRn5AYd62L2Z
   Iy/ftGJnW8uXz9mzDPvhoV3IWcIx2YWEC517FWz2qoVg6GkPqjQV05jY+
   s+SJYLEb40Anw+rHoeem96n4macl3WS+3Ny43MCR4bkzhixFCS1jhqXdx
   Up1JRTATgsHni7OJzBltiZiCV+BFys9uEMxV3hiX4u6ePXkVWau7z47qc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420887176"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="420887176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 21:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920530910"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="920530910"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2023 21:50:48 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com
Subject: [PATCH v4 13/34] x86/fred: header file for event types
Date:   Wed,  1 Mar 2023 21:24:50 -0800
Message-Id: <20230302052511.1918-14-xin3.li@intel.com>
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

FRED inherits the Intel VT-x enhancement of classified events with
a two-level event dispatch logic. The first-level dispatch is on
the event type, not the event vector as used in the IDT architecture.
This also means that vectors in different event types are orthogonal,
e.g., vectors 0x10-0x1f become available as hardware interrupts.

Add a header file for event types, and also use it in <asm/vmx.h>.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/event-type.h | 17 +++++++++++++++++
 arch/x86/include/asm/vmx.h        | 17 +++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/include/asm/event-type.h

diff --git a/arch/x86/include/asm/event-type.h b/arch/x86/include/asm/event-type.h
new file mode 100644
index 000000000000..fedaa0e492c5
--- /dev/null
+++ b/arch/x86/include/asm/event-type.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_EVENT_TYPE_H
+#define _ASM_X86_EVENT_TYPE_H
+
+/*
+ * Event type codes: these are the same that are used by VTx.
+ */
+#define EVENT_TYPE_HWINT	0	/* Maskable external interrupt */
+#define EVENT_TYPE_RESERVED	1
+#define EVENT_TYPE_NMI		2	/* Non-maskable interrupt */
+#define EVENT_TYPE_HWFAULT	3	/* Hardware exceptions (e.g., page fault) */
+#define EVENT_TYPE_SWINT	4	/* Software interrupt (INT n) */
+#define EVENT_TYPE_PRIVSW	5	/* INT1 (ICEBP) */
+#define EVENT_TYPE_SWFAULT	6	/* Software exception (INT3 or INTO) */
+#define EVENT_TYPE_OTHER	7	/* FRED: SYSCALL/SYSENTER */
+
+#endif
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 498dc600bd5c..8d9b8b0d8e56 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/asm/vmx.h>
+#include <asm/event-type.h>
 #include <asm/vmxfeatures.h>
 
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
@@ -372,14 +373,14 @@ enum vmcs_field {
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
 
-#define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt */
-#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
-#define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
-#define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
-#define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
-#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
-#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
-#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
+#define INTR_TYPE_EXT_INTR		(EVENT_TYPE_HWINT << 8)		/* external interrupt */
+#define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
+#define INTR_TYPE_NMI_INTR		(EVENT_TYPE_NMI << 8)		/* NMI */
+#define INTR_TYPE_HARD_EXCEPTION	(EVENT_TYPE_HWFAULT << 8)	/* processor exception */
+#define INTR_TYPE_SOFT_INTR		(EVENT_TYPE_SWINT << 8)		/* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(EVENT_TYPE_PRIVSW << 8)	/* ICE breakpoint - undocumented */
+#define INTR_TYPE_SOFT_EXCEPTION	(EVENT_TYPE_SWFAULT << 8)	/* software exception */
+#define INTR_TYPE_OTHER_EVENT		(EVENT_TYPE_OTHER << 8)		/* other event */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
 #define GUEST_INTR_STATE_STI		0x00000001
-- 
2.34.1

