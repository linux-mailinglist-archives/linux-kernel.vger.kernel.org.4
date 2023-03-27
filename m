Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3416CA9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjC0QBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjC0QBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3E46B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE2161372
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDADAC433AF;
        Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932857;
        bh=ouspNU+K1gyvLb2HKblJJmDAoAUT2VISUiIQf8ijcJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NP503enpxBHNNnrS7Xth/nqQzgMG8Q5fF3zn5DjpS4GO09w7OndJq7BQZaSkEHR9f
         pZaINcTY3qQQLFViJxpdupawo5yVMaEGetHFePzy2boiN0Kl79hOh1V6q1qbagGXdx
         kYPr1iAqTKWgSI42IXMUmUozTGvaarCM6kQHwdnr/5/rXuXZCDcUZtEO1VOWYKGOUg
         VCgeG27rugpUG0hrUj/lTn9HPJo9P95G96E7tINdDeirzHiC0GPljT2VyMJhaqq1xI
         tnC3eFYkoQXSWjlcGxow4K/XqCbbnCjHr+CcZ97LTreSFjFzn74AJuEI5O34BybXuj
         bRqRvea9cFs1A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/5] objtool: Add "missing __noreturn" warning
Date:   Mon, 27 Mar 2023 09:00:48 -0700
Message-Id: <4f22aa05702ca037630fa6c1f7fd54d13914a631.1679932620.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679932620.git.jpoimboe@kernel.org>
References: <cover.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most "unreachable instruction" warnings these days seem to actually be
the result of a missing __noreturn annotation.  Add an explicit check
for that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  7 +++++++
 tools/objtool/check.c                   | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index ec6f82fb414c..e04d16490c3b 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -423,6 +423,13 @@ the objtool maintainers.
    names and does not use module_init() / module_exit() macros to create
    them.
 
+13. file.o: warning: func(): missing __noreturn
+
+   Objtool has detected that the function doesn't return, but is missing
+   the __noreturn annotation.  NOTE: In addition to adding the
+   __noreturn annotation, the function name also needs to be added to
+   'global_noreturns' in tools/objtool/check.c.
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 67a684225702..1ed3024af2b1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4548,7 +4548,8 @@ static int validate_sls(struct objtool_file *file)
 
 static int validate_reachable_instructions(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *prev_insn;
+	struct symbol *call_dest;
 
 	if (file->ignore_unreachables)
 		return 0;
@@ -4561,8 +4562,19 @@ static int validate_reachable_instructions(struct objtool_file *file)
 			continue;
 		insn->sym->warned = 1;
 
+		prev_insn = prev_insn_same_sec(file, insn);
+		if (prev_insn)
+			call_dest = insn_call_dest(prev_insn);
+		if (prev_insn && prev_insn->dead_end && call_dest) {
+			if (call_dest->warned)
+				continue;
+			call_dest->warned = 1;
+
+			WARN("%s(): missing __noreturn", call_dest->name);
+			continue;
+		}
+
 		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
-		return 1;
 	}
 
 	return 0;
-- 
2.39.2

