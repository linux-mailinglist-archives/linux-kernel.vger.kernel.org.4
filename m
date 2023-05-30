Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC53716ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjE3RWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjE3RVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E84A3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE4063132
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64178C433A7;
        Tue, 30 May 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467296;
        bh=HlkIG7/lxu8Z5s71NR4vy/FPtwUZQJbUdoT7MnQ0tW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elaSImFIdZdrh5zUJAZbamkTBBWmB/G5gb4R5nDCe89iOK7EhU0qPE1Ww/bt0hAbW
         BOLYSm2+v4LE4r28TUhHad6gYSbWpxTS+xjTCJcsCd9bqOtdyh8Quo6O2UJQRi0zU7
         w2dkDzzkxPW4UJbUjml3HEYKs4lHsoQ3h0MK42pyDGzONhi4wjf+nixZ01lgKDWSRl
         eyOCI83b20wPauHlfpDlFSE2DsZyYISFT2GwTNwQO7OgvkuRco9Ult+WCMCukZnOYl
         kphyLS2RwJeRwO7GRd4DHcWWTO1mfdQJfyCbbo1y1JCAlcDXutbPnQ7ljPkUjyBWh1
         +HAthGrhF5lkg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 13/22] objtool: Get rid of reloc->idx
Date:   Tue, 30 May 2023 10:21:05 -0700
Message-Id: <7351d2ebad0519027db14a32f6204af84952574a.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the array offset to calculate the reloc index.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 45.56G
- After:  peak heap memory consumption: 43.83G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 |  6 ++----
 tools/objtool/include/objtool/elf.h | 10 +++++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 19ac53ad76ee..70c801254566 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -829,7 +829,6 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 		return NULL;
 	}
 
-	reloc->idx = reloc_idx;
 	reloc->sec = rsec;
 	reloc->offset = offset;
 	reloc->type = type;
@@ -954,7 +953,6 @@ static int read_relocs(struct elf *elf)
 				return -1;
 
 			reloc->sec = rsec;
-			reloc->idx = i;
 			symndx = GELF_R_SYM(reloc->rel.r_info);
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
@@ -1237,9 +1235,9 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 
 	if (rsec->sh.sh_type == SHT_RELA) {
 		reloc->rela.r_addend = reloc->addend;
-		ret = gelf_update_rela(rsec->data, reloc->idx, &reloc->rela);
+		ret = gelf_update_rela(rsec->data, reloc_idx(reloc), &reloc->rela);
 	} else {
-		ret = gelf_update_rel(rsec->data, reloc->idx, &reloc->rel);
+		ret = gelf_update_rel(rsec->data, reloc_idx(reloc), &reloc->rel);
 	}
 
 	if (!ret) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a09da208ddb8..2a14da633d56 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -76,9 +76,8 @@ struct reloc {
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
 	unsigned long offset;
-	unsigned int type;
 	s64 addend;
-	int idx;
+	unsigned int type;
 	bool jump_table_start;
 };
 
@@ -200,6 +199,11 @@ static inline unsigned int sec_num_entries(struct section *sec)
 	return sec->sh.sh_size / sec->sh.sh_entsize;
 }
 
+static inline unsigned int reloc_idx(struct reloc *reloc)
+{
+	return reloc - reloc->sec->relocs;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
@@ -219,7 +223,7 @@ static inline unsigned int sec_num_entries(struct section *sec)
 		     __i++, reloc++)
 
 #define for_each_reloc_from(rsec, reloc)				\
-	for (int __i = reloc->idx;					\
+	for (int __i = reloc_idx(reloc);				\
 	     __i < sec_num_entries(rsec);				\
 	     __i++, reloc++)
 
-- 
2.40.1

