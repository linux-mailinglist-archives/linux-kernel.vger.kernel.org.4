Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AF729194
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjFIHrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbjFIHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457201FDA;
        Fri,  9 Jun 2023 00:47:28 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNXHBPCYF47cb3Wbr5BaCCWRR55d58Xpn9SmgNd6fiA=;
        b=SbWxtzsIMr7AF2Svtllhg/Ln89/KhK3x1QHFpYZBAoLqFe7l8lAPC/G6RHRl/p/Y7Lw+y6
        w5as0Yeq+/9iMTQHEhQ9a6iAiuh3Z5+1D1mtdx+9XUFpBq2SLzOFyLzIIYS4DwjkJ/QECh
        ZShpVsaFO5e3ziuWG6dap8+rAPRuOuvP1+1e9lGQGMpeEZm6F1qGmKFTul858UFpmbBrbG
        JhUrfeJEhhuel4wmw+dzeL/Of4cuImaFFncZGsBd1asZ//q1kUtnsqzEoOfmtBP8pyU9FM
        RRpfoi/sDNTlHHb4qJmRi8SJx/LZ1zLudt28mV2b8HFX0BvNN7Tzg5gVBBw0mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNXHBPCYF47cb3Wbr5BaCCWRR55d58Xpn9SmgNd6fiA=;
        b=NobgaAD+H6mwSVdoX0EppAtqT6cK/r8NwekkO8DQukIj+EraRiMna3LoWkOyIYNRq3kVIM
        RPXqYy9X+s0TpKDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Free insns when done
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4d4bca1a0f869de020dac80d91f9acbf6df77eab.1685464332.git.jpoimboe@kernel.org>
References: <4d4bca1a0f869de020dac80d91f9acbf6df77eab.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684647.404.12216177036864165921.tip-bot2@tip-bot2>
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

Commit-ID:     d93b5935fd47007597aed5105a902a10204bc30e
Gitweb:        https://git.kernel.org/tip/d93b5935fd47007597aed5105a902a10204bc30e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:13 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:27 -07:00

objtool: Free insns when done

Free the decoded instructions as they're no longer needed after this
point.  This frees up a big chunk of heap, which will come handy when
skipping the reading of DWARF section data.

Link: https://lore.kernel.org/r/4d4bca1a0f869de020dac80d91f9acbf6df77eab.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 47ff130..8936a05 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4596,6 +4596,34 @@ static int disas_warned_funcs(struct objtool_file *file)
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
@@ -4742,6 +4770,8 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	free_insns(file);
+
 	if (opts.verbose)
 		disas_warned_funcs(file);
 
