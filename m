Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26E656CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiL0QDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiL0QCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:49 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BAEF18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:46 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156964;
        bh=XawsrqdClQjkEya+uIP7vjQbb3ysRQ5lLFyEAtEK+X4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lINXVNrUUOk3hwcmjZnbQqmQK+nWm1BcT4cDJEsbYIIzLtmYmF/Pa46Qr/kz4ILKE
         aIMVVuWkMs85n8wybbHJLPIPfPqJEsNwLInKYqw77S5rV88v2eBaeTtg/42RC+aktE
         9Yv1W/0cepNMMrI8WYetZPG6WcPIEyVLUIggI8/s=
Date:   Tue, 27 Dec 2022 16:01:00 +0000
Subject: [PATCH v2 4/8] objtool: introduce function elf_reloc_set_type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-4-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=3243;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XawsrqdClQjkEya+uIP7vjQbb3ysRQ5lLFyEAtEK+X4=;
 b=gugRTtsJc0DvdnolPu6136JquZ3HSZXxFn9SkQmu8SbmeCtcWKkUYH2qz4tHTEEZRpry7agDfeVf
 xZvDrS44Czdh0zzmjTf9DxjCa0HgwUTq3S7H3iJUan4BcdvqDiOC
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

An upcoming patch needs to perform validation when setting reloc->type
so introduce a helper to contain this validation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/check.c               |  6 +++---
 tools/objtool/elf.c                 | 11 ++++++++---
 tools/objtool/include/objtool/elf.h |  2 ++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be739f4f..971ee6826de7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1355,7 +1355,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 */
 	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
-			reloc->type = R_NONE;
+			elf_reloc_set_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 
@@ -1384,7 +1384,7 @@ static void annotate_call_site(struct objtool_file *file,
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 		if (opts.mnop) {
 			if (reloc) {
-				reloc->type = R_NONE;
+				elf_reloc_set_type(reloc, R_NONE);
 				elf_write_reloc(file->elf, reloc);
 			}
 
@@ -1863,7 +1863,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
-			reloc->type = R_NONE;
+			elf_reloc_set_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 		elf_write_insn(file->elf, orig_insn->sec,
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 9c326efb8cd9..ee355beb0d82 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -555,7 +555,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 
 	reloc->sec = sec->reloc;
 	reloc->offset = offset;
-	reloc->type = type;
+	elf_reloc_set_type(reloc, type);
 	reloc->sym = sym;
 	reloc->addend = addend;
 
@@ -872,7 +872,7 @@ static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsig
 		WARN_ELF("gelf_getrel");
 		return -1;
 	}
-	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
+	elf_reloc_set_type(reloc, GELF_R_TYPE(reloc->rel.r_info));
 	reloc->addend = 0;
 	reloc->offset = reloc->rel.r_offset;
 	*symndx = GELF_R_SYM(reloc->rel.r_info);
@@ -885,7 +885,7 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 		WARN_ELF("gelf_getrela");
 		return -1;
 	}
-	reloc->type = GELF_R_TYPE(reloc->rela.r_info);
+	elf_reloc_set_type(reloc, GELF_R_TYPE(reloc->rela.r_info));
 	reloc->addend = reloc->rela.r_addend;
 	reloc->offset = reloc->rela.r_offset;
 	*symndx = GELF_R_SYM(reloc->rela.r_info);
@@ -1471,3 +1471,8 @@ void elf_close(struct elf *elf)
 	free(elf->section_data);
 	free(elf);
 }
+
+void elf_reloc_set_type(struct reloc *reloc, int type)
+{
+	reloc->type = type;
+}
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 1c90f0ac0d53..33ec6cf72325 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -83,6 +83,8 @@ struct reloc {
 	bool jump_table_start;
 };
 
+void elf_reloc_set_type(struct reloc *reloc, int type);
+
 #define ELF_HASH_BITS	20
 
 struct elf {

-- 
2.39.0
