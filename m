Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2A5F3721
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJCUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJCUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8B8275C8;
        Mon,  3 Oct 2022 13:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA56E611EA;
        Mon,  3 Oct 2022 20:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF26C433C1;
        Mon,  3 Oct 2022 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664829064;
        bh=wlLyNKUestjg2RQzEjgToHRn7ZovntcxJNvVYC3Mdmw=;
        h=From:To:Cc:Subject:Date:From;
        b=iE3OrMx+yyF5D7JFc0vA7OavHoAWjvYMr6e6cMCtf1+RLYCLzIw3Bc7CmpRHNddCU
         mx6M0j+NhPmHzNIJNdFSi5dgdIxre9qP7jB+QLrM1KgCVLNuBoTXMmM8I6x1puFldD
         iLeX9PlarmRudD7cmXvnccGmV+G1GUsTI/2zCUVFKKLkcEOJnARwKc0cZIbFUPD+A5
         rdwSebTT1jDpnbqsOfK/imZt5wpnA51in6C1G+ai0EH243eAcVaa8m/L9rHnVnnq6Q
         UU0IwQydM2/eTBbPjei0fR8ZL8Z1KTxw3owCGQsqEJxKgn620lyn1ZdYFlY5jxdAUL
         XjyDVWZ4uNYmQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] clk: xilinx: Drop duplicate depends on COMMON_CLK
Date:   Mon,  3 Oct 2022 13:31:03 -0700
Message-Id: <20221003203103.2705007-1-sboyd@kernel.org>
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

This entire Kconfig file is only included within the if COMMON_CLK
section of the drivers/clk/Kconfig file. That makes the depends on
COMMON_CLK here redundant. Remove it.

Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/xilinx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
index f205522c40ff..051756953558 100644
--- a/drivers/clk/xilinx/Kconfig
+++ b/drivers/clk/xilinx/Kconfig
@@ -2,7 +2,7 @@
 
 config XILINX_VCU
 	tristate "Xilinx VCU logicoreIP Init"
-	depends on HAS_IOMEM && COMMON_CLK
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Provides the driver to enable and disable the isolation between the
@@ -19,7 +19,7 @@ config XILINX_VCU
 
 config COMMON_CLK_XLNX_CLKWZRD
 	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF
+	depends on OF
 	depends on HAS_IOMEM
 	help
 	  Support for the Xilinx Clocking Wizard IP core clock generator.

base-commit: c00b5f204041581fadcc6d3de7f9407d2d110035
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

