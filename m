Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DE7330AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbjFPMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:03:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2B295B;
        Fri, 16 Jun 2023 05:03:11 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686916989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+hO6lUsJ+fKQi1OpOmoqjBrIThguK00NWLOatsOhNc=;
        b=yYp9RbPVAjNLWiXdjkP9vM+CjCnr81j3JRnBiMH6zR7qixawBxVItUM36Aa0nq7rY6rFy7
        5xRxANEaSHGHZRP3mToZ6862+v48VH/CWzk/pv6pINs9LeJySqpuSy/U6gGhCcHPdK2w7L
        ttQ1G0AAO6g1Lkfsywuqqsn8gB6wGoW2/vJK1YKK3Q72qhVBsE8Doz4yxdU7tL3SfOOd2U
        L+DajcjYQdHJ1Nfe472BCrT98xiPzmv60R8Z03ThF18pwN/rKvtOtpYdQFCv0qinLBNv6o
        ZiXSdoEACZUpFepFkAn4wbtpK9wENoaoog5ScKB0QQO1NmZ7WD4Iu1FMZrqTKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686916989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+hO6lUsJ+fKQi1OpOmoqjBrIThguK00NWLOatsOhNc=;
        b=YNcoHxQDkwnBuccQl/QjlyWg0X+lXnSxzqX06YR2H1GINcp7azdw8O6R9KNGWEefHOZUal
        0xAs5/zp1wmIYVDg==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Fix IRQ trigger
 polarity
Cc:     stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Chong Qiao <qiaochong@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230614115936.5950-4-lvjianmin@loongson.cn>
References: <20230614115936.5950-4-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <168691698940.404.8300996918505647671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     1d7471b4e0ebba5a4bf9db4ade43619e8f2d333d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/1d7471b4e0ebba5a4bf9db4ade43619e8f2d333d
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 14 Jun 2023 19:59:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:59:28 +01:00

irqchip/loongson-liointc: Fix IRQ trigger polarity

For the INT_POLARITY register of Loongson-2K series IRQ
controller, '0' indicates high level or rising edge triggered,
'1' indicates low level or falling edge triggered, and we
can find out the information from the Loongson 2K1000LA User
Manual v1.0, Table 9-2, Section 9.3 (=E4=B8=AD=E6=96=AD=E5=AF=84=E5=AD=98=E5=
=99=A8=E6=8F=8F=E8=BF=B0 / Description
of the Interrupt Registers).

For Loongson-3 CPU series, setting INT_POLARITY register is not
supported and writting it has no effect.

So trigger polarity setting shouled be fixed for Loongson-2K CPU
series.

Fixes: 17343d0b4039 ("irqchip/loongson-liointc: Support to set IRQ type for A=
CPI path")
Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-4-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 8d00a9a..5dd9db8 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -32,6 +32,10 @@
 #define LIOINTC_REG_INTC_EN_STATUS	(LIOINTC_INTC_CHIP_START + 0x04)
 #define LIOINTC_REG_INTC_ENABLE	(LIOINTC_INTC_CHIP_START + 0x08)
 #define LIOINTC_REG_INTC_DISABLE	(LIOINTC_INTC_CHIP_START + 0x0c)
+/*
+ * LIOINTC_REG_INTC_POL register is only valid for Loongson-2K series, and
+ * Loongson-3 series behave as noops.
+ */
 #define LIOINTC_REG_INTC_POL	(LIOINTC_INTC_CHIP_START + 0x10)
 #define LIOINTC_REG_INTC_EDGE	(LIOINTC_INTC_CHIP_START + 0x14)
=20
@@ -116,19 +120,19 @@ static int liointc_set_type(struct irq_data *data, unsi=
gned int type)
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	default:
 		irq_gc_unlock_irqrestore(gc, flags);
