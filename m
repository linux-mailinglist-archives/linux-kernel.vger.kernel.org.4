Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961DD6E6E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjDRV2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjDRV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F31026E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D6D612AE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE361C4339B;
        Tue, 18 Apr 2023 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853281;
        bh=ij85bIvlI0ug5hahPrm5CUQ/Uj6pydt9FfFsLuqiE1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwW7odxeNgHigkMNNMw1f88aayUFzwCqtCcmWcCvr+ZBqnoaEexntOjXcgZD2PLf8
         VWilc8PbrS+97sWQ5yTo1qLWnrcjD3AKumLAPGjRsydINKg01qS5oUyqjxJiuTPLYN
         XMKEPDsMDzZTLXtgmKHfktMroK7xaAtrSOuBEYwUTkDVRhu5ln+OfoeGoCe94YIzVq
         ycgik4QUrMA6gXCr/X/8UvIQrw25D4gYdd1uThwXmtl+iNXz1j9VJ9dg7Mjj8yDIoi
         Xozdhxx3k2/QJqQS+tgYJUqEiR6LJdHueN3e0ZV5KlyYIVpvyzjbiVgzfFmkm+K33H
         pqKiNjWgQgZNQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 5/8] objtool: Ignore exc_double_fault() __noreturn warnings
Date:   Tue, 18 Apr 2023 14:27:51 -0700
Message-Id: <a45b085071d3a7d049a20f9e78754452336ecbe8.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index dd10128ab013..1cace399d32a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4505,6 +4505,35 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
+static bool ignore_noreturn_call(struct instruction *insn)
+{
+	struct symbol *call_dest = insn_call_dest(insn);
+
+	/*
+	 * FIXME: hack, we need a real noreturn solution
+	 *
+	 * Problem is, exc_double_fault() may or may not return, depending on
+	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
+	 * to the kernel config.
+	 *
+	 * Other potential ways to fix it:
+	 *
+	 *   - have compiler communicate __noreturn functions somehow
+	 *   - remove CONFIG_X86_ESPFIX64
+	 *   - read the .config file
+	 *   - add a cmdline option
+	 *   - create a generic objtool annotation format (vs a bunch of custom
+	 *     formats) and annotate it
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
@@ -4521,7 +4550,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
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

