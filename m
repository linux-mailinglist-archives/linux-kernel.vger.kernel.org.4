Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E226E2629
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDNOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjDNOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B785B767;
        Fri, 14 Apr 2023 07:48:00 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mWb2aAF0jq45xU6JGyry1bh+JVl0x18FRdqSbb0R+4U=;
        b=NmEapt/PWJfiQqvJpdNiC0sToS4ohEPsOLbZrSFB63a84svQWBPOySu8x4UapJeOpQ1SSw
        /n0N+i8Gt/J6e/G2m6Sb2maN7adSqUs31ZabfJ+QatIbbGuYljo6JvdUmCgeg2VmZC1MhO
        1gtfZ6GChLlPIrvdOj/oAKq2XSuv+rnpl/qVskRwvrcdHE7YsKOILYZ6hlBBKKs12EfE8M
        B7Msz1oM7HZrz/1cp8J2z0AC1f+6K8fVqycSQqq4FRyK4YOLILP65mxsQF075bNebaBNTK
        fb09I8gGK9C9Ig3rB0LazCLP9BOXbY9EaMR7dBnqy6/hZ2lfWfzLTLZGXz0nAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mWb2aAF0jq45xU6JGyry1bh+JVl0x18FRdqSbb0R+4U=;
        b=G523Fgc9sNlXt53b45mH+RHpNPL/SjN6OS6SDophsqxHp9Zk6pgzwskEbMx2FxH5vutY00
        yZsKXtJtwnw15eDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] Revert "objtool: Support addition to set CFA base"
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168148367669.404.17357067209548739992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e18398e80c73e3cc7d9c3d2e0bc06a4af8f4f1cb
Gitweb:        https://git.kernel.org/tip/e18398e80c73e3cc7d9c3d2e0bc06a4af8f4f1cb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 10:29:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:27 +02:00

Revert "objtool: Support addition to set CFA base"

Commit 468af56a7bba ("objtool: Support addition to set CFA base") was
added as a preparatory patch for arm64 support, but that support never
came.  It triggers a false positive warning on x86, so just revert it
for now.

Fixes the following warning:

  vmlinux.o: warning: objtool: cdce925_regmap_i2c_write+0xdb: stack state mismatch: cfa1=4+120 cfa2=5+40

Fixes: 468af56a7bba ("objtool: Support addition to set CFA base")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/oe-kbuild-all/202304080538.j5G6h1AB-lkp@intel.com/
---
 tools/objtool/check.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cae6ac6..9440b07 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3002,17 +3002,6 @@ static int update_cfi_state(struct instruction *insn,
 				break;
 			}
 
-			if (!cfi->drap && op->src.reg == CFI_SP &&
-			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
-			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
-
-				/* lea disp(%rsp), %rbp */
-				cfa->base = CFI_BP;
-				cfa->offset -= op->src.offset;
-				cfi->bp_scratch = false;
-				break;
-			}
-
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
