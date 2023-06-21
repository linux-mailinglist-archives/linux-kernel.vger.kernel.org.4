Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB6738216
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjFUKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjFUKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:38:56 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25010F6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:38:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QmKj94fDRz9sDZ;
        Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZqIy9NxERBSY; Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QmKj93zWQz9sCn;
        Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 856E28B779;
        Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0klM9h5esvpM; Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 647A58B763;
        Wed, 21 Jun 2023 12:38:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35LAcHmW2082700
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 12:38:17 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35LAcGkn2082695;
        Wed, 21 Jun 2023 12:38:16 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/step: Mark __copy_mem_out() and __emulate_dcbz() __always_inline
Date:   Wed, 21 Jun 2023 12:38:10 +0200
Message-Id: <f1d4a15da70190f8c2fcddb377bbc1e09827242c.1687343857.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687343888; l=1441; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=78jbU4+zwN0iMnzcpOxCNm9Y19Fwj9LuLVxd5iPrWXo=; b=hOMVeA3ee2aJgapXJOJ9svZ4ikXSDNaflCwN2aa7oRVUSWO0lg2ah3GFYX3182xtBQW68+sJ5 bwypOanxIUkD5TsUd9jn4BJu+I3/Zyy6lSTcPL3lNwSTxmj2zsY+Waz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool reports two folliwng warnings:
  arch/powerpc/lib/sstep.o: warning: objtool: copy_mem_out+0x3c
    (.text+0x30c): call to __copy_mem_out() with UACCESS enabled
  arch/powerpc/lib/sstep.o: warning: objtool: emulate_dcbz+0x70
    (.text+0x4dc): call to __emulate_dcbz() with UACCESS enabled

Mark __copy_mem_out() and __emulate_dcbz() __always_inline

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/sstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 38158b77a801..a4ab8625061a 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -485,7 +485,7 @@ write_mem_aligned(unsigned long val, unsigned long ea, int nb, struct pt_regs *r
  * Copy from a buffer to userspace, using the largest possible
  * aligned accesses, up to sizeof(long).
  */
-static nokprobe_inline int __copy_mem_out(u8 *dest, unsigned long ea, int nb, struct pt_regs *regs)
+static __always_inline int __copy_mem_out(u8 *dest, unsigned long ea, int nb, struct pt_regs *regs)
 {
 	int c;
 
@@ -1043,7 +1043,7 @@ static nokprobe_inline int do_vsx_store(struct instruction_op *op,
 }
 #endif /* CONFIG_VSX */
 
-static int __emulate_dcbz(unsigned long ea)
+static __always_inline int __emulate_dcbz(unsigned long ea)
 {
 	unsigned long i;
 	unsigned long size = l1_dcache_bytes();
-- 
2.40.1

