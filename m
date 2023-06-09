Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0E7291A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbjFIHs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjFIHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECC210C;
        Fri,  9 Jun 2023 00:47:40 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1QjFx25a8QTH/dzubQvtPLDE1NUoR24eLALObuUbSg=;
        b=3blPo3mDsiV2HYY0n9H6byKre1/q+kDXiBeMIRW28pHp0bKqjushonaRwD3Wwq1fQnGxy5
        fAIkyIoqLgqI7lX8L/JZO1exl32Qnucek/JGXzo8Z5tvrx59rxmIkCQ3WfXv9i5bH/iBk7
        +YThbdTJAOBg8hC1E1lDM39rIJHfh109dHVN2AQIWAlDncIinxPdPzOG5gaFx7mo23wGRG
        FCq7XBqrHDLOn5VhTf0EGkHq2mScT6HLYl3uyVM/FOA6ft2YGwl2YS35acat3HW7AIcHQf
        46fg7e4eaVBK0gshYiNEhVJzTXzCrj7IeCDsYQB8ScsPcXgEdVApVgErkq7ibA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1QjFx25a8QTH/dzubQvtPLDE1NUoR24eLALObuUbSg=;
        b=B6TFGray1JRom/ORFJkugovknSf/Bm3PPf73rL5WEcq/RRxjFm9vUsBETAwN6dOke5d70r
        647xxBSErvwQmpAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->idx
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7351d2ebad0519027db14a32f6204af84952574a.1685464332.git.jpoimboe@kernel.org>
References: <7351d2ebad0519027db14a32f6204af84952574a.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685158.404.4699012820536375293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     be9a4c116824c39720001db5bc45fe7528b26cff
Gitweb:        https://git.kernel.org/tip/be9a4c116824c39720001db5bc45fe7528b26cff
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:05 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:21 -07:00

objtool: Get rid of reloc->idx

Use the array offset to calculate the reloc index.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 45.56G
- After:  peak heap memory consumption: 43.83G

Link: https://lore.kernel.org/r/7351d2ebad0519027db14a32f6204af84952574a.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 |  6 ++----
 tools/objtool/include/objtool/elf.h | 10 +++++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 19ac53a..70c8012 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -829,7 +829,6 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 		return NULL;
 	}
 
-	reloc->idx = reloc_idx;
 	reloc->sec = rsec;
 	reloc->offset = offset;
 	reloc->type = type;
@@ -954,7 +953,6 @@ static int read_relocs(struct elf *elf)
 				return -1;
 
 			reloc->sec = rsec;
-			reloc->idx = i;
 			symndx = GELF_R_SYM(reloc->rel.r_info);
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
@@ -1237,9 +1235,9 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 
 	if (rsec->sh.sh_type == SHT_RELA) {
 		reloc->rela.r_addend = reloc->addend;
-		ret = gelf_update_rela(rsec->data, reloc->idx, &reloc->rela);
+		ret = gelf_update_rela(rsec->data, reloc_idx(reloc), &reloc->rela);
 	} else {
-		ret = gelf_update_rel(rsec->data, reloc->idx, &reloc->rel);
+		ret = gelf_update_rel(rsec->data, reloc_idx(reloc), &reloc->rel);
 	}
 
 	if (!ret) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a09da20..2a14da6 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -76,9 +76,8 @@ struct reloc {
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
 	unsigned long offset;
-	unsigned int type;
 	s64 addend;
-	int idx;
+	unsigned int type;
 	bool jump_table_start;
 };
 
@@ -200,6 +199,11 @@ static inline unsigned int sec_num_entries(struct section *sec)
 	return sec->sh.sh_size / sec->sh.sh_entsize;
 }
 
+static inline unsigned int reloc_idx(struct reloc *reloc)
+{
+	return reloc - reloc->sec->relocs;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
@@ -219,7 +223,7 @@ static inline unsigned int sec_num_entries(struct section *sec)
 		     __i++, reloc++)
 
 #define for_each_reloc_from(rsec, reloc)				\
-	for (int __i = reloc->idx;					\
+	for (int __i = reloc_idx(reloc);				\
 	     __i < sec_num_entries(rsec);				\
 	     __i++, reloc++)
 
