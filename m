Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B58690D22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjBIPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBIPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:37:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E863136
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16287B82193
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A59FC433D2;
        Thu,  9 Feb 2023 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675957000;
        bh=gHYGLHg1aB0ik45JC+4zloo1eDdi2WUI1kKJrxICvNI=;
        h=From:To:Cc:Subject:Date:From;
        b=U4AkSmo7WhLntlQo82gyxHgscJ70CK/zQRakf0C8DdZHYsAWBIIPjcQpBcU/pBt4n
         0W9FmAVjgqkRgkzDP6EngmkXLngTBCVZz7e4ysvdebw+b2njayu6BjiacCBW1cn8MT
         JfoJ65IwMJ3/1uSV7BhCgtoUGAVSKjwaaHwXnE8ndDQJ9TV03iTOD8inzQrOAB2jHs
         xb4Gw9LBR84PxzKxutQFnJEkPS1oWCpVPzlCgA0ZgXHBhNMw1f2SlRiN9SFJzmEkvw
         aNwyZiPkHgdIG1b5jlSxexrCs9+2PodSEYdTBxEQyPShDcsbHJIs1uP6OkPsO9OqxV
         jyM0QLnVFnU2g==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip] kprobes/x86: Remove unneeded casting from immediate value
Date:   Fri, 10 Feb 2023 00:36:36 +0900
Message-Id:  <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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
 arch/x86/kernel/kprobes/core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 695873c0f50b..2440e736d0e4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -607,19 +607,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 	case 0xe8:	/* near call relative */
 		p->ainsn.emulate_op = kprobe_emulate_call;
 		if (insn->immediate.nbytes == 2)
-			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		else
-			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0xeb:	/* short jump relative */
 	case 0xe9:	/* near jump relative */
 		p->ainsn.emulate_op = kprobe_emulate_jmp;
 		if (insn->immediate.nbytes == 1)
-			p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		else if (insn->immediate.nbytes == 2)
-			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		else
-			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+			p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0x70 ... 0x7f:
 		/* 1 byte conditional jump */
@@ -634,9 +634,9 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 			p->ainsn.emulate_op = kprobe_emulate_jcc;
 			p->ainsn.jcc.type = opcode & 0xf;
 			if (insn->immediate.nbytes == 2)
-				p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+				p->ainsn.rel32 = insn->immediate.value;
 			else
-				p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+				p->ainsn.rel32 = insn->immediate.value;
 		} else if (opcode == 0x01 &&
 			   X86_MODRM_REG(insn->modrm.bytes[0]) == 0 &&
 			   X86_MODRM_MOD(insn->modrm.bytes[0]) == 3) {
@@ -651,7 +651,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		p->ainsn.emulate_op = kprobe_emulate_loop;
 		p->ainsn.loop.type = opcode & 0x3;
 		p->ainsn.loop.asize = insn->addr_bytes * 8;
-		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0xff:
 		/*

