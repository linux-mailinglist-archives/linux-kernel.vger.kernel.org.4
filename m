Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEE656A55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiL0MAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiL0L7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:59:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24734B7F5;
        Tue, 27 Dec 2022 03:59:18 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:59:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672142356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iqAaKJfRk6rZtNTrGoo86R4tttMmLNYvpxtFe/8uMQ=;
        b=a2bc7NZ0C4QuX7KiujnTBhlwvSlrRfOLQ4QGtQRNMLr4WJK5ORVr/uOMtpp2KzQ4c7JvVw
        HyUO6dnmtVZkYdycX3oukMOeWmX2orVW/q2VFKv5Ey8O0eXHs8nB1Y6dQllubgh9ZRLYXK
        N2NMJAfLgV7h2UbjMAzGik1cuG8L9c6s18RpxWVBZFi9CvASVG4nuhNed/SbLNOEcbKGtw
        u/nCqL/5EDJiuQx2/pgah2AAjw9sZNJGkebOu60cmIT3EUUoV0ZdbMuYNGlTE6f8EhMOig
        fFNypQngHcjpm/xVbpUrSuHqKoRh6ALLLtoPHT6vZ6j+AfF04Gt/jPDfvQMalg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672142356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iqAaKJfRk6rZtNTrGoo86R4tttMmLNYvpxtFe/8uMQ=;
        b=Qkq88T6V+9wSNySeT77jwo/lEkusWNf66uaM8mSKjI62l3MBFtYrqs5nWqFfpqWPWazral
        ubFwLU6coi/n2zBg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/calldepth: Fix incorrect init section references
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221215164334.968863-1-arnd@kernel.org>
References: <20221215164334.968863-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <167214235637.4906.10804629490623439525.tip-bot2@tip-bot2>
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

Commit-ID:     ade8c20847fcc3f4de08b35f730ec04ef29ddbdc
Gitweb:        https://git.kernel.org/tip/ade8c20847fcc3f4de08b35f730ec04ef29ddbdc
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 15 Dec 2022 17:43:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:51:58 +01:00

x86/calldepth: Fix incorrect init section references

The addition of callthunks_translate_call_dest means that
skip_addr() and patch_dest() can no longer be discarded
as part of the __init section freeing:

WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> patch_dest (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: is_callthunk.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221215164334.968863-1-arnd@kernel.org
---
 arch/x86/kernel/callthunks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 7d2c75e..ffea98f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -119,7 +119,7 @@ static bool is_coretext(const struct core_text *ct, void *addr)
 	return within_module_coretext(addr);
 }
 
-static __init_or_module bool skip_addr(void *dest)
+static bool skip_addr(void *dest)
 {
 	if (dest == error_entry)
 		return true;
@@ -181,7 +181,7 @@ static const u8 nops[] = {
 	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
 };
 
-static __init_or_module void *patch_dest(void *dest, bool direct)
+static void *patch_dest(void *dest, bool direct)
 {
 	unsigned int tsize = SKL_TMPL_SIZE;
 	u8 *pad = dest - tsize;
