Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647E6B5265
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCJU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjCJUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E04413553A;
        Fri, 10 Mar 2023 12:54:56 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SymeUDKa3DSF68b1pHrLhL33sIy61tisuwLPE9bkyzM=;
        b=pHHQ3qI0VVvB4B/QmFgYuI5CtIu7qokWeuSzdPuNQSunaaqqRTaKzE7GpC9T6h6sgG9R05
        dssNHH/M3kP+UpvpExCa2iaKYnC2kS+CkDUZCmY6BLAoWBfg6mITqexjhrbbH4WDKsHvz5
        eEJ/nVbaaSWL8jwohB8ykX99am5K04CnO1kBLOw5D7q8FugxVfZqHnPUy2bz7NVcOB/jnK
        nxbBX8XWIr1wh/Gxbo2LIAsp9LO0ZWDXSRpvVs4XMEw9uYU4ERONWf7rA6aIQASqPdop2A
        4owizD3vBXop6NLppWoWZpGdN9gEwQPB3U+Xi9HcQyS7i1xrOYhp9vdR0dRxPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SymeUDKa3DSF68b1pHrLhL33sIy61tisuwLPE9bkyzM=;
        b=j2XS2wRiOueYJJD0uftlMVJqpiBsDnAeDwHisvXQO9LNZ44A/cSlq+/fg9lvH87OOYmuZk
        8pU1nsdEKXi9UMBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] csky/cpu: Make sure arch_cpu_idle_dead() doesn't return
Cc:     Guo Ren <guoren@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1e9ecc3d248e82973e80bc336fc9f97e3ba2708d.1676358308.git.jpoimboe@kernel.org>
References: <1e9ecc3d248e82973e80bc336fc9f97e3ba2708d.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169468.5837.15267243328787227151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1b2442a835a0acc7d76ae2f48ca7a94f962b29c8
Gitweb:        https://git.kernel.org/tip/1b2442a835a0acc7d76ae2f48ca7a94f962b29c8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:39 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:05 -08:00

csky/cpu: Make sure arch_cpu_idle_dead() doesn't return

arch_cpu_idle_dead() doesn't return.  Make that more explicit with a
BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/1e9ecc3d248e82973e80bc336fc9f97e3ba2708d.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/csky/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b45d107..0ec20ef 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -317,5 +317,7 @@ void arch_cpu_idle_dead(void)
 		"jmpi	csky_start_secondary"
 		:
 		: "r" (secondary_stack));
+
+	BUG();
 }
 #endif
