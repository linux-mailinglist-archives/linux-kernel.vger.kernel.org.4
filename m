Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF0722C47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjFEQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjFEQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510BBD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1EC627F4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB561C433A4;
        Mon,  5 Jun 2023 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685981551;
        bh=GbiswfqlPKxb8y7Cgh7d9fzBotuGBKD2mu+cvUJpcr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhicJi3EulNDmKVT5zOxoXSJn8Gf9Ok6AcSu2Q4X/qtJ8svD2SxRIhxqV4QoEQ7Jz
         mslv+YWbWjpGC5c2mluIh5YPn3aPAhYOwO/Au2IRgxV6VttYqBGKllB1kTCG39R1Yn
         uRcrWyMFVUW8b3VPBeQC3DG3e8PKNxfAb5q9pOZEnSfQz2RRop8Pmh/bOAkvEe7r3x
         b/ntM4UQ1nPaMtPZU+8QYXS1ofomme3x9xrfOp91VnInn4jW7cI4mWvNiXE+/1MXae
         ZwofIIPgM/E1kdH1c7+LL9v1uw7odHN165s4CPspOItUOu5Lq8lUG1cc3ec8c2phdR
         JLhSV/jb4B7xw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-graphics-maintainer@vmware.com,
        Zack Rusin <zackr@vmware.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] drm/vmwgfx: Add unwind hints around RBP clobber
Date:   Mon,  5 Jun 2023 09:12:22 -0700
Message-Id: <4c795f2d87bc0391cf6543bcb224fa540b55ce4b.1685981486.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685981486.git.jpoimboe@kernel.org>
References: <cover.1685981486.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware high-bandwidth hypercalls take the RBP register as input.  This
breaks basic frame pointer convention, as RBP should never be clobbered.

So frame pointer unwinding is broken for the instructions surrounding
the hypercalls.  Fortunately this doesn't break live patching with
CONFIG_FRAME_POINTER, as it only unwinds from blocking tasks, and stack
traces from preempted tasks are already marked unreliable anyway.

However, for live patching with ORC, this could actually be a
theoretical problem if vmw_port_hb_{in,out}() were still compiled with a
frame pointer due to having an aligned stack.  In practice that hasn't
seemed to be an issue since the objtool warnings have only been seen
with CONFIG_FRAME_POINTER.

Add unwind hint annotations to tell the ORC unwinder to mark stack
traces as unreliable.

Fixes the following warnings:

  vmlinux.o: warning: objtool: vmw_port_hb_in+0x1df: return with modified stack frame
  vmlinux.o: warning: objtool: vmw_port_hb_out+0x1dd: return with modified stack frame

Fixes: 89da76fde68d ("drm/vmwgfx: Add VMWare host messaging capability")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160135.97q0Elax-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/unwind_hints.h     |  9 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 01cb9692b160..85cc57cb6539 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -76,9 +76,18 @@
 
 #else
 
+#define UNWIND_HINT_UNDEFINED \
+	UNWIND_HINT(UNWIND_HINT_TYPE_UNDEFINED, 0, 0, 0)
+
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
index 0b74ca2dfb7b..23899d743a90 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h
@@ -105,10 +105,14 @@
                         flags, magic, bp,		\
                         eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
+		UNWIND_HINT_UNDEFINED			\
                 "mov %12, %%rbp;"			\
                 VMWARE_HYPERCALL_HB_OUT			\
-                "pop %%rbp;" :				\
+                "pop %%rbp;"				\
+		UNWIND_HINT_RESTORE :			\
                 "=a"(eax),				\
                 "=b"(ebx),				\
                 "=c"(ecx),				\
@@ -130,10 +134,14 @@
                        flags, magic, bp,		\
                        eax, ebx, ecx, edx, si, di)	\
 ({							\
-        asm volatile ("push %%rbp;"			\
+        asm volatile (					\
+		UNWIND_HINT_SAVE			\
+		"push %%rbp;"				\
+		UNWIND_HINT_UNDEFINED			\
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

