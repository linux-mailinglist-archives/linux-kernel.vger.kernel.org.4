Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1566E6326
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDRMiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 08:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjDRMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:38:10 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C513867;
        Tue, 18 Apr 2023 05:38:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1921824E31D;
        Tue, 18 Apr 2023 20:38:00 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:37:59 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:37:59 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Paul Gazzillo" <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a specified case
Date:   Tue, 18 Apr 2023 20:37:56 +0800
Message-ID: <20230418123756.62495-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418123756.62495-1-hal.feng@starfivetech.com>
References: <20230418123756.62495-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When (ARCH_STARFIVE [=n] && COMPILE_TEST [=y] && RESET_CONTROLLER [=n]),
RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
and CLK_STARFIVE_JH7110_AON.

Add a condition `if RESET_CONTROLLER` to fix it. Also, delete redundant
selected options of CLK_STARFIVE_JH7110_AON because these options are
already selected by the dependency.

Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on clock driver")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 71c1148ee5f6..5d2333106f13 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
 	select CLK_STARFIVE_JH71X0
-	select RESET_STARFIVE_JH7110
+	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the system clock controller on the
@@ -35,9 +35,6 @@ config CLK_STARFIVE_JH7110_SYS
 config CLK_STARFIVE_JH7110_AON
 	tristate "StarFive JH7110 always-on clock support"
 	depends on CLK_STARFIVE_JH7110_SYS
-	select AUXILIARY_BUS
-	select CLK_STARFIVE_JH71X0
-	select RESET_STARFIVE_JH7110
 	default m if ARCH_STARFIVE
 	help
 	  Say yes here to support the always-on clock controller on the
-- 
2.38.1

