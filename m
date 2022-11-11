Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA519625954
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiKKL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiKKL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:28:03 -0500
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8A60EBB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:28:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45F504070D;
        Fri, 11 Nov 2022 12:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1668166078; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=9BmkVh6jIh/jyhyFFqsPkAGeVwmF2cJMvet6/U1c940=;
        b=cigeI+HJRe6JIJ2uzZTjx0+QwIL3d2NcFzzLCU7g4uLi1ePXFF50sMtilsU0UpDeOOdkkG
        gbSo/GwMuqGRzKd7/fAL16JNWFIo2SYjq3eqk7JoTsUFNg4Ey4AL4xdpU1ca5jEfnP4FCx
        NoVJ/6F/FTicNLbic8Y45Hs7tuc3kzeRcr99xHilkL5FG7Ay0rzL/5a0rnM1OV427OWUjT
        EL9Zu2n6nlubE3JO/eAxbmwuY67N3o5s84c+m/ECFbu/PmD/Q+HMiJ0kQx/ZtH7NnSGjSu
        nyhFeeup7/c0KFjJ04iz6pPJ/93BpZ3P0kCvNtv2ZQYcCrFhRlRC+HUNn9ZHfg==
From:   Mitja Spes <mitja@lxnav.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mitja Spes <mitja@lxnav.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: adc: mcp3422: fix scale read bug
Date:   Fri, 11 Nov 2022 12:26:53 +0100
Message-Id: <20221111112657.1521307-2-mitja@lxnav.com>
In-Reply-To: <20221111112657.1521307-1-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scale was returned for currently active channel instead of the specified
channel.

Signed-off-by: Mitja Spes <mitja@lxnav.com>
Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
---
 drivers/iio/adc/mcp3422.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index da353dcb1e9d..3d53de300c89 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -164,8 +164,9 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 	struct mcp3422 *adc = iio_priv(iio);
 	int err;
 
+	u8 req_channel = channel->channel;
 	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
-	u8 pga		 = MCP3422_PGA(adc->config);
+	u8 pga		 = adc->pga[req_channel];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -175,7 +176,6 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-
 		*val1 = 0;
 		*val2 = mcp3422_scales[sample_rate][pga];
 		return IIO_VAL_INT_PLUS_NANO;
-- 
2.34.1

