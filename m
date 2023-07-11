Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB574F42B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjGKP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:59:29 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09F12F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:59:28 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0ltP67GTz9sFF;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2rhQ6e6KCcfX; Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0ltP5RbGz9sFB;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B473F8B77E;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1TmYi9Rvc3T6; Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A5A08B779;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BFxOF33695831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:59:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BFxMpn3695820;
        Tue, 11 Jul 2023 17:59:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/9] Cleanup/Optimise KUAP (v3)
Date:   Tue, 11 Jul 2023 17:59:12 +0200
Message-ID: <cover.1689091022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091151; l=2312; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=adFnaIZiJTeO6Cz2UZ7Q2Z0r73HSP64qXDq2uOoJDHg=; b=cJIwd0NwhGM51zL42j746sWOQgqcbuDCTQiEwCnaLwWrWXmLyT7thaJeWWl3TxvIN5P7kXb3Q rmWY9ebNuuSALHY6muQGk4xHeZgWct7If21U4uyKEWOy4jYxWkbvhKG
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is cleaning up a bit KUAP in preparation of using objtool
to validate UACCESS.

There are two main changes in this series:

1/ Simplification of KUAP on book3s/32

2/ Using ASM features on 32 bits and booke as suggested by Nic.

Those changes will be required for objtool UACCESS validation, but
even before they are worth it, especially the simplification on 32s.

Changes in v3:
- Rearranged book3s/32 simplification in order to ease objtool UACCESS
check implementation (patches 7 and 9)

Christophe Leroy (9):
  powerpc/kuap: Avoid unnecessary reads of MD_AP
  powerpc/kuap: Avoid useless jump_label on empty function
  powerpc/kuap: Fold kuep_is_disabled() into its only user
  powerpc/features: Add capability to update mmu features later
  powerpc/kuap: MMU_FTR_BOOK3S_KUAP becomes MMU_FTR_KUAP
  powerpc/kuap: Use MMU_FTR_KUAP on all and refactor disabling kuap
  powerpc/kuap: Simplify KUAP lock/unlock on BOOK3S/32
  powerpc/kuap: KUAP enabling/disabling functions must be
    __always_inline
  powerpc/kuap: Use ASM feature fixups instead of static branches

 arch/powerpc/include/asm/book3s/32/kup.h      | 123 ++++++++----------
 .../powerpc/include/asm/book3s/64/hash-pkey.h |   2 +-
 arch/powerpc/include/asm/book3s/64/kup.h      |  54 ++++----
 arch/powerpc/include/asm/bug.h                |   1 +
 arch/powerpc/include/asm/feature-fixups.h     |   1 +
 arch/powerpc/include/asm/kup.h                |  91 +++++--------
 arch/powerpc/include/asm/mmu.h                |   4 +-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |  62 +++++----
 arch/powerpc/include/asm/nohash/kup-booke.h   |  68 +++++-----
 arch/powerpc/include/asm/uaccess.h            |   6 +-
 arch/powerpc/kernel/cputable.c                |   4 +
 arch/powerpc/kernel/syscall.c                 |   2 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/lib/feature-fixups.c             |  31 ++++-
 arch/powerpc/mm/book3s32/kuap.c               |  20 +--
 arch/powerpc/mm/book3s32/mmu_context.c        |   2 +-
 arch/powerpc/mm/book3s64/pkeys.c              |   2 +-
 arch/powerpc/mm/init_32.c                     |   2 +
 arch/powerpc/mm/nohash/kup.c                  |   8 +-
 19 files changed, 222 insertions(+), 263 deletions(-)

-- 
2.41.0

