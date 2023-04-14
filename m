Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1686E261F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjDNOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDNOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE932B771;
        Fri, 14 Apr 2023 07:47:56 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQvYuxUC/QcIQvw+Ivq8Y82aImbh6rzooJmlsMHXwBc=;
        b=SuEmgiALoFQt6hFhTxL6puYYkE6UrSCxOidJ5g1yM+rnoj0RZ+5HocODO4w9xPCsRdEXOD
        eC4mRI9bDNJ+Tq7hN98UA4lCCjzmxKBuHGfwhr2wuVS6BD9yppqUr4VX0eFqe2PZ9rZ+Os
        jox5XNzG9I/OWBP0ITUNcOKQQxFeqqQ/8smPZMPwYetFKaSuxDCcn3vKcKOvTV8pJhxMV1
        yUBceoYf6tkfJCqSZfHSgFyvyAE2pAYrRKXT0AhB6DESy0aXRs2I0FDafg3RWKLYPZFrEc
        kXQ/JojtwLkxfxIm3r3NB0XNT/Jfm96zqnzbgOR0+PFZCAGos1HGyvyfxV0y9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQvYuxUC/QcIQvw+Ivq8Y82aImbh6rzooJmlsMHXwBc=;
        b=qCM4DzgGhCCpg7dP1iHj2PVygRqIaTc49pGiThYiLxNNRzNUYVyZy+LsfPWx9vaOVuyDcG
        nA2hjG7TtUhfg9BQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove superfluous dead_end_function() check
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5d603a301e9a8b1036b61503385907e154867ace.1681325924.git.jpoimboe@kernel.org>
References: <5d603a301e9a8b1036b61503385907e154867ace.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367520.404.8281581917129598548.tip-bot2@tip-bot2>
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

Commit-ID:     6126ed5dfbc656374e851bfdfb128f3aa9e1263a
Gitweb:        https://git.kernel.org/tip/6126ed5dfbc656374e851bfdfb128f3aa9e1263a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 12:03:22 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:29 +02:00

objtool: Remove superfluous dead_end_function() check

annotate_call_site() already sets 'insn->dead_end' for calls to dead end
functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/5d603a301e9a8b1036b61503385907e154867ace.1681325924.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9de3972..1cf2e28 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4078,8 +4078,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn = prev_insn_same_sec(file, insn);
-	if ((prev_insn->dead_end ||
-	     dead_end_function(file, insn_call_dest(prev_insn))) &&
+	if (prev_insn->dead_end &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
