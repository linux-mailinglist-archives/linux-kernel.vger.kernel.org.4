Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC87716AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjE3RW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjE3RVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E690F10A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66D063159
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F096C4331E;
        Tue, 30 May 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467299;
        bh=ecG2X1Qumz/2oCyr7RUA0LcooVSAeFFdy7NDRLMkRxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbpRFfjJGiYuUw11vsmHWm4yiGB4iJ1K4ATRPYtqMG6AdOc5+lo499YNfPtSyPnoZ
         eCIYc8roJZVEYSbuJ95Ogtej0Izo2Cz6fQr+2d7kq0A5+4zIXVOnSbbtc3zwrPbtls
         M/kSq8iAh5w53c7PnZjsVn6M4qt1hQAYSrB9Hb5NNqQjc5ktdGkL5bsnSvNvLsZoaV
         CopHxL/NpxmhSgLMcW0Lgyklnpbwp4pTNPbV7NjwHoS6O6ozckoge8Gnmv06glX6TN
         falLUWjvXcR+bE6VER0yfeosQWUEX64XE4SppA11c+gzzg05yyqJPUr73iR/RzCH9i
         zIxlR8MKOaYeQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 21/22] objtool: Free insns when done
Date:   Tue, 30 May 2023 10:21:13 -0700
Message-Id: <4d4bca1a0f869de020dac80d91f9acbf6df77eab.1685464332.git.jpoimboe@kernel.org>
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

Free the decoded instructions as they're no longer needed after this
point.  This frees up a big chunk of heap, which will come handy when
skipping the reading of DWARF section data.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 65c59b0b1e96..80d3a97e442b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4587,6 +4587,34 @@ static int disas_warned_funcs(struct objtool_file *file)
 	return 0;
 }
 
+struct insn_chunk {
+	void *addr;
+	struct insn_chunk *next;
+};
+
+/*
+ * Reduce peak RSS usage by freeing insns memory before writing the ELF file,
+ * which can trigger more allocations for .debug_* sections whose data hasn't
+ * been read yet.
+ */
+static void free_insns(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct insn_chunk *chunks = NULL, *chunk;
+
+	for_each_insn(file, insn) {
+		if (!insn->idx) {
+			chunk = malloc(sizeof(*chunk));
+			chunk->addr = insn;
+			chunk->next = chunks;
+			chunks = chunk;
+		}
+	}
+
+	for (chunk = chunks; chunk; chunk = chunk->next)
+		free(chunk->addr);
+}
+
 int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
@@ -4731,6 +4759,8 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	free_insns(file);
+
 	if (opts.verbose)
 		disas_warned_funcs(file);
 
-- 
2.40.1

