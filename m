Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF35730639
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjFNRnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjFNRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:42:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CE1BF0;
        Wed, 14 Jun 2023 10:42:57 -0700 (PDT)
Date:   Wed, 14 Jun 2023 17:42:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686764575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hfkqaiey4eDp8QZH5LR5I91Mf3eI8gRoHf9KYFgCwTM=;
        b=p2UvlN3pOnWAt8bO2PQHu4MCkuWYzG5/L5PsA+XTlrWVmWPUVkBpSZCFmpR8T2fXJ6dY4q
        pKXfrCpi8OH1vN3f/nrnITSFkVp3GmxhlBOJv6ujXvd7wNbv0YrqCRMt9rYwJKazC6cVnk
        5jqjGQmn9B/I6xP5apC+s4VbRrEUj/qKq45sbykrdGtbTJ2xrJimtwnnkzr42QVID0qN1t
        SF9PPO5OBFahSE3TBUsPGn2YwPvYTMkgnvCks1knmgpafsE4tnw+Bzcm4hq+E4aYcyp/So
        opJRfamE6fjMvYFaZgCgvywCOhLjrLfaovG3fkoZ0impVL204cPqLfWSeLyumQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686764575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hfkqaiey4eDp8QZH5LR5I91Mf3eI8gRoHf9KYFgCwTM=;
        b=VUIyuFVu+aw2Zf5NuWRLRt/gHhj3bmuCIqL7B0aDU1QbOPmy4f/wk3Z5SkI/eAmf0beF8k
        5E2t5j6i4jzWKEDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: PAUSE is not a NOP
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168676457432.404.2368644491901077612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     2bd4aa9325821551648cf9738d6aa3a49317d7e5
Gitweb:        https://git.kernel.org/tip/2bd4aa9325821551648cf9738d6aa3a49317d7e5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Jun 2023 16:35:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 14 Jun 2023 19:02:54 +02:00

x86/alternative: PAUSE is not a NOP

While chasing ghosts, I did notice that optimize_nops() was replacing
'REP NOP' aka 'PAUSE' with NOP2. This is clearly not right.

Fixes: 6c480f222128 ("x86/alternative: Rewrite optimize_nops() some")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/linux-next/20230524130104.GR83892@hirez.programming.kicks-ass.net/
---
 arch/x86/kernel/alternative.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index bbfbf7a..a7e1ec5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -169,9 +169,12 @@ void text_poke_early(void *addr, const void *opcode, size_t len);
  */
 static bool insn_is_nop(struct insn *insn)
 {
-	if (insn->opcode.bytes[0] == 0x90)
+	/* Anything NOP, but no REP NOP */
+	if (insn->opcode.bytes[0] == 0x90 &&
+	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] != 0xF3))
 		return true;
 
+	/* NOPL */
 	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
 		return true;
 
