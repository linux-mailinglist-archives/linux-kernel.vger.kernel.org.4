Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1F64FF1E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLRO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiLRO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:27:19 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B07642
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:27:18 -0800 (PST)
Received: from dslb-178-004-201-210.178.004.pools.vodafone-ip.de ([178.4.201.210] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p6udH-0007F2-Vr; Sun, 18 Dec 2022 15:27:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Andre Przywara <andre.przywara@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: highbank: fix of node handling in highbank_init_irq
Date:   Sun, 18 Dec 2022 15:26:47 +0100
Message-Id: <20221218142647.394881-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221218142647.394881-1-martin@kaiser.cx>
References: <20221218142647.394881-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

highbank_init calls of_find_compatible_node and discards the returned
node. We should save the node and call of_node_put on it when finished.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-highbank/highbank.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 97ccb8c1b3cd..54eb1422ef8f 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -50,10 +50,16 @@ static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
 
 static void __init highbank_init_irq(void)
 {
+	struct device_node *np;
+
 	irqchip_init();
 
-	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
-		highbank_scu_map_io();
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9");
+	if (!np)
+		return;
+
+	highbank_scu_map_io();
+	of_node_put(np);
 }
 
 static void highbank_power_off(void)
-- 
2.30.2

