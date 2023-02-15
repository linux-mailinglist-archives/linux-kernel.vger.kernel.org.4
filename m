Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB1697289
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjBOAK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBOAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:10:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F713311D4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24D30B81F62
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F240C433D2;
        Wed, 15 Feb 2023 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676419827;
        bh=3J6SK8xX///7h1Dumxc1Ibt18+tu5um71PTnl4nqrdk=;
        h=From:To:Cc:Subject:Date:From;
        b=o0v3agpCzjFLGmJpdUgnhyIzfE6pp51RRQykQEKv6MkKepWZ801Lqz0aYWlG45weu
         38BLOunOHDEZEMJVJdLZVKwndv+gZNvEpC9MPFfIYmpxqlNZG2X9e2TOsnfQS632E1
         Q/VXjydkCuwrieXtfrIMZf2SZA1qj4mDWX9Eu2l7+q4dkFTm7dcg6iSBcsD9K2tB8x
         MeEDKYRZK7+tBofeQofVlCVSD5aWvcaKg6CsqcKCMZjVB+WKfG5VuycMnkd1jAmZCa
         IJygfX1teQNAq7S0WtKhbdgHB3BzIWzkB5v60hImrl0eCC655i5RYcU2C48z5AxJtx
         pX3QQjflyBYBA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v2] x86/kprobes: Remove unneeded casting from immediate value
Date:   Wed, 15 Feb 2023 09:10:24 +0900
Message-Id:  <167641982421.1677831.18379341946856978545.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Remove unneeded casting from immediate value assignments for relative
jump offset. Since the immediate values in the 'insn' data structure are
assigned from immediate bytes as a signed value to insn.immediate.value
by insn_field_set(). Thus, if we need to access that value as a signed
value (in this kprobe's case), we don't need to cast it.
This is a kind of clean up (should not change behavior) follows Nadav's
bugfix.

Link: https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
  - Remove meaningless immediate size branches too.
---
 arch/x86/kernel/kprobes/core.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 695873c0f50b..41ffdf04d9c4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -606,20 +606,12 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		break;
 	case 0xe8:	/* near call relative */
 		p->ainsn.emulate_op = kprobe_emulate_call;
-		if (insn->immediate.nbytes == 2)
-			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
-		else
-			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0xeb:	/* short jump relative */
 	case 0xe9:	/* near jump relative */
 		p->ainsn.emulate_op = kprobe_emulate_jmp;
-		if (insn->immediate.nbytes == 1)
-			p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
-		else if (insn->immediate.nbytes == 2)
-			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
-		else
-			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0x70 ... 0x7f:
 		/* 1 byte conditional jump */
@@ -633,10 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 			/* 2 bytes Conditional Jump */
 			p->ainsn.emulate_op = kprobe_emulate_jcc;
 			p->ainsn.jcc.type = opcode & 0xf;
-			if (insn->immediate.nbytes == 2)
-				p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
-			else
-				p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		} else if (opcode == 0x01 &&
 			   X86_MODRM_REG(insn->modrm.bytes[0]) == 0 &&
 			   X86_MODRM_MOD(insn->modrm.bytes[0]) == 3) {
@@ -651,7 +640,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		p->ainsn.emulate_op = kprobe_emulate_loop;
 		p->ainsn.loop.type = opcode & 0x3;
 		p->ainsn.loop.asize = insn->addr_bytes * 8;
-		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0xff:
 		/*

