Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF43702F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEOOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjEOOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:07:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6155D199F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:07:38 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 764FC1EC0646;
        Mon, 15 May 2023 16:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684159656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qGlgGqPJ5+LpDeFZFeGUzglsgfTogWZSynQhMOm/vnk=;
        b=lBxhywZz2bdoLeWWHAQTNpBcAOILfWsxnd+buYhGUheLRKKrjuFs0POLR9GWen66FTbm2Z
        5aP0IVFSlLP12RhcPBBiNMF8jHsHJA101M4X/f5tY92RmrVVO6Lqe6lUPGJHNnl1KHXr+d
        +WPcxsomnxHqURLJAZkfI3mwG0+JkDM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH] x86/retbleed: Add __x86_return_thunk alignment checks
Date:   Mon, 15 May 2023 16:07:26 +0200
Message-Id: <20230515140726.28689-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a linker assertion and compute the 0xcc padding dynamically so that
__x86_return_thunk is always cacheline-aligned. Leave the SYM_START()
macro in as the untraining doesn't need ENDBR annotations anyway.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/vmlinux.lds.S | 4 ++++
 arch/x86/lib/retpoline.S      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 25f155205770..03c885d3640f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -508,4 +508,8 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
+#ifdef CONFIG_RETHUNK
+. = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");
+#endif
+
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index b3b1e376dce8..3fd066d42ec0 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -143,7 +143,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 63, 0xcc
+	.skip 64 - (__x86_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
-- 
2.35.1

