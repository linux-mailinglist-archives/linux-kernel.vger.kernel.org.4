Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A30717836
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjEaH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjEaH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:28:56 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128EB132;
        Wed, 31 May 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685518134; x=1717054134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/rCPOtrgMPJMDbH+AA+B4NDRRzzEObWVWt08S/40rhg=;
  b=P9uMQngFaz4NjtJxA3j5aX3C2lUlBgrWEeib8vhXR00s6iAd0PCv0gqV
   Kf2mX5DBMaUdca0x/dn9L2i/0xPTyCBHcJe/CqJGUXr+7ODInxtCExl6o
   DLnYULy9OeCK+ZeIVMA210WfxUBfEpCm340gECds0jGqr5DR6U74F+C3R
   mYIX5RpCKTuMkhjQsbbB03sGO8dvnHQMqlgjwRyolrdPQ5C1rRWri7ulF
   qmTvQfvt4AtssVZrXE/jiWfgHqVw0oUfxWvJHgXYew+HgcQcDHWolN/hL
   ntwA3yuV/sM0WJFXSUn2a4laQkKQo6tqW4WHJt4Gd0/+PTeMxgsAe1P9E
   g==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31184666"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 May 2023 09:28:52 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 May 2023 09:28:52 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 May 2023 09:28:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685518132; x=1717054132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/rCPOtrgMPJMDbH+AA+B4NDRRzzEObWVWt08S/40rhg=;
  b=YkUU+MDWnIZ5M6JtK+hHFen1TAn2HfZih9tuYYr7yRARDFPLzihfnLW/
   ixTQoVzqIm2AEv6ZtBd9lWXqPnVvYnp5zuHk+5TogiS1pGP0zVvVAaE+6
   1r+iHtLo8HpqmA8f9u1vJoK7SwIjIU2tOsAbrg1GntFWEKgJd6bAOEIN0
   byUOuaiEOB8XCgJuyRlkZGBgjbYJiW2kCF6BeoyT6rIqT8Y3G5VCWwOox
   l6G9Vqo7peGtjGelF1xiDrgIT3Jxxc0ajBj+aJC1NBORQ2/RV8PHJ3NbC
   OPx39NBqDBuKmi+gxwwVcJ7tGzk9QZuRjfLm0mhTql3Sl5IlsFmxqVeWj
   g==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31184665"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 May 2023 09:28:52 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4A278280099;
        Wed, 31 May 2023 09:28:52 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] spi: spi-fsl-lpspi: downgrade log level for pio mode
Date:   Wed, 31 May 2023 09:28:49 +0200
Message-Id: <20230531072850.739021-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having no DMA is not an error. The simplest reason is not having it
configured. SPI will still be usable, so raise a warning instead to
get still some attention.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 80f7367095ab..fb68c72df171 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -917,7 +917,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
 	if (ret < 0)
-		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
 	else
 		/*
 		 * disable LPSPI module IRQ when enable DMA mode successfully,
-- 
2.34.1

