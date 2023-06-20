Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD773760F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFTU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFTU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:29:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39910F8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687292945; x=1718828945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xUASsq4735yNa0rqWKigSfGCKuX95XAU6zrjRbcxtJg=;
  b=UgOu7fBl1N79OCtXnX9nsFJQtQvF5bCBmbKZH5pzzVZeIY5SJTgfVcVw
   IgXWYtxUwr7LhOV7ze8b/j0SDxuAY2qKtVtzKxZE6HqcvmAXV/82ZVZMP
   LCCVSmzqlUf9RbnSZkKdp0ysgGtk5GExEsQO0t4NGBvsq65hsuuXj7HPG
   GwshaxDnQy8Oy1rd8E5eAj9RWIVUay4JwXVVMuJq/uAhYMw1oxPYwsT+M
   PEWx9+KLwSZU1z1X96dEjvhzvGtWwxVeCpOj8klNtQtS0sBEug61yITnA
   ZEoGV+tJgI6+el990s3JZZxRbPztw3745Lx2OteaUcm5trRusupKOSEcp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389324644"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="389324644"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 13:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804077879"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="804077879"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.240.28])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 13:29:04 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yilun.xu@intel.com, matthew.gerlach@linux.intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Date:   Tue, 20 Jun 2023 13:28:24 -0700
Message-Id: <20230620202824.380313-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_raw_write member of the regmap_spi_avmm_bus structure is defined
as:
	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT

SPI_AVMM_VAL_SIZE == 4 and MAX_WRITE_CNT == 1 so this results in a
maximum write transfer size of 4 bytes which provides only enough space to
transfer the address of the target register. It provides no space for the
value to be transferred. This bug became an issue (divide-by-zero in
_regmap_raw_write()) after the following was accepted into mainline:

commit 3981514180c9 ("regmap: Account for register length when chunking")

Change max_raw_write to include space (4 additional bytes) for both the
register address and value:

	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT

Fixes: 7f9fb67358a2 ("regmap: add Intel SPI Slave to AVMM Bus Bridge support")
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/base/regmap/regmap-spi-avmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 4c2b94b3e30b..6af692844c19 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -660,7 +660,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
-- 
2.25.1

