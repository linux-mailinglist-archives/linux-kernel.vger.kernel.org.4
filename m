Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60865B6DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiIMMxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIMMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:53:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920924D83C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:53:20 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:53:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663073598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gODvVEUHGIXkZJ4/TvKgVkj5nCjnj3KeHlYUmWGpcFQ=;
        b=LDUofbcdfgN560TK70YReCYg3bmC43QfGG86d8H/KlSyNIQofZMewaW58/5+RewrLNpM86
        L+yGiUwh4PamRYREWgFnec1PwOh8MO41DmDK6Vb7LwDW8k8R4fPwBTFKoBkOgfj83L7PXL
        OwYimV0Y81maq1ap/5Gj/bPQgdoxRkwHT3uEyskvLkLIh4VLSYluTL/32CxznCeKChkYaC
        Hp3kT8XF2Q/sKgN6jH2d5EATOa+BUG5jIDrfZempkEM60ClqUFLwJkg+hnxyReQ20Y+xR2
        4F3DC0agA6hpCjfjPOqvM4PQTMzdLUKw02TIMu52LGUWUAH32BC08gI18HjKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663073598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gODvVEUHGIXkZJ4/TvKgVkj5nCjnj3KeHlYUmWGpcFQ=;
        b=VTKgqw5wgMmOmBeFnn61nM7SeKJI5eNSxSxvMBOdx6es09wf79CVPSpZMsIMKaIWu29boy
        WIbkhEP4TxJkCnBg==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/stm32-exti: Remove check on
 always false condition
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220817125758.5975-1-antonio.borneo@foss.st.com>
References: <20220817125758.5975-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <166307359696.401.1638589625214166673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     8fc7a6198a80bc39b6c5b3cc1a578e7d24f068a2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8fc7a6198a80bc39b6c5b3cc1a578e7d24f068a2
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Wed, 17 Aug 2022 14:57:58 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 12 Sep 2022 16:31:25 +01:00

irqchip/stm32-exti: Remove check on always false condition

The field drv_data is assigned during driver's probe, where it's
already checked to be not NULL.

Remove the always false check '!host_data->drv_data'.

This fixes a warning "variable dereferenced before check" detected
by '0-DAY CI Kernel Test Service'.

Fixes: c297493336b7 ("irqchip/stm32-exti: Simplify irq description table")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/lkml/202208131739.gJvcs9ls-lkp@intel.com/
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220817125758.5975-1-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index a73763d..6a3f749 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -716,7 +716,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 
-	if (!host_data->drv_data || !host_data->drv_data->desc_irqs)
+	if (!host_data->drv_data->desc_irqs)
 		return -EINVAL;
 
 	desc_irq = host_data->drv_data->desc_irqs[hwirq];
