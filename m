Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235C2676588
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAUJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:57:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE81353B;
        Sat, 21 Jan 2023 01:57:26 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674295045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmtBArXGsLKsmisCNbGh0SET3ImTh+pYPr5K7kZMwHY=;
        b=Hg/rIklRGW36JdCrETInvtXNarbgoLaY/lOyUy6Ak93NEddtHldMfBhO6RcB10IA66ylqH
        0awaLLvDoonsItIP7g55GJ0J9tptABoqG1T4t2xPBh2owNGBpdMtjniBP0KGR0MlkZuKRm
        cFcf3dqM5OEqXNFiS/bKZbrekTRhnWCJt7cSdSLX7AzM2/dJ+FIf8kCq8sZcUuYCWeTDoh
        dytmtbGeGmRN60lEGQeiO+G2YqHSNJO47oe1NtgIikXy8Sd64rZJLCOo9lV9NhbnmRL++L
        FxXPSSqr5b3KQOkgvGHoLybtLU7Rou6yRDqgbaThdPmU3hQTfa0w/gDpGMqlOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674295045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmtBArXGsLKsmisCNbGh0SET3ImTh+pYPr5K7kZMwHY=;
        b=4KDZn+IABRzw2ZpOJRb75NFBCHriMBZyXnDEBktL1lRqedAeqHcvhKEwXBD7lVM+Z4f2Up
        l8GMnzHuTSQ/ufBA==
From:   "tip-bot2 for Michal Kubecek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Check that module init/exit function is
 an indirect call target
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118105215.B9DA960514@lion.mk-sys.cz>
References: <20230118105215.B9DA960514@lion.mk-sys.cz>
MIME-Version: 1.0
Message-ID: <167429504442.4906.8670860752531771829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     03d7a1053cf72372be22b43faada5bca12ff183d
Gitweb:        https://git.kernel.org/tip/03d7a1053cf72372be22b43faada5bca12ff183d
Author:        Michal Kubecek <mkubecek@suse.cz>
AuthorDate:    Wed, 18 Jan 2023 11:52:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 10:50:18 +01:00

objtool: Check that module init/exit function is an indirect call target

Some out-of-tree modules still do not use module_init() / module_exit()
macros and simply create functions with magic names init_module() and
cleanup_module() instead. As a result, these functions are not recognized
as indirect call targets by objtool and such module fails to load into an
IBT enabled kernel.

This old way is not even documented any more but it is cleaner to issue
a warning than to let the module fail on load without obvious reason.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230118105215.B9DA960514@lion.mk-sys.cz
---
 tools/objtool/Documentation/objtool.txt | 8 ++++++++
 tools/objtool/check.c                   | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8a67190..8e53fc6 100644
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
index cab1a16..7c40bd5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -847,8 +847,15 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
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
