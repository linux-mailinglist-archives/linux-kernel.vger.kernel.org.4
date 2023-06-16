Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4333A732FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjFPLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjFPLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:25:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D671FF9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:28 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:25:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686914727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G22dwzIlCJuuAAqHAywFRu3WniA79YSRhjQkgApGuTg=;
        b=gxwRumIME4Z5TsKu9r9aMYNHwy3Z8oSR3UMyxdgw2b1M4SA8/QGnpsJ85KG5S+qg+9gArh
        O754Y5cICf8okW0LPvD+Tl9l50X+bkLsMqAQkuXcpReuJn1dvNpvU8PuLtMpVLyGa4bFVy
        jrcuVRIyxBaaYna5XZfw3FIUGefyhFiinNPAjrr0XP8LPW1Ft4nCafVMSu1eAxeJjBr+4i
        ShUsVvgGGbY6qY7dygNmCaM8oDWsEsiaPE0Go7HgWWG6jBa44KCCMc3i/kL0bEjF9cWReC
        ChOwmGVLVJ7kd2+ioUct3vQFn5rYYPEXecjFxZ58uLX4X/qxtj1qkj49Ef7YlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686914727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G22dwzIlCJuuAAqHAywFRu3WniA79YSRhjQkgApGuTg=;
        b=BwrX1l/8cVZVJhsMn/Hp/zH82K7mweTjogyKjBzIp+0/YTR1BPiZ9nb0GdjyTqqgFULaRo
        oXp7MsEKoc/St0Dw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Use BIT() for the IRQD_* state flags
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <168691472694.404.16292215695049776270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0cfb4a1af386427cdaba98f18f501eb074985cfd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0cfb4a1af386427cdaba98f18f501eb074985cfd
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 15 Jun 2023 14:58:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:22:00 +01:00

genirq: Use BIT() for the IRQD_* state flags

As we're about to use the last bit available in the IRQD_* state
flags, rewrite these flags with BIT(), which ensures that these
constant do not represent a signed value.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28af..d9c86db 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -226,29 +226,29 @@ struct irq_data {
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
-	IRQD_SETAFFINITY_PENDING	= (1 <<  8),
-	IRQD_ACTIVATED			= (1 <<  9),
-	IRQD_NO_BALANCING		= (1 << 10),
-	IRQD_PER_CPU			= (1 << 11),
-	IRQD_AFFINITY_SET		= (1 << 12),
-	IRQD_LEVEL			= (1 << 13),
-	IRQD_WAKEUP_STATE		= (1 << 14),
-	IRQD_MOVE_PCNTXT		= (1 << 15),
-	IRQD_IRQ_DISABLED		= (1 << 16),
-	IRQD_IRQ_MASKED			= (1 << 17),
-	IRQD_IRQ_INPROGRESS		= (1 << 18),
-	IRQD_WAKEUP_ARMED		= (1 << 19),
-	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
-	IRQD_AFFINITY_MANAGED		= (1 << 21),
-	IRQD_IRQ_STARTED		= (1 << 22),
-	IRQD_MANAGED_SHUTDOWN		= (1 << 23),
-	IRQD_SINGLE_TARGET		= (1 << 24),
-	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
-	IRQD_CAN_RESERVE		= (1 << 26),
-	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
-	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
+	IRQD_SETAFFINITY_PENDING	= BIT(8),
+	IRQD_ACTIVATED			= BIT(9),
+	IRQD_NO_BALANCING		= BIT(10),
+	IRQD_PER_CPU			= BIT(11),
+	IRQD_AFFINITY_SET		= BIT(12),
+	IRQD_LEVEL			= BIT(13),
+	IRQD_WAKEUP_STATE		= BIT(14),
+	IRQD_MOVE_PCNTXT		= BIT(15),
+	IRQD_IRQ_DISABLED		= BIT(16),
+	IRQD_IRQ_MASKED			= BIT(17),
+	IRQD_IRQ_INPROGRESS		= BIT(18),
+	IRQD_WAKEUP_ARMED		= BIT(19),
+	IRQD_FORWARDED_TO_VCPU		= BIT(20),
+	IRQD_AFFINITY_MANAGED		= BIT(21),
+	IRQD_IRQ_STARTED		= BIT(22),
+	IRQD_MANAGED_SHUTDOWN		= BIT(23),
+	IRQD_SINGLE_TARGET		= BIT(24),
+	IRQD_DEFAULT_TRIGGER_SET	= BIT(25),
+	IRQD_CAN_RESERVE		= BIT(26),
+	IRQD_MSI_NOMASK_QUIRK		= BIT(27),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(28),
+	IRQD_AFFINITY_ON_ACTIVATE	= BIT(29),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(30),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
