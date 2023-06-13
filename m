Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A172D8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjFME6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjFME6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:58:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF48E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686632314; x=1718168314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKWqNItNhnl2qzeK3LTkxa2K/X8UQHIfaIfPLs0gLNM=;
  b=CksqoXARYx89ZHaVMxCTy4a9DnG+zkdHmZHLuc5+Qk+Kf7Tph8UH61RW
   qJCELSbF/FZUShmt7G/l96X+ufR+Zqrmy1Qayf9ls8meOvWuCWyveU+Qd
   WPW2NHr3M0JtD1w4EF8S6f6Y1tbrx0yvymGTfQ4p+N3yNPKmCcjv3/U/S
   2HNYqnPspWj0892Yc3mGLmLHWEKQC4yVJY9tlEWC/iZAZAXnf922nCJQy
   atxJjNHouy128t/Na2qoBUHzJw9DiWOTbXrGqDWu6wpWph4kuD9ncnOaf
   7DwixNZPVo/tGE5UrevCc9TJqBxhXpohXEleGaOUmNWBF1Ecasl1aBcGM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421819089"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="421819089"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041614066"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="1041614066"
Received: from haoyao-desk.bj.intel.com ([10.238.232.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:58:31 -0700
From:   Hao Yao <hao.yao@intel.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hao Yao <hao.yao@intel.com>, Md Sadre Alam <mdalam@codeaurora.org>
Subject: [PATCH v2] mtd: spi-nor: gigadevice: Add support for gd25lb256
Date:   Tue, 13 Jun 2023 12:53:13 +0800
Message-Id: <20230613045313.2690342-1-hao.yao@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
References: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
Signed-off-by: Hao Yao <hao.yao@intel.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index d57ddaf1525b..d56c1876549f 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -62,6 +62,10 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "gd25lb256", INFO(0xc86719, 0, 64 * 1024, 512)
+		PARSE_SFDP
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
 		PARSE_SFDP
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
-- 
2.34.1

