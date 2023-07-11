Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061A74F473
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjGKQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjGKQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:08:52 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37177DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:08:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5C2mMPz9sFF;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C9jn_gTS9xtG; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C26y9z9sFC;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 441DB8B78C;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qAb5vznBg5NF; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE41D8B77A;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8iXP3696806
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:44 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8i1a3696805;
        Tue, 11 Jul 2023 18:08:44 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 03/15] objtool: Allow an architecture to disable objtool on ASM files
Date:   Tue, 11 Jul 2023 18:08:29 +0200
Message-ID: <f7902ba65573fd46691db0a00d92b1ff78f81ce3.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091705; l=1429; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=LpZtEBaGHh5V3WGM+V+sJTc1/w2XLjECt2Sdv79iyT8=; b=LpGh/tS33is/AsbgigCGB02KZVjeyfe9Tfn7tbIEREYKTRoJ+IKKUtLDLY97tJ9qrG4C/BiUj f7zl9we0J/5D+9WFKejAtNj0j8M+Uh988fQx84sq96oNHhpfNb2Fsvq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supporting objtool on ASM files requires quite an effort.

Features like UACCESS validation don't require ASM files validation.

In order to allow architectures to enable objtool validation
without spending unnecessary effort on cleaning up ASM files,
provide an option to disable objtool validation on ASM files.

Suggested-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/Kconfig           | 5 +++++
 scripts/Makefile.build | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af2..3330ed761260 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1111,6 +1111,11 @@ config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 config HAVE_OBJTOOL
 	bool
 
+config ARCH_OBJTOOL_SKIP_ASM
+	bool
+	help
+	  Architecture doesn't support objtool on ASM files
+
 config HAVE_JUMP_LABEL_HACK
 	bool
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6413342a03f4..5818baddfb27 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -342,7 +342,11 @@ $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
+ifndef CONFIG_ARCH_OBJTOOL_SKIP_ASM
       cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool)
+else
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
+endif
 
 ifdef CONFIG_ASM_MODVERSIONS
 
-- 
2.41.0

