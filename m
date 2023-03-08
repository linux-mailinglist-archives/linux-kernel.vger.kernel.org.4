Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3566B0665
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCHLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjCHLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08226CEB;
        Wed,  8 Mar 2023 03:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F056961655;
        Wed,  8 Mar 2023 11:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC4C433D2;
        Wed,  8 Mar 2023 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276387;
        bh=ZkVhJIkKT/UYTmS7WbDcXYK9TEkAwrVF1Ql4lmc2Mhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vsd5CVbV1PoPpTPc7I4dJkA9DptzliuNU/OO92MKuJkgXQjffDnCWDLTofFP4qc1o
         V12RE3UK1V3PmTMHZpHKs1VI17AA1u4Za+bA3Ykwbd/OztMLes/XAGGMWmK5109DSY
         oJmOIXFw6yV81jOMcf0AvLnyLLRV4sclBYrmELndDxoO9M5k1A/o7z82PUQbMIWHGd
         BH1gRujdy4fgNRWearLeF3WbAjX09Kp7AgstPy0Q+4UdhFbQNMrHfbBpucrJ8Iv1NU
         ucjgZQddu8Z98G7hHhVklDHlEMD2vB385s4/bLbQXeVv7E7/K+FOX8V5yPsolCnVZ4
         LZfS963zU9B5Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/8] scripts/kallsyms: change the output order
Date:   Wed,  8 Mar 2023 20:52:41 +0900
Message-Id: <20230308115243.82592-6-masahiroy@kernel.org>
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

Currently, this tool outputs symbol data in the following order.

 (1) kallsyms_addressed / kallsyms_offsets
 (2) kallsyms_relative_base
 (3) kallsyms_num_syms
 (4) kallsyms_names
 (5) kallsyms_markers
 (6) kallsyms_seq_of_names
 (7) kallsyms_token_table
 (8) kallsyms_token_index

This commit changes the order as follows:

 (1) kallsyms_num_syms
 (2) kallsyms_names
 (3) kallsyms_markers
 (4) kallsyms_token_table
 (5) kallsyms_token_index
 (6) kallsyms_addressed / kallsyms_offsets
 (7) kallsyms_relative_base
 (8) kallsyms_seq_of_names

The motivation is to decrease the number of function calls to
expand_symbol() and cleanup_symbol_name().

The compressed names are only required for writing 'kallsyms_names'.
If you do this first, we can restore the original symbol names.
You do not need to repeat the same operation over again.

The actual refactoring will happen in the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 118 ++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 97d514c0fc8f..5996f1e61bcf 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -412,56 +412,6 @@ static void write_src(void)
 
 	printf("\t.section .rodata, \"a\"\n");
 
-	if (!base_relative)
-		output_label("kallsyms_addresses");
-	else
-		output_label("kallsyms_offsets");
-
-	for (i = 0; i < table_cnt; i++) {
-		if (base_relative) {
-			/*
-			 * Use the offset relative to the lowest value
-			 * encountered of all relative symbols, and emit
-			 * non-relocatable fixed offsets that will be fixed
-			 * up at runtime.
-			 */
-
-			long long offset;
-			int overflow;
-
-			if (!absolute_percpu) {
-				offset = table[i]->addr - relative_base;
-				overflow = (offset < 0 || offset > UINT_MAX);
-			} else if (symbol_absolute(table[i])) {
-				offset = table[i]->addr;
-				overflow = (offset < 0 || offset > INT_MAX);
-			} else {
-				offset = relative_base - table[i]->addr - 1;
-				overflow = (offset < INT_MIN || offset >= 0);
-			}
-			if (overflow) {
-				fprintf(stderr, "kallsyms failure: "
-					"%s symbol value %#llx out of range in relative mode\n",
-					symbol_absolute(table[i]) ? "absolute" : "relative",
-					table[i]->addr);
-				exit(EXIT_FAILURE);
-			}
-			expand_symbol(table[i]->sym, table[i]->len, buf);
-			printf("\t.long\t%#x	/* %s */\n", (int)offset, buf);
-		} else if (!symbol_absolute(table[i])) {
-			output_address(table[i]->addr);
-		} else {
-			printf("\tPTR\t%#llx\n", table[i]->addr);
-		}
-	}
-	printf("\n");
-
-	if (base_relative) {
-		output_label("kallsyms_relative_base");
-		output_address(relative_base);
-		printf("\n");
-	}
-
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
@@ -521,15 +471,6 @@ static void write_src(void)
 
 	free(markers);
 
-	sort_symbols_by_name();
-	output_label("kallsyms_seqs_of_names");
-	for (i = 0; i < table_cnt; i++)
-		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\n",
-			(unsigned char)(table[i]->seq >> 16),
-			(unsigned char)(table[i]->seq >> 8),
-			(unsigned char)(table[i]->seq >> 0));
-	printf("\n");
-
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
@@ -544,6 +485,65 @@ static void write_src(void)
 	for (i = 0; i < 256; i++)
 		printf("\t.short\t%d\n", best_idx[i]);
 	printf("\n");
+
+	if (!base_relative)
+		output_label("kallsyms_addresses");
+	else
+		output_label("kallsyms_offsets");
+
+	for (i = 0; i < table_cnt; i++) {
+		if (base_relative) {
+			/*
+			 * Use the offset relative to the lowest value
+			 * encountered of all relative symbols, and emit
+			 * non-relocatable fixed offsets that will be fixed
+			 * up at runtime.
+			 */
+
+			long long offset;
+			int overflow;
+
+			if (!absolute_percpu) {
+				offset = table[i]->addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else if (symbol_absolute(table[i])) {
+				offset = table[i]->addr;
+				overflow = (offset < 0 || offset > INT_MAX);
+			} else {
+				offset = relative_base - table[i]->addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"%s symbol value %#llx out of range in relative mode\n",
+					symbol_absolute(table[i]) ? "absolute" : "relative",
+					table[i]->addr);
+				exit(EXIT_FAILURE);
+			}
+			expand_symbol(table[i]->sym, table[i]->len, buf);
+			printf("\t.long\t%#x	/* %s */\n", (int)offset, buf);
+		} else if (!symbol_absolute(table[i])) {
+			output_address(table[i]->addr);
+		} else {
+			printf("\tPTR\t%#llx\n", table[i]->addr);
+		}
+	}
+	printf("\n");
+
+	if (base_relative) {
+		output_label("kallsyms_relative_base");
+		output_address(relative_base);
+		printf("\n");
+	}
+
+	sort_symbols_by_name();
+	output_label("kallsyms_seqs_of_names");
+	for (i = 0; i < table_cnt; i++)
+		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\n",
+			(unsigned char)(table[i]->seq >> 16),
+			(unsigned char)(table[i]->seq >> 8),
+			(unsigned char)(table[i]->seq >> 0));
+	printf("\n");
 }
 
 
-- 
2.34.1

