Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AD733EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjFQGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjFQGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9D295B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:50 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FK7vwTwMdaSFQCi5hicS/BB05pqp6xuCyXFiX4Y4XvQ=;
        b=DovnS+EwueUXlVBPe+lrvwm+bLPA2awXt21THiaUSxQjE3psynnjLPDPphu2UA3sxFiK2A
        mBIYFkmT7y9wbMM5VPx5WG2s57L4P2qNjMuHcLvQkdNll4HIKWIdGpDLwFMfWHmKqBvqgA
        XbvarldZRBQjx8zraXV5diC8wg87JomjXC1PsQy8gLYDsOU+z8tCOHF8dDZGcETJ+kwWbq
        BYkDTp+maDLR7RWKC8+aZf7p6YVhdA9yafIWM/ZlAoY9I+JGmk4LOQApiKptn4SK1V0Z9l
        lzgNv7nNuUyRfAmqeyR6Ffjc4pMaTcZxo7Q7cOmy3480KhD1fbjCfaUYNnoeag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FK7vwTwMdaSFQCi5hicS/BB05pqp6xuCyXFiX4Y4XvQ=;
        b=8a8cyVlg1csfNy0S2FHWnNBgLX0601ee+0mFBkH3VADGisAtP+bCoc2SdRBKxV5q+EYfZC
        MwhfSDVy9F7C62Bg==
From:   "irqchip-bot for Marek Vasut" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Add STM32MP15xx IWDG2
 EXTI to GIC map
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marek Vasut <marex@denx.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230517194349.105745-1-marex@denx.de>
References: <20230517194349.105745-1-marex@denx.de>
MIME-Version: 1.0
Message-ID: <168698398896.404.16254885199442815024.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1c5187968846fd252d42924fd54f3aad5a6ad7ff
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1c5187968846fd252d42924fd54f3aad5a6ad7ff
Author:        Marek Vasut <marex@denx.de>
AuthorDate:    Wed, 17 May 2023 21:43:47 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:25:32 +01:00

irqchip/stm32-exti: Add STM32MP15xx IWDG2 EXTI to GIC map

The EXTI interrupt 46 is mapped to GIC interrupt 151. Add the
missing mapping, which is used for IWDG2 pretimeout interrupt
and wake up source.

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230517194349.105745-1-marex@denx.de
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6a3f749..f684be7 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -208,6 +208,7 @@ static const u8 stm32mp1_desc_irq[] = {
 	[31] = 53,
 	[32] = 82,
 	[33] = 83,
+	[46] = 151,
 	[47] = 93,
 	[48] = 138,
 	[50] = 139,
