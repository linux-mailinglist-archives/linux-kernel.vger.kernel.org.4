Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F576607915
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiJUOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJUOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:00:20 -0400
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC9760FD;
        Fri, 21 Oct 2022 06:59:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D2A4068A;
        Fri, 21 Oct 2022 15:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1666360766; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=aXnlVmknXqlNDzLOlbxpu9TZwfggntzi2DQjXqZO6uU=;
        b=wMDicj80enjKytifaED4mHK5xQHLe92TDYMkh9FwzOuXtPkCsKlsb8khqIqDVml6vsVLvb
        PQgzc5GHM466qwX24qdqoJqSAZ1NUzVn0dhpQsgzOljmzQx3LhL6mPHHXycy/GXA8V1Kkl
        DOjWZlAXrXszAsExiEVdQEgPiIbjicM/wo812c00oigQuW+fU7LHm3ZFlp1rpF2FWsBkB5
        DvUma5B8h54muHaM+M+61YxsOk5+2edO4LBbnFrLpxJ4yNDJgfRAGLG4cQMtRu6k3/TJR4
        ZCHjx8f5Ec/Bwp3qbW69DRH8QS6NTmZU2EGzZsRnOKNzQp0VA3k/M1JHnYS0Zw==
From:   Mitja Spes <mitja@lxnav.com>
Cc:     Mitja Spes <mitja@lxnav.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: pressure: ms5611: changed hardcoded SPI speed to value limited
Date:   Fri, 21 Oct 2022 15:58:21 +0200
Message-Id: <20221021135827.1444793-3-mitja@lxnav.com>
In-Reply-To: <20221021135827.1444793-1-mitja@lxnav.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hardcode the ms5611 SPI speed, limit it instead.

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 drivers/iio/pressure/ms5611_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 432e912096f4..a0a7205c9c3a 100644
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

