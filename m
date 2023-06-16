Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BE73327C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbjFPNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbjFPNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:48:23 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02330E0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:48:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QjL8Z2XWrz9s2J;
        Fri, 16 Jun 2023 15:48:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8giTzWa4F7S1; Fri, 16 Jun 2023 15:48:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QjL8W0LS1z9s1G;
        Fri, 16 Jun 2023 15:48:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 051FC8B781;
        Fri, 16 Jun 2023 15:48:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PXLWrfkVSk2n; Fri, 16 Jun 2023 15:48:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C14D18B764;
        Fri, 16 Jun 2023 15:48:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35GDm4i21175650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 15:48:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35GDm0FV1175646;
        Fri, 16 Jun 2023 15:48:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v1 0/3] powerpc/objtool: First step towards uaccess validation (v1)
Date:   Fri, 16 Jun 2023 15:47:49 +0200
Message-Id: <cover.1686922583.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686923268; l=3187; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=A1u6ADmaDLt4PC3Ez60heNCY/BgdxUOWGXdUy2kyQ/E=; b=wlVJoF5RAtYZPAopVtD/HPmHr2OSX6EeUqL0HkNxk+4vZlF7Q0yW/YlqO5szOXZ68pBWnOOIJ sqsI2hfURbjAk7qLMEOR+fSCrWe2b/Mx4q0i69MAhwKLjiFNggRi9I9
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

This RFC is a first step towards the validation of userspace accesses.

For the time being it targets only PPC32 and includes hacks directly in
core part of objtool.

It doesn't yet include handling of uaccess at all but is a first step
to support objtool validation.

Assembly files have been kept aside as they require a huge work before
being ready for objtool validation and are not directly relevant for
uaccess validation.

Please have a look and hold hand if I'm going in the wrong direction.

For the few hacks done directly in the core part of objtool don't
hesitate to suggest ways to make it more generic.

Christophe Leroy (3):
  Revert "powerpc/bug: Provide better flexibility to
    WARN_ON/__WARN_FLAGS() with asm goto"
  powerpc: Mark all .S files invalid for objtool
  powerpc: WIP draft support to objtool check

 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/boot/Makefile                    | 17 +++++
 arch/powerpc/crypto/Makefile                  | 13 ++++
 arch/powerpc/include/asm/book3s/64/kup.h      |  2 +-
 arch/powerpc/include/asm/bug.h                | 67 +++----------------
 arch/powerpc/include/asm/extable.h            | 14 ----
 arch/powerpc/include/asm/ppc_asm.h            | 11 ++-
 arch/powerpc/kernel/Makefile                  | 44 ++++++++++++
 arch/powerpc/kernel/misc_32.S                 |  2 +-
 arch/powerpc/kernel/trace/Makefile            |  4 ++
 arch/powerpc/kernel/traps.c                   |  9 +--
 arch/powerpc/kernel/vdso/Makefile             | 11 +++
 arch/powerpc/kexec/Makefile                   |  2 +
 arch/powerpc/kvm/Makefile                     | 13 ++++
 arch/powerpc/lib/Makefile                     | 25 +++++++
 arch/powerpc/mm/book3s32/Makefile             |  3 +
 arch/powerpc/mm/nohash/Makefile               |  3 +
 arch/powerpc/perf/Makefile                    |  2 +
 arch/powerpc/platforms/44x/Makefile           |  2 +
 arch/powerpc/platforms/52xx/Makefile          |  3 +
 arch/powerpc/platforms/83xx/Makefile          |  2 +
 arch/powerpc/platforms/cell/spufs/Makefile    |  3 +
 arch/powerpc/platforms/pasemi/Makefile        |  2 +
 arch/powerpc/platforms/powermac/Makefile      |  3 +
 arch/powerpc/platforms/powernv/Makefile       |  3 +
 arch/powerpc/platforms/ps3/Makefile           |  2 +
 arch/powerpc/platforms/pseries/Makefile       |  2 +
 arch/powerpc/purgatory/Makefile               |  3 +
 arch/powerpc/sysdev/Makefile                  |  3 +
 arch/powerpc/xmon/Makefile                    |  3 +
 scripts/Makefile.lib                          |  2 +-
 tools/objtool/arch/powerpc/decode.c           | 60 +++++++++++++++--
 .../arch/powerpc/include/arch/special.h       |  2 +-
 tools/objtool/arch/powerpc/special.c          | 44 +++++++++++-
 tools/objtool/check.c                         | 29 ++++----
 tools/objtool/include/objtool/elf.h           |  1 +
 tools/objtool/include/objtool/special.h       |  2 +-
 .../powerpc/primitives/asm/extable.h          |  1 -
 38 files changed, 311 insertions(+), 104 deletions(-)
 delete mode 120000 tools/testing/selftests/powerpc/primitives/asm/extable.h

-- 
2.40.1

