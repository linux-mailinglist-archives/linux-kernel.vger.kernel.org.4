Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468BF68A96F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjBDKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjBDKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B356D07D;
        Sat,  4 Feb 2023 02:17:14 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHbXMBa5LGbiG1r2ra+O5gRvBCMVagNfjwwVpOPmy1Q=;
        b=G7sKpIrgCCAfSa5Y2n7ZW5iD2CbC4Cj+L2ZZ3xYtmYK75IhKg7epDbbdwqt2DtEOb2XMMg
        91gzsgsJAYPZzfmniRJLBDprGH+aHodUUjSQ8wIn7AhUXw1dG3T/+LsUhvPOoMJ+jH9IgS
        8UW1XXjtUVBwqcKfQwDdsBhse5bHZ9cTgVJyqzzxQASeKTtnHdRgLDQagfw0QGt8aK2KhD
        DzdlMW/Mp+XqC3PudaYDTqrGKf+TtlNor7zSN4wiCqpRFJp28PYACICLApaV1nQLYaNoxo
        ca41JxDzSQicxE8I6dqcyhcUQwl0VhRy/atRzzoRD73cV+Tx9OzoMzKUaFJOfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHbXMBa5LGbiG1r2ra+O5gRvBCMVagNfjwwVpOPmy1Q=;
        b=IjbVx5r+ekK+bcud8mdKervXhlhc/xWZlmVkaTsErthMQwCiOBvhtmcecZ1MFtL/NLhNMk
        urcejpnDkaQrLPBA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allocate multiple structures with calloc()
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-3-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-3-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167550583173.4906.15229152758172943490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8045b8f0b17edf375849f83c80dd05194850b6ed
Gitweb:        https://git.kernel.org/tip/8045b8f0b17edf375849f83c80dd0519485=
0b6ed
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:00:59=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 01 Feb 2023 09:15:23 -08:00

objtool: Allocate multiple structures with calloc()

By using calloc() instead of malloc() in a loop, libc does not have to
keep around bookkeeping information for each single structure.

This reduces maximum memory usage while processing vmlinux.o from
3153325 KB to 3035668 KB (-3.7%) on my notebooks "localmodconfig".

Note this introduces memory leaks, because some additional structs get
added to the lists later after reading the symbols and sections from the
original object.  Luckily we don't really care about memory leaks in
objtool.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-3-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 42 ++++++++++++++--------------
 tools/objtool/include/objtool/elf.h |  4 +++-
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 64443a7..6806ce0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -284,13 +284,13 @@ static int read_sections(struct elf *elf)
 	    !elf_alloc_hash(section_name, sections_nr))
 		return -1;
=20
+	elf->section_data =3D calloc(sections_nr, sizeof(*sec));
+	if (!elf->section_data) {
+		perror("calloc");
+		return -1;
+	}
 	for (i =3D 0; i < sections_nr; i++) {
-		sec =3D malloc(sizeof(*sec));
-		if (!sec) {
-			perror("malloc");
-			return -1;
-		}
-		memset(sec, 0, sizeof(*sec));
+		sec =3D &elf->section_data[i];
=20
 		INIT_LIST_HEAD(&sec->symbol_list);
 		INIT_LIST_HEAD(&sec->reloc_list);
@@ -422,13 +422,13 @@ static int read_symbols(struct elf *elf)
 	    !elf_alloc_hash(symbol_name, symbols_nr))
 		return -1;
=20
+	elf->symbol_data =3D calloc(symbols_nr, sizeof(*sym));
+	if (!elf->symbol_data) {
+		perror("calloc");
+		return -1;
+	}
 	for (i =3D 0; i < symbols_nr; i++) {
-		sym =3D malloc(sizeof(*sym));
-		if (!sym) {
-			perror("malloc");
-			return -1;
-		}
-		memset(sym, 0, sizeof(*sym));
+		sym =3D &elf->symbol_data[i];
=20
 		sym->idx =3D i;
=20
@@ -918,13 +918,13 @@ static int read_relocs(struct elf *elf)
 		sec->base->reloc =3D sec;
=20
 		nr_reloc =3D 0;
+		sec->reloc_data =3D calloc(sec->sh.sh_size / sec->sh.sh_entsize, sizeof(*r=
eloc));
+		if (!sec->reloc_data) {
+			perror("calloc");
+			return -1;
+		}
 		for (i =3D 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
-			reloc =3D malloc(sizeof(*reloc));
-			if (!reloc) {
-				perror("malloc");
-				return -1;
-			}
-			memset(reloc, 0, sizeof(*reloc));
+			reloc =3D &sec->reloc_data[i];
 			switch (sec->sh.sh_type) {
 			case SHT_REL:
 				if (read_rel_reloc(sec, i, reloc, &symndx))
@@ -1453,16 +1453,16 @@ void elf_close(struct elf *elf)
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
=20
+	free(elf->symbol_data);
+	free(elf->section_data);
 	free(elf);
 }
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index bb60fd4..1c90f0a 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,6 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	bool changed, text, rodata, noinstr, init, truncate;
+	struct reloc *reloc_data;
 };
=20
 struct symbol {
@@ -104,6 +105,9 @@ struct elf {
 	struct hlist_head *section_hash;
 	struct hlist_head *section_name_hash;
 	struct hlist_head *reloc_hash;
+
+	struct section *section_data;
+	struct symbol *symbol_data;
 };
=20
 #define OFFSET_STRIDE_BITS	4
