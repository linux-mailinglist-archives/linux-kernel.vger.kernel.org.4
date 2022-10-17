Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000DC6011F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJQO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1F6919C;
        Mon, 17 Oct 2022 07:54:04 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hp0mos0E5tiiArrrX3oYVon6nqy3KoAW1xuLuR6niQ=;
        b=j4Ox5Vv19GswD3+zOb+aGkXIhqDSgs3dZzBRSSYbJZC2TZc3MpDUtHxGb6A94zHrsJO6he
        Dzegfx6PjNTVetEyD6S9ZVgzT+pcSvGxVVeLznuOeHDUCFyzeO649q2UmWppsWmYvQcChT
        5hp+QB1eEz/T9dPkAZQjpDsRONGamuVx1oVVO96Qgu/YBqvrbauyfMcIJ37zGvOGoJ2aRS
        KErLE+xq7aqqBu77piYUYdrQQ7xksmfX4fvWidi9tXFUh38ceWFRLLpD/wA35snK5cOY+T
        yYmGjcnQbbLS5NaclDb4V8AjmPGfOjOss0NyF4Brvcy6nG9G2GYc9nh3B0sSvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hp0mos0E5tiiArrrX3oYVon6nqy3KoAW1xuLuR6niQ=;
        b=zFVxN+UdE4t4XWbf3py0T3xVKSsy0H+SUCzRQmZLBfidhEXGuLk3zlK8ulEc3PXUwoTxX2
        LhChO7UdEBBtxIBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Track init section
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.910334431@infradead.org>
References: <20220915111145.910334431@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844116.401.582646215088062442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6644ee846cb983437063da8fd24b7cae671fd019
Gitweb:        https://git.kernel.org/tip/6644ee846cb983437063da8fd24b7cae671fd019
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:07 +02:00

objtool: Track init section

For future usage of .init.text exclusion track the init section in the
instruction decoder and use the result in retpoline validation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.910334431@infradead.org
---
 tools/objtool/check.c               | 17 ++++++++++-------
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7174bba..bb7c819 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -382,6 +382,15 @@ static int decode_instructions(struct objtool_file *file)
 		    !strncmp(sec->name, ".text.__x86.", 12))
 			sec->noinstr = true;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(sec->name, ".init.text") && !opts.module)
+			sec->init = true;
+
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -3748,13 +3757,7 @@ static int validate_retpoline(struct objtool_file *file)
 		if (insn->retpoline_safe)
 			continue;
 
-		/*
-		 * .init.text code is ran before userspace and thus doesn't
-		 * strictly need retpolines, except for modules which are
-		 * loaded late, they very much do need retpoline in their
-		 * .init.text
-		 */
-		if (!strcmp(insn->sec->name, ".init.text") && !opts.module)
+		if (insn->sec->init)
 			continue;
 
 		if (insn->type == INSN_RETURN) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 16f4067..baa8085 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, init;
 };
 
 struct symbol {
