Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F75D74F471
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjGKQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGKQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:08:46 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59BDD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:08:44 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m573wdmz9sFB;
        Tue, 11 Jul 2023 18:08:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AYKowbR74jgg; Tue, 11 Jul 2023 18:08:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m544gHJz9sF7;
        Tue, 11 Jul 2023 18:08:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 999928B77A;
        Tue, 11 Jul 2023 18:08:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 26s-KvZYG0f0; Tue, 11 Jul 2023 18:08:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FCA88B763;
        Tue, 11 Jul 2023 18:08:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8avd3696791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8ZRg3696790;
        Tue, 11 Jul 2023 18:08:35 +0200
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
Subject: [PATCH v4 00/15] powerpc/objtool: uaccess validation for PPC32 (v4)
Date:   Tue, 11 Jul 2023 18:08:26 +0200
Message-ID: <cover.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091705; l=3854; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=SIhXxQOiBzhmKHv9Gecp3ZvjAMii+RQSJw/gLgDNIV4=; b=sNTJqHVF9MVy0ICHZdjSNg9G3w7215FQxGqEK9LahHCrWCapSZmtATm/iIMkHfqCXeDTSYwg4 mUYNsWX7hUdCNhOomjNacVEeil3+bAKJG7F6/bSuIuTDWfPzJrVqu3f
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

This series adds UACCESS validation for PPC32. It includes
a dozen of changes to objtool core.

It applies on top of series "Cleanup/Optimise KUAP (v3)"
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=363368&state=*

It is almost mature, performs code analysis for all PPC32.

In this version objtool switch table lookup has been enhanced to
handle nested switch tables.

Most object files are correctly decoded, only a few
'unreachable instruction' warnings remain due to more complex
fonctions which include back and forth jumps or branches.

It allowed to detect some UACCESS mess in a few files. They've been
fixed through other patches.

Changes in v4:
- Split series in two parts, the powerpc uaccess rework is submitted
separately, see https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=363368&state=*
- Support of UACCESS on all PPC32 including book3s/32 which was missing in v3.
- More elaborated switch tables lookup.
- Patches 2, 7, 8, 9, 10, 11 are new
- Patch 11 in series v3 is now removed.

Changes in v3:
- Rebased on top of a merge of powerpc tree and tip/objtool/core tree
- Simplified support for relative switch tables based on relocation type
- Taken comments from Peter

Christophe Leroy (15):
  Revert "powerpc/bug: Provide better flexibility to
    WARN_ON/__WARN_FLAGS() with asm goto"
  objtool: Move back misplaced comment
  objtool: Allow an architecture to disable objtool on ASM files
  objtool: Fix JUMP_ENTRY_SIZE for bi-arch like powerpc
  objtool: Add INSN_RETURN_CONDITIONAL
  objtool: Add support for relative switch tables
  objtool: Merge mark_func_jump_tables() and add_func_jump_tables()
  objtool: Track general purpose register used for switch table base
  objtool: Find end of switch table directly
  objtool: When looking for switch tables also follow conditional and
    dynamic jumps
  objtool: .rodata.cst{2/4/8/16} are not switch tables
  objtool: Add support for more complex UACCESS control
  objtool: Prepare noreturns.h for more architectures
  powerpc/bug: Annotate reachable after warning trap
  powerpc: Implement UACCESS validation on PPC32

 arch/Kconfig                                  |   5 +
 arch/powerpc/Kconfig                          |   2 +
 arch/powerpc/include/asm/book3s/32/kup.h      |   2 +
 arch/powerpc/include/asm/book3s/64/kup.h      |   2 +-
 arch/powerpc/include/asm/bug.h                |  77 ++-------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |   4 +-
 arch/powerpc/include/asm/nohash/kup-booke.h   |   4 +-
 arch/powerpc/kernel/misc_32.S                 |   2 +-
 arch/powerpc/kernel/traps.c                   |   9 +-
 arch/powerpc/kexec/core_32.c                  |   4 +-
 arch/powerpc/mm/nohash/kup.c                  |   2 +
 include/linux/objtool.h                       |  14 ++
 scripts/Makefile.build                        |   4 +
 tools/objtool/arch/powerpc/decode.c           | 155 +++++++++++++++++-
 .../arch/powerpc/include/arch/noreturns.h     |  11 ++
 .../arch/powerpc/include/arch/special.h       |   2 +-
 tools/objtool/arch/powerpc/special.c          |  39 ++++-
 .../objtool/arch/x86/include/arch/noreturns.h |  20 +++
 tools/objtool/arch/x86/special.c              |   8 +-
 tools/objtool/check.c                         | 154 ++++++++++++-----
 tools/objtool/include/objtool/arch.h          |   1 +
 tools/objtool/include/objtool/check.h         |   6 +-
 tools/objtool/include/objtool/special.h       |   3 +-
 tools/objtool/noreturns.h                     |  14 +-
 tools/objtool/special.c                       |  55 +++----
 25 files changed, 425 insertions(+), 174 deletions(-)
 create mode 100644 tools/objtool/arch/powerpc/include/arch/noreturns.h
 create mode 100644 tools/objtool/arch/x86/include/arch/noreturns.h

-- 
2.41.0

