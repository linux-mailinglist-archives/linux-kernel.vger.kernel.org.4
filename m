Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AAF70584E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEPUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEPUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14DE5FCA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAA562CEE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A0C433D2;
        Tue, 16 May 2023 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267521;
        bh=wikSyWqzlAJd2tgFWBBFCVgyU4deM5B+UNmj/wOjPpE=;
        h=From:To:Cc:Subject:Date:From;
        b=J+ZvipnA8doCVHcQF1T6olbgyqzzfVEXHSt8VUWUyYvIdCL5M+5RqBS1M93ppRfkQ
         77uKZauXRaFZcyf6/Tfe9RONL7pzWQOqC4uIQJk5v+wGF9vy3ZWhZ61hOzoFd/xUuT
         BC62Kf5s/yTIbQRfaZoWVFLUB7ZHMA1FdcIjaZwx1GGgivVZGWSACminSLUTSCTobE
         3XVXVUNUMaYjOjQpP6QLwppgeFfip3nFarr4g5Y1XjPNSM8wXsywSBRrkjosyLF0gS
         zF9YqmAxaXl6mwjrRTLhsSW+4b5laIDg2/W2VrgYx84hZydrxrv5sTX2urabAhrMeL
         myrTRJo4kRMdw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] irqchip: ftintc010: mark all function static
Date:   Tue, 16 May 2023 22:05:04 +0200
Message-Id: <20230516200516.554663-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two functions were always global but never had any callers
outside of this file:

drivers/irqchip/irq-ftintc010.c:128:39: error: no previous prototype for 'ft010_irqchip_handle_irq'
drivers/irqchip/irq-ftintc010.c:165:12: error: no previous prototype for 'ft010_of_init_irq'

Fixes: b4d3053c8ce9 ("irqchip: Add a driver for Cortina Gemini")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-ftintc010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 46a3aa60e50e..359efc1d1be7 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -125,7 +125,7 @@ static struct irq_chip ft010_irq_chip = {
 /* Local static for the IRQ entry call */
 static struct ft010_irq_data firq;
 
-asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
 {
 	struct ft010_irq_data *f = &firq;
 	int irq;
@@ -162,7 +162,7 @@ static const struct irq_domain_ops ft010_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-int __init ft010_of_init_irq(struct device_node *node,
+static int __init ft010_of_init_irq(struct device_node *node,
 			      struct device_node *parent)
 {
 	struct ft010_irq_data *f = &firq;
-- 
2.39.2

