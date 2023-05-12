Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE7700C44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242058AbjELPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbjELPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:50:30 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24187DBA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:50:28 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QHt5r4h20z9shD;
        Fri, 12 May 2023 17:31:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rIDy-JiO_jv1; Fri, 12 May 2023 17:31:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QHt5r3s9wz9sh9;
        Fri, 12 May 2023 17:31:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 732B18B78C;
        Fri, 12 May 2023 17:31:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H1LpH-jMWSRN; Fri, 12 May 2023 17:31:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5678D8B763;
        Fri, 12 May 2023 17:31:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34CFVRlp027559
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:31:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34CFVQ9N027555;
        Fri, 12 May 2023 17:31:26 +0200
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
Subject: [PATCH 0/3] Extend KCSAN to all powerpc
Date:   Fri, 12 May 2023 17:31:16 +0200
Message-Id: <cover.1683892665.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683905477; l=837; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hPBnA5KflZMsLfBVOf1qnFl729hUS0enPhkbxf5HtTs=; b=+rCPMq09lu0PQQBWq0K3cX4hp8o3P5mr2OmgxPEWSSY2TZtz6UHhi0/tZZqKNtNMu8nfSrXT9 2/46XXMIUz7C1yYchavqsPeWJAztLAyhgUonNSsXnrmrAL0V9j9ZI1a
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

This series enables KCSAN on all powerpc.

To do this, a fix is required to KCSAN core.

Once that fix is done, the stubs can also be removed from xtensa.

It would be nice if patch 1 could go in v6.4 as a fix, then patches 2 and 3
could be handled separately in each architecture in next cycle.

Christophe Leroy (2):
  kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
  xtensa: Remove 64 bits atomic builtins stubs

Rohan McLure (1):
  powerpc/{32,book3e}: kcsan: Extend KCSAN Support

 arch/powerpc/Kconfig          |  2 +-
 arch/xtensa/lib/Makefile      |  2 --
 arch/xtensa/lib/kcsan-stubs.c | 54 -----------------------------------
 kernel/kcsan/core.c           |  2 ++
 4 files changed, 3 insertions(+), 57 deletions(-)
 delete mode 100644 arch/xtensa/lib/kcsan-stubs.c

-- 
2.40.1

