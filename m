Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B607C720501
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjFBO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjFBO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F51E52
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBAFE650F1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0665DC433EF;
        Fri,  2 Jun 2023 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685717829;
        bh=Z6KkIGntO9yp+lB8wVqWa8YF1x8r+9hlNelCh2cmJ2g=;
        h=From:To:Cc:Subject:Date:From;
        b=QF/xdJYWLs4nbVbIqMOSZYDqjNFFd7kMojmpRbz+XwMCrSikgMA8PQTcT0ogAkcff
         NyYnROGZZFEeQekrsVEzY1NPowfgz3GvMMon14EmAwyKY3jocWaV8Qi5Gnh40bTaoT
         Fgu0KczP+C84Nj40KE0eypm0gQdRlmU2ajc8z34fVQiiQh0Iurlo5EFC3BDYv/ssTR
         lHbJx/lr66OAS9a7S867fR+UCvfwEBIeXldqBXMJS5MRYjYChKCVFmvksSOb8lwjEJ
         wkSpjpFTlcBzpwgAuhycHfLVZ05ToiDnJ0E38BqcpTJNnJu0BSVEBiiZHCqX1Amw/r
         vhC/WCLuAsUqg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Zack Rusin <zackr@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/vmwgfx: Silence RBP clobber warnings
Date:   Fri,  2 Jun 2023 07:56:34 -0700
Message-Id: <e9388b1ad4d955b43b44e8a5dcd6cf6da7d260a0.1685717659.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware hypercalls take the RBP register as input.  This breaks basic
frame pointer convention, as RBP should never be clobbered.

So frame pointer unwinding is broken for the instructions surrounding
the hypercall with the clobbered RBP.  There's nothing that can be done
about that.  Just tell objtool to ignore it.

Silences the following warnings:

  vmlinux.o: warning: objtool: vmw_port_hb_in+0x1df: return with modified stack frame
  vmlinux.o: warning: objtool: vmw_port_hb_out+0x1dd: return with modified stack frame

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160135.97q0Elax-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/unwind_hints.h     |  6 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h | 14 ++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 01cb9692b160..91ab6e5426c6 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -79,6 +79,12 @@
 #define UNWIND_HINT_FUNC \
 	UNWIND_HINT(UNWIND_HINT_TYPE_FUNC, ORC_REG_SP, 8, 0)
 
+#define UNWIND_HINT_SAVE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+
+#define UNWIND_HINT_RESTORE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
index 0b74ca2dfb7b..79050a78fa4c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
@@ -105,10 +105,13 @@
                         flags, magic, bp,		\
                         eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
                 "mov %12, %%rbp;"			\
                 VMWARE_HYPERCALL_HB_OUT			\
-                "pop %%rbp;" :				\
+                "pop %%rbp;"				\
+		UNWIND_HINT_RESTORE :			\
                 "=a"(eax),				\
                 "=b"(ebx),				\
                 "=c"(ecx),				\
@@ -130,10 +133,13 @@
                        flags, magic, bp,		\
                        eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
                 "mov %12, %%rbp;"			\
                 VMWARE_HYPERCALL_HB_IN			\
-                "pop %%rbp" :				\
+                "pop %%rbp;"				\
+		UNWIND_HINT_RESTORE :			\
                 "=a"(eax),				\
                 "=b"(ebx),				\
                 "=c"(ecx),				\
-- 
2.40.1

