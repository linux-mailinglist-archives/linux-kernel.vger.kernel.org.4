Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8ED6048FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiJSOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJSOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:18:00 -0400
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A810534E;
        Wed, 19 Oct 2022 07:00:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B87354075F;
        Wed, 19 Oct 2022 14:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1666184107; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=tbxh/dg1kBGR8qv4q7dWhiVWhYX5Ix6vXLZzG/XL/Uo=;
        b=XLHEk3QeyltKS238jCQJpZHaq3jm0Hez3iYBBdx33JXw3DQLK5WICZnmVbcC5gOPOGbmIS
        7bxCQt97sv9fO2FGoxly4BVil9dro75v7bLC2H42cREVaJUmdJitFOYr9vxatwy06wwVin
        /NWdHT+91SSH84tb2k/V0C+RhVECzw7VyM6DnBQCpv4s6L1XDPbmNR2M2lh1N4R4qileEx
        r1YFJ8+bpCE+einx4wbLw4aWf1mnksaJ5vEV4zISpdUt5UzRFjaZWEJJYDhNJ0SPOMK0MK
        W3NlBch+RruaQ3eJjDCIyrZXmMD2V1Dbqw7XgKcbsokAth96nNBCO+L0z4AJ8g==
From:   Mitja Spes <mitja@lxnav.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc:     Mitja Spes <mitja@lxnav.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: pressure: ms5611: changed hardcoded SPI speed to value limited
Date:   Wed, 19 Oct 2022 14:52:51 +0200
Message-Id: <20221019125254.952588-2-mitja@lxnav.com>
In-Reply-To: <20221019125254.952588-1-mitja@lxnav.com>
References: <20221019125254.952588-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hardcode the ms5611 SPI speed, limit it instead.

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 drivers/iio/pressure/ms5611_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 281b08398720..1b1e863783ec 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -91,7 +91,7 @@ static int ms5611_spi_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	spi->mode = SPI_MODE_0;
-	spi->max_speed_hz = 20000000;
+	spi->max_speed_hz = min(spi->max_speed_hz, 20000000U);
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
 	if (ret < 0)
-- 
2.34.1

