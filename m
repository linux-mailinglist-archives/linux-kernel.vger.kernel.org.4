Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9A6DFE50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDLTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDLTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC040F9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBED66120A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105FC433D2;
        Wed, 12 Apr 2023 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326228;
        bh=vyrH7fWmcqWjltl/LdT1BsNQ9591BQaxXbDWTsC3pYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UudiDOujlu3FC9gXbLoKD/o9qBM5vOmRVcq9RCfnH2a+m7zindDoVG0SirE95XWlP
         ffko4mKUAo/3phlkK9kJu7UDtNghhhf2IlLadhhKjqWD1C/RqDLnciHusi6+DtfynJ
         Bk8eZh04yv+8fUCVHlMGD01c1FS8YHuN3tNDp/50xZlMpMlvijlzImNgca7M0Mkri2
         NchUqg8Kz0peoSFTWP1jBx1x86gKSmf+2cEKmPoMlQCE3UgLotOj7d3EjB0g6tj1GZ
         ZRSglLWvn9f/vwjWnk6qo3LfEpb2n4tJI4UYLIFHcpU9qATq+M5FSXkw5tqmKkX3AN
         q3B6E/dQaZSnw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
Date:   Wed, 12 Apr 2023 12:03:23 -0700
Message-Id: <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 tools/objtool/Documentation/objtool.txt |  6 ++++++
 tools/objtool/check.c                   | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 5a69c207a10e..2cd1fa16ed08 100644
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
index 5e7d3c62fb9d..60f2d649f19f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4485,7 +4485,8 @@ static int validate_sls(struct objtool_file *file)
 
 static int validate_reachable_instructions(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *prev_insn;
+	struct symbol *call_dest;
 	int warnings = 0;
 
 	if (file->ignore_unreachables)
@@ -4495,6 +4496,17 @@ static int validate_reachable_instructions(struct objtool_file *file)
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
-- 
2.39.2

