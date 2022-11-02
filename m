Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA6615F85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKBJWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKBJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE6365A2;
        Wed,  2 Nov 2022 02:20:08 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCaIO1zUHpx41jxtR0vGc0NZJ7OQkBuM2m8u8UjxdHo=;
        b=PcYpkm+q3HRc7m19SblIX7HrOb2jKeWbrcVWUbi8vyzUGiGkrvqfDsXMf2bFRlYSsc2rDX
        kL8jjZmMpnBKpadO4on4DU88N42gvQROENwhO2ln1P0hhi+CuHOz6Si5XNLjnTlH6tVgZP
        aXJ+PHJL+Pqvgs5SUOvTa9uqv8aVVBPLHPMwGq/GEKi+SG+fncYtCkiIffZfvXZyUBwmvH
        KP6Y1yuTCqfOk0OeCjrdRNebmPmvMvlEDggpbRX8x3v9YDL8B4f5sqCk4k0rKC20ECQE6S
        +zAAq8ZToW0h5Basq1UkSdDUIzHVB+1w+1PYdet0ZsRavqGWrelf6m1rwImo8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCaIO1zUHpx41jxtR0vGc0NZJ7OQkBuM2m8u8UjxdHo=;
        b=8CPITZNFi+Dv+G261vs28vH2Ad4gjNmaiToIOG5lDsSnIe7SLAhYUoq7dV3tV1FmrKUHpa
        AIk45FDF0fvMGCCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Avoid O(bloody terrible) behaviour -- an ode
 to libelf
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yujie Liu <yujie.liu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028194453.461658986@infradead.org>
References: <20221028194453.461658986@infradead.org>
MIME-Version: 1.0
Message-ID: <166738080540.7716.10737738024182403591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     13f60e80e15dd0657c90bcca372ba045630ed9de
Gitweb:        https://git.kernel.org/tip/13f60e80e15dd0657c90bcca372ba045630ed9de
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Oct 2022 20:29:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:08 +01:00

objtool: Avoid O(bloody terrible) behaviour -- an ode to libelf

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
Tested-by: Yujie Liu <yujie.liu@intel.com>
Link: https://lkml.kernel.org/r/20221028194453.461658986@infradead.org
---
 tools/objtool/elf.c                 | 89 ++++++++++++++++++++++++++--
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3ad89d9..36dc787 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -634,6 +634,12 @@ static int elf_update_symbol(struct elf *elf, struct section *symtab,
 
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
@@ -647,28 +653,34 @@ static int elf_update_symbol(struct elf *elf, struct section *symtab,
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
@@ -770,6 +782,14 @@ non_local:
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
 
@@ -1286,6 +1306,60 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
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
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d285331..9e96a61 100644
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
