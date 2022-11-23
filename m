Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D499636596
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiKWQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiKWQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:20:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E88F3F6;
        Wed, 23 Nov 2022 08:20:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FC32B821B7;
        Wed, 23 Nov 2022 16:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6A3C433B5;
        Wed, 23 Nov 2022 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669220427;
        bh=mOSyGYRUF4lmG8EN95GXAb+yeeVqCi5QVicqdZ3b/6o=;
        h=From:To:Cc:Subject:Date:From;
        b=XkfGBr+eqCNc/F+e54oPBY1i5IgnC8B1DMZRW20YCs5JEo3y4iGgm+iIo0eoGJPxG
         9YV07cdR+IwTVo9YlQOpTtcmVLj2+oeL9gvaJSFp63cADY+fIvHIW7RNen1mrbTz66
         YzKYhxtyfERSzT/QNtPEHT6z/PQuignwaDA0pmJtC4qVehbA0WRSbWkCy3Aj8Pdeiv
         Q5QAy7cNxP2INyDgaLF+gjny1KvHEtwYQCbdUiZGGceWTIHITH2ZUg7ZB9FuTWtTZD
         dT4Qxa/ll19h15DrpNJJojXG51RS5vxyC1wNcDObJCyAVGp8zQHgc63/sPjBOU/64/
         CQ1JZsGEvY+Cw==
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: microchip: enable the MPFS clk driver by default if SOC_MICROCHIP_POLARFIRE
Date:   Wed, 23 Nov 2022 16:19:22 +0000
Message-Id: <20221123161921.81195-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
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

From: Conor Dooley <conor.dooley@microchip.com>

With the intent of removing driver selects from Kconfig.socs in
arch/riscv, essential drivers that were being selected there could
instead by enabled by defaulting them to the value of the SoC's Kconfig
symbol.

Do so here & drop the depend on RISC-V - the SOC_ symbols are only
defined there anyway.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I thought I sent this with the SiFive stuff a few weeks ago - but
obviously not!

CC: Claudiu Beznea <claudiu.beznea@microchip.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/clk/microchip/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index b46e864b3bd8..e33e51978938 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -5,7 +5,8 @@ config COMMON_CLK_PIC32
 
 config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
-	depends on (RISCV && SOC_MICROCHIP_POLARFIRE) || COMPILE_TEST
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	default SOC_MICROCHIP_POLARFIRE
 	select AUXILIARY_BUS
 	help
 	  Supports Clock Configuration for PolarFire SoC
-- 
2.38.1

