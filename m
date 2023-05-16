Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBF705850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEPUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEPUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00493E8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA7463AEE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C02C433EF;
        Tue, 16 May 2023 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267538;
        bh=jOaCLqt9lfDL0b/jZW2RMI1YYnbfHLOLMiHxnOKfg+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRn29TWBolL8E06SvEVXRYmNHxVja3WkTfaclMbTb9FIqPMGNLqkJB4Rf5HPymwET
         W1yC0qEYh/haNdAOqMlR4HcoM6yVd4S5Y12FaGQ+29LjnGMeSXZGxCL5IVJyaSo9M/
         ONyPHcCrbo5Lh8gO3a6T1PJDbj725FwPlWazv/EP6AmQfm0Z/0OjYWq4yNKcC81992
         +Ah4gAwS/FIuFXQ0z+dBTTWkPtNr526wiAcuAoMTabLr+5SjGBv2BfViBSgIDWRo3P
         Vwm4f6aR8vUreKXhzOLKeD+0Qs9L89p5EQOTvyhcl48XArkjUDTcoSPGMUajAQbnb9
         OCOwmkVjN1Sfw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] irqchip: clps711x: remove unused clps711x_intc_init() function
Date:   Tue, 16 May 2023 22:05:06 +0200
Message-Id: <20230516200516.554663-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
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

This function has no caller or declaration any more:

drivers/irqchip/irq-clps711x.c:215:13: error: no previous prototype for 'clps711x_intc_init'

The #ifdef check around clps711x_intc_init_dt() is also not
needed since the file is only built when that is enabled.

Fixes: 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-clps711x.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 77ebe7e47e0e..e731e0784f7e 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -212,12 +212,6 @@ static int __init _clps711x_intc_init(struct device_node *np,
 	return err;
 }
 
-void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
-{
-	BUG_ON(_clps711x_intc_init(NULL, base, size));
-}
-
-#ifdef CONFIG_IRQCHIP
 static int __init clps711x_intc_init_dt(struct device_node *np,
 					struct device_node *parent)
 {
@@ -231,4 +225,3 @@ static int __init clps711x_intc_init_dt(struct device_node *np,
 	return _clps711x_intc_init(np, res.start, resource_size(&res));
 }
 IRQCHIP_DECLARE(clps711x, "cirrus,ep7209-intc", clps711x_intc_init_dt);
-#endif
-- 
2.39.2

