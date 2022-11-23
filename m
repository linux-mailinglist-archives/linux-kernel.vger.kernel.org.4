Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAF636E43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKWXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKWXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:20:30 -0500
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 15:20:29 PST
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0511604E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:20:28 -0800 (PST)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by a.peacevolution.org (Postfix) with ESMTPA id 43C0C7E00E;
        Wed, 23 Nov 2022 23:11:30 +0000 (UTC)
From:   Aren Moynihan <aren@peacevolution.org>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH] mfd: axp20x: fix order of pek rise and fall events
Date:   Wed, 23 Nov 2022 18:07:41 -0500
Message-Id: <20221123230741.2430813-1-aren@peacevolution.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
        s=dkim; t=1669245090;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=X8Qm5jm0AtEblzCeF9itCHAowb9iYc8polGhradUFPU=;
        b=aX6eqJCu411zJGL0YO09SckcfgDVgQ55UbzLBVY2LnjHHxKwGPXJ0fRcl/nFsPDp4/Xkwq
        w0o4zhX0xS25J2GMBf+ElBLjDbxVasKa26BAY5QxM0EOlPGWi9/MQ7MrAsWAQ70vfz7+RX
        tgUzSkmRk1K0CVxd0W8xr5qDY34qn+E=
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
 include/linux/mfd/axp20x.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7ea..a13ba2bdd01f 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -432,8 +432,8 @@ enum {
 	AXP152_IRQ_PEK_SHORT,
 	AXP152_IRQ_PEK_LONG,
 	AXP152_IRQ_TIMER,
-	AXP152_IRQ_PEK_RIS_EDGE,
 	AXP152_IRQ_PEK_FAL_EDGE,
+	AXP152_IRQ_PEK_RIS_EDGE,
 	AXP152_IRQ_GPIO3_INPUT,
 	AXP152_IRQ_GPIO2_INPUT,
 	AXP152_IRQ_GPIO1_INPUT,
@@ -472,8 +472,8 @@ enum {
 	AXP20X_IRQ_LOW_PWR_LVL1,
 	AXP20X_IRQ_LOW_PWR_LVL2,
 	AXP20X_IRQ_TIMER,
-	AXP20X_IRQ_PEK_RIS_EDGE,
 	AXP20X_IRQ_PEK_FAL_EDGE,
+	AXP20X_IRQ_PEK_RIS_EDGE,
 	AXP20X_IRQ_GPIO3_INPUT,
 	AXP20X_IRQ_GPIO2_INPUT,
 	AXP20X_IRQ_GPIO1_INPUT,
@@ -502,8 +502,8 @@ enum axp22x_irqs {
 	AXP22X_IRQ_LOW_PWR_LVL1,
 	AXP22X_IRQ_LOW_PWR_LVL2,
 	AXP22X_IRQ_TIMER,
-	AXP22X_IRQ_PEK_RIS_EDGE,
 	AXP22X_IRQ_PEK_FAL_EDGE,
+	AXP22X_IRQ_PEK_RIS_EDGE,
 	AXP22X_IRQ_GPIO1_INPUT,
 	AXP22X_IRQ_GPIO0_INPUT,
 };
@@ -571,8 +571,8 @@ enum axp803_irqs {
 	AXP803_IRQ_LOW_PWR_LVL1,
 	AXP803_IRQ_LOW_PWR_LVL2,
 	AXP803_IRQ_TIMER,
-	AXP803_IRQ_PEK_RIS_EDGE,
 	AXP803_IRQ_PEK_FAL_EDGE,
+	AXP803_IRQ_PEK_RIS_EDGE,
 	AXP803_IRQ_PEK_SHORT,
 	AXP803_IRQ_PEK_LONG,
 	AXP803_IRQ_PEK_OVER_OFF,
@@ -623,8 +623,8 @@ enum axp809_irqs {
 	AXP809_IRQ_LOW_PWR_LVL1,
 	AXP809_IRQ_LOW_PWR_LVL2,
 	AXP809_IRQ_TIMER,
-	AXP809_IRQ_PEK_RIS_EDGE,
 	AXP809_IRQ_PEK_FAL_EDGE,
+	AXP809_IRQ_PEK_RIS_EDGE,
 	AXP809_IRQ_PEK_SHORT,
 	AXP809_IRQ_PEK_LONG,
 	AXP809_IRQ_PEK_OVER_OFF,
-- 
2.38.1

