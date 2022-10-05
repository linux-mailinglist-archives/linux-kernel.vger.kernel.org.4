Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AF5F58E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJEROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJERO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A097AC20;
        Wed,  5 Oct 2022 10:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140F36156F;
        Wed,  5 Oct 2022 17:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB2EC433B5;
        Wed,  5 Oct 2022 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990064;
        bh=FYFZ1JV5IJJ1bzGkzuTk0Eck/dERbIKxB/AHNzA5FWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLVOBGmzOcxKlwnKXhY9Nvf3yga8bk/SinMKfLEJCMmulTw0cFOwico/z1cWcpZG3
         aT61mCCBGQFwaH4ZYobLLrhfIlKVrD/NTRC5MtlynbHK+u+opQM6xj/K7bduf0YI6k
         A1OlFu8JXU3wey7Mx4WinAz9/tuKRajAJn3QHmNld9b+MftnhOf1/TNX0kR6le09gP
         sv7AIlXuQBoQjfclYt7M0j8LbOhpHIezElAd/FADAbcwzh3F3Gc42GFuKA6wPTyJ+N
         bjRGcXX8BpdWl9KBzM9iWOJMO/tPOv/bWA6rp8LVeIxrjSkfRA1tekQBMtfAA3Dy1c
         /MSQn5tMiefQQ==
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
Subject: [PATCH 1/6] clk: sifive: select by default if SOC_SIFIVE
Date:   Wed,  5 Oct 2022 18:13:44 +0100
Message-Id: <20221005171348.167476-2-conor@kernel.org>
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

With the aim of dropping direct selects of drivers from Kconfig.socs,
default the SiFive clock drivers to the value of SOC_SIFIVE.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/sifive/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 9132c3c4aa86..b7fde0aadfcb 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -2,7 +2,8 @@
 
 menuconfig CLK_SIFIVE
 	bool "SiFive SoC driver support"
-	depends on RISCV || COMPILE_TEST
+	depends on SOC_SIFIVE || COMPILE_TEST
+	default SOC_SIFIVE
 	help
 	  SoC drivers for SiFive Linux-capable SoCs.
 
@@ -10,6 +11,7 @@ if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
 	bool "PRCI driver for SiFive SoCs"
+	default SOC_SIFIVE
 	select RESET_CONTROLLER
 	select RESET_SIMPLE
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
-- 
2.37.3

