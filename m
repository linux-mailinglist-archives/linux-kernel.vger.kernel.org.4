Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF50642704
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLEK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:59:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD56DDF9B;
        Mon,  5 Dec 2022 02:59:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 10:59:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670237962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvAvPykNMRYlrbzOwQu7gWUpRqhoBIZ03TOr0pZ9ZRI=;
        b=mkRei7HnxmV7UMGuVNhSuHv9j6HB3wf9OkOu+4yZEKFFiRga1zth/EHHFlyUtOmbhD24MN
        g5NKOZN9S/wg0C2N6TqDj0wz1idGmNcsFAJeOTo+tN/nPnSrKuHEcdFE9nexPtAtf0fTQv
        a3tpylOZ3XuqPgXBoXR/9+y17h7a9C3TxFTIQGyIqOxa/uWyC5QVdlt1heIMFDq5b1g7wi
        CJfqbY7urJ9iJsY826oDY5E4wNRWr1PPjkk5B6LmfEY02eQsaVk14iYgOT0aRgX+aEDO5l
        13C/iTPwoWYdxqq8/0Uwp9O1bujhxH7QwmOtvtDRvLEsbV1xUn3lAwR2ikRJPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670237962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvAvPykNMRYlrbzOwQu7gWUpRqhoBIZ03TOr0pZ9ZRI=;
        b=Pld4Gmg78gPryYe0JPDmhdQ8FkOEQnocOyZ2BGVCLB8U98cAq5Bx4cKoMsOxHEVbg1KF7A
        nvdl4F6bP3ZX4nCQ==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] uprobes/x86: Allow to probe a NOP instruction with
 0x66 prefix
Cc:     Seiji Nishikawa <snishika@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221204173933.GA31544@redhat.com>
References: <20221204173933.GA31544@redhat.com>
MIME-Version: 1.0
Message-ID: <167023796182.4906.2250449121984358359.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cefa72129e45313655d53a065b8055aaeb01a0c9
Gitweb:        https://git.kernel.org/tip/cefa72129e45313655d53a065b8055aaeb01a0c9
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 04 Dec 2022 18:39:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 11:55:18 +01:00

uprobes/x86: Allow to probe a NOP instruction with 0x66 prefix

Intel ICC -hotpatch inserts 2-byte "0x66 0x90" NOP at the start of each
function to reserve extra space for hot-patching, and currently it is not
possible to probe these functions because branch_setup_xol_ops() wrongly
rejects NOP with REP prefix as it treats them like word-sized branch
instructions.

Fixes: 250bbd12c2fe ("uprobes/x86: Refuse to attach uprobe to "word-sized" branch insns")
Reported-by: Seiji Nishikawa <snishika@redhat.com>
Suggested-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20221204173933.GA31544@redhat.com

---
 arch/x86/kernel/uprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index b63cf8f..6c07f6d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -722,8 +722,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
 		break;
+	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
+		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
@@ -753,6 +754,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 			return -ENOTSUPP;
 	}
 
+setup:
 	auprobe->branch.opc1 = opc1;
 	auprobe->branch.ilen = insn->length;
 	auprobe->branch.offs = insn->immediate.value;
