Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915795F3709
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJCU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJCU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:26:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493661E705;
        Mon,  3 Oct 2022 13:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4BDCB815E0;
        Mon,  3 Oct 2022 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67134C433D7;
        Mon,  3 Oct 2022 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664828769;
        bh=jnFPsoANaGbvm2KNkdpVXHUu0c4//sg68i+LcNYUka4=;
        h=From:To:Cc:Subject:Date:From;
        b=SzwqX9dYDN1yuNr2CepyEotD88akT2aFRTYwMR+1Z9LMxMu2gAS62dJMmvkSx1lJG
         CGIuV7uxz6jWisV4ldlBqVEs1vAm0x84pFG2Py2/24Pbc3ZPrARFOeAZyZYp93gvwV
         SqVaC/dmdgFqq2gSQTG3GrmyCHGFX15RDC/xZtuv6z1wtJtNKr3yyPiLqWTtDKj14J
         hat4sHoBoTCzqYr1R2YLTBvpMYv8l77fPvZqCFKu3t7FWZ5bbiKf2QxoUhJeXpySEt
         DnyNk9OmkQMCD3wwQrNWs0nAaOMOZlOSIO+hxzlM+E6rt6AbUGL0Ndx4DWJLk0jSYP
         1MK4PG/5bSzSw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] clk: clocking-wizard: Depend on HAS_IOMEM
Date:   Mon,  3 Oct 2022 13:26:08 -0700
Message-Id: <20221003202608.2611295-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

This driver uses devm_platform_ioremap_resource() and thus depends on
HAS_IOMEM. Add the Kconfig dependency to avoid build issues.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Fixes: c822490f52da ("clk: clocking-wizard: Move clocking-wizard out")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
index 5b99ecfd2f06..f205522c40ff 100644
--- a/drivers/clk/xilinx/Kconfig
+++ b/drivers/clk/xilinx/Kconfig
@@ -20,6 +20,7 @@ config XILINX_VCU
 config COMMON_CLK_XLNX_CLKWZRD
 	tristate "Xilinx Clocking Wizard"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for the Xilinx Clocking Wizard IP core clock generator.
 	  Adds support for clocking wizard and compatible.

base-commit: e8db788d686a2a2e5318364a1942d01c3cc83d87
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

