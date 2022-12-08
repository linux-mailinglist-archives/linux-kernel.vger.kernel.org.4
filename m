Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70B6478BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLHWUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHWUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:20:06 -0500
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421C79C1D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:20:05 -0800 (PST)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by a.peacevolution.org (Postfix) with ESMTPA id CE14B7E1B3;
        Thu,  8 Dec 2022 22:20:03 +0000 (UTC)
From:   Aren Moynihan <aren@peacevolution.org>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Samuel Holland <samuel@sholland.org>,
        Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v2] mfd: axp20x: fix order of pek rise and fall events
Date:   Thu,  8 Dec 2022 17:02:26 -0500
Message-Id: <20221208220225.635414-1-aren@peacevolution.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
        s=dkim; t=1670538004;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=WSYhaxSQty5iTEEj1mN3sd2CyE1BSjZkImL69tHo/uA=;
        b=FZbHqacUd3rn3ri4wAOwrX7pvzIoxr+Bd60M9jO5eOlKpFLCkSXxcGo05xjR5AEv7lR6ab
        OWiePGJYPsYN1zyIatIEyCEzw5qqq9uiWOuhuP6CFK5YKkaYWPRVEMfiDkizEcI3YlCwlh
        7MJ35GTIahXUMU3aifTjYd/zq2KgouI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power button can get "stuck" if the rising edge and falling edge irq
are read in the same pass. This can often be triggered when resuming
from suspend if the power button is released before the kernel handles
the interrupt.

Swapping the order of the rise and fall events makes sure that the press
event is handled first, which prevents this situation.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
changes in v2:
  - add comments describing the reason these are out of bit order

previous version:
https://lore.kernel.org/lkml/20221123230741.2430813-1-aren@peacevolution.org/T/

 include/linux/mfd/axp20x.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7ea..2058194807bd 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -432,8 +432,9 @@ enum {
 	AXP152_IRQ_PEK_SHORT,
 	AXP152_IRQ_PEK_LONG,
 	AXP152_IRQ_TIMER,
-	AXP152_IRQ_PEK_RIS_EDGE,
+	/* out of bit order to make sure the press event is handled first */
 	AXP152_IRQ_PEK_FAL_EDGE,
+	AXP152_IRQ_PEK_RIS_EDGE,
 	AXP152_IRQ_GPIO3_INPUT,
 	AXP152_IRQ_GPIO2_INPUT,
 	AXP152_IRQ_GPIO1_INPUT,
@@ -472,8 +473,9 @@ enum {
 	AXP20X_IRQ_LOW_PWR_LVL1,
 	AXP20X_IRQ_LOW_PWR_LVL2,
 	AXP20X_IRQ_TIMER,
-	AXP20X_IRQ_PEK_RIS_EDGE,
+	/* out of bit order to make sure the press event is handled first */
 	AXP20X_IRQ_PEK_FAL_EDGE,
+	AXP20X_IRQ_PEK_RIS_EDGE,
 	AXP20X_IRQ_GPIO3_INPUT,
 	AXP20X_IRQ_GPIO2_INPUT,
 	AXP20X_IRQ_GPIO1_INPUT,
@@ -502,8 +504,9 @@ enum axp22x_irqs {
 	AXP22X_IRQ_LOW_PWR_LVL1,
 	AXP22X_IRQ_LOW_PWR_LVL2,
 	AXP22X_IRQ_TIMER,
-	AXP22X_IRQ_PEK_RIS_EDGE,
+	/* out of bit order to make sure the press event is handled first */
 	AXP22X_IRQ_PEK_FAL_EDGE,
+	AXP22X_IRQ_PEK_RIS_EDGE,
 	AXP22X_IRQ_GPIO1_INPUT,
 	AXP22X_IRQ_GPIO0_INPUT,
 };
@@ -571,8 +574,9 @@ enum axp803_irqs {
 	AXP803_IRQ_LOW_PWR_LVL1,
 	AXP803_IRQ_LOW_PWR_LVL2,
 	AXP803_IRQ_TIMER,
-	AXP803_IRQ_PEK_RIS_EDGE,
+	/* out of bit order to make sure the press event is handled first */
 	AXP803_IRQ_PEK_FAL_EDGE,
+	AXP803_IRQ_PEK_RIS_EDGE,
 	AXP803_IRQ_PEK_SHORT,
 	AXP803_IRQ_PEK_LONG,
 	AXP803_IRQ_PEK_OVER_OFF,
@@ -623,8 +627,9 @@ enum axp809_irqs {
 	AXP809_IRQ_LOW_PWR_LVL1,
 	AXP809_IRQ_LOW_PWR_LVL2,
 	AXP809_IRQ_TIMER,
-	AXP809_IRQ_PEK_RIS_EDGE,
+	/* out of bit order to make sure the press event is handled first */
 	AXP809_IRQ_PEK_FAL_EDGE,
+	AXP809_IRQ_PEK_RIS_EDGE,
 	AXP809_IRQ_PEK_SHORT,
 	AXP809_IRQ_PEK_LONG,
 	AXP809_IRQ_PEK_OVER_OFF,
-- 
2.38.1

