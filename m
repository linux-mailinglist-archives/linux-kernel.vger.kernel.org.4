Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5C73BD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFWRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFWRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:06:44 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726E3296F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:06:31 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QnkCV2b7Tz9sgZ;
        Fri, 23 Jun 2023 19:05:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ijUDFS2sDcLV; Fri, 23 Jun 2023 19:05:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QnkCR4VThz9sgc;
        Fri, 23 Jun 2023 19:05:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 926EB8B780;
        Fri, 23 Jun 2023 19:05:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4cLp94DbmV0O; Fri, 23 Jun 2023 19:05:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C3D28B763;
        Fri, 23 Jun 2023 19:05:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35NH5mCG2645789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 19:05:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35NH5miB2645785;
        Fri, 23 Jun 2023 19:05:48 +0200
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
Subject: [PATCH v3 11/15] objtool: Remove too strict constraint in jump table search
Date:   Fri, 23 Jun 2023 19:05:22 +0200
Message-Id: <14f2cad7af163cbd8d41521714c3cf975aed0ca4.1687539638.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687539638.git.christophe.leroy@csgroup.eu>
References: <cover.1687539638.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687539922; l=1230; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=sRx8dCgeNVZpKuyVq5Uc0RBPaU0ysjWzONNOIlDLbc0=; b=GYxaVE5kKuRlH4J9V5SHhNRCEkIIoJ+ZJRGS7BruDVPONXAUd/ti/DtPIWZPFses0naIrX3lf eCERb6Pq+YuDdIinaxzb5PP2qMxv7w+DMB+iraTgjc+v7MPX1ZOWpLN
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

In code there is often a pattern like:

	load jump table address
	do some test
	conditional jump to label1:
	do something
	unconditional jump to label2:
label1:
	do something else
	read jump table
	dynamic jump
label2:
	do other job here ....

find_jump_table() contains a constraint that stops the backsearch
of the table address loading when a jump is found in-between.

Remove that constraint.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/check.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 05d789e6d3b6..c9f0fd31d146 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2067,13 +2067,6 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
-		/* allow small jumps within the range */
-		if (insn->type == INSN_JUMP_UNCONDITIONAL &&
-		    insn->jump_dest &&
-		    (insn->jump_dest->offset <= insn->offset ||
-		     insn->jump_dest->offset > orig_insn->offset))
-		    break;
-
 		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
-- 
2.40.1

