Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126ED705AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEPWvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:51:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDC6E9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684277469; x=1715813469;
  h=from:to:cc:subject:date:message-id;
  bh=bnlHaZuttI+Cn/fZ2ttTZGBxQdXXNPCgcrMnVd163Hg=;
  b=KFxMxWnh79dGLR5+MdlEFGJMgpJ4HH9oi+XHXftSzPuytzf20TkKQlxp
   C7Ol7Yke96AOjhJD7XxKzYchT0jomf8etrgx4pL2ZUWr5Er5cgeoaZV0C
   6lMAaHIWF1u+IJitUFIIRh6M5Ax7qdxH22IepJROTC2/+U2boOFhoRyhL
   4sx46u1DQNHVuLQ39bPB8wPz1Y6nFsFjpixvGLXXOwnUkbCeHPUUcDQB5
   MeijqLaxKDadDRbRCC4Lhn0wlM0WFWclyWtIWKaTsF0PPdeFzg3C4tqtI
   lh8utTnes4A9PUkspJw7bIzPhcfbhCBMAP6jYB75vSg9xXxEOaGfr0/sb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350448823"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="350448823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="845846539"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="845846539"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2023 15:51:10 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        pratyush@kernel.org, tudor.ambarus@linaro.org
Subject: [PATCH] MTD SPI-NOR: BUG FIX of divide by zero in new n_banks value
Date:   Tue, 16 May 2023 15:51:08 -0700
Message-Id: <20230516225108.29194-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing 6.4-rc1 on our Lenovo Thinkpad X1 I discovered
that freeze, suspend, and shutdown, all hang the system. I bisected
it to an addition made to the MTD spi-nor code.

The new "n_banks" value is being divided into without a proper check..
Thus on certain systems this causes a divide by zero hang.

Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 drivers/mtd/spi-nor/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0bb0ad14a2fc..084117959be4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2921,7 +2921,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
-	nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
+	if (nor->info->n_banks > 0)
+		nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
+	else
+		nor->params->bank_size = 0;
 }
 
 /**
-- 
2.17.1

