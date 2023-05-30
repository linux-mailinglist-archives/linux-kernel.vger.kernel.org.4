Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99345716AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjE3RWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjE3RVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D1F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77EEF63104
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B477DC4339E;
        Tue, 30 May 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467295;
        bh=5bKLUxUNwXL7zbFSdm1bk4h9wh+okZrHItfELV5Rer8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDI8gjeyCx8VJZPs5/Q+PYBmp/xKv0tWOcR7wXGh52Nysw5W4vbK87wbGXynvcBV0
         L+xaZ2Jz/MogFnOZ/fkKdm/BnHPFkYTiz4OarWEswn/W9C4RGOlf5AVpDv/Sgw8hRn
         J67seHDmXbTJPpjmx1g5nFzVytRSrgB5iQTNsz7Trtcz7s4OKHA24AeaMW1kU665+J
         ltZSMJMbsEGwceccQ7donK1Yir8UNleyR1Jz28hjmr8hto0W2JqzrVxQxcLAhByqXK
         f01AOv8QIi5t03mrjbNodPmY1XQ785vNu+SEQtpq+kAJ03KUZ7cwK4KMbJ7RXUah63
         y+m0jEUmFzTgw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 11/22] objtool: Allocate relocs in advance for new rela sections
Date:   Tue, 30 May 2023 10:21:03 -0700
Message-Id: <5332d845c5a2d6c2d052075b381bfba8bcb67ed5.1685464332.git.jpoimboe@kernel.org>
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

Similar to read_relocs(), allocate the reloc structs all together in an
array rather than allocating them one at a time.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8d53f18a9502..5f69d4590117 100644
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
 
-- 
2.40.1

