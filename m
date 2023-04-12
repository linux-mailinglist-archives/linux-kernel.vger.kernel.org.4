Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769496DFE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDLTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDLTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693830C8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 100566386B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44606C433D2;
        Wed, 12 Apr 2023 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326226;
        bh=os7uY3nMTCWb+jG1PKMR9S3yUK1VjSJJlj7joM5hI9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWt5t1kVr9C1RDqVU4+9Zo/cjruM2zWe+BLhm+LRCAl1RaCMobV8Gu2Mdwx6cvPcI
         w1xXBL0pHHtKfsI+8jpBAa5bdj3/ibHeDsx2ZAOGY7RGwZ5vk3LHm6nAWoDfydjvQZ
         2Y9zerupDngDJFU2DsoSt6FxRvqq8l+6veIWlRtFHWr644unF8dlcgeuoLwN4mzeTL
         pV+DDprL7Vu2f6S7jXTdKbqbM9qBFCQh/Krf3Rm2F0qW5jFXVUmdA9jKaz0g63Yld6
         HjeK8y+C5X3zDC7yXvlXLWNqJzCXjBlzn2/L/tO5JIL+7WHxSNvTiAgb/x8W3Hg4uX
         kRceCXII2Gqvw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 3/9] objtool: Limit unreachable warnings to once per function
Date:   Wed, 12 Apr 2023 12:03:18 -0700
Message-Id: <81ed0b8e5218ac6ecae49af901bf5e0fb3687cef.1681325924.git.jpoimboe@kernel.org>
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
 tools/objtool/include/objtool/warn.h | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e85440db7a5f..de0d0234527d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4509,6 +4509,7 @@ static int validate_sls(struct objtool_file *file)
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
+	int warnings = 0;
 
 	if (file->ignore_unreachables)
 		return 0;
@@ -4518,10 +4519,10 @@ static int validate_reachable_instructions(struct objtool_file *file)
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
index ad0024da262b..a668173a5869 100644
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
index b1c920dc9516..4ef9b278e5fd 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -55,7 +55,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN_INSN(insn, format, ...)					\
 ({									\
-	WARN_FUNC(format, insn->sec, insn->offset,  ##__VA_ARGS__);	\
+	if (!insn->sym || !insn->sym->warned)				\
+		WARN_FUNC(format, insn->sec, insn->offset, ##__VA_ARGS__);\
+	if (insn->sym)							\
+		insn->sym->warned = 1;					\
 })
 
 #define BT_FUNC(format, insn, ...)			\
-- 
2.39.2

