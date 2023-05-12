Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A6700C40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbjELPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbjELPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:50:23 -0400
X-Greylist: delayed 1072 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 08:50:12 PDT
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379691BD7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:50:12 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QHt610zXXz9shF;
        Fri, 12 May 2023 17:31:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0NR9N_j0eNz5; Fri, 12 May 2023 17:31:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QHt602kSNz9shH;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D6608B78D;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rn7iRsKABlYE; Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 19C5E8B763;
        Fri, 12 May 2023 17:31:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34CFVWbx027568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:31:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34CFVWm4027562;
        Fri, 12 May 2023 17:31:32 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, Rohan McLure <rmclure@linux.ibm.com>
Subject: [PATCH 1/3] kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
Date:   Fri, 12 May 2023 17:31:17 +0200
Message-Id: <d9c6afc28d0855240171a4e0ad9ffcdb9d07fceb.1683892665.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683892665.git.christophe.leroy@csgroup.eu>
References: <cover.1683892665.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683905477; l=2965; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=37bWyYVN3vTJ1QuCO1CebY5RYrI1juPiUTBYcAmWWDU=; b=SCEXIyl+QeSBTalTSYb28ctSf7iwi4YRcjupvXCplEUtY6ePrW7RQWBcP1Nm8YcUkmyttrNzR o3Vct24RL+QBsfrJvYlTzjmm8fCMHigBCa/8aSw7V1Ryl+JV4ARn3G0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activating KCSAN on a 32 bits architecture leads to the following
link-time failure:

    LD      .tmp_vmlinux.kallsyms1
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_load':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_load_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_store':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_store_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_exchange':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_add':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_add_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_sub':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_sub_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_and':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_and_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_or':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_or_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_xor':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_xor_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_nand':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_nand_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_strong':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_weak':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
  powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_val':
  kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'

32 bits architectures don't have 64 bits atomic builtins. Only
include DEFINE_TSAN_ATOMIC_OPS(64) on 64 bits architectures.

Fixes: 0f8ad5f2e934 ("kcsan: Add support for atomic builtins")
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/kcsan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 5a60cc52adc0..8a7baf4e332e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1270,7 +1270,9 @@ static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
 DEFINE_TSAN_ATOMIC_OPS(8);
 DEFINE_TSAN_ATOMIC_OPS(16);
 DEFINE_TSAN_ATOMIC_OPS(32);
+#ifdef CONFIG_64BIT
 DEFINE_TSAN_ATOMIC_OPS(64);
+#endif
 
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
-- 
2.40.1

