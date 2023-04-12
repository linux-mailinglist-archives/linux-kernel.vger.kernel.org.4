Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BA6DFE52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDLTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDLTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F646B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140EA6387D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F03DC4339B;
        Wed, 12 Apr 2023 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326228;
        bh=h9r8KJRiCpRGToEG6UzamCIqwFgA/cCcBPojuYwWHP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGnrh85+l03ixoIvN+Boa5Wsmn1a2TRrdjOGzj9r1U9roeakZMS3e49+rtkhk8d0S
         W98FJK8H4zyqtSbS4F8UMeq8rO5A8pPOD+QZX/4VCSONkjab6sUPh04OB2hkBuVJjD
         F6wUHNNQtG6I1ip+cOQMZwiA5Kb+sdsGeNMQ+wRxiSC6mCVxltBaIRlA3c7WmYuq7m
         KFNqT6cZgPcDpwp7+epsiajuithymXLOa/1eujZFaqu8zqPNjnXUKoM6GACX+HCXZP
         IhoLQGnFVilG9RmYQ6RoVhcyT7IXDx17q4WWJVUimXZkd8XqlxPzaiI3EpjF/epPAD
         gqZDpC/Ct7vog==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 9/9] objtool: Ignore exc_double_fault() __noreturn warnings
Date:   Wed, 12 Apr 2023 12:03:24 -0700
Message-Id: <683214828d8b2ad732dab1a74e858087519d8c8b.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a hack, but it works for now.

Problem is, exc_double_fault() may or may not return, depending on
whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility to
the kernel config.

"Fix" it by silencing the exc_double_fault() __noreturn warning.

This removes the following warning:

  vmlinux.o: warning: objtool: xenpv_exc_double_fault+0xd: exc_double_fault() is missing a __noreturn annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 60f2d649f19f..7641e818db7d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4483,6 +4483,35 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
+static bool ignore_noreturn_call(struct instruction *insn)
+{
+	struct symbol *call_dest = insn_call_dest(insn);
+
+	/*
+	 * This is a hack, but it works for now.
+	 *
+	 * Problem is, exc_double_fault() may or may not return, depending on
+	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
+	 * to the kernel config.
+	 *
+	 * Other potential ways to fix it:
+	 *
+	 *   - remove CONFIG_X86_ESPFIX64
+	 *   - read the .config file
+	 *   - add a cmdline option
+	 *   - create a generic objtool annotation format (vs a bunch of custom
+	 *     formats) and annotate it
+	 *   - have compiler communicate __noreturn functions somehow
+	 */
+	if (!strcmp(call_dest->name, "exc_double_fault")) {
+		/* prevent further unreachable warnings for the caller */
+		insn->sym->warned = 1;
+		return true;
+	}
+
+	return false;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
@@ -4499,7 +4528,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		prev_insn = prev_insn_same_sec(file, insn);
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
-			if (call_dest) {
+			if (call_dest && !ignore_noreturn_call(prev_insn)) {
 				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
 					  call_dest->name);
 				warnings++;
-- 
2.39.2

