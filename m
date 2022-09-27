Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770125EC695
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiI0Ohc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiI0Ogw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:36:52 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3C1BB221
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:34:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4McMYp2QSGz9spG;
        Tue, 27 Sep 2022 16:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1zT7Gyh6NGPT; Tue, 27 Sep 2022 16:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4McMYm2nxJz9sp5;
        Tue, 27 Sep 2022 16:33:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5179D8B790;
        Tue, 27 Sep 2022 16:33:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yWy96NN-JrEf; Tue, 27 Sep 2022 16:33:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE56E8B77A;
        Tue, 27 Sep 2022 16:33:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28REXRkv351176
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:33:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28REXRPh351175;
        Tue, 27 Sep 2022 16:33:27 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Gray <bgray@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/4] powerpc/code-patching: Use jump_label to check if poking_init() is done
Date:   Tue, 27 Sep 2022 16:33:08 +0200
Message-Id: <8d6088aca7b63247377b6d9e4897d08d935fbe93.1647962456.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1647962456.git.christophe.leroy@csgroup.eu>
References: <cover.1647962456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664289185; l=1657; s=20211009; h=from:subject:message-id; bh=VpCvKObwtwt586zecmpLYRX0hNgaFguYgIynvmw/m08=; b=kT8iktDaTO4pQER95y0kfISPsXUCHdTEt8zdMLVh9Q+Ug2+sTLPJT5PHFJs61dIl0HCh74vY0E0U Z+VmuI4PCfnxu6nL6rutSs1td7mtU7CNWz7LavNjI//cZ2byXe/x
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only during early startup that poking_init() is not done yet,
for instance when calling ftrace_init().

Once poking_init() has been called there must be a poking area, no
need to check it everytime patch_instruction() is called.

ftrace activation time is reduced by 7% with the change on an 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index ab434c3853c9..8bd74bbe8b8d 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -79,6 +79,8 @@ static int text_area_cpu_down(unsigned int cpu)
 	return 0;
 }
 
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(poking_init_done);
+
 /*
  * Although BUG_ON() is rude, in this case it should only happen if ENOMEM, and
  * we judge it as being preferable to a kernel that will crash later when
@@ -89,6 +91,7 @@ void __init poking_init(void)
 	BUG_ON(!cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 		"powerpc/text_poke:online", text_area_cpu_up,
 		text_area_cpu_down));
+	static_branch_enable(&poking_init_done);
 }
 
 static unsigned long get_patch_pfn(void *addr)
@@ -176,7 +179,7 @@ static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
 	 * when text_poke_area is not ready, but we still need
 	 * to allow patching. We just do the plain old patching
 	 */
-	if (!this_cpu_read(text_poke_area))
+	if (!static_branch_likely(&poking_init_done))
 		return raw_patch_instruction(addr, instr);
 
 	local_irq_save(flags);
-- 
2.35.1

