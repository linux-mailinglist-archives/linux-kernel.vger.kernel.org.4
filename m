Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B36C05A2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCSVfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCSVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CC6584;
        Sun, 19 Mar 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8m8F125vs28BNQfwZCFnodLMrX3W0w1T4J8QWupY5ig=; b=GTtlsuGbgsuAp8vwH33WEU2s/U
        4y007i5AhtjQCDMMtVpRq/ANNqlTYRm/yBTZa2fHfP+0O6GR957zE8L6ey3wWPLxdqRQFzmlrGxtG
        KwOXw5mehMbNhyhAnDViSSCSVNfQMuuD1Jxd40ZzYorqEd+4WSrx8fCcM4MVpmU+UiBK3oUJTEKTF
        C9P8phKz1aHFKqBeYgDPbfQYJrBftrMxsoWNNPpySFQCbznQ8wXwu+v4y+IutVMqcnFTLFGKA6w6y
        wooGsJZOBEzoGC9NbtzupCQrRV4ugwEqHRLyYMdTOSo7Jd7qO5rX+Bx9o5L4oPhs0obg/nUtxl4+3
        34RDozdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmx-1k;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 4/5] module: merge remnants of setup_load_info() to elf validation
Date:   Sun, 19 Mar 2023 14:35:41 -0700
Message-Id: <20230319213542.1790479-5-mcgrof@kernel.org>
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

The setup_load_info() was actually had ELF validation checks of its
own. To later cache useful variables as an secondary step just means
looping again over the ELF sections we just validated. We can simply
keep tabs of the key sections of interest as we validate the module
ELF section in one swoop, so do that and merge the two routines
together.

Expand a bit on the documentation / intent / goals.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 60 ++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 84a7f96cf35a..929644d79d38 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1647,12 +1647,26 @@ static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 }
 
 /*
- * Sanity checks against invalid binaries, wrong arch, weird elf version.
+ * Check userspace passed ELF module against our expectations, and cache
+ * useful variables for further processing as we go.
  *
- * Also do basic validity checks against section offsets and sizes, the
+ * This does basic validity checks against section offsets and sizes, the
  * section name string table, and the indices used for it (sh_name).
+ *
+ * As a last step, since we're already checking the ELF sections we cache
+ * useful variables which will be used later for our convenience:
+ *
+ * 	o pointers to section headers
+ * 	o cache the modinfo symbol section
+ * 	o cache the string symbol section
+ * 	o cache the module section
+ *
+ * As a last step we set info->mod to the temporary copy of the module in
+ * info->hdr. The final one will be allocated in move_module(). Any
+ * modifications we make to our copy of the module will be carried over
+ * to the final minted module.
  */
-static int elf_validity_check(struct load_info *info)
+static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	unsigned int i;
 	Elf_Shdr *shdr, *strhdr;
@@ -1872,6 +1886,13 @@ static int elf_validity_check(struct load_info *info)
 	if (!info->name)
 		info->name = info->mod->name;
 
+	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
+		info->index.vers = 0; /* Pretend no __versions section! */
+	else
+		info->index.vers = find_sec(info, "__versions");
+
+	info->index.pcpu = find_pcpusec(info);
+
 	return 0;
 
 no_exec:
@@ -1984,26 +2005,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 	return 0;
 }
 
-/*
- * Set up our basic convenience variables (pointers to section headers,
- * search for module section index etc), and do some basic section
- * verification.
- *
- * Set info->mod to the temporary copy of the module in info->hdr. The final one
- * will be allocated in move_module().
- */
-static int setup_load_info(struct load_info *info, int flags)
-{
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
-		info->index.vers = 0; /* Pretend no __versions section! */
-	else
-		info->index.vers = find_sec(info, "__versions");
-
-	info->index.pcpu = find_pcpusec(info);
-
-	return 0;
-}
-
 /*
  * These calls taint the kernel depending certain module circumstances */
 static void module_augment_kernel_taints(struct module *mod, struct load_info *info)
@@ -2809,17 +2810,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	/*
 	 * Do basic sanity checks against the ELF header and
-	 * sections.
-	 */
-	err = elf_validity_check(info);
-	if (err)
-		goto free_copy;
-
-	/*
-	 * Everything checks out, so set up the section info
-	 * in the info structure.
+	 * sections. Cache useful sections and set the
+	 * info->mod to the userspace passed struct module.
 	 */
-	err = setup_load_info(info, flags);
+	err = elf_validity_cache_copy(info, flags);
 	if (err)
 		goto free_copy;
 
-- 
2.39.1

