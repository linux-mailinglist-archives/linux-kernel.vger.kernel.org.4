Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3672E863
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbjFMQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbjFMQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:21:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF8019BC;
        Tue, 13 Jun 2023 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673289; x=1718209289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JbtrRPhXbe4+HtB+H83QtDFKeemImf7hGdkYfL6MURA=;
  b=MkLbDnQ24IAk0HB4BnmtDvCpYgKosU0eciaBIbbs4fiXeouDy2oUDnmU
   3K7Yno4qvnCjlHDm2S9mQ0wf6R9xZDOosoOPvAX25wMuFJ43Cdb79AvZV
   nlcYV4c7O6VtElqFsQo0c6DdVZtxEaZgZjDZ5lMbNaRxzUh02XR9WVlLY
   SpsudpoDNurj/vfxNsfsZK7a1PzEk8koaf16zBfD2Pg4rZnH/SJC/3C9S
   jg4dpHiH7btcIuy8pgp+NJXaA5wCf2SqFOhcjU+5i1dLQgLjJ/UU3zbXf
   BSNFa1gQEALK1acBA2fA4OKB8vWluRE1+OCBvRhwNVtgdHzN83mRXEq1W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424269381"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="424269381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744737157"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="744737157"
Received: from ekohande-desk2.vc.intel.com ([10.234.35.153])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:21:28 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Abe Kohandel <abe.kohandel@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] spi: dw: Replace incorrect spi_get_chipselect with set
Date:   Tue, 13 Jun 2023 09:21:03 -0700
Message-Id: <20230613162103.569812-1-abe.kohandel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 445164e8c136 ("spi: dw: Replace spi->chip_select references with
function calls") replaced direct access to spi.chip_select with
spi_*_chipselect calls but incorrectly replaced a set instance with a
get instance, replace the incorrect instance.

Fixes: 445164e8c136 ("spi: dw: Replace spi->chip_select references with function calls")
Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a699ce496cc5..a963bc96c223 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -292,7 +292,7 @@ static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
 	 */
 	spi_set_chipselect(spi, 0, 0);
 	dw_spi_set_cs(spi, enable);
-	spi_get_chipselect(spi, cs);
+	spi_set_chipselect(spi, 0, cs);
 }
 
 static int dw_spi_elba_init(struct platform_device *pdev,
-- 
2.40.1

