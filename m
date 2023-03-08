Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C906B0667
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCHLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCHLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23494D280;
        Wed,  8 Mar 2023 03:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B327561758;
        Wed,  8 Mar 2023 11:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F46C433A0;
        Wed,  8 Mar 2023 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276390;
        bh=ItNl/VUdFsdbRrM3FYDQwEWNJZg7o1tpHGJGDk3Q3uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuQdIWp3o2rCCF0WNC47R0nVaUQFAnWL/A5R99rxnkqvJBtyU0kfQxOwCLLHFjsZk
         bN9BYnebAVV2QRjWh8Fu/brb56KLp4LlrZDEwOGWU+z1TUS6AXOS30yO/tSIU4jfLp
         SjXYAr8wdzaIn21GDPOCvSWfpgudc6oImq/K1EdjsILTbPtsxTN5xEE+2y2U/eOLLL
         VQF3t9dIbPQdj3W5pSxdp5jmyUo2nNJPQsv63GQ4vyxGJLnMeSQ/c4wQ9DVtbtO9sU
         ZZ4xnmAEIu+E9EA+d0QdObBK5f55B7laDtW1SwT9Bb0FCht4F3Giq366viOoZ7WF+Z
         Qewp4S7u7uYBw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 7/8] scripts/kallsyms: decrease expand_symbol() / cleanup_symbol_name() calls
Date:   Wed,  8 Mar 2023 20:52:42 +0900
Message-Id: <20230308115243.82592-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308115243.82592-1-masahiroy@kernel.org>
References: <20230308115243.82592-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, expand_symbol() is called many times to get the uncompressed
symbol names for sorting, and also for adding comments.

With the output order shuffled in the previous commit, the symbol data
are now written in the following order:

 (1) kallsyms_num_syms
 (2) kallsyms_names                         <-- need compressed names
 (3) kallsyms_markers
 (4) kallsyms_token_table
 (5) kallsyms_token_index
 (6) kallsyms_addressed / kallsyms_offsets  <-- need uncompressed names (for commenting)
 (7) kallsyms_relative_base
 (8) kallsyms_seq_of_names                  <-- need uncompressed names (for sorting)

The compressed names are only needed by (2).

Call expand_symbol() between (2) and (3) to restore the original symbol
names. This requires just one expand_symbol() call for each symbol.

Call cleanup_symbol_name() between (7) and (8) instead of during sorting.
It is allowed to overwrite the ->sym field because (8) just outputs the
index instead of the name of each symbol. Again, this requires just one
cleanup_symbol_name() call for each symbol.

This refactoring makes it ~30% faster.

[Before]

  $ time scripts/kallsyms --all-symbols --absolute-percpu --base-relative \
    .tmp_vmlinux.kallsyms2.syms >/dev/null

  real    0m1.027s
  user    0m1.010s
  sys     0m0.016s

  $ time scripts/kallsyms --all-symbols --absolute-percpu --base-relative \
    .tmp_vmlinux.kallsyms2.syms >/dev/null

  real    0m0.717s
  user    0m0.717s
  sys     0m0.000s

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 5996f1e61bcf..937900823fa8 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -335,19 +335,10 @@ static int symbol_absolute(const struct sym_entry *s)
 	return s->percpu_absolute;
 }
 
-static char * s_name(char *buf)
-{
-	/* Skip the symbol type */
-	return buf + 1;
-}
-
 static void cleanup_symbol_name(char *s)
 {
 	char *p;
 
-	if (!lto_clang)
-		return;
-
 	/*
 	 * ASCII[.]   = 2e
 	 * ASCII[0-9] = 30,39
@@ -366,16 +357,10 @@ static void cleanup_symbol_name(char *s)
 static int compare_names(const void *a, const void *b)
 {
 	int ret;
-	char sa_namebuf[KSYM_NAME_LEN];
-	char sb_namebuf[KSYM_NAME_LEN];
 	const struct sym_entry *sa = *(const struct sym_entry **)a;
 	const struct sym_entry *sb = *(const struct sym_entry **)b;
 
-	expand_symbol(sa->sym, sa->len, sa_namebuf);
-	expand_symbol(sb->sym, sb->len, sb_namebuf);
-	cleanup_symbol_name(s_name(sa_namebuf));
-	cleanup_symbol_name(s_name(sb_namebuf));
-	ret = strcmp(s_name(sa_namebuf), s_name(sb_namebuf));
+	ret = strcmp(sym_name(sa), sym_name(sb));
 	if (!ret) {
 		if (sa->addr > sb->addr)
 			return 1;
@@ -464,6 +449,15 @@ static void write_src(void)
 	}
 	printf("\n");
 
+	/*
+	 * Now that we wrote out the compressed symbol names, restore the
+	 * original names, which are needed in some of the later steps.
+	 */
+	for (i = 0; i < table_cnt; i++) {
+		expand_symbol(table[i]->sym, table[i]->len, buf);
+		strcpy((char *)table[i]->sym, buf);
+	}
+
 	output_label("kallsyms_markers");
 	for (i = 0; i < ((table_cnt + 255) >> 8); i++)
 		printf("\t.long\t%u\n", markers[i]);
@@ -520,8 +514,7 @@ static void write_src(void)
 					table[i]->addr);
 				exit(EXIT_FAILURE);
 			}
-			expand_symbol(table[i]->sym, table[i]->len, buf);
-			printf("\t.long\t%#x	/* %s */\n", (int)offset, buf);
+			printf("\t.long\t%#x	/* %s */\n", (int)offset, table[i]->sym);
 		} else if (!symbol_absolute(table[i])) {
 			output_address(table[i]->addr);
 		} else {
@@ -536,6 +529,10 @@ static void write_src(void)
 		printf("\n");
 	}
 
+	if (lto_clang)
+		for (i = 0; i < table_cnt; i++)
+			cleanup_symbol_name((char *)table[i]->sym);
+
 	sort_symbols_by_name();
 	output_label("kallsyms_seqs_of_names");
 	for (i = 0; i < table_cnt; i++)
-- 
2.34.1

