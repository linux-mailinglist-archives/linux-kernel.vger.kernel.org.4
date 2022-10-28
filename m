Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9011611B20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJ1Tr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ1Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78069241B37
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3QcO6i1OADBJrO89uFWVOZLcBxalIqOKw3AE7W+Oknw=; b=unaldPb3HwjbCtO0iBmuGZTk6j
        juei5a08VijPiQrm129/7iCtv3PUdfkDT4r4emLHSA8PKltscoNN2VYUewY2eG/k0gbbTIvxyWXTK
        +pWLutlNYuznSLqIlz8sv6PdRv+++S9LYb2GUhA69JqylEY1OXW55EgSsX6ANz7hbW1u74qOGd4j3
        GmtIrPhP1EQhaV4HP64GxnKfZfU77aXsRB/qE1sS26zfagxhP87AHpKXfY/EqIaI5gJtHTT/0SaSi
        PCiL1A1q5QOfVoH73H6y1ihD8g1PZb/RqRIf3nxDvRQCYC5Hkr0WgG0pdoZizfWjdILDZiEJaCcvP
        EAs2VNLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKV-001V5p-VU; Fri, 28 Oct 2022 19:47:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B90B7300872;
        Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9F8672B9B03D1; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194453.461658986@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 3/5] objtool: Avoid O(bloody terrible) behaviour -- an ode to libelf
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to how gelf_update_sym*() requires an Elf_Data pointer, and how
libelf keeps Elf_Data in a linked list per section,
elf_update_symbol() ends up having to iterate this list on each
update to find the correct Elf_Data for the index'ed symbol.

By allocating one Elf_Data per new symbol, the list grows per new
symbol, giving an effective O(n^2) insertion time. This is obviously
bloody terrible.

Therefore over-allocate the Elf_Data when an extention is needed.
Except it turns out libelf disregards Elf_Scn::sh_size in favour of
the sum of Elf_Data::d_size. IOW it will happily write out all the
unused space and fill it with:

  0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND

entries (aka zeros). Which obviously violates the STB_LOCAL placement
rule, and is a general pain in the backside for not being the desired
behaviour.

Manually fix-up the Elf_Data size to avoid this problem before calling
elf_update().

This significantly improves performance when adding a significant
number of symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c                 |   89 +++++++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/elf.h |    2 
 2 files changed, 84 insertions(+), 7 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -634,6 +634,12 @@ static int elf_update_symbol(struct elf
 
 		/* end-of-list */
 		if (!symtab_data) {
+			/*
+			 * Over-allocate to avoid O(n^2) symbol creation
+			 * behaviour.  The down side is that libelf doesn't
+			 * like this; see elf_truncate_section() for the fixup.
+			 */
+			int num = max(1U, sym->idx/3);
 			void *buf;
 
 			if (idx) {
@@ -647,28 +653,34 @@ static int elf_update_symbol(struct elf
 			if (t)
 				shndx_data = elf_newdata(t);
 
-			buf = calloc(1, entsize);
+			buf = calloc(num, entsize);
 			if (!buf) {
 				WARN("malloc");
 				return -1;
 			}
 
 			symtab_data->d_buf = buf;
-			symtab_data->d_size = entsize;
+			symtab_data->d_size = num * entsize;
 			symtab_data->d_align = 1;
 			symtab_data->d_type = ELF_T_SYM;
 
-			symtab->sh.sh_size += entsize;
 			symtab->changed = true;
+			symtab->truncate = true;
 
 			if (t) {
-				shndx_data->d_buf = &sym->sec->idx;
-				shndx_data->d_size = sizeof(Elf32_Word);
+				buf = calloc(num, sizeof(Elf32_Word));
+				if (!buf) {
+					WARN("malloc");
+					return -1;
+				}
+
+				shndx_data->d_buf = buf;
+				shndx_data->d_size = num * sizeof(Elf32_Word);
 				shndx_data->d_align = sizeof(Elf32_Word);
 				shndx_data->d_type = ELF_T_WORD;
 
-				symtab_shndx->sh.sh_size += sizeof(Elf32_Word);
 				symtab_shndx->changed = true;
+				symtab_shndx->truncate = true;
 			}
 
 			break;
@@ -770,6 +782,14 @@ __elf_create_symbol(struct elf *elf, str
 		return NULL;
 	}
 
+	symtab->sh.sh_size += symtab->sh.sh_entsize;
+	symtab->changed = true;
+
+	if (symtab_shndx) {
+		symtab_shndx->sh.sh_size += sizeof(Elf32_Word);
+		symtab_shndx->changed = true;
+	}
+
 	return sym;
 }
 
@@ -1286,6 +1306,60 @@ int elf_write_reloc(struct elf *elf, str
 	return 0;
 }
 
+/*
+ * When Elf_Scn::sh_size is smaller than the combined Elf_Data::d_size
+ * do you:
+ *
+ *   A) adhere to the section header and truncate the data, or
+ *   B) ignore the section header and write out all the data you've got?
+ *
+ * Yes, libelf sucks and we need to manually truncate if we over-allocate data.
+ */
+static int elf_truncate_section(struct elf *elf, struct section *sec)
+{
+	u64 size = sec->sh.sh_size;
+	bool truncated = false;
+	Elf_Data *data = NULL;
+	Elf_Scn *s;
+
+	s = elf_getscn(elf->elf, sec->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	for (;;) {
+		/* get next data descriptor for the relevant section */
+		data = elf_getdata(s, data);
+
+		if (!data) {
+			if (size) {
+				WARN("end of section data but non-zero size left\n");
+				return -1;
+			}
+			return 0;
+		}
+
+		if (truncated) {
+			/* when we remove symbols */
+			WARN("truncated; but more data\n");
+			return -1;
+		}
+
+		if (!data->d_size) {
+			WARN("zero size data");
+			return -1;
+		}
+
+		if (data->d_size > size) {
+			truncated = true;
+			data->d_size = size;
+		}
+
+		size -= data->d_size;
+	}
+}
+
 int elf_write(struct elf *elf)
 {
 	struct section *sec;
@@ -1296,6 +1370,9 @@ int elf_write(struct elf *elf)
 
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
+		if (sec->truncate)
+			elf_truncate_section(elf, sec);
+
 		if (sec->changed) {
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr, init;
+	bool changed, text, rodata, noinstr, init, truncate;
 };
 
 struct symbol {


