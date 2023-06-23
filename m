Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEA73B8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjFWNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:13 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FA2688;
        Fri, 23 Jun 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527850; bh=I9sBWXJarUacmT9tJVRaaV9L2voiD3I9Gx59y+JU7NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnGl2zpNJcTOSoS6xm5nWi8rAtAahvSAYEgKmfK0DBi0WiLoKBbB/7sBsR7XOPXo+
         P2ZfadFDDkDGkOQDEgdxm1y5Ur8ETZRC959WDAeAFuKU3PPeu8fuhMgcKZ+Jr094S/
         i+oScUM/oUUXFDKK/KJq+8/OapsFgD+h+JjF4tu8=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7E1EC605E0;
        Fri, 23 Jun 2023 21:44:10 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 3/9] LoongArch: Prepare for assemblers with proper FCSR bank support
Date:   Fri, 23 Jun 2023 21:43:45 +0800
Message-Id: <20230623134351.1898379-4-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

The GNU assembler (as of 2.40) mis-treats FCSR operands as GPRs, but
the LLVM IAS does not. Probe for this and refer to FCSRs as "$fcsrNN"
if support is present.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Kconfig                | 3 +++
 arch/loongarch/include/asm/fpregdef.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 743d87655742..c8e4f8b03c55 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -242,6 +242,9 @@ config SCHED_OMIT_FRAME_POINTER
 config AS_HAS_EXPLICIT_RELOCS
 	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
 
+config AS_HAS_FCSR_BANK
+	def_bool $(as-instr,x:movfcsr2gr \$t0$(comma)\$fcsr0)
+
 config CC_HAS_LSX_EXTENSION
 	def_bool $(cc-option,-mlsx)
 
diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
index b6be527831dd..b0ac640db74c 100644
--- a/arch/loongarch/include/asm/fpregdef.h
+++ b/arch/loongarch/include/asm/fpregdef.h
@@ -40,6 +40,12 @@
 #define fs6	$f30
 #define fs7	$f31
 
+#ifdef CONFIG_AS_HAS_FCSR_BANK
+#define fcsr0	$fcsr0
+#define fcsr1	$fcsr1
+#define fcsr2	$fcsr2
+#define fcsr3	$fcsr3
+#else
 /*
  * Current binutils expects *GPRs* at FCSR position for the FCSR
  * operation instructions, so define aliases for those used.
@@ -48,5 +54,6 @@
 #define fcsr1	$r1
 #define fcsr2	$r2
 #define fcsr3	$r3
+#endif
 
 #endif /* _ASM_FPREGDEF_H */
-- 
2.40.0

