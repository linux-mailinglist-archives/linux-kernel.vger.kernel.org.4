Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24C64DF42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLORCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiLORCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:02:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667622280
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24F64CE1BC0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7EDC433D2;
        Thu, 15 Dec 2022 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123728;
        bh=aZPP5Ds69HdaOxy+6a8OrUz2MqCG1aXCDs4UKolW/As=;
        h=From:To:Cc:Subject:Date:From;
        b=l0tpiBK+b9s4IrxHju9S2phe8M9Eex7yQTuPXrR+Vv0qVD1fKN3TZCZS4/Zkeof9S
         1EuDmyi66XvSafhDdW5J0EVGCpH8l7uhZOkLZ0oP+ne8YT1H860ndqgvNVPk8FAmCB
         c+mSLLVzxgpjnVuPY16B3q7IfYZkTh6eEEh6fYyw5VjQpdgbutJ+E60WGDWE1KJ/M7
         Dhqjb2Xf9Y1p0bbRhKhFnH7NVGzUJBpz7z7lWyfbiaKiW+XgBpcaWbXgaovUcix59C
         xKT/cnOZ/QNchOpmvKXlql2qSMf8ifx6umv78Uvjzhdcae2FKjrwlw3Fow5EgVWprP
         MZl/XyyS+ZlzQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Rossi <nathan.rossi@digi.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: armada: suppress unused-function warning
Date:   Thu, 15 Dec 2022 18:01:57 +0100
Message-Id: <20221215170202.2441960-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

armada_370_xp_msi_reenable_percpu is only defined when CONFIG_PCI_MSI
is enabled, and only called when SMP is enabled.

Without CONFIG_SMP, there are no callers, so we get a build time
warning instead:

drivers/irqchip/irq-armada-370-xp.c:319:13: error: 'armada_370_xp_msi_reenable_percpu' defined but not used [-Werror=unused-function]
  319 | static void armada_370_xp_msi_reenable_percpu(void) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark the function as __maybe_unused to avoid adding more complexity
to the #ifdefs.

Fixes: 8ca61cde32c1 ("irqchip/armada-370-xp: Enable MSI affinity configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee18eb3e72b7..178ff63f8e93 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -316,7 +316,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 	return 0;
 }
 #else
-static void armada_370_xp_msi_reenable_percpu(void) {}
+static __maybe_unused void armada_370_xp_msi_reenable_percpu(void) {}
 
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)
-- 
2.35.1

