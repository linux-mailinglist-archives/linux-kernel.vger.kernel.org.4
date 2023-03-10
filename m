Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2F6B5263
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCJU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCJUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831B13B2A9;
        Fri, 10 Mar 2023 12:54:57 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBWg/DR4Hke3Z1o2x99mcKWAlfHQVtpi4pzh5iMUYvI=;
        b=ANTgaut3mPNb5LvRS1zKh8BX4hwr1voMqWf/5qqFqbD4YDuyJHrY207OdofQ9YwvZBVaZ0
        WvPiDD3GeHe7dj2T2q1RLw5Vhgw+aEtzA3BMNDC+oor+QQo0HBWDPaxIX7UxQ6kIRyFLzF
        pAtv0ETzMr03eojAZpuIE3oKLbl5DUG6U3ZqugZJZcgztF54eQCbbsU2SoOo+nkAMpvJaQ
        VNLkjsWpbYy8LbKlisorScryzrAkvHM4Vef4v5aWd9UwL1ieZDeW62FgbP12jF5p1xzlo2
        237EvI1evVozsm4yf0Q5aHPI+3VZj2qrGs4cIvzs+pO3DCPIYxFL1ECKiIaF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBWg/DR4Hke3Z1o2x99mcKWAlfHQVtpi4pzh5iMUYvI=;
        b=vLBCPOKsSsxsyrxzQeXCMzNMvXZ7in0880KmPf7uh3jgNsWKZLjcdkqKSZcLgVQ+LFZY6q
        LqjeY2T24dFVF3Dg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] alpha/cpu: Make sure arch_cpu_idle_dead() doesn't return
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <19ffef09a175fecb783abcd44d6bcfeade2857eb.1676358308.git.jpoimboe@kernel.org>
References: <19ffef09a175fecb783abcd44d6bcfeade2857eb.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169589.5837.10610874531476586578.tip-bot2@tip-bot2>
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

Commit-ID:     550db6795e9bb0b1b40f9c52bbe3d0ee735dbdb0
Gitweb:        https://git.kernel.org/tip/550db6795e9bb0b1b40f9c52bbe3d0ee735dbdb0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:36 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:03 -08:00

alpha/cpu: Make sure arch_cpu_idle_dead() doesn't return

arch_cpu_idle_dead() doesn't return.  Make that more explicit with a
BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Link: https://lore.kernel.org/r/19ffef09a175fecb783abcd44d6bcfeade2857eb.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/alpha/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 3251102..a82fefa 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -63,6 +63,7 @@ void arch_cpu_idle(void)
 void arch_cpu_idle_dead(void)
 {
 	wtint(INT_MAX);
+	BUG();
 }
 #endif /* ALPHA_WTINT */
 
