Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE26DCDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDJXMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDJXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30A2135;
        Mon, 10 Apr 2023 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168302; x=1712704302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=e8bCb4INlqBkf0K+wkKTyG3ginAA5mKmpmasRm00usQ=;
  b=kciAi+OyVrPTwC+YTe2Hg54uD7HTaP1j7wFBu0d8ITm2GiBpzPMJPIJ/
   y1Z5bf+wZEUWMIgtS5IMMfQJvguk3IcTBcp6q75SjhtWZo/HhqSluqUsT
   ua9cZ5eAytCVhh1rj8MsVwInejbHG+ZKcPTbMt6WcQe0LYV62IOcNrB4/
   t7qu7aUiEe1IcQ+h6tBDQUjhBgmp/o/Erxl2L6LQJMmLCFPEedpUPWghm
   luufPwJwlpQmHBI9YmYiMm1wovn/GzArJDcxOHg+7H7aX9Qy7oLrkRNZN
   2wpkE/3IY/+rSYtSoKhmy/+VoUy6aTPb/RXAeGX+AaKVZT2OCUXAiTFBj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962521"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962521"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757607999"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757607999"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:39 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 04/12] x86/asm: Add a wrapper function for the LOADIWKEY instruction
Date:   Mon, 10 Apr 2023 15:59:28 -0700
Message-Id: <20230410225936.8940-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker introduces a CPU-internal wrapping key to encode a user key to a
key handle. Then a key handle is referenced instead of the plain text key.

The new instruction loads an internal wrapping key in the
software-inaccessible CPU state. It operates only in kernel mode.

Define struct iwkey to pass the key value.

The kernel will use this function to load a new key at boot time when the
feature is enabled.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Separate out the code as a new patch.
* Improve the usability with the new struct as an argument. (Dan
  Williams)

Note, Dan wondered if:
  WARN_ON(!irq_fpu_usable());
would be appropriate in the load_xmm_iwkey() function.
---
 arch/x86/include/asm/keylocker.h     | 25 ++++++++++++++++++++++
 arch/x86/include/asm/special_insns.h | 32 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 arch/x86/include/asm/keylocker.h

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
new file mode 100644
index 000000000000..df84c83228a1
--- /dev/null
+++ b/arch/x86/include/asm/keylocker.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_KEYLOCKER_H
+#define _ASM_KEYLOCKER_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/fpu/types.h>
+
+/**
+ * struct iwkey - A temporary internal wrapping key storage.
+ * @integrity_key:	A 128-bit key to check that key handles have not
+ *			been tampered with.
+ * @encryption_key:	A 256-bit encryption key used in
+ *			wrapping/unwrapping a clear text key.
+ *
+ * This storage should be flushed immediately after loaded.
+ */
+struct iwkey {
+	struct reg_128_bit integrity_key;
+	struct reg_128_bit encryption_key[2];
+};
+
+#endif /*__ASSEMBLY__ */
+#endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index d6cd9344f6c7..90b23f55970a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -9,6 +9,7 @@
 #include <asm/processor-flags.h>
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
+#include <asm/keylocker.h>
 
 /*
  * The compiler should not reorder volatile asm statements with respect to each
@@ -296,6 +297,37 @@ static __always_inline void tile_release(void)
 	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
 }
 
+/**
+ * load_xmm_iwkey - Load a CPU-internal wrapping key
+ * @key:	A struct iwkey pointer.
+ *
+ * Load @key to XMMs then do LOADIWKEY. After this, flush XMM
+ * registers. Caller is responsible for kernel_cpu_begin().
+ */
+static inline void load_xmm_iwkey(struct iwkey *key)
+{
+	struct reg_128_bit zeros = { 0 };
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %1, %%xmm1; movdqu %2, %%xmm2;"
+		      :: "m"(key->integrity_key), "m"(key->encryption_key[0]),
+			 "m"(key->encryption_key[1]));
+
+	/*
+	 * LOADIWKEY %xmm1,%xmm2
+	 *
+	 * EAX and XMM0 are implicit operands. Load a key value
+	 * from XMM0-2 to a software-invisible CPU state. With zero
+	 * in EAX, CPU does not do hardware randomization and the key
+	 * backup is allowed.
+	 *
+	 * This instruction is supported by binutils >= 2.36.
+	 */
+	asm volatile (".byte 0xf3,0x0f,0x38,0xdc,0xd1" :: "a"(0));
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %0, %%xmm1; movdqu %0, %%xmm2;"
+		      :: "m"(zeros));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
-- 
2.17.1

