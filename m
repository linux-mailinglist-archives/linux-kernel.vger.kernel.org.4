Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603664FBF2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLQS5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLQSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB3F49;
        Sat, 17 Dec 2022 10:55:39 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oyLziOMTJoU0purFTTd8yDxf6Tw40HdsE7Rn9fFNKI=;
        b=nDWpVXhxBlIxs9v1RHdkjG5gysIbY1zolNtfKt6I3BBWG4Rh8r/9thrt+2b1Rc5q1+3LrJ
        3sndYL+nDre55VArD0qZMi6G3cfHM2ELf+SLU3hzjUqMQ+Q78kyK9422LD9lZ7hVUu+UXQ
        6fZKnf1hjm/qFRW9/qo4XJUpz3gWX4vmI/Hw90nWMNsAjW2iIQn/s5pmq5ApOgmljN8ukq
        5IOPJDhgSLs+lBsq+nxlxiadw1w/tWoV6nfXIiKTDTKhz0eetHIpI4hT/ZsR/UkTZiEjJy
        GLHGT9DCkKo++l7xNvwFAq9voQEWft6AIWx74ve5zCuoDQda1WpTzSjxtB6c/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oyLziOMTJoU0purFTTd8yDxf6Tw40HdsE7Rn9fFNKI=;
        b=E7Dna2I6zGs1AeKoQl/OqtmJxdPI8tqGUPZzBbgIAIPbhK+O3fu858De5B/0hHCfZBzb4T
        xQAGPwRLrAEhkvBA==
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
Message-ID: <167130333534.4906.12011322763172418991.tip-bot2@tip-bot2>
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

Commit-ID:     5b93a83649c7cba3a15eb7e8959b250841acb1b1
Gitweb:        https://git.kernel.org/tip/5b93a83649c7cba3a15eb7e8959b250841acb1b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:25 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

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
