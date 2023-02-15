Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E79697D59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBON3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBON3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:02 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DEEF97
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:28:37 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PGzR14vYjz9snB;
        Wed, 15 Feb 2023 14:27:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nMKN8nN8XQkP; Wed, 15 Feb 2023 14:27:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PGzNR6PDCz9sqV;
        Wed, 15 Feb 2023 14:25:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B3048B7CE;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lyj-ZWMa5yLJ; Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31AF38B7C7;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31FCrs6D217611
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 13:53:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31FCrsS8217610;
        Wed, 15 Feb 2023 13:53:54 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 9/9] powerpc/85xx: Don't check ppc_md.progress in mpc85xx_cds_setup_arch()
Date:   Wed, 15 Feb 2023 13:53:38 +0100
Message-Id: <2a774f9efd9f900934b08116f8af5d2966a724ab.1676465585.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676465615; l=1383; s=20211009; h=from:subject:message-id; bh=CkexO9nWG62Wgf3O48GCFq1qIddbZ+AKNgX3L52bRU0=; b=AdSQXK+H403KvFAflCqwoPps4rJRDezaZxtNZ1XJYWCzIS8nq5bybMwDwkIWN8I3mz2AYad1tQqi yALdtUGXC3YqufAUpMTUvU4DHcOeThkLE2pGO/Vs0sq2sOgZH/hM
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc85xx_cds_setup_arch() is not a hot path, creating the string to be
printed even when it doesn't get printed at the end is not an problem.

Do it at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 41079d02dee8..dd969311b78e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -318,6 +318,7 @@ static void __init mpc85xx_cds_setup_arch(void)
 {
 	struct device_node *np;
 	int cds_pci_slot;
+	char buf[40];
 
 	ppc_md_progress("mpc85xx_cds_setup_arch()", 0);
 
@@ -334,13 +335,9 @@ static void __init mpc85xx_cds_setup_arch(void)
 		return;
 	}
 
-	if (ppc_md.progress) {
-		char buf[40];
-		cds_pci_slot = ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + 1;
-		snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
-				in_8(&cadmus->cm_ver), cds_pci_slot);
-		ppc_md_progress(buf, 0);
-	}
+	cds_pci_slot = ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + 1;
+	snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n", in_8(&cadmus->cm_ver), cds_pci_slot);
+	ppc_md_progress(buf, 0);
 
 #ifdef CONFIG_PCI
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
-- 
2.39.1

