Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57C707EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjERLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjERLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381F10EA;
        Thu, 18 May 2023 04:08:05 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOLKbqZ+WEyAA/7wcsnVMTanilWInv/gKVP1qd2MJ1c=;
        b=sXqCLz91X7I8seLlwJprPcBJXo+uwFO2ng5l6DsvF+DiZq9nMJIb20zqV+NI2DGhbdmH2D
        bpNoxhCPam01WzuviiS6oEUoHdv/YP2AfKHyRSnV1YFGI3DtwxYziRJL16r73dpYuKEeVN
        Oz2vSlmVnTX496tPz4k0YV/bd1DZWFC6sXG+GWC+fn62CgrCyhXrLti2FjTSXla9clQ+Bs
        jh/qtYh2OqIeIISnWYQOUQNRRBIFSkiX7YYlD35kfPp4/qz0dt63DgEax5/MO11p3re/qT
        tgoSaOJO70OThmgxw5wMLNQO2VGremDipRw3+kFMzdIAo1jQZWGpTy2dsgAr3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOLKbqZ+WEyAA/7wcsnVMTanilWInv/gKVP1qd2MJ1c=;
        b=K+dWE8F0qSlzUzYPx9hMdFGPgFcYhNMIiQSLbwEqNVIiLgkjQSQLSvmCz+Th2HZZSVsBHP
        dSa7SSUzcPG5VaDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Detect missing __noreturn annotations
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6e2b93d8c65eaed6c4166a358269dc0ef01f890c.1681853186.git.jpoimboe@kernel.org>
References: <6e2b93d8c65eaed6c4166a358269dc0ef01f890c.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808219.404.11188702829106131273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fedb724c3db5490234ddde0103811c28c2fedae0
Gitweb:        https://git.kernel.org/tip/fedb724c3db5490234ddde0103811c28c2fedae0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:50 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:53 -07:00

objtool: Detect missing __noreturn annotations

Most "unreachable instruction" warnings these days seem to actually be
the result of a missing __noreturn annotation.  Add an explicit check
for that.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/6e2b93d8c65eaed6c4166a358269dc0ef01f890c.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  6 ++++++
 tools/objtool/check.c                   | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 9ec8cbf..f9345e0 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -303,6 +303,12 @@ the objtool maintainers.
    If it's not actually in a callable function (e.g. kernel entry code),
    change ENDPROC to END.
 
+3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
+
+   The call from foo() to bar() doesn't return, but bar() is missing the
+   __noreturn annotation.  NOTE: In addition to adding the __noreturn
+   annotation, the function name also needs to be added to
+   'global_noreturns' in tools/objtool/check.c.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 71985f3..8d1b422 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4507,7 +4507,8 @@ static int validate_sls(struct objtool_file *file)
 
 static int validate_reachable_instructions(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *prev_insn;
+	struct symbol *call_dest;
 	int warnings = 0;
 
 	if (file->ignore_unreachables)
@@ -4517,6 +4518,17 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (insn->visited || ignore_unreachable_insn(file, insn))
 			continue;
 
+		prev_insn = prev_insn_same_sec(file, insn);
+		if (prev_insn && prev_insn->dead_end) {
+			call_dest = insn_call_dest(prev_insn);
+			if (call_dest) {
+				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
+					  call_dest->name);
+				warnings++;
+				continue;
+			}
+		}
+
 		WARN_INSN(insn, "unreachable instruction");
 		warnings++;
 	}
