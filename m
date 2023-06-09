Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF67291AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbjFIHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbjFIHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7072121;
        Fri,  9 Jun 2023 00:47:42 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrhZCMplyizefRqS6kdXynqwThRa/YNMtlT+wHVGuCw=;
        b=Pht3l2pBJv3GF+SMMG8D+tb5N40hTJLW3URgMH0s43iVuvufqfaQ1qp5/XGKI61oauWsOm
        nNVwkVAJe4FjpT1v0XlcYcZmpBBGu0P3OocylnOweJ2ejCUlO0QcwNC9k3Yw8+/667AR/2
        AF6ldbkp0EHpw5PteDMu6W+z1s5gIwDdO3Z6a4khaVbscD1snUSDy4afj8Y2EVqIY0P5C0
        o+9LQegbX3OHb3GJ646C6ejzbVsMYXvLz/7xADj/ub1f0706FhyTGLGCe9SF6FTl447oIC
        a7SX+u3Rnp+SZAk5CJnFyry+MxwQr/tzwLy5pc7b9nL+UgiBi8o6GckkQZ9Qbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrhZCMplyizefRqS6kdXynqwThRa/YNMtlT+wHVGuCw=;
        b=/PgHlsoEuZWefg+wR6j1GmEVmWqyI6BqTy28gdlEOJO+1ce/vPyYFkBupoo3djgcUHxgkl
        PTLBsoMYE3Ud1FCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix reloc_hash size
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <38ef60dc8043270bf3b9dfd139ae2a30ca3f75cc.1685464332.git.jpoimboe@kernel.org>
References: <38ef60dc8043270bf3b9dfd139ae2a30ca3f75cc.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685671.404.3682740079672959168.tip-bot2@tip-bot2>
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

Commit-ID:     eb0481bbc4ce386e73e28ad8590b4f12c8aded56
Gitweb:        https://git.kernel.org/tip/eb0481bbc4ce386e73e28ad8590b4f12c8aded56
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:20:57 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:16 -07:00

objtool: Fix reloc_hash size

With CONFIG_DEBUG_INFO, DWARF creates a lot of relocations and
reloc_hash is woefully undersized, which can affect performance
significantly.  Fix that.

Link: https://lore.kernel.org/r/38ef60dc8043270bf3b9dfd139ae2a30ca3f75cc.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 16 +++++++---------
 tools/objtool/include/objtool/elf.h |  8 +++++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4bbdd8e..f72ec6d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -328,12 +328,12 @@ static int read_sections(struct elf *elf)
 			}
 		}
 
-		if (sec->sh.sh_flags & SHF_EXECINSTR)
-			elf->text_size += sec->sh.sh_size;
-
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
+
+		if (is_reloc_sec(sec))
+			elf->num_relocs += sec->sh.sh_size / sec->sh.sh_entsize;
 	}
 
 	if (opts.stats) {
@@ -888,19 +888,18 @@ static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
 
 static int read_relocs(struct elf *elf)
 {
-	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
+	unsigned long nr_reloc, max_reloc = 0;
 	struct section *rsec;
 	struct reloc *reloc;
 	unsigned int symndx;
 	struct symbol *sym;
 	int i;
 
-	if (!elf_alloc_hash(reloc, elf->text_size / 16))
+	if (!elf_alloc_hash(reloc, elf->num_relocs))
 		return -1;
 
 	list_for_each_entry(rsec, &elf->sections, list) {
-		if ((rsec->sh.sh_type != SHT_RELA) &&
-		    (rsec->sh.sh_type != SHT_REL))
+		if (!is_reloc_sec(rsec))
 			continue;
 
 		rsec->base = find_section_by_index(elf, rsec->sh.sh_info);
@@ -942,12 +941,11 @@ static int read_relocs(struct elf *elf)
 			nr_reloc++;
 		}
 		max_reloc = max(max_reloc, nr_reloc);
-		tot_reloc += nr_reloc;
 	}
 
 	if (opts.stats) {
 		printf("max_reloc: %lu\n", max_reloc);
-		printf("tot_reloc: %lu\n", tot_reloc);
+		printf("num_relocs: %lu\n", elf->num_relocs);
 		printf("reloc_bits: %d\n", elf->reloc_bits);
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 6f82f25..b81d78b 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -90,8 +90,9 @@ struct elf {
 	int fd;
 	bool changed;
 	char *name;
-	unsigned int text_size, num_files;
+	unsigned int num_files;
 	struct list_head sections;
+	unsigned long num_relocs;
 
 	int symbol_bits;
 	int symbol_name_bits;
@@ -158,6 +159,11 @@ static inline size_t elf_rela_size(struct elf *elf)
 	return elf_addr_size(elf) == 4 ? sizeof(Elf32_Rela) : sizeof(Elf64_Rela);
 }
 
+static inline bool is_reloc_sec(struct section *sec)
+{
+	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
