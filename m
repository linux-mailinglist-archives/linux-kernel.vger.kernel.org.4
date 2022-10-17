Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB9601229
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJQO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiJQO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8176AE8D;
        Mon, 17 Oct 2022 07:55:19 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHE5BUe4f/3zSTaUPJQMMr/NoAiSUzmhhG4WIp8BV+Q=;
        b=R8ttylc2pg+g9C691l+N8T2tLKpKHB0X1Vt5kcygNHqTnkuiZg70Lli1bXw+0JZJc2yHCn
        nT3g92DVDuhC5q6JW+rvMRQ6Ok7vZAYZ2MjhOVjeiDmWORusmWUShnmvXNW9NdLrW+ydo/
        ZYCGH8DO4oBJ2O80eCgoWPXcSaLHut+H9hkWEJSONpsN/FLuYKYpe/YuOdDPByHLxD59OI
        C1eEz0MMiBHZJ510NR9KoK8jzgYmIeM50RdtWZwNOKVTEzDmL5f4TlGw/aAEpXhqxVN/BQ
        oETrT0Qma5RU3wq/W0akgBy/VqEtlGR5D/imQP/nWT8GNnkZlK3vzUg8jhv+iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHE5BUe4f/3zSTaUPJQMMr/NoAiSUzmhhG4WIp8BV+Q=;
        b=xElgjLGEBdfG8mkn9e1k3SEyOfaGKomhnho2IztoGQtzpkWjNO035TaWu+Z0+yE2MpwVMc
        gNPvX+k6iFRJhyAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/error_inject: Align function properly
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.930201368@infradead.org>
References: <20220915111143.930201368@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846243.401.16360337742759626779.tip-bot2@tip-bot2>
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

Commit-ID:     1934dc9a8a92fda36ab80cfd55edab1708dcdf9a
Gitweb:        https://git.kernel.org/tip/1934dc9a8a92fda36ab80cfd55edab1708dcdf9a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:10:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:59 +02:00

x86/error_inject: Align function properly

Ensure inline asm functions are consistently aligned with compiler
generated and SYM_FUNC_START*() functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.930201368@infradead.org
---
 arch/x86/lib/error-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 1e3de07..b5a6d83 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -11,6 +11,7 @@ asm(
 	".text\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
+	ASM_FUNC_ALIGN
 	"just_return_func:\n"
 		ANNOTATE_NOENDBR
 		ASM_RET
