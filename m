Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961095B4870
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIJTvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIJTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:50:41 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A15933E03;
        Sat, 10 Sep 2022 12:50:34 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 40A4EDA5;
        Sat, 10 Sep 2022 22:54:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 40A4EDA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839655;
        bh=TB9unqPvnug/2liozOk2BhmZybDmASoW/4iYt0xdIqQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=d7g0GkkkbieJQa9xdLu2VJBdKSxaqlSwoAL/DTm34xmLuj8X/NM7nAHxwIvWjbGmt
         5CjiSkEVufOKzGRmKWbsbuggCgyJ2WJl+aaa8EfDdUyNuZzZHnNNujJ0gjKsqnIugi
         K6Px0FyHgy3cpVvRvl2J0hOClW0W9E5ZblDfpjLs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:50:24 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 09/18] EDAC/synopsys: Set actual DIMM ECC errors grain
Date:   Sat, 10 Sep 2022 22:49:58 +0300
Message-ID: <20220910195007.11027-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was wrong to set the DIMM errors grain parameter to just 1 byte because
DW uMCTL2 DDRC calculates ECC for each SDRAM word and passes it as an
additional byte of data to the memory chips. SDRAM word is the actual
DQ-bus width determined by the DQ-width set during the IP-core synthesize
and the DQ-bus mode (part of the DQ-bus actually used to get data from the
memory chips) selected during the DDR controller initial setup procedure.
Thus let's set the MCI DIMMs grain based on these parameters determined
during the DW uMCTL2 DDRC config getting procedure.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 87acb683ab5c..c0e5476d5c85 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -26,9 +26,6 @@
 /* Number of channels per memory controller */
 #define SNPS_EDAC_NR_CHANS		1
 
-/* Granularity of reported error in bytes */
-#define SNPS_EDAC_ERR_GRAIN		1
-
 #define SNPS_EDAC_MSG_SIZE		256
 
 #define SNPS_EDAC_MOD_STRING		"snps_edac"
@@ -733,9 +730,12 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	u32 size, row;
+	u32 size, row, width;
 	int j;
 
+	/* Actual SDRAM-word width for which ECC is calculated */
+	width = 1U << (priv->info.dq_width - priv->info.dq_mode);
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = snps_get_memsize();
@@ -745,7 +745,7 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= priv->info.sdram_mode;
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
+			dimm->grain	= width;
 			dimm->dtype	= priv->info.dev_cfg;
 		}
 	}
-- 
2.37.2

