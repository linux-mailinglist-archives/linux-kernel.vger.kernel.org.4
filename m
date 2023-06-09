Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE17291D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbjFIH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjFIHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:55:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB141BE2;
        Fri,  9 Jun 2023 00:55:25 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:55:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686297315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6FqFH1BcUytgqX4QKu6xifdNtfoGeELk4tAxVMyGeg=;
        b=HXuE+w7Dm3yxc6KfeAmuQen4ZEiCLEoqXCE0+BoFCME8c6NxNHkGWj7xNYAvuUPJ8ynbHp
        yZ/XUYYlZ0kxxpC0v9oXm2w2NgGecWrkUMYYy2z8XGBZE+FZo4bp44sQWYaqZ4CfpOsoTm
        kBoEYqZYdMQbosbu1pJ1KjYkRwRanzJFKe+Mg0CTBcsLeIfdpMhmCeYnYRJDW+yXPu+SpE
        WdenkcA5OOMnURRdC9WdsBAnTVkh+meAnPJBgZ9+Rn6gDlc+qU5uX8MfEfmKnDqPpGejaN
        s/OL6kZe/xsyPf8C2BuKgT/XzFR1kS9k3rKPA5YC/gMGXN+SfdaUTyR3OOV9uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686297315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6FqFH1BcUytgqX4QKu6xifdNtfoGeELk4tAxVMyGeg=;
        b=bXlnvLXqk8XNGDfJmxMlGjIHwA/9V4Ihxb29PCFQIl/LZqG74lptlhlNyL7qohJa+kC1OI
        6nxePkJoApN2rFDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64/arch_timer: Fix MMIO byteswap
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606080614.GB905437@hirez.programming.kicks-ass.net>
References: <20230606080614.GB905437@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168629731478.404.15268928192840800699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5416bf1cf5602ab3a38b4c0d15ccec1ca4199633
Gitweb:        https://git.kernel.org/tip/5416bf1cf5602ab3a38b4c0d15ccec1ca4199633
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Jun 2023 10:06:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jun 2023 10:19:51 +02:00

arm64/arch_timer: Fix MMIO byteswap

The readl_relaxed() to __raw_readl() change meant to loose the
instrumentation, but also (inadvertently) lost the byteswap.

Fixes: 24ee7607b286 ("arm64/arch_timer: Provide noinstr sched_clock_read() functions")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20230606080614.GB905437@hirez.programming.kicks-ass.net
---
 drivers/clocksource/arm_arch_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b23d23b..e733a2a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -776,9 +776,9 @@ static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
 	u32 cnt_lo, cnt_hi, tmp_hi;
 
 	do {
-		cnt_hi = __raw_readl(t->base + offset_lo + 4);
-		cnt_lo = __raw_readl(t->base + offset_lo);
-		tmp_hi = __raw_readl(t->base + offset_lo + 4);
+		cnt_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
+		cnt_lo = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
+		tmp_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
 	} while (cnt_hi != tmp_hi);
 
 	return ((u64) cnt_hi << 32) | cnt_lo;
