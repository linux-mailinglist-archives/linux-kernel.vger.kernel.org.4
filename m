Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF1656CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiL0QDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiL0QCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:49 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195FCF1A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:47 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156964;
        bh=y+8ND3SPE2pShaR1P8+M7kgXvRP1pJvPmxf10cM5y8Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B1CyNrKUwOFlrC/zgBHc9Up0AmSlWdkNnf/zucgJzpvF9KscVOFZm+v5sv8KqNX8+
         zJDIt/c/lFIz2XKLHYcnLcL0CipdrSUrrdz3v4OKojwRNd4PXb0emo6oWcB34vAlre
         +x/sKyBaX97HIJX6tO5KNXs8LtnVCgIld5bTNL1o=
Date:   Tue, 27 Dec 2022 16:00:59 +0000
Subject: [PATCH v2 3/8] objtool: allocate multiple structures with calloc()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-3-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=3464;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y+8ND3SPE2pShaR1P8+M7kgXvRP1pJvPmxf10cM5y8Q=;
 b=bm0NcSswg7oFUqzRMCfQCFgtM2ia9e0hYr/UJH2Ja8VEhCPmcRWUO4dZSpBYyAgPY3kP2q/Xxvf8
 FkDHETPnD/lDwkqgNbWghVPYCVeObcNKKSO8u0USlUOGuitMyCGH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using calloc() instead of malloc() in a loop, libc does not have to
keep around bookkeeping information for each single structure.

This reduces maximum memory usage while processing vmlinux.o from
3153325 KB to 3035668 KB (-3.7%) on my notebooks "localmodconfig".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/elf.c                 | 42 ++++++++++++++++++-------------------
 tools/objtool/include/objtool/elf.h |  4 ++++
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7eae95f33a72..9c326efb8cd9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -285,13 +285,13 @@ static int read_sections(struct elf *elf)
 	    !elf_alloc_hash(section_name, sections_nr))
 		return -1;
 
+	elf->section_data = calloc(sections_nr, sizeof(*sec));
+	if (!elf->section_data) {
+		perror("calloc");
+		return -1;
+	}
 	for (i = 0; i < sections_nr; i++) {
-		sec = malloc(sizeof(*sec));
-		if (!sec) {
-			perror("malloc");
-			return -1;
-		}
-		memset(sec, 0, sizeof(*sec));
+		sec = &elf->section_data[i];
 
 		INIT_LIST_HEAD(&sec->symbol_list);
 		INIT_LIST_HEAD(&sec->reloc_list);
@@ -423,13 +423,13 @@ static int read_symbols(struct elf *elf)
 	    !elf_alloc_hash(symbol_name, symbols_nr))
 		return -1;
 
+	elf->symbol_data = calloc(symbols_nr, sizeof(*sym));
+	if (!elf->symbol_data) {
+		perror("calloc");
+		return -1;
+	}
 	for (i = 0; i < symbols_nr; i++) {
-		sym = malloc(sizeof(*sym));
-		if (!sym) {
-			perror("malloc");
-			return -1;
-		}
-		memset(sym, 0, sizeof(*sym));
+		sym = &elf->symbol_data[i];
 
 		sym->idx = i;
 
@@ -919,13 +919,13 @@ static int read_relocs(struct elf *elf)
 		sec->base->reloc = sec;
 
 		nr_reloc = 0;
+		sec->reloc_data = calloc(sec->sh.sh_size / sec->sh.sh_entsize, sizeof(*reloc));
+		if (!sec->reloc_data) {
+			perror("calloc");
+			return -1;
+		}
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
-			reloc = malloc(sizeof(*reloc));
-			if (!reloc) {
-				perror("malloc");
-				return -1;
-			}
-			memset(reloc, 0, sizeof(*reloc));
+			reloc = &sec->reloc_data[i];
 			switch (sec->sh.sh_type) {
 			case SHT_REL:
 				if (read_rel_reloc(sec, i, reloc, &symndx))
@@ -1458,16 +1458,16 @@ void elf_close(struct elf *elf)
 		list_for_each_entry_safe(sym, tmpsym, &sec->symbol_list, list) {
 			list_del(&sym->list);
 			hash_del(&sym->hash);
-			free(sym);
 		}
 		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
 			list_del(&reloc->list);
 			hash_del(&reloc->hash);
-			free(reloc);
 		}
 		list_del(&sec->list);
-		free(sec);
+		free(sec->reloc_data);
 	}
 
+	free(elf->symbol_data);
+	free(elf->section_data);
 	free(elf);
 }
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index bb60fd42b46f..1c90f0ac0d53 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,6 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	bool changed, text, rodata, noinstr, init, truncate;
+	struct reloc *reloc_data;
 };
 
 struct symbol {
@@ -104,6 +105,9 @@ struct elf {
 	struct hlist_head *section_hash;
 	struct hlist_head *section_name_hash;
 	struct hlist_head *reloc_hash;
+
+	struct section *section_data;
+	struct symbol *symbol_data;
 };
 
 #define OFFSET_STRIDE_BITS	4

-- 
2.39.0
