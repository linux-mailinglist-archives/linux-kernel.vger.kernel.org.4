Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F3662BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjAIRCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjAIRBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:01:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E93DBD6;
        Mon,  9 Jan 2023 09:01:20 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:01:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmTEpx1rglD7bjrUm/jwfOColHcEYONm70QHf3GenQE=;
        b=DCj6r5wsypfJH6WwaMxb2hEk3kB6Ef0xX/aFxrjpDXZBUSIDgjD0YGX0+vHQ9FThTIEE46
        1Hz3RxBFTpcZ6c4W6YZWRGPzsIept9hmT/ZAN2tFKcCyEBFV8ibsvZq9lC8DGWUnGwSAaq
        9Zk91fyoFTo3S3gRA4KbHS9FzjBn85ZAEF/JLkb8M/do+WM4OOC6exg9lO13U5NUrg3njA
        6aaIE8j+N4kvcJxUM9AXgWYqOU3daAmIBsIUcuu6SmkDs5lh01UxFOapM6wEE6etsRvEgE
        XjnG+VPbc8pt7CQ7P4w+KgMvX+HJiUmaWO4M97HsustiKe0AzXvJwv3cSsYqzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmTEpx1rglD7bjrUm/jwfOColHcEYONm70QHf3GenQE=;
        b=W/tVs/DyFQosdn+X9LEpr5YOUqiwQWGNiZ8uZrpirBKCR9M1y2mY7uTE4cQZUHgBkzsiYh
        qKTk9F1cFSPH98DQ==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] objtool: Tolerate STT_NOTYPE symbols at end of section
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221220101323.3119939-1-npiggin@gmail.com>
References: <20221220101323.3119939-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <167328367772.4906.2873693536526803314.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     cad90e5381d840cf2296aaac9b3eff71a30b7c5b
Gitweb:        https://git.kernel.org/tip/cad90e5381d840cf2296aaac9b3eff71a30b7c5b
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Tue, 20 Dec 2022 20:13:23 +10:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 17:53:46 +01:00

objtool: Tolerate STT_NOTYPE symbols at end of section

Hand-written asm often contains non-function symbols in executable
sections. _end symbols for finding the size of instruction blocks
for runtime processing is one such usage.

optprobe_template_end is one example that causes the warning:

  objtool: optprobe_template_end(): can't find starting instruction

This is because the symbol happens to be at the end of the file (and
therefore end of a section in the object file).

So ignore end-of-section STT_NOTYPE symbols instead of bailing out
because an instruction can't be found. While we're here, add a more
descriptive warning for STT_FUNC symbols found at the end of a
section.

[ This also solves a PowerPC regression reported by Sathvika Vasireddy. ]

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reported-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Sathvika Vasireddy <sv@linux.ibm.com>
Link: https://lore.kernel.org/r/20221220101323.3119939-1-npiggin@gmail.com
---
 tools/objtool/check.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be7..4b7c8b3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -427,6 +427,15 @@ static int decode_instructions(struct objtool_file *file)
 			if (func->type != STT_NOTYPE && func->type != STT_FUNC)
 				continue;
 
+			if (func->offset == sec->sh.sh_size) {
+				/* Heuristic: likely an "end" symbol */
+				if (func->type == STT_NOTYPE)
+					continue;
+				WARN("%s(): STT_FUNC at end of section",
+				     func->name);
+				return -1;
+			}
+
 			if (func->return_thunk || func->alias != func)
 				continue;
 
