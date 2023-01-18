Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63110671AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjARLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjARLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:32:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9595166FF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:52:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02F8B205DA;
        Wed, 18 Jan 2023 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674039136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=4CzLTnXF1RGnXjzn638iSw21L+MKQzT38mnf8LP2ER8=;
        b=CZHCZkfNSnc0v2Aywk4cPfl87iNvRA3TuOYbUT3sABI3Wu2+YcH5BDlLRIb5eHqyjoyh+8
        dllgMdk+CQSn+j+joQgqxx4RfNquDjp3J+ig6ZH1aeex6uwrpJGeSjeJ7GbMljgEfQ36n0
        quSY7cvlKx/CVXmdsRsXH85Hc71mY0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674039136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=4CzLTnXF1RGnXjzn638iSw21L+MKQzT38mnf8LP2ER8=;
        b=YCuzL6Z+vqRqKHgPHFQdPWq1N3RhW3H+gcV3Hw1Z8FKMwkvRl5R0Sl95aMGjK1BlGesaJF
        maWg25+vcEu+uiBg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6B5C2C141;
        Wed, 18 Jan 2023 10:52:15 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id B9DA960514; Wed, 18 Jan 2023 11:52:15 +0100 (CET)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] objtool: check that module init/exit function is an indirect
 call target
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <20230118105215.B9DA960514@lion.mk-sys.cz>
Date:   Wed, 18 Jan 2023 11:52:15 +0100 (CET)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some out-of-tree modules still do not use module_init() / module_exit()
macros and simply create functions with magic names init_module() and
cleanup_module() instead. As a result, these functions are not recognized
as indirect call targets by objtool and such module fails to load into an
IBT enabled kernel.

This old way is not even documented any more but it is cleaner to issue
a warning than to let the module fail on load without obvious reason.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 tools/objtool/Documentation/objtool.txt | 8 ++++++++
 tools/objtool/check.c                   | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8a671902a187..8e53fc6735ef 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -410,6 +410,14 @@ the objtool maintainers.
    can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
    directive right before the call.
 
+12. file.o: warning: func(): not an indirect call target
+
+   This means that objtool is running with --ibt and a function expected
+   to be an indirect call target is not. In particular, this happens for
+   init_module() or cleanup_module() if a module relies on these special
+   names and does not use module_init() / module_exit() macros to create
+   them.
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b7c8b33069e..0afa4f0ffa67 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -854,8 +854,15 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->endbr_list, call_node) {
 
 		int *site = (int *)sec->data->d_buf + idx;
+		struct symbol *sym = insn->sym;
 		*site = 0;
 
+		if (opts.module && sym && sym->type == STT_FUNC &&
+		    insn->offset == sym->offset &&
+		    (!strcmp(sym->name, "init_module") ||
+		     !strcmp(sym->name, "cleanup_module")))
+			WARN("%s(): not an indirect call target", sym->name);
+
 		if (elf_add_reloc_to_insn(file->elf, sec,
 					  idx * sizeof(int),
 					  R_X86_64_PC32,
-- 
2.38.1

