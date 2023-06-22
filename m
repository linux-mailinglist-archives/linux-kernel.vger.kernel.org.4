Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E4739EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjFVKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFVKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:55:03 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E41BC5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:55:01 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qmy1r3Pcwz9sRF;
        Thu, 22 Jun 2023 12:54:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XbfJliOpw3c2; Thu, 22 Jun 2023 12:54:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qmy1q5zgVz9sRh;
        Thu, 22 Jun 2023 12:54:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C782A8B77C;
        Thu, 22 Jun 2023 12:54:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Jhq4CNWlVTjO; Thu, 22 Jun 2023 12:54:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.14])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7954E8B768;
        Thu, 22 Jun 2023 12:54:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35MAslvw2382515
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:54:47 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35MAskIe2382511;
        Thu, 22 Jun 2023 12:54:46 +0200
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
Subject: [PATCH v2 00/14] powerpc/objtool: uaccess validation for PPC32 (v2)
Date:   Thu, 22 Jun 2023 12:54:22 +0200
Message-Id: <cover.1687430631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687431271; l=3072; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Dg5zdi84TXnAtT8CD6i72DeNJLQHkYOORwQ7HSHb3nA=; b=/dakf9ZGZCCVtBFnQ82TXejVmhGFFcDD2/Ph/28PUBrubyWdIkls8BgvPDjqaoG5G6NEgZLHh 9xoWbp1L9A9BYa/445Eq4TtSoUBZTVGXe/dwCuYI+Vac+x/jP75Uc+B
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

This series adds UACCESS validation for PPC32. It includes half
a dozen of changes to objtool core.

It is almost mature, performs code analysis for all PPC32, only
missing marking of UACCESS enable/disable for book3s/32.

Most object files are correctly decoded, only a few
'unreachable instruction' warnings remain due to more complex
switch table cases:
- Loading of table address after the dynamic jump
- Nested switches

It allowed to detect some UACCESS mess in a few files. They've been
fixed through other patches.

Christophe Leroy (14):
  powerpc/kuap: Avoid unnecessary reads of MD_AP
  powerpc/kuap: Avoid useless jump_label on empty function
  powerpc/kuap: Refactor static branch for disabling kuap
  powerpc/kuap: Make disabling KUAP at boottime impossible except on
    book3s/64
  powerpc/kuap: KUAP enabling/disabling functions must be
    __always_inline
  Revert "powerpc/bug: Provide better flexibility to
    WARN_ON/__WARN_FLAGS() with asm goto"
  objtool: Allow an architecture to disable objtool on ASM files
  objtool: Fix JUMP_ENTRY_SIZE for bi-arch like powerpc
  objtool: Add INSN_RETURN_CONDITIONAL
  objtool: Add support for relative switch tables
  objtool: Remove too strict constraint in jump table search
  objtool: Add support for more complex UACCESS control
  powerpc/bug: Annotate reachable after warning trap
  powerpc: Implement UACCESS validation on PPC32

 arch/Kconfig                                  |  5 ++
 arch/powerpc/Kconfig                          |  2 +
 arch/powerpc/include/asm/book3s/32/kup.h      | 39 ++++-----
 arch/powerpc/include/asm/book3s/64/kup.h      | 36 ++++----
 arch/powerpc/include/asm/bug.h                | 77 ++++-------------
 arch/powerpc/include/asm/kup.h                | 66 ++++++++++-----
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  | 52 +++++-------
 arch/powerpc/include/asm/nohash/kup-booke.h   | 49 +++++------
 arch/powerpc/include/asm/uaccess.h            |  6 +-
 arch/powerpc/kernel/misc_32.S                 |  2 +-
 arch/powerpc/kernel/traps.c                   |  9 +-
 arch/powerpc/kexec/core_32.c                  |  4 +-
 arch/powerpc/mm/book3s32/kuap.c               | 18 ++--
 arch/powerpc/mm/init-common.c                 |  3 +
 arch/powerpc/mm/nohash/kup.c                  | 11 +--
 include/linux/objtool.h                       | 14 ++++
 scripts/Makefile.build                        |  4 +
 tools/objtool/arch/powerpc/decode.c           | 82 +++++++++++++++++--
 .../arch/powerpc/include/arch/special.h       |  2 +-
 tools/objtool/arch/powerpc/special.c          | 44 +++++++++-
 tools/objtool/arch/x86/special.c              |  3 +-
 tools/objtool/check.c                         | 79 ++++++++++++++----
 tools/objtool/include/objtool/arch.h          |  1 +
 tools/objtool/include/objtool/elf.h           |  1 +
 tools/objtool/include/objtool/special.h       |  2 +-
 tools/objtool/special.c                       | 55 ++++++-------
 26 files changed, 395 insertions(+), 271 deletions(-)

-- 
2.40.1

