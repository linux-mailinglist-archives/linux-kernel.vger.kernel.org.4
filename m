Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1C716AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjE3RVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjE3RVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1997A3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410BB6311B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0BAC433D2;
        Tue, 30 May 2023 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467293;
        bh=hMoGya2geNmJobaVb9+9In1Lii1AlJYW6XIs+9NEqCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWphnRNt3nJjnSbOZRPLqIQ5DMRcjM9EADpoiahmDgdMD79fu5kXF6efQ9JmQ5Fyk
         bq8GfakE0FRygnybJ9tVrtBUXGMKkmEANROD7QeQRWaTYKKf0E6y8EuS80IFtzmcvp
         oxr0JyJK4OcbNSKBtuXkMVn7UslSJSiFU6LzHdGmjDL7lBaj5BbC3IyKCmCEy/ddzz
         XYHpSsud1rwi9cTKeV4r826dR4v3PDuPyKWsUI72qEVSwvHOItFdJAX9gWUK1VDOAP
         Y+skuOmN5h7gU9He8FY8gGgSA2TgfZ4GRqUlktQhOiURbK9dAxq6UtxdDlyW9Vhk8D
         xJX39TcyvhwmQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 05/22] objtool: Fix reloc_hash size
Date:   Tue, 30 May 2023 10:20:57 -0700
Message-Id: <38ef60dc8043270bf3b9dfd139ae2a30ca3f75cc.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DEBUG_INFO, DWARF creates a lot of relocations and
reloc_hash is woefully undersized, which can affect performance
significantly.  Fix that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 16 +++++++---------
 tools/objtool/include/objtool/elf.h |  8 +++++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4bbdd8e6df2c..f72ec6d8fb14 100644
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
index 6f82f2515d6b..b81d78b35126 100644
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
 
-- 
2.40.1

