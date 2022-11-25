Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499916387A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiKYKhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:37:46 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342F311A26
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669372664;
  x=1700908664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D09VrSl7WEIOCmbG+vjrZPtMD0Rhl/PJ8YiALk/C7+o=;
  b=SwGO/wxLmsTVRghQQ322csv441MKRwlo0PB/axl6sKTQVVnIgCdrzJer
   QhlevagUNPI+VqPwOMDrwaW94C/g6G6TA4EPfQwmu+zxutWJCnik3cPYg
   Tj1W4j+Z3SsKnt4aAUet/KUXraDOBJM5QkoXFeXL5jZzL9pnjDHaPfHhy
   17cK6epTmmFbtfb7Ayi9f2qnQ0+yKiklCgshhwSxUf/V47DCgRGQDOxbh
   pJ2D9DInfqIEln5GdRrTl4O0pSPOpSysN1tx3cFjcd1Enpu9YuoKmwYDd
   gtBlm+dXu6TaSxCCWbqzqsIWH6zUyp70S2Q90yr41IXizTp8ZPUFqTDOp
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: vdso: Include .eh_frame in debug ELF
Date:   Fri, 25 Nov 2022 11:37:40 +0100
Message-ID: <20221125103740.2062285-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently strip out .eh_frame to work around crashes in libgcc when
it tries to unwind out of signal handlers, see commit 87676cfca141
("arm64: vdso: Disable dwarf unwinding through the sigreturn
trampoline").

The .eh_frame does however have correct unwind information for the
functions implemented in C in vgettimeofday.c, but currently this
information is not available even for offline unwinding using the
vdso.so.dbg.  As a result of this, perf built with libdw is unable to
unwind the stack when the PC is inside one of these functions.

To fix this, strip the .eh_frame section only from the vdso.so and not
from the vdso.so.dbg.  This can be used by offline unwinders with access
to the debug symbols, and will not affect libgcc since the section will
still not be present in the normal vDSO.

Cc: Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Daniel Kiss <daniel.kiss@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/arm64/kernel/vdso/Makefile   | 2 +-
 arch/arm64/kernel/vdso/vdso.lds.S | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 619e2dc7ee14..91aac17e11bc 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -65,7 +65,7 @@ $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 # Strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: OBJCOPYFLAGS := -S --remove-section=.eh_frame --remove-section=.eh_frame_hdr
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 6028f1fe2d1c..66abf70efc58 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -31,6 +31,8 @@ SECTIONS
 	.gnu.version	: { *(.gnu.version) }
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
+	.eh_frame	: { *(.eh_frame) }
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }
 
 	/*
 	 * Discard .note.gnu.property sections which are unused and have
@@ -78,7 +80,6 @@ SECTIONS
 	/DISCARD/	: {
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
-		*(.eh_frame .eh_frame_hdr)
 	}
 }
 
-- 
2.34.1

