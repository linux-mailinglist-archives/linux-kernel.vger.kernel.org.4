Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD041707EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjERLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjERLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BF1738;
        Thu, 18 May 2023 04:08:30 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATqR6+23eUp9OSsJpJ6LDVDI6BWgqiqufebazH3Qso=;
        b=Z4k5wrCpButQ5ztn8gNmpE86UfOfX4NGi5ZC4IQrgITNMYssFktm0GAn5GCm4ZQXF+Nm74
        Zr6427PdGY6kIQv8oYROUEZeBb6BMxiZp8vs79do2vgk4b7k5Nb9DF8FExnThO5OCq+2+B
        eWa60oRfeHtneDrcFJotyQEYHn85vzTfutifvW7uIpqUb4eIyiB/vtAJOaNFHu56NGpktU
        E1BAwP+jnQ/ogxli4txfZL3NZqfyWsZILHbRFF/Z//1K/Jzf71Z4d4ej0u+3rvqAEaAtWj
        ByvKrApri9lxRMgHsXLlMdllecWkqasCYMvvbWTvhGULUYcsWeMd2x/ZEWNI8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATqR6+23eUp9OSsJpJ6LDVDI6BWgqiqufebazH3Qso=;
        b=IeH4ed2b6ngQPj7TAI/c3beRbDIHDEl3f2syZ7bc4mZ2qVroxvf02OXPEb6/bplYWX1t4F
        TnsCptdoN/EVyCCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Limit unreachable warnings to once per function
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9d38f881bfc34e031c74e4e90064ccb3e49f599a.1681853186.git.jpoimboe@kernel.org>
References: <9d38f881bfc34e031c74e4e90064ccb3e49f599a.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808302.404.11280971463305376650.tip-bot2@tip-bot2>
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

Commit-ID:     5e3992fe72748ed3892be876f09d4d990548b7af
Gitweb:        https://git.kernel.org/tip/5e3992fe72748ed3892be876f09d4d990548b7af
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:47 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:51 -07:00

objtool: Limit unreachable warnings to once per function

Unreachable instruction warnings are limited to once per object file.
That no longer makes sense for vmlinux validation, which might have
more unreachable instructions lurking in other places.  Change it to
once per function.

Note this affects some other (much rarer) non-fatal warnings as well.
In general I think one-warning-per-function makes sense, as related
warnings can accumulate quickly and we want to eventually get back to
failing the build with -Werror anyway.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/9d38f881bfc34e031c74e4e90064ccb3e49f599a.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                | 5 +++--
 tools/objtool/include/objtool/elf.h  | 1 +
 tools/objtool/include/objtool/warn.h | 7 ++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0fcf99c..98e6c3b 100644
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
index e1ca588..78e2d0f 100644
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
index b1c920d..f195dea 100644
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
