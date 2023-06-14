Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90097730638
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbjFNRnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjFNRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:42:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417CE43;
        Wed, 14 Jun 2023 10:42:56 -0700 (PDT)
Date:   Wed, 14 Jun 2023 17:42:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686764575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntZkBUJtac81cXHWHcoh+F7kGceASVAOizr14nWNrKg=;
        b=hAIWd8nI3fYDHtyR2wUV06zMD4WZ2mAzpM9r2cCb9SnFohOfRVM9nMCpuXcqIq9gYyr2lA
        gfZIBKlJNPJNPu8HkUevIlJ41BJQ0u4qrJBIzcqCTMJBruRKFlCstffXbqDpjudRbQkJKy
        /5RmSA37zMrkyPazJ2olX015hpwKRlEOBtgqupAeXkpVTxVR88r3u1Q20pddkThm7J+XH8
        hofR9cHiayMdNqGQhBtdPu3iMRTvmJDlR2wZfZOCCvBcZeo07zcUB+jiMf5sSJoHM4FB1n
        APsUP4AfUrMrjP/dMg6rM9ybrGKtImwZkCQAhUUVFSk3S0sRJafNffYrzEmumw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686764575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntZkBUJtac81cXHWHcoh+F7kGceASVAOizr14nWNrKg=;
        b=52YXpUoazXAkyPaXjmCF9fPFBBftkVrSN3YloOUZFt9Zs1Hxmhhyjxs4nbjr3L5l3ybNdW
        FOW0rT9Dyofi3RDg==
From:   "tip-bot2 for Steven Rostedt (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531092419.4d051374@rorschach.local.home>
References: <20230531092419.4d051374@rorschach.local.home>
MIME-Version: 1.0
Message-ID: <168676457481.404.7166372409577741142.tip-bot2@tip-bot2>
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

Commit-ID:     9350a629e839ca1c2b529a83a916cf2370bd1c64
Gitweb:        https://git.kernel.org/tip/9350a629e839ca1c2b529a83a916cf2370bd1c64
Author:        Steven Rostedt (Google) <rostedt@goodmis.org>
AuthorDate:    Wed, 31 May 2023 09:24:19 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 14 Jun 2023 18:50:00 +02:00

x86/alternatives: Add cond_resched() to text_poke_bp_batch()

Debugging in the kernel has started slowing down the kernel by a
noticeable amount. The ftrace start up tests are triggering the softlockup
watchdog on some boxes. This is caused by the start up tests that enable
function and function graph tracing several times. Sprinkling
cond_resched() just in the start up test code was not enough to stop the
softlockup from triggering. It would sometimes trigger in the
text_poke_bp_batch() code.

When function tracing enables all functions, it will call
text_poke_queue() to queue the places that need to be patched. Every
256 entries will do a "flush" that calls text_poke_bp_batch() to do the
update of the 256 locations. As this is in a scheduleable context,
calling cond_resched() at the start of text_poke_bp_batch() will ensure
that other tasks could get a chance to run while the patching is
happening. This keeps the softlockup from triggering in the start up
tests.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230531092419.4d051374@rorschach.local.home
---
 arch/x86/kernel/alternative.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0747d29..bbfbf7a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2119,6 +2119,16 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	atomic_set_release(&bp_desc.refs, 1);
 
 	/*
+	 * Function tracing can enable thousands of places that need to be
+	 * updated. This can take quite some time, and with full kernel debugging
+	 * enabled, this could cause the softlockup watchdog to trigger.
+	 * This function gets called every 256 entries added to be patched.
+	 * Call cond_resched() here to make sure that other tasks can get scheduled
+	 * while processing all the functions being patched.
+	 */
+	cond_resched();
+
+	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * nr_entries and handler are correctly ordered wrt. patching.
 	 */
