Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B03615F51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiKBJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKBJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9EE29358;
        Wed,  2 Nov 2022 02:12:54 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXmWqeFOPeD+qQZdadbVwbpEDThmdSdOk9JCve6JHlc=;
        b=BJYNL48aXTk7DktXcUIavTQiEm5AWxu9dOWstUQJalIWsnVnYjI/T0vrs9AYK+kUyGNIC0
        NBLduhP9AGPkNSF0yixoOL1Pzz/ujMnzkwVOinBbIlTY5vWHjRrPaz+1zyPO12t5gHzrCX
        wtqVAHjIcnQk4SidJ+W21mw+/V4zLR7eMxcrDXfBaxxkQ2zJ0zHgaKMAyk9Pv0yKug8HQf
        zhCVRAISMEuzFzw2auXwy1HSK9edKwPNtvbmL9qp2TSLvfWAOMU/dHmZYXQwVKg2pXjEeI
        oQOPjPNyspOxJconqA4KB3EsH1ssa6FKwCq2bCPDIufMYAY0+JFhBXNZnDgkAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXmWqeFOPeD+qQZdadbVwbpEDThmdSdOk9JCve6JHlc=;
        b=JxjC3af0UcjjIOwIDHd1CfxeeLfWSd6wvspAZYaeXaHA+n2sI9Vo/mcGPsFgS8HkdiayM9
        wNJYEeg2r5nI47Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Initialize text poking earlier
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221025201057.881703081@infradead.org>
References: <20221025201057.881703081@infradead.org>
MIME-Version: 1.0
Message-ID: <166738037147.7716.13263575050649140959.tip-bot2@tip-bot2>
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

Commit-ID:     4b6f3a4cd681fa54e67c2987dfebe413cd8d5a59
Gitweb:        https://git.kernel.org/tip/4b6f3a4cd681fa54e67c2987dfebe413cd8d5a59
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:57 +01:00

x86/mm: Initialize text poking earlier

Move poking_init() up a bunch; specifically move it right after
mm_init() which is right before ftrace_init().

This will allow simplifying ftrace text poking which currently has
a bunch of exceptions for early boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221025201057.881703081@infradead.org
---
 init/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index f1d1a54..5372ea2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -996,7 +996,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	sort_main_extable();
 	trap_init();
 	mm_init();
-
+	poking_init();
 	ftrace_init();
 
 	/* trace_printk can be enabled here */
@@ -1135,7 +1135,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
