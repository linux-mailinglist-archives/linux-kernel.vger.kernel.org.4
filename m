Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024EF697D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjBON03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjBON0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:26:22 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0F392BF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:26:19 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PGzP10ksxz9sly;
        Wed, 15 Feb 2023 14:26:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KO5zznWU5VIK; Wed, 15 Feb 2023 14:26:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PGzNQ6C1xz9smm;
        Wed, 15 Feb 2023 14:25:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 899058B7C4;
        Wed, 15 Feb 2023 13:53:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oodJWV8ZwTyx; Wed, 15 Feb 2023 13:53:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6837D8B796;
        Wed, 15 Feb 2023 13:53:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31FCrmvS217569
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 13:53:48 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31FCrlBH217566;
        Wed, 15 Feb 2023 13:53:47 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/9] powerpc/machdep: Define 'compatible' property in ppc_md and use it
Date:   Wed, 15 Feb 2023 13:53:30 +0100
Message-Id: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676465614; l=1859; s=20211009; h=from:subject:message-id; bh=MW6umzi5IamlmdhC1yWNdpvp/zOgLkgCImK0fsT3+lc=; b=OuQuKYU3UCHzIZ10Q0pWIKrjlrfcB+K/Kw80W8Mxjt2aIFe0meCdVKcQ0ROreqQI8R7shoszUA1p P5YJkD1RDKFScUaUDBlmciDtY+dSOlwOhX0uFVAPJa4GNkPtz1/B
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most probe functions do nothing else than checking whether
the machine is compatible to a given string.

Define that string in ppc_md structure and check it directly from
probe_machine() instead of using ppc_md.probe() for that.

Keep checking in ppc_md.probe() only for more complex probing.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: New
---
 arch/powerpc/include/asm/machdep.h |  1 +
 arch/powerpc/kernel/setup-common.c | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 378b8d5836a7..c5dfe5ff923c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -20,6 +20,7 @@ struct pci_host_bridge;
 
 struct machdep_calls {
 	char		*name;
+	char		*compatible;
 #ifdef CONFIG_PPC64
 #ifdef CONFIG_PM
 	void		(*iommu_restore)(void);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9b10e57040c6..d1e205fe72ba 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -626,13 +626,14 @@ static __init void probe_machine(void)
 	for (machine_id = &__machine_desc_start;
 	     machine_id < &__machine_desc_end;
 	     machine_id++) {
-		DBG("  %s ...", machine_id->name);
+		DBG("  %s ...\n", machine_id->name);
+		if (machine_id->compatible && !of_machine_is_compatible(machine_id->compatible))
+			continue;
 		memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
-		if (ppc_md.probe()) {
-			DBG(" match !\n");
-			break;
-		}
-		DBG("\n");
+		if (ppc_md.probe && !ppc_md.probe())
+			continue;
+		DBG("   %s match !\n", machine_id->name);
+		break;
 	}
 	/* What can we do if we didn't find ? */
 	if (machine_id >= &__machine_desc_end) {
-- 
2.39.1

