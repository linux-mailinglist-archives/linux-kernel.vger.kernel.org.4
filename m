Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC7722C46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjFEQMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFEQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467FB7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D0F6209E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573E6C4339B;
        Mon,  5 Jun 2023 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685981550;
        bh=Y/CZjNZo+1qpj5wP4ui+d4BljXqVHm12WzlCqm4DwWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpTmJiA3wvYc3nJFc3onPNTivqFIDK+4LergCSsq9dPrr2QukzMLRXUwmKxWyMx/H
         Kkn0zIevs/BE+n6arqBaKP/vrpzIbPzm6NJ9Fn3o4g111hZ+gJD47MzGI0V7lmqiBV
         L1VewThgnel9XuN25rqbCWprkFBl6SmPbrkVmqUB7df7eRty4T8vlbWjr3aBkVb2hF
         TLgyeBrq90lX1Gk892f1CWYrdgG10NVby5EkQ3K2g8dT+IkvTSO5DU2EuvWzXXjq+3
         duqvTR/JO0GIIYbA3ko+Ms1+R+i18UT4kn3tTFKjnJolDLIhK0Bt/0qTPuMwKwcrNI
         qeMZLS20qxwPg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-graphics-maintainer@vmware.com, Zack Rusin <zackr@vmware.com>
Subject: [PATCH v2 1/2] objtool: Allow stack operations in UNWIND_HINT_UNDEFINED regions
Date:   Mon,  5 Jun 2023 09:12:21 -0700
Message-Id: <820c5b433f17c84e8761fb7465a8d319d706b1cf.1685981486.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685981486.git.jpoimboe@kernel.org>
References: <cover.1685981486.git.jpoimboe@kernel.org>
MIME-Version: 1.0
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

If the code specified UNWIND_HINT_UNDEFINED, skip the "undefined stack
state" warning due to a stack operation.  Just ignore the stack op and
continue to propagate the undefined state.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 12 ++++++++++++
 tools/objtool/include/objtool/cfi.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b869de7e827..b11c25a715ac 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -33,6 +33,7 @@ static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 static struct cfi_init_state initial_func_cfi;
 static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
+static struct cfi_state force_undefined_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -2240,6 +2241,11 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
+		if (hint->type == UNWIND_HINT_TYPE_UNDEFINED) {
+			insn->cfi = &force_undefined_cfi;
+			continue;
+		}
+
 		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
 			insn->hint = false;
 			insn->save = true;
@@ -2793,6 +2799,10 @@ static int update_cfi_state(struct instruction *insn,
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
 
+	/* ignore UNWIND_HINT_UNDEFINED regions */
+	if (cfi->force_undefined)
+		return 0;
+
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
 		if (insn_func(insn)) {
@@ -4607,6 +4617,8 @@ int check(struct objtool_file *file)
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
 	set_func_state(&func_cfi);
+	init_cfi_state(&force_undefined_cfi);
+	force_undefined_cfi.force_undefined = true;
 
 	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
 		goto out;
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index b1258e79a1b7..c8a6bec4f6b9 100644
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -36,6 +36,7 @@ struct cfi_state {
 	bool drap;
 	bool signal;
 	bool end;
+	bool force_undefined;
 };
 
 #endif /* _OBJTOOL_CFI_H */
-- 
2.40.1

