Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1064FBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLQS5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLQSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFBF25;
        Sat, 17 Dec 2022 10:55:39 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qqEbo2z0uGyJboC2Y5J4/W6tlDZ63PWcNPiBneyAlk=;
        b=0bPGqo5PkP3XzoOcWO52eimc7GNoyits8Zm0L2mPI6QVZa9Fg8RqMQ+I7tgztRvB8ixjG7
        9pxEUlfOr7S27xBcDBca6lXUnmT2RskK3VZ/XDjO0BzLsISDr6imxZRuB6W1qV/UMTO9An
        0o908NQ+uezpzO6SBgotpN/NrSQroP6NCFC+jQLZ1m90uklyX3cy/jSRw9BEZ+IVdfUvip
        FLA4NlLSjsbcTymRToJo9qqNdW/uzYsBRxedWTZrDyGat/bDCmf8pSQQPJ20J3Yj/ra6Dv
        qePkYUz6adPuPWGCdPzaQT5JIxjOOX/3IDx6PMIWFODhZ2e4ypp+kRn+E7Abdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qqEbo2z0uGyJboC2Y5J4/W6tlDZ63PWcNPiBneyAlk=;
        b=c/TfriQDxsNwmvKuDZo1NFHVOX+oBxa9ApPpPB/FA9UJmQd6L1hlvqohq7gV9grOxrtOUz
        1Q68gd20Dbsa/QBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Do verify W^X at boot up
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221025201058.011279208@infradead.org>
References: <20221025201058.011279208@infradead.org>
MIME-Version: 1.0
Message-ID: <167130333490.4906.16809810464935518091.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     414ebf148cb5c5fa727ec51fdb69c4ab82dccf3b
Gitweb:        https://git.kernel.org/tip/414ebf148cb5c5fa727ec51fdb69c4ab82dccf3b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:39:43 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

x86/mm: Do verify W^X at boot up

Straight up revert of commit:

  a970174d7a10 ("x86/mm: Do not verify W^X at boot up")

now that the root cause has been fixed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221025201058.011279208@infradead.org
---
 arch/x86/mm/pat/set_memory.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2e5a045..97342c4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -587,10 +587,6 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
-	/* Kernel text is rw at boot up */
-	if (system_state == SYSTEM_BOOTING)
-		return new;
-
 	/*
 	 * 32-bit has some unfixable W+X issues, like EFI code
 	 * and writeable data being in the same page.  Disable
