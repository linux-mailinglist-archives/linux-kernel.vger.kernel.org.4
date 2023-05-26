Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C9714F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjE2TKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2TKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:10:30 -0400
X-Greylist: delayed 12004 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 12:10:18 PDT
Received: from pegase2.c-s.fr (unknown [92.175.17.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC7BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:10:18 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QSDjY4qvyz9skW;
        Fri, 26 May 2023 07:57:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UX0gB1HwZOeH; Fri, 26 May 2023 07:57:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QSDjY41Bvz9skT;
        Fri, 26 May 2023 07:57:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72CFA8B780;
        Fri, 26 May 2023 07:57:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id d4Cyt6NbTa6b; Fri, 26 May 2023 07:57:53 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.54])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B5F88B763;
        Fri, 26 May 2023 07:57:53 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34Q5vlQC2409970
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:57:47 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34Q5vjkP2409965;
        Fri, 26 May 2023 07:57:45 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kcsan: Properly instrument arch_spin_unlock()
Date:   Fri, 26 May 2023 07:57:33 +0200
Message-Id: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685080620; l=1725; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CfZu93KMbju/LZ6ePfCOTshmQTWaMrm/rB4z3C92oIs=; b=+2PWX6nDdw/gAAX7fW08lO94CwMfTSoBkFH5UtBWw1jDJYxWf2c51uGUxZj8A8GYiczDC50Om 8+HisYWedKSBTWwJyGHw7Avdcacb0Rs2Quv8jSrKi/D7d32b3LC0PSB
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following boottime error is encountered with SMP kernel:

  kcsan: improperly instrumented type=(0): arch_spin_unlock(&arch_spinlock)
  kcsan: improperly instrumented type=(0): spin_unlock(&test_spinlock)
  kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): arch_spin_unlock(&arch_spinlock)
  kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): spin_unlock(&test_spinlock)
  kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): arch_spin_unlock(&arch_spinlock)
  kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): spin_unlock(&test_spinlock)
  kcsan: selftest: test_barrier failed
  kcsan: selftest: 2/3 tests passed
  Kernel panic - not syncing: selftests failed

Properly instrument arch_spin_unlock() with kcsan_mb().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/simple_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 9dcc7e9993b9..4dd12dcb9ef8 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -15,6 +15,7 @@
  * (the type definitions are in asm/simple_spinlock_types.h)
  */
 #include <linux/irqflags.h>
+#include <linux/kcsan-checks.h>
 #include <asm/paravirt.h>
 #include <asm/paca.h>
 #include <asm/synch.h>
@@ -126,6 +127,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
+	kcsan_mb();
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
 				PPC_RELEASE_BARRIER: : :"memory");
 	lock->slock = 0;
-- 
2.40.1

