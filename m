Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B626C05A9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCSVgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCSVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133CA11676;
        Sun, 19 Mar 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8Q+rY3sEv8O/a1Hte6tCTS4ueqFBvl5vBQjw2THVgEs=; b=xx0XlBhQiPPXqsx0AbY+0td+J6
        UUCh/x/XSkabldPx6kMcolXsH9lJT4bbWRKKYJ5m6BAP3OjqG6i2ev8+m/npQA7M2sVZ2dSNNjaYE
        k2mYrJYMqeRVw2Y+YNiw5hBCiUMSBtoXXp4pe67ys1pGHk6bR4/i62mf8C3Vjn3B1aa/htmoX2FER
        w5FXR9AFjKyamKJeKlrozTyOyzffiiHmsz1Kzod9+FGwxPw+s19k/VFAm5dZkAxNUG4XM2GC0XIx3
        QTSxw8Dt5yPrqUzFiTRdIMuKSGPo2KnwxMJr8K0fkGgaG1oRGAr+lttmlxs14U0cfWqHRK5VwkHhs
        fq3GKRZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmr-1P;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 1/5] module: add sanity check for ELF module section
Date:   Sun, 19 Mar 2023 14:35:38 -0700
Message-Id: <20230319213542.1790479-2-mcgrof@kernel.org>
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

The ELF ".gnu.linkonce.this_module" section is special, it is what we
use to construct the struct module __this_module, which THIS_MODULE
points to. When userspace loads a module we always deal first with a
copy of the userspace buffer, and twiddle with the userspace copy's
version of the struct module. Eventually we allocate memory to do a
memcpy() of that struct module, under the assumption that the module
size is right. But we have no validity checks against the size or
the requirements for the section.

Add some validity checks for the special module section early and while
at it, cache the module section index early, so we don't have to do that
later.

While at it, just move over the assigment of the info->mod to make the
code clearer. The validity checker also adds an explicit size check to
ensure the module section size matches the kernel's run time size for
sizeof(struct module). This should prevent sloppy loads of modules
which are built today *without* actually increasing the size of
the struct module. A developer today can for example expand the size
of struct module, rebuild a directoroy 'make fs/xfs/' for example and
then try to insmode the driver there. That module would in effect have
an incorrect size. This new size check would put a stop gap against such
mistakes.

This also makes the entire goal of ".gnu.linkonce.this_module" pretty
clear. Before this patch verification of the goal / intent required some
Indian Jones whips, torches and cleaning up big old spider webs.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 62 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index cf097ffe6a4a..e1a9dd51c036 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2002 Richard Henderson
  * Copyright (C) 2001 Rusty Russell, 2002, 2010 Rusty Russell IBM.
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
  */
 
 #define INCLUDE_VERMAGIC
@@ -1656,6 +1657,7 @@ static int elf_validity_check(struct load_info *info)
 	unsigned int i;
 	Elf_Shdr *shdr, *strhdr;
 	int err;
+	unsigned int num_mod_secs = 0, mod_idx;
 
 	if (info->len < sizeof(*(info->hdr))) {
 		pr_err("Invalid ELF header len %lu\n", info->len);
@@ -1767,6 +1769,11 @@ static int elf_validity_check(struct load_info *info)
 					i, shdr->sh_type);
 				return err;
 			}
+			if (strcmp(info->secstrings + shdr->sh_name,
+				   ".gnu.linkonce.this_module") == 0) {
+				num_mod_secs++;
+				mod_idx = i;
+			}
 
 			if (shdr->sh_flags & SHF_ALLOC) {
 				if (shdr->sh_name >= strhdr->sh_size) {
@@ -1779,6 +1786,52 @@ static int elf_validity_check(struct load_info *info)
 		}
 	}
 
+	/*
+	 * The ".gnu.linkonce.this_module" ELF section is special. It is
+	 * what modpost uses to refer to __this_module and let's use rely
+	 * on THIS_MODULE to point to &__this_module properly. The kernel's
+	 * modpost declares it on each modules's *.mod.c file. If the struct
+	 * module of the kernel changes a full kernel rebuild is required.
+	 *
+	 * We have a few expectaions for this special section, the following
+	 * code validates all this for us:
+	 *
+	 *   o Only one section must exist
+	 *   o We expect the kernel to always have to allocate it: SHF_ALLOC
+	 *   o The section size must match the kernel's run time's struct module
+	 *     size
+	 */
+	if (num_mod_secs != 1) {
+		pr_err("Only one .gnu.linkonce.this_module section must exist.\n");
+		goto no_exec;
+	}
+
+	shdr = &info->sechdrs[mod_idx];
+
+	/*
+	 * This is already implied on the switch above, however let's be
+	 * pedantic about it.
+	 */
+	if (shdr->sh_type == SHT_NOBITS) {
+		pr_err(".gnu.linkonce.this_module section must have a size set\n");
+		goto no_exec;
+	}
+
+	if (!(shdr->sh_flags & SHF_ALLOC)) {
+		pr_err(".gnu.linkonce.this_module must occupy memory during process execution\n");
+		goto no_exec;
+	}
+
+	if (shdr->sh_size != sizeof(struct module)) {
+		pr_err(".gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n");
+		goto no_exec;
+	}
+
+	info->index.mod = mod_idx;
+
+	/* This is temporary: point mod into copy of data. */
+	info->mod = (void *)info->hdr + shdr->sh_offset;
+
 	return 0;
 
 no_exec:
@@ -1925,15 +1978,6 @@ static int setup_load_info(struct load_info *info, int flags)
 		return -ENOEXEC;
 	}
 
-	info->index.mod = find_sec(info, ".gnu.linkonce.this_module");
-	if (!info->index.mod) {
-		pr_warn("%s: No module found in object\n",
-			info->name ?: "(missing .modinfo section or name field)");
-		return -ENOEXEC;
-	}
-	/* This is temporary: point mod into copy of data. */
-	info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;
-
 	/*
 	 * If we didn't load the .modinfo 'name' field earlier, fall back to
 	 * on-disk struct mod 'name' field.
-- 
2.39.1

