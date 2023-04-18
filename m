Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBA6E6E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjDRV2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjDRV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD14BBAA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008CD6394F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96148C433D2;
        Tue, 18 Apr 2023 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853280;
        bh=d8JeZbsO9FoCUm7Dn+I8dcmej5dQ111QeGOLzKzYoxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQOxdvbFmQbJ8Ey4p9LJ+o8btkCtcDjirAQFXJUP9kU7/jj5rHE7x6YNHb2wuzse/
         wZzM5lnhebXXYVROnDVsWNniHyqHAtA65tiRFNLYvSyCWQLFPaESkwG1Dm098ottzm
         pthA0dTvkLcmyvE93Mz+Y/BoY7whAsZNwvxg6VTWG8nQe/RXJyrlRXaTR3ttw9l7jd
         sHRNLAw2FR5jzW8oKGwhO/ojHNkRN150MZr4s9boNzIR/YcaGjlZKkvfunlh5Gdmnt
         pxhY3aZSbLQ3fxejuQqc/7BG6oKjhWQ50+mV+aN1M5BVvdFNSDVKBeyL0Hbr6rQQuQ
         Tha6MYOjdzuCQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 4/8] objtool: Detect missing __noreturn annotations
Date:   Tue, 18 Apr 2023 14:27:50 -0700
Message-Id: <6e2b93d8c65eaed6c4166a358269dc0ef01f890c.1681853186.git.jpoimboe@kernel.org>
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
index aa083296af1e..dd10128ab013 100644
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
-- 
2.39.2

