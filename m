Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6B6C05AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCSVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCSVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574B113F1;
        Sun, 19 Mar 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HF9NF/yBwymtSuL/hDrmdyOKiRi1h3O7H2O+TxiSARc=; b=ZQQBxuuR02y60vCB+7GBdnQXcX
        YdbX8jiMZJZuVMw7Rvoc5g1FkMgeWyy8JbIeN348nQo2UHbjPs0Y1Zyx5K7182GpJ5LXFvYHBWL2W
        3D/z8MZxcV6eTDd7Lct1y3nMwXGG+/RaKZeP1DbsZsOa7BxfjMS4Z+YveurMORBVdbh0lh1UPJK0m
        DK2LdFz3gPnrJ8zRyQmLf5VzouZqycTGLDQcWhg3WUgrAgjDUvy9UQeVL9mQWwVo8i98/WIbibUlh
        6xsvX9HmyX0vc/asrGqOWfG+OAKffnE1O4OrekexWRkcFlBsREWOut5cuuXDuaB7hoFvvCLrP2bFg
        K8vhEKcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmv-1d;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 3/5] module: move more elf validity checks to elf_validity_check()
Date:   Sun, 19 Mar 2023 14:35:40 -0700
Message-Id: <20230319213542.1790479-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319213542.1790479-1-mcgrof@kernel.org>
References: <20230319213542.1790479-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol and strings section validation currently happen in
setup_load_info() but since they are also doing validity checks
move this to elf_validity_check().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 79 ++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fbe62d1625bc..84a7f96cf35a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1658,6 +1658,8 @@ static int elf_validity_check(struct load_info *info)
 	Elf_Shdr *shdr, *strhdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
+	unsigned int num_info_secs = 0, info_idx;
+	unsigned int num_sym_secs = 0, sym_idx;
 
 	if (info->len < sizeof(*(info->hdr))) {
 		pr_err("Invalid ELF header len %lu\n", info->len);
@@ -1761,6 +1763,8 @@ static int elf_validity_check(struct load_info *info)
 				       info->hdr->e_shnum);
 				goto no_exec;
 			}
+			num_sym_secs++;
+			sym_idx = i;
 			fallthrough;
 		default:
 			err = validate_section_offset(info, shdr);
@@ -1773,6 +1777,10 @@ static int elf_validity_check(struct load_info *info)
 				   ".gnu.linkonce.this_module") == 0) {
 				num_mod_secs++;
 				mod_idx = i;
+			} else if (strcmp(info->secstrings + shdr->sh_name,
+				   ".modinfo") == 0) {
+				num_info_secs++;
+				info_idx = i;
 			}
 
 			if (shdr->sh_flags & SHF_ALLOC) {
@@ -1786,6 +1794,27 @@ static int elf_validity_check(struct load_info *info)
 		}
 	}
 
+	if (num_info_secs > 1) {
+		pr_err("Only one .modinfo section must exist.\n");
+		goto no_exec;
+	} else if (num_info_secs == 1) {
+		/* Try to find a name early so we can log errors with a module name */
+		info->index.info = info_idx;
+		info->name = get_modinfo(info, "name");
+	}
+
+	if (num_sym_secs != 1) {
+		pr_warn("%s: module has no symbols (stripped?)\n",
+			info->name ?: "(missing .modinfo section or name field)");
+		goto no_exec;
+	}
+
+	/* Sets internal symbols and strings. */
+	info->index.sym = sym_idx;
+	shdr = &info->sechdrs[sym_idx];
+	info->index.str = shdr->sh_link;
+	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
+
 	/*
 	 * The ".gnu.linkonce.this_module" ELF section is special. It is
 	 * what modpost uses to refer to __this_module and let's use rely
@@ -1802,7 +1831,8 @@ static int elf_validity_check(struct load_info *info)
 	 *     size
 	 */
 	if (num_mod_secs != 1) {
-		pr_err("Only one .gnu.linkonce.this_module section must exist.\n");
+		pr_err("module %s: Only one .gnu.linkonce.this_module section must exist.\n",
+		       info->name ?: "(missing .modinfo section or name field)");
 		goto no_exec;
 	}
 
@@ -1813,17 +1843,20 @@ static int elf_validity_check(struct load_info *info)
 	 * pedantic about it.
 	 */
 	if (shdr->sh_type == SHT_NOBITS) {
-		pr_err(".gnu.linkonce.this_module section must have a size set\n");
+		pr_err("module %s: .gnu.linkonce.this_module section must have a size set\n",
+		       info->name ?: "(missing .modinfo section or name field)");
 		goto no_exec;
 	}
 
 	if (!(shdr->sh_flags & SHF_ALLOC)) {
-		pr_err(".gnu.linkonce.this_module must occupy memory during process execution\n");
+		pr_err("module %s: .gnu.linkonce.this_module must occupy memory during process execution\n",
+		       info->name ?: "(missing .modinfo section or name field)");
 		goto no_exec;
 	}
 
 	if (shdr->sh_size != sizeof(struct module)) {
-		pr_err(".gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n");
+		pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
+		       info->name ?: "(missing .modinfo section or name field)");
 		goto no_exec;
 	}
 
@@ -1832,6 +1865,13 @@ static int elf_validity_check(struct load_info *info)
 	/* This is temporary: point mod into copy of data. */
 	info->mod = (void *)info->hdr + shdr->sh_offset;
 
+	/*
+	 * If we didn't load the .modinfo 'name' field earlier, fall back to
+	 * on-disk struct mod 'name' field.
+	 */
+	if (!info->name)
+		info->name = info->mod->name;
+
 	return 0;
 
 no_exec:
@@ -1954,37 +1994,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
  */
 static int setup_load_info(struct load_info *info, int flags)
 {
-	unsigned int i;
-
-	/* Try to find a name early so we can log errors with a module name */
-	info->index.info = find_sec(info, ".modinfo");
-	if (info->index.info)
-		info->name = get_modinfo(info, "name");
-
-	/* Find internal symbols and strings. */
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		if (info->sechdrs[i].sh_type == SHT_SYMTAB) {
-			info->index.sym = i;
-			info->index.str = info->sechdrs[i].sh_link;
-			info->strtab = (char *)info->hdr
-				+ info->sechdrs[info->index.str].sh_offset;
-			break;
-		}
-	}
-
-	if (info->index.sym == 0) {
-		pr_warn("%s: module has no symbols (stripped?)\n",
-			info->name ?: "(missing .modinfo section or name field)");
-		return -ENOEXEC;
-	}
-
-	/*
-	 * If we didn't load the .modinfo 'name' field earlier, fall back to
-	 * on-disk struct mod 'name' field.
-	 */
-	if (!info->name)
-		info->name = info->mod->name;
-
 	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
 		info->index.vers = 0; /* Pretend no __versions section! */
 	else
-- 
2.39.1

