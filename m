Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6D651DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLTJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiLTJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:40:39 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA31B5F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:40:38 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Nbs4z4lBVz9t3q;
        Tue, 20 Dec 2022 10:40:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SUyV7fBD5z7Y; Tue, 20 Dec 2022 10:40:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Nbs4n4nr8z9t41;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C87E8B774;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rw_imi8iIn-V; Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72F6B8B763;
        Tue, 20 Dec 2022 10:40:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2BJIkHMn1709633
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:46:17 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2BJIkHCi1709632;
        Mon, 19 Dec 2022 19:46:17 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 5/5] powerpc/epapr: Don't use wrteei on non booke
Date:   Mon, 19 Dec 2022 19:46:00 +0100
Message-Id: <b29c7f1727433b003eae050e44072741c8ac223b.1671475543.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671475558; l=1048; s=20211009; h=from:subject:message-id; bh=Cg2+M3VifLSSD0LyQ3hL3PQ83SXOIFp0qiPKO1QwDcg=; b=Vi1YuEJYanST1ZaxHCzqg5MiIex+yQfaZB3QwDjpW/HIWKiLwC2JIlosX7s9rPOLK9INV5zBdEbY aJFypXFPDMeprZ694hPaChMXlL/qlkok/ub0DKOwUgRMJbAzf8bd
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wrteei is only for booke. Use the standard mfmsr/ori/mtmsr
when non booke.

Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Not sure this is needed at all, the commit that introduced the code says it is for e500, but there's no such limitation in Kconfig. Maybe we should limit all the file to CONFIG_PPC_E500
---
 arch/powerpc/kernel/epapr_hcalls.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 69a912550577..033116e465d0 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -21,7 +21,13 @@ _GLOBAL(epapr_ev_idle)
 	ori	r4, r4,_TLF_NAPPING	/* so when we take an exception */
 	PPC_STL	r4, TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 
+#ifdef CONFIG_BOOKE_OR_40x
 	wrteei	1
+#else
+	mfmsr	r4
+	ori	r4, r4, MSR_EE
+	mtmsr	r4
+#endif
 
 idle_loop:
 	LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
-- 
2.38.1

