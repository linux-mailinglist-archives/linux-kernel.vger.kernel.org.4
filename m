Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1674EFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjGKNIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGKNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE4E4F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC765614CD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8BAC433C8;
        Tue, 11 Jul 2023 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689080924;
        bh=QNUVKJXnoZSUVP2Eq6Ceyt+qtwl6KbgMvYZ6bIQgM18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C04HhYVc8+putRViF/blzDQorcqlJp+TzjaE8DP3/7WfNIsss1zpO4ZzPcaxzK/ES
         +pMNCbzp8A1+JLlJJEGzXyYo5tnBmtQsDEAjSYWwU14ELLL15eS8NQw+/SgzFz0aKP
         5R2M01ThIBXh2jnUQaBGHmFS8tnsS9kfM94fK0iAy2F6H/IPTr6pGJxgOoxSzpQosd
         MJnDcqvxKNo1Dj5ZzkUJkubVYqkN6Bil381ee+L9D4HqQnYC/mV8G+UNIGWQZmJWrx
         iGbrc89PzwQY2Dq0uI5lSg77b1+B6aHnM9z1tANEQF/MjHrhbC85d3Q7F1k1G0NZV3
         c7MaXU1umlJyA==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     palmer@dabbelt.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, brauner@kernel.org,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2 1/2] binfmt_elf_fdpic: support 64-bit systems
Date:   Tue, 11 Jul 2023 23:07:53 +1000
Message-Id: <20230711130754.481209-2-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711130754.481209-1-gerg@kernel.org>
References: <20230711130754.481209-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binfmt_flat_fdpic code has a number of 32-bit specific data
structures associated with it. Extend it to be able to support and
be used on 64-bit systems as well.

The new code defines a number of key 64-bit variants of the core
elf-fdpic data structures - along side the existing 32-bit sized ones.
A common set of generic named structures are defined to be either
the 32-bit or 64-bit ones as required at compile time. This is a
similar technique to that used in the ELF binfmt loader.

For example:

  elf_fdpic_loadseg is either elf32_fdpic_loadseg or elf64_fdpic_loadseg
  elf_fdpic_loadmap is either elf32_fdpic_loadmap or elf64_fdpic_loadmap

the choice based on ELFCLASS32 or ELFCLASS64.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
v1->v2: rebase onto linux-6.5-rc1

 fs/binfmt_elf_fdpic.c          | 38 +++++++++++++++++-----------------
 include/linux/elf-fdpic.h      | 14 ++++++++++++-
 include/uapi/linux/elf-fdpic.h | 15 ++++++++++++++
 3 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1c6c5832af86..43b2a2851ba3 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -138,7 +138,7 @@ static int is_constdisp(struct elfhdr *hdr)
 static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 				 struct file *file)
 {
-	struct elf32_phdr *phdr;
+	struct elf_phdr *phdr;
 	unsigned long size;
 	int retval, loop;
 	loff_t pos = params->hdr.e_phoff;
@@ -560,8 +560,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	sp &= ~7UL;
 
 	/* stack the load map(s) */
-	len = sizeof(struct elf32_fdpic_loadmap);
-	len += sizeof(struct elf32_fdpic_loadseg) * exec_params->loadmap->nsegs;
+	len = sizeof(struct elf_fdpic_loadmap);
+	len += sizeof(struct elf_fdpic_loadseg) * exec_params->loadmap->nsegs;
 	sp = (sp - len) & ~7UL;
 	exec_params->map_addr = sp;
 
@@ -571,8 +571,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	current->mm->context.exec_fdpic_loadmap = (unsigned long) sp;
 
 	if (interp_params->loadmap) {
-		len = sizeof(struct elf32_fdpic_loadmap);
-		len += sizeof(struct elf32_fdpic_loadseg) *
+		len = sizeof(struct elf_fdpic_loadmap);
+		len += sizeof(struct elf_fdpic_loadseg) *
 			interp_params->loadmap->nsegs;
 		sp = (sp - len) & ~7UL;
 		interp_params->map_addr = sp;
@@ -740,13 +740,13 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 			      struct mm_struct *mm,
 			      const char *what)
 {
-	struct elf32_fdpic_loadmap *loadmap;
+	struct elf_fdpic_loadmap *loadmap;
 #ifdef CONFIG_MMU
-	struct elf32_fdpic_loadseg *mseg;
+	struct elf_fdpic_loadseg *mseg;
 	unsigned long load_addr;
 #endif
-	struct elf32_fdpic_loadseg *seg;
-	struct elf32_phdr *phdr;
+	struct elf_fdpic_loadseg *seg;
+	struct elf_phdr *phdr;
 	unsigned nloads, tmp;
 	unsigned long stop;
 	int loop, ret;
@@ -766,7 +766,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 
 	params->loadmap = loadmap;
 
-	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
+	loadmap->version = ELF_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
 
 	/* map the requested LOADs into the memory space */
@@ -839,8 +839,8 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 			if (phdr->p_vaddr >= seg->p_vaddr &&
 			    phdr->p_vaddr + phdr->p_memsz <=
 			    seg->p_vaddr + seg->p_memsz) {
-				Elf32_Dyn __user *dyn;
-				Elf32_Sword d_tag;
+				Elf_Dyn __user *dyn;
+				Elf_Sword d_tag;
 
 				params->dynamic_addr =
 					(phdr->p_vaddr - seg->p_vaddr) +
@@ -850,11 +850,11 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 				 * one item, and that the last item is a NULL
 				 * entry */
 				if (phdr->p_memsz == 0 ||
-				    phdr->p_memsz % sizeof(Elf32_Dyn) != 0)
+				    phdr->p_memsz % sizeof(Elf_Dyn) != 0)
 					goto dynamic_error;
 
-				tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
-				dyn = (Elf32_Dyn __user *)params->dynamic_addr;
+				tmp = phdr->p_memsz / sizeof(Elf_Dyn);
+				dyn = (Elf_Dyn __user *)params->dynamic_addr;
 				if (get_user(d_tag, &dyn[tmp - 1].d_tag) ||
 				    d_tag != 0)
 					goto dynamic_error;
@@ -923,8 +923,8 @@ static int elf_fdpic_map_file_constdisp_on_uclinux(
 	struct file *file,
 	struct mm_struct *mm)
 {
-	struct elf32_fdpic_loadseg *seg;
-	struct elf32_phdr *phdr;
+	struct elf_fdpic_loadseg *seg;
+	struct elf_phdr *phdr;
 	unsigned long load_addr, base = ULONG_MAX, top = 0, maddr = 0;
 	int loop, ret;
 
@@ -1007,8 +1007,8 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 					     struct file *file,
 					     struct mm_struct *mm)
 {
-	struct elf32_fdpic_loadseg *seg;
-	struct elf32_phdr *phdr;
+	struct elf_fdpic_loadseg *seg;
+	struct elf_phdr *phdr;
 	unsigned long load_addr, delta_vaddr;
 	int loop, dvset;
 
diff --git a/include/linux/elf-fdpic.h b/include/linux/elf-fdpic.h
index 3bea95a1af53..e533f4513194 100644
--- a/include/linux/elf-fdpic.h
+++ b/include/linux/elf-fdpic.h
@@ -10,13 +10,25 @@
 
 #include <uapi/linux/elf-fdpic.h>
 
+#if ELF_CLASS == ELFCLASS32
+#define Elf_Sword			Elf32_Sword
+#define elf_fdpic_loadseg		elf32_fdpic_loadseg
+#define elf_fdpic_loadmap		elf32_fdpic_loadmap
+#define ELF_FDPIC_LOADMAP_VERSION	ELF32_FDPIC_LOADMAP_VERSION
+#else
+#define Elf_Sword			Elf64_Sxword
+#define elf_fdpic_loadmap		elf64_fdpic_loadmap
+#define elf_fdpic_loadseg		elf64_fdpic_loadseg
+#define ELF_FDPIC_LOADMAP_VERSION	ELF64_FDPIC_LOADMAP_VERSION
+#endif
+
 /*
  * binfmt binary parameters structure
  */
 struct elf_fdpic_params {
 	struct elfhdr			hdr;		/* ref copy of ELF header */
 	struct elf_phdr			*phdrs;		/* ref copy of PT_PHDR table */
-	struct elf32_fdpic_loadmap	*loadmap;	/* loadmap to be passed to userspace */
+	struct elf_fdpic_loadmap	*loadmap;	/* loadmap to be passed to userspace */
 	unsigned long			elfhdr_addr;	/* mapped ELF header user address */
 	unsigned long			ph_addr;	/* mapped PT_PHDR user address */
 	unsigned long			map_addr;	/* mapped loadmap user address */
diff --git a/include/uapi/linux/elf-fdpic.h b/include/uapi/linux/elf-fdpic.h
index 4fcc6cfebe18..ec23f0871129 100644
--- a/include/uapi/linux/elf-fdpic.h
+++ b/include/uapi/linux/elf-fdpic.h
@@ -32,4 +32,19 @@ struct elf32_fdpic_loadmap {
 
 #define ELF32_FDPIC_LOADMAP_VERSION	0x0000
 
+/* segment mappings for ELF FDPIC libraries/executables/interpreters */
+struct elf64_fdpic_loadseg {
+	Elf64_Addr	addr;		/* core address to which mapped */
+	Elf64_Addr	p_vaddr;	/* VMA recorded in file */
+	Elf64_Word	p_memsz;	/* allocation size recorded in file */
+};
+
+struct elf64_fdpic_loadmap {
+	Elf64_Half	version;	/* version of these structures, just in case... */
+	Elf64_Half	nsegs;		/* number of segments */
+	struct elf64_fdpic_loadseg segs[];
+};
+
+#define ELF64_FDPIC_LOADMAP_VERSION	0x0000
+
 #endif /* _UAPI_LINUX_ELF_FDPIC_H */
-- 
2.25.1

