Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0450745797
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGCIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:48:28 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988793
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:48:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qvfhm13rMz9sFZ;
        Mon,  3 Jul 2023 10:48:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s56jr0HLz2no; Mon,  3 Jul 2023 10:48:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qvfhm0Pbjz9sFY;
        Mon,  3 Jul 2023 10:48:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A39E8B77D;
        Mon,  3 Jul 2023 10:48:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HLKDBUvwH8fT; Mon,  3 Jul 2023 10:48:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE2578B768;
        Mon,  3 Jul 2023 10:48:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3638mKST1103930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 10:48:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3638mJ431103885;
        Mon, 3 Jul 2023 10:48:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/9] Cleanup/Optimise KUAP (v2)
Date:   Mon,  3 Jul 2023 10:48:04 +0200
Message-ID: <cover.1688373335.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688374083; l=2180; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=jg5CxylxOUWVvMQGhNpE+P9dYek5xUoJPjrrm3aS3JY=; b=EFpCpAJxEPCz144zmiYqdlRm+JxPY0RjpQCxCkHb5loXXVFecipiCwyhQxWEqUGGvJmSjNXVo YMc0iAnYFwhDJ92sjVU5G6K9DmzF6pnHUMuDajlX8iESLe+8PqEKOKB
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

This series is cleaning up a bit KUAP in preparation of using objtool
to validate UACCESS.

There are two main changes in this series:

1/ Simplification of KUAP on book3s/32

2/ Using ASM features on 32 bits and booke as suggested by Nic.

Those changes will be required for objtool UACCESS validation, but
even before they are worth it, especially the simplification on 32s.

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

 arch/powerpc/include/asm/book3s/32/kup.h      | 131 +++++++-----------
 .../powerpc/include/asm/book3s/64/hash-pkey.h |   2 +-
 arch/powerpc/include/asm/book3s/64/kup.h      |  54 +++-----
 arch/powerpc/include/asm/bug.h                |   1 +
 arch/powerpc/include/asm/feature-fixups.h     |   1 +
 arch/powerpc/include/asm/kup.h                |  91 +++++-------
 arch/powerpc/include/asm/mmu.h                |   4 +-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |  62 ++++-----
 arch/powerpc/include/asm/nohash/kup-booke.h   |  68 ++++-----
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
 19 files changed, 220 insertions(+), 273 deletions(-)

-- 
2.41.0

