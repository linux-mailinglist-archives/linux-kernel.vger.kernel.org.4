Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB236DFFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDLU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDLU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE410DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC2F631DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C79FC433A4;
        Wed, 12 Apr 2023 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331182;
        bh=zo0BxAzMtQYruLjF5XaJiSkqwASG0OADnk73jUKYYMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGh8C+WjFDMkawFcUIWtEsUhPrhmYCi0exlZBJVzag/j57IfTMGMCHT/uSH6nBnO/
         qY69xO3WOk/r1W/nY7ZPEMpmuOI6hdpqLNYRfGc4Gj51zroYfmHeyncccCPbuV3bTM
         0ceZjyKGyOgzw1dXPXsNfavYYygL09hqrvNouTDMbuQ0q9pKNSiMRr9n9jo2Z1xdvb
         vsUql2XbzlSbef8FR2Oigx6di1bi7E53UAcfZ+7YnudmAoB5FijOwKYUnwaRJksD0w
         8zAkeBSFe9ptgTiK7hq96ZWzV93WtNPGAB0vfBVLs1xXjziMbouEqxrvD9IssoC4VO
         3HpR7NIvLXa8A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 3/3] objtool: Generate ORC data for __pfx code
Date:   Wed, 12 Apr 2023 13:26:15 -0700
Message-Id: <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681331135.git.jpoimboe@kernel.org>
References: <cover.1681331135.git.jpoimboe@kernel.org>
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

Allow unwinding from prefix code by copying the CFI from the starting
instruction of the corresponding function.  Even when the NOPs are
replaced, they're still stack-invariant instructions so the same ORC
entry can be reused everywhere.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2f3136145b2e..3f27a0278bf8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4123,6 +4123,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
 {
 	struct instruction *insn, *prev;
+	struct cfi_state *cfi;
 
 	insn = find_insn(file, func->sec, func->offset);
 	if (!insn)
@@ -4151,6 +4152,19 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
 	if (!prev)
 		return -1;
 
+	if (!insn->cfi) {
+		/*
+		 * This can happen if stack validation isn't enabled or the
+		 * function is annotated with STACK_FRAME_NON_STANDARD.
+		 */
+		return 0;
+	}
+
+	/* Propagate insn->cfi to the prefix code */
+	cfi = cfi_hash_find_or_add(insn->cfi);
+	for (; prev != insn; prev = next_insn_same_sec(file, prev))
+		prev->cfi = cfi;
+
 	return 0;
 }
 
@@ -4158,7 +4172,7 @@ static int add_prefix_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
-	int ret, warnings = 0;
+	int warnings = 0;
 
 	for_each_sec(file, sec) {
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
-- 
2.39.2

