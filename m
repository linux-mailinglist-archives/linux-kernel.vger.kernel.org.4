Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BA601209
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJQO6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJQO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:57:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB469F45;
        Mon, 17 Oct 2022 07:54:58 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/bMudpa5gTmZ9hfllAlrxNOnF11rbHrfs2Q31WspBQ=;
        b=D2EITnlmp+ns8u6PL9Gfage+5aCIaEPtDVe9C1Y3JnIdcYTqc5vUJF2whnZMPlIDJwwanA
        dL+SXuiV9cNeHU2X8SLcAyEUkdf0fF+UlWFYo0gtijWn0WhayXxulJzaKDDt3BSp/YcV3L
        0a744ABL8oS3UTmplp4V28T+AOcbNdnxVm0MBNbuSk6kTPvMwEzQT0DABzAo1GWLjPVuZ9
        DCm24F00sI8Cz8r8tKbJIAvbFa1a6HLohkne7nZeWw/pwL7zOzfEC4r2/+Te/9SftN+Arx
        mynxbvlwbold0XXR0oLbGuPhsJTHqWl8sv2dSWuBt0AkAhQBis+b8Dk1FEzmOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/bMudpa5gTmZ9hfllAlrxNOnF11rbHrfs2Q31WspBQ=;
        b=tAMEfsX5XopNsQlgwrHLMZpqsOAKe1iqR9mG8Oeg1rg8uNh5SHk8iACc98j7hVFYtABjsX
        vlOq4hLzWcBbLbAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Sanitize linker script
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.614728935@infradead.org>
References: <20220915111143.614728935@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846568.401.9844468920539425423.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     24a9c543d2114d416f84e386c2fa90089bd97e4c
Gitweb:        https://git.kernel.org/tip/24a9c543d2114d416f84e386c2fa90089bd97e4c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:57 +02:00

x86: Sanitize linker script

The section ordering in the text section is more than suboptimal:

    ALIGN_ENTRY_TEXT_BEGIN
    ENTRY_TEXT
    ALIGN_ENTRY_TEXT_END
    SOFTIRQENTRY_TEXT
    STATIC_CALL_TEXT
    INDIRECT_THUNK_TEXT

ENTRY_TEXT is in a seperate PMD so it can be mapped into the cpu entry area
when KPTI is enabled. That means the sections after it are also in a
seperate PMD. That's wasteful especially as the indirect thunk text is a
hotpath on retpoline enabled systems and the static call text is fairly hot
on 32bit.

Move the entry text section last so that the other sections share a PMD
with the text before it. This is obviously just best effort and not
guaranteed when the previous text is just at a PMD boundary.

The text section placement needs an overhaul in general. There is e.g. no
point to have debugfs, sysfs, cpuhotplug and other rarely used functions
next to hot path text.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.614728935@infradead.org
---
 arch/x86/kernel/vmlinux.lds.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 15f2905..0e9fc08 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,18 +132,19 @@ SECTIONS
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
-		ALIGN_ENTRY_TEXT_BEGIN
-		ENTRY_TEXT
-		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
-		STATIC_CALL_TEXT
-		*(.gnu.warning)
-
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
 		*(.text.__x86.*)
 		__indirect_thunk_end = .;
 #endif
+		STATIC_CALL_TEXT
+
+		ALIGN_ENTRY_TEXT_BEGIN
+		ENTRY_TEXT
+		ALIGN_ENTRY_TEXT_END
+		*(.gnu.warning)
+
 	} :text =0xcccc
 
 	/* End of text section, which should occupy whole number of pages */
