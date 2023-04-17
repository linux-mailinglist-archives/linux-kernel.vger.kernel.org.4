Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712C16E45BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDQKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDQKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3037B107;
        Mon, 17 Apr 2023 03:50:06 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3cRL4xoLBwh2G97fXLQqe8IVnTzzLGQ4Y5MoSfBc5s=;
        b=rOL5U705iJEb1ShdBIQIqUzEZapRrZBO689JkOVsrGnHpPNRceGP+z2dqgEsY+dYtsCDUa
        FyCAJIActZMM24YFX6+GRSHpD4kvSCl0svEIaK63q1LWKLCAI/SXRJkvcqv0DoVLOVJp5O
        50eeBXSJO0nhmbmTm8LkKgFyUrMKakn4OOW/o4yBeTiKcVXf+PYaRBR6LQ9QAhEadaFcdK
        NsTnxKmepP2jIa6xAzaQ1obo0KtiSS8JwFZXnnB/Tu5rc80CyDbfI10NTa539Ox0K9HfgK
        qNNtL+TAR0Zfd1p3/K8HBxGD4XJDSwfvWnwt/EjWVUHngblmog2adpkmAWUlgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3cRL4xoLBwh2G97fXLQqe8IVnTzzLGQ4Y5MoSfBc5s=;
        b=AboNt+p9+L2G8vEp723DBokzNWWDFj/HYLW05qL0SqwkSQkg/+YTCiZC+7+CFCfQnwvpYv
        rbrkH7r5P9elo3Bw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Include weak functions in global_noreturns check
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org>
References: <ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840649.404.8270052350550677405.tip-bot2@tip-bot2>
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

Commit-ID:     1c47c8758a11345ac643fa68cb70b708a6668883
Gitweb:        https://git.kernel.org/tip/1c47c8758a11345ac643fa68cb70b708a6668883
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:26 +02:00

objtool: Include weak functions in global_noreturns check

If a global function doesn't return, and its prototype has the
__noreturn attribute, its weak counterpart must also not return so that
it matches the prototype and meets call site expectations.

To properly follow the compiled control flow at the call sites, change
the global_noreturns check to include both global and weak functions.

On the other hand, if a weak function isn't in global_noreturns, assume
the prototype doesn't have __noreturn.  Even if the weak function
doesn't return, call sites treat it like a returnable function.

Fixes the following warning:

  kernel/sched/build_policy.o: warning: objtool: do_idle() falls through to next function play_idle_precise()

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8d073bf..ae0c942 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -236,14 +236,14 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	if (!func)
 		return false;
 
-	if (func->bind == STB_WEAK)
-		return false;
-
-	if (func->bind == STB_GLOBAL)
+	if (func->bind == STB_GLOBAL || func->bind == STB_WEAK)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
 				return true;
 
+	if (func->bind == STB_WEAK)
+		return false;
+
 	if (!func->len)
 		return false;
 
