Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E086E6E28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjDRV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjDRV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E0AD3D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551FC63951
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80055C4339E;
        Tue, 18 Apr 2023 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853279;
        bh=QLb9CZEh4jbifWcfcjQ/raJsyLVWkp1Ug+utfGGdmOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAFVT7Th4uWYQ5gVAbR35YJeC/EuGSNAl/6RaCsICHji5Ezk2jCGofZBnr4atJJpy
         UOompHmTAw/0dhGQ9f6EdBAstltpwdxCpBvvuBQLchl4MbBH6FnZHGX0Te6SzUBEW7
         qNL/MXS66dNDLAX0L8Vzd4Xl7qvwfMKolvby59iGOvnyWuHwMtD3fNGN2J2AnoAHAC
         Jo7PRS/UJkvi59h3ZV1yedBmCN9m00imhM6P76KbnrUyfSY2ykwdbffmvGhBXYnvK7
         3rAoqOZAMxAYP++eGZNZpEApbXxOsspLX3MBqWyxoVXeh5SCCN0wKco4CcvMcI/uBB
         L1uti4KL0mHgA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 1/8] objtool: Limit unreachable warnings to once per function
Date:   Tue, 18 Apr 2023 14:27:47 -0700
Message-Id: <9d38f881bfc34e031c74e4e90064ccb3e49f599a.1681853186.git.jpoimboe@kernel.org>
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

Unreachable instruction warnings are limited to once per object file.
That no longer makes sense for vmlinux validation, which might have
more unreachable instructions lurking in other places.  Change it to
once per function.

Note this affects some other (much rarer) non-fatal warnings as well.
In general I think one-warning-per-function makes sense, as related
warnings can accumulate quickly and we want to eventually get back to
failing the build with -Werror anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                | 5 +++--
 tools/objtool/include/objtool/elf.h  | 1 +
 tools/objtool/include/objtool/warn.h | 7 ++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5b600bbf2389..a00931342c7e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4514,6 +4514,7 @@ static int validate_sls(struct objtool_file *file)
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
+	int warnings = 0;
 
 	if (file->ignore_unreachables)
 		return 0;
@@ -4523,10 +4524,10 @@ static int validate_reachable_instructions(struct objtool_file *file)
 			continue;
 
 		WARN_INSN(insn, "unreachable instruction");
-		return 1;
+		warnings++;
 	}
 
-	return 0;
+	return warnings;
 }
 
 int check(struct objtool_file *file)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e1ca588eb69d..78e2d0fc21ca 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 warned	     : 1;
 	struct list_head pv_target;
 	struct list_head reloc_list;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index b1c920dc9516..f195deab456e 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -55,7 +55,12 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN_INSN(insn, format, ...)					\
 ({									\
-	WARN_FUNC(format, insn->sec, insn->offset,  ##__VA_ARGS__);	\
+	struct instruction *_insn = (insn);				\
+	if (!_insn->sym || !_insn->sym->warned)				\
+		WARN_FUNC(format, _insn->sec, _insn->offset,		\
+			  ##__VA_ARGS__);				\
+	if (_insn->sym)							\
+		_insn->sym->warned = 1;					\
 })
 
 #define BT_FUNC(format, insn, ...)			\
-- 
2.39.2

