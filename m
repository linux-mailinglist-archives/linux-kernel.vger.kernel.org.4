Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED46035BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJRWQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJRWQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:16:14 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 468A589955
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:16:11 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kub2omqjesjaWkub4oJ4kH; Tue, 18 Oct 2022 23:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666130282; bh=8dZypNrMfB1+G/UELohyzH1JgpNG3hmgKJYujA5q944=;
        h=From:To:Subject:Date:MIME-Version;
        b=SRuSHNeq39k9KgeenHkhgIDWL0dDk3CDEC2KmcWWMYAQ+5xXSOwq+Vg0Xy7BBto90
         jwJCHbZU7nGq4mORcMLQGQq0MP/Btk8JWhpDSA0RWLfHO0+cotbPODYuVyCCaAAuCZ
         3dF7WaPvnBi8ehCbA5lxRKIt4nc3kvukG8RBwCPNx9oVxefZSfuO/U+zfFr9K2Q3yr
         80EgY3cc1Aj2QBswcjXe2MEe37ZaxtqaVIuvIKBviJN88ZV6LSjTyW6JU7Uwf+CPT7
         RUI1Y0zHdZPBiUnVGQdGWQRH9ENqI4xx7tIPBnoftCLvG7wKUtlyoZADIgNQyEHe0F
         DXZOIyFZUwW7Q==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Song Liu <song@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 2/3] spi: fsl-cpm: substitute empty_zero_page with helper ZERO_PAGE(0)
Date:   Tue, 18 Oct 2022 23:57:54 +0200
Message-Id: <20221018215755.33566-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
References: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLP2urURZfQFB1yAY55ub1PVpneyUyJ0CHOO3oG9A8j9epcn57H4WVK+0ow2sxVOxI/GMoQzCt3q4X9ONmIe6QPNrjBO+Pu3SC60MP1YHQ0YnsUZpEhs
 kppXUQ/W23tfU8VcLha7d6EfRUCpvKaOHPmyQj4oDi4PHXJfLl/k5083pJzmbwdKc4sab0oP9kM88PqZjhZbsLlb+7af01eviIlOVmxeQgtfNIrA3r9PtuCM
 38tjmV0Rvf8iRqJg3GclatvHMBMastuttgrqZfWIM96yUj/bbZx904Tok7HVi5rbJdmxvhhuXBvEk7pWnsw5AWxBhQRPjCdEQ6cXU1ceWAVoh5EThxOy67mB
 pnnEoIHN8bPt1SahRnxY7XY5/eUQrxsFole9s6cvRinoSVA7CFTdnkRoCdSgP+BLnjunBjUbAYYXy3q/ZeO0JKDgENo5W0HDcs8Dm2KkEHiYJSE5ebUxorax
 jmzqjWu4h8c6iyQlNseXLWIrqT+vHcYeO934LA8PJ2Cc5l7QWNvLtXVfQR+EaO/VH7/VS9dA1FMmQ2yT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all zero page implementations use empty_zero_page global pointer so
let's substitute empty_zero_page occurence with helper ZERO_PAGE(0).

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/spi/spi-fsl-cpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index ee905880769e..17a44d4f5021 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -333,7 +333,7 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		goto err_bds;
 	}
 
-	mspi->dma_dummy_tx = dma_map_single(dev, empty_zero_page, PAGE_SIZE,
+	mspi->dma_dummy_tx = dma_map_single(dev, ZERO_PAGE(0), PAGE_SIZE,
 					    DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, mspi->dma_dummy_tx)) {
 		dev_err(dev, "unable to map dummy tx buffer\n");
-- 
2.34.1

