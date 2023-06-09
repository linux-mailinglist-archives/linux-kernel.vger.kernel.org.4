Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923967291A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFIHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjFIHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E530F5;
        Fri,  9 Jun 2023 00:47:40 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=706pUqJ1rxVQuZQlYVkYva1NebzBF1ueHcAL4F1w4kg=;
        b=215sTCQ5yYQdwnrjV9K5sqr5mwxgfpm4IZjge0cDksEfGbc2Z4PG5ZPcFfSxZ+i5fhZ7zI
        UxemA1uUMvuLaYlCzgc0IgpgeS4vNc1ORCO33SrHtnNfsge33+At4fMqo5IVHw7sPp+hh2
        HneFmBpNDSj8Eh/MmHIcZQQlgwBzmEYZt/AIGHQBTdifkXIAopRf7B0DTJOQQUjd6qnlo9
        DaHW9WP+bQ5viAO8Zdmu07sNxQZ/RwgmrmU2A4By0gbFgVZgISqL1pfX8qdLFEYXUrDQzV
        qjivYeaGovhgCY5yDbrOy+JzX7PsvESrbTg4cjaUSEwF4f3HT4hQZPNSQkodZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=706pUqJ1rxVQuZQlYVkYva1NebzBF1ueHcAL4F1w4kg=;
        b=PpGYaGTavtDzCm7x+v3ANT46XbkAkvDgE/7qxEhx4KUyNAXyPme/2uvWSr68EwXj35EW+A
        /J6drpHvggtJO9Bg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allocate relocs in advance for new rela sections
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5332d845c5a2d6c2d052075b381bfba8bcb67ed5.1685464332.git.jpoimboe@kernel.org>
References: <5332d845c5a2d6c2d052075b381bfba8bcb67ed5.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685285.404.18154288626119314332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e0a9349b4c590145c6a83e6c9f7701cec42debbd
Gitweb:        https://git.kernel.org/tip/e0a9349b4c590145c6a83e6c9f7701cec42debbd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:03 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:20 -07:00

objtool: Allocate relocs in advance for new rela sections

Similar to read_relocs(), allocate the reloc structs all together in an
array rather than allocating them one at a time.

Link: https://lore.kernel.org/r/5332d845c5a2d6c2d052075b381bfba8bcb67ed5.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8d53f18..5f69d45 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -814,7 +814,7 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 				    unsigned long offset, struct symbol *sym,
 				    s64 addend, unsigned int type)
 {
-	struct reloc *reloc;
+	struct reloc *reloc, empty = { 0 };
 
 	if (reloc_idx >= rsec->sh.sh_size / elf_rela_size(elf)) {
 		WARN("%s: bad reloc_idx %u for %s with size 0x%lx",
@@ -822,12 +822,13 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 		return NULL;
 	}
 
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
+	reloc = &rsec->reloc_data[reloc_idx];
+
+	if (memcmp(reloc, &empty, sizeof(empty))) {
+		WARN("%s: %s: reloc %d already initialized!",
+		     __func__, rsec->name, reloc_idx);
 		return NULL;
 	}
-	memset(reloc, 0, sizeof(*reloc));
 
 	reloc->idx = reloc_idx;
 	reloc->sec = rsec;
@@ -1185,6 +1186,13 @@ static struct section *elf_create_rela_section(struct elf *elf,
 	rsec->sh.sh_info = sec->idx;
 	rsec->sh.sh_flags = SHF_INFO_LINK;
 
+	rsec->reloc_data = calloc(rsec->sh.sh_size / rsec->sh.sh_entsize,
+				  sizeof(struct reloc));
+	if (!rsec->reloc_data) {
+		perror("calloc");
+		return NULL;
+	}
+
 	sec->rsec = rsec;
 	rsec->base = sec;
 
