Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEF5F58F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJERPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiJEROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72065A198;
        Wed,  5 Oct 2022 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4479C6156F;
        Wed,  5 Oct 2022 17:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2B8C433C1;
        Wed,  5 Oct 2022 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990078;
        bh=wJnnXErmXwIuS63pnOYPIZMoevXGwPTwZXkAnc5SFRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=argNZOR8Kv0lIi1n4XhQAUao3CpXMOun1Insci6BNIyqTffXlQGyinpCqCnAy9394
         7CaQg0s5dikONMfgDA4V2YxxotOhWe30fDpm13XfALC8WcgQ127SiT+yPYiGnPc+Tp
         gDSIpafpUt3bhdTMDX+sqyLgk3N8LGfqxwrukyqf++qF7jNQ1g0yUevKFVZuWk1EqI
         ozmfLIqE8YETr1PFrWYfnjSAtpYWOkbfHuke9VWmEVYlOm6mO4CarklkKr2JE//er6
         Sv13IXl1ddjVSVwemC0z8AR8LFx7HC/mCOYtqWF1VnLtu2XYr7CfF5D4U0st0x8FSj
         giZ5nbM9671oA==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 6/6] riscv: stop directly selecting drivers for SOC_CANAAN
Date:   Wed,  5 Oct 2022 18:13:49 +0100
Message-Id: <20221005171348.167476-7-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005171348.167476-1-conor@kernel.org>
References: <20221005171348.167476-1-conor@kernel.org>
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

The serial and clock drivers will be enabled by default if the symbol
itself is enabled, so stop directly selecting the drivers in
Kconfigs.socs.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index b6f4cfad159b..0ddbc9eb7af4 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -40,13 +40,10 @@ config SOC_CANAAN
 	bool "Canaan Kendryte K210 SoC"
 	depends on !MMU
 	select CLINT_TIMER if RISCV_M_MODE
-	select SERIAL_SIFIVE if TTY
-	select SERIAL_SIFIVE_CONSOLE if TTY
 	select SIFIVE_PLIC
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	select COMMON_CLK
-	select COMMON_CLK_K210
 	help
 	  This enables support for Canaan Kendryte K210 SoC platform hardware.
 
-- 
2.37.3

