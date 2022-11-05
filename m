Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AF61D97A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKEKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:36:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94E2B18B;
        Sat,  5 Nov 2022 03:36:29 -0700 (PDT)
Date:   Sat, 05 Nov 2022 10:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667644588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1DAEXCKv31INkvBrmiYFmBxfqIyfg4r8BE7OR9TUi7U=;
        b=W2NNpFo8d0RGhmikvSY/jUyJcSQ8ijkiC1sJcAUV3BY/D78eLq2UWUfdbGgX0NTeXCuW23
        2GopUjcPXwi7294Z6gGokiQ5wmnspc9Y7HbqCgj8UEV0Zwo5Yo3zxYLQefY241ave94RrG
        pYbrIpMHfI5AY3aB9i9LXuKJmeBbNYGZ74WpsEFdjtGc7UBKgYsVifR/+RAXba2ux8a8RX
        DMIXNyvqq4uoR8qMYc8fo+bqga1SnhnmvfETouH1G6tqRYqms9EqDZwzMm45hHw6qyNOTj
        fWto68z8+25889BVTAcN/H0UBAVUc5xVXrYj7ZXU/QIIHDGBUOBFxz4wmrmFPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667644588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1DAEXCKv31INkvBrmiYFmBxfqIyfg4r8BE7OR9TUi7U=;
        b=pkRCGDKAu6cle/KR+FEgLAHIALxhzcXpq6cRd+cAx3Q8nUPm6WDmblv21Ig8hXaZhmhTMg
        Vq3B/hbkYYQh/nCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Fix weak hole vs prefix symbol
Cc:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166764458700.4906.4772901868553171180.tip-bot2@tip-bot2>
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

Commit-ID:     023f2340f053537cce170c31c430b0886c6f07ca
Gitweb:        https://git.kernel.org/tip/023f2340f053537cce170c31c430b0886c6f07ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 03 Nov 2022 20:57:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 05 Nov 2022 11:28:02 +01:00

objtool: Fix weak hole vs prefix symbol

Boris (and the robot) reported that objtool grew a new complaint about
unreachable instructions. Upon inspection it was immediately clear
the __weak zombie instructions struck again.

For the unweary, the linker will simply remove the symbol for
overriden __weak symbols but leave the instructions in place, creating
unreachable instructions -- and objtool likes to report these.

Commit 4adb23686795 ("objtool: Ignore extra-symbol code") was supposed
to have dealt with that, but the new commit 9f2899fe36a6 ("objtool:
Add option to generate prefix symbols") subtly broke that logic by
created unvisited symbols.

Fixes: 9f2899fe36a6 ("objtool: Add option to generate prefix symbols")
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 55066c4..4f1a738 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4053,8 +4053,28 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
 
 		offset = func->offset - prev->offset;
 		if (offset >= opts.prefix) {
-			if (offset == opts.prefix)
+			if (offset == opts.prefix) {
+				/*
+				 * Since the sec->symbol_list is ordered by
+				 * offset (see elf_add_symbol()) the added
+				 * symbol will not be seen by the iteration in
+				 * validate_section().
+				 *
+				 * Hence the lack of list_for_each_entry_safe()
+				 * there.
+				 *
+				 * The direct concequence is that prefix symbols
+				 * don't get visited (because pointless), except
+				 * for the logic in ignore_unreachable_insn()
+				 * that needs the terminating insn to be visited
+				 * otherwise it will report the hole.
+				 *
+				 * Hence mark the first instruction of the
+				 * prefix symbol as visisted.
+				 */
+				prev->visited |= VISITED_BRANCH;
 				elf_create_prefix_symbol(file->elf, func, opts.prefix);
+			}
 			break;
 		}
 		insn = prev;
