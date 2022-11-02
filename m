Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB0615F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiKBJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiKBJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3EF2934B;
        Wed,  2 Nov 2022 02:12:52 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcwLzVCBmz29JFQ1vIp0KD7wCCpLS+HKSEoCyPXyhAY=;
        b=4lDKa0CT38FW7LCYVTrSX5zbRVVeZcLaD8zQGeWOnjAxSEfyDj/nq3ibfbu3ufpOmYGPfG
        wMNekJbXbGM/dEwGRPZmm6FKan4JWmk9Nlr9SKcMa0VimMS5tbg3UjjxXz765BN2CqwHoy
        kO1xrVL9v+758v+XWAlczHtkbmH2cTxHeyfJHrZcoGbJ2DZhbOsYvNflh7vVbfV7MJ1yI2
        IPUYo2ddJVzs5vwkEcOayem+GX6JEIKXUsilvJDAd2KoWjSkGUBLdUEdaQzY95TsIOrSV9
        2KXRidcdMuPbvAWqCJb4AkH3g2ZuJkTqBx1aM4TZV9GPa7IslCwCxh9qKmCXKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcwLzVCBmz29JFQ1vIp0KD7wCCpLS+HKSEoCyPXyhAY=;
        b=y9vVLSIxBwdXWd0rXUTQ886FnwKDhn76JyauQHa+Pi7ynEZuqsIjrriYKEXgiG1f/YGIeQ
        c6G069hqxtMgDcDw==
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
Message-ID: <166738036942.7716.6212112990239698813.tip-bot2@tip-bot2>
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

Commit-ID:     237c7e967566ca7048fd7e74951fccb026f92df0
Gitweb:        https://git.kernel.org/tip/237c7e967566ca7048fd7e74951fccb026f92df0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:39:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:58 +01:00

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
