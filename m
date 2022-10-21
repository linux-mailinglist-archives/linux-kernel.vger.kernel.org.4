Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F760816C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJUWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJUWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:19:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DD2AAC00
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666390743; x=1697926743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kNHtAX3mEHzTLo+VDVyWKv6DLaeRHOEsKonhUqzYgFQ=;
  b=QCX/O45PRyQc34qFv+UFzSnaH4L9dO43ZoM08ciKgBafJehsi+3dpXmo
   eR+RKHWE1Lx99MCafEiMId1wDrPnar3yN2lgDENBNCBr2CqtRbib+UGuC
   qnErhaBXn2U0S63lrwji7OUpsqXSOnY7faJ/Cn5f+7dTMuX5iVwfseSBP
   DUTVFORQU8HJHJP1MBeHsNYAIoZ1l4yd9DBYMWrHglsSWp7OH2edkKVJ/
   I+TbUMTr49a6ZsrR5gd7rmpNKd4rorSeKussXcT9ismIeEXd+dGJRkAx5
   bGZTcLWKHCKKwiZ6l796gX9NLGp1MUn4JTxvugdMglVluU3sFQud493k5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369181095"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369181095"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959808506"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="959808506"
Received: from sanekar-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.5.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:37 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        keescook@chromium.org, ebiederm@xmission.com
Subject: [PATCH 2/2] x86: Improve formatting of user_regset arrays
Date:   Fri, 21 Oct 2022 15:18:03 -0700
Message-Id: <20221021221803.10910-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
References: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
struct user_regset arrays. They have multiple member initializations per
line and some lines exceed 100 chars. Reformat them like he suggested.

[0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

 - Drop Kees' Reviewed-by, as I had to redo it with the new REGSET64_FOO
   format.

 arch/x86/kernel/ptrace.c | 107 ++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 356495ab37a6..dfaa270a7cc9 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1235,28 +1235,37 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
 	[REGSET64_GENERAL] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.regset_get = genregs_get, .set = genregs_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.regset_get	= genregs_get,
+		.set		= genregs_set
 	},
 	[REGSET64_FP] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET64_XSTATE] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET64_IOPERM] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_LONGS,
-		.size = sizeof(long), .align = sizeof(long),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_LONGS,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
@@ -1276,42 +1285,56 @@ static const struct user_regset_view user_x86_64_view = {
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
 	[REGSET32_GENERAL] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.regset_get = genregs32_get, .set = genregs32_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct32) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.regset_get	= genregs32_get,
+		.set		= genregs32_set
 	},
 	[REGSET32_FP] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_fpregs_active,
+		.regset_get	= fpregs_get,
+		.set		= fpregs_set
 	},
 	[REGSET32_XFP] = {
-		.core_note_type = NT_PRXFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRXFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET32_XSTATE] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET32_TLS] = {
-		.core_note_type = NT_386_TLS,
-		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
-		.size = sizeof(struct user_desc),
-		.align = sizeof(struct user_desc),
-		.active = regset_tls_active,
-		.regset_get = regset_tls_get, .set = regset_tls_set
+		.core_note_type	= NT_386_TLS,
+		.n		= GDT_ENTRY_TLS_ENTRIES,
+		.bias		= GDT_ENTRY_TLS_MIN,
+		.size		= sizeof(struct user_desc),
+		.align		= sizeof(struct user_desc),
+		.active		= regset_tls_active,
+		.regset_get	= regset_tls_get,
+		.set		= regset_tls_set
 	},
 	[REGSET32_IOPERM] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_BYTES / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_BYTES / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
-- 
2.17.1

