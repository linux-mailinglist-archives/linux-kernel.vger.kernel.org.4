Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E66294F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiKOJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKOJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:55:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F760AE61
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id be13so23622743lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23t4Te+yw+Hqm+0pjO3fcF8NMLCFiSBxJI+O+j/PQU0=;
        b=WGBR5LG3Z/5OspOwwBLwL/f4DQt3EbSb2GSsCAq4/4Rw17LYljrtFT1mtEQ3fRFSJk
         2WMtRjfQ0B1/i/6BDPZzrgWNOY6nEpC4+rafytXiULnV9L7/txmaey99VFWBIgLG+6oi
         JrR1oXpfymU5E6oWJuu/rAeKeulGAP26vpa4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23t4Te+yw+Hqm+0pjO3fcF8NMLCFiSBxJI+O+j/PQU0=;
        b=1hFFc2bfMU6mFAJqU7ZJmLtPuXMeccwazR2dvtlA1/MpcprOYyQ2WOAYUmnIiGi0OO
         Mdob8DMyX9frzJh53WrKpUBJ6qX7IQmyNuzMlfOiE8vjp3rcSD2T+b+4BMxhcW7Z3w8x
         OMfle3N6yeZxtnp3DlkyN2Rzwf+1UlZxE8y2ksNEB4GIM2Ajhcb1CcLQ8nPcLcggfccp
         ejZtnz6lFwO9o4fRnxO0faFQKfEUWXU6QV/2ydUwsvIdzyhpHAGISbqS6AVYFgu88NIq
         7Z3lZFCadaI516AKHvuGrqCC9jYFrIzcuek/E8T4WWxaIHEvyE3Q8H27YP/aVvnuCgAh
         H1tw==
X-Gm-Message-State: ANoB5pkffQKeSvKgXCUqQonzpSN4Je3XLfZKY42THhlReuuvdbJwuXp+
        f7UFR4aFo47IyvLhM9ggW+DfEg==
X-Google-Smtp-Source: AA0mqf4+RWJc7VzvUBK5tdYcqEuSDHuctvwj/7ftSLOlDEN7QARqcw5/psupBW3/lsazEeVhY0v6bg==
X-Received: by 2002:a05:6512:a86:b0:4a4:72b0:9a2b with SMTP id m6-20020a0565120a8600b004a472b09a2bmr5104119lfu.469.1668506121475;
        Tue, 15 Nov 2022 01:55:21 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b00493014c3d7csm2148598lfh.309.2022.11.15.01.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:55:20 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: addac: ad74413r: add spi_device_id table
Date:   Tue, 15 Nov 2022 10:55:15 +0100
Message-Id: <20221115095517.1008632-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the run-time warning

  SPI driver ad74413r has no spi_device_id for adi,ad74412r

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 899bcd83f40b..a157f2247a50 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1305,6 +1305,15 @@ static int ad74413r_probe(struct spi_device *spi)
 	st->spi = spi;
 	st->dev = &spi->dev;
 	st->chip_info = device_get_match_data(&spi->dev);
+	if (!st->chip_info) {
+		const struct spi_device_id *id = spi_get_device_id(spi);
+		if (id)
+			st->chip_info =
+				(struct ad74413r_chip_info *)id->driver_data;
+		if (!st->chip_info)
+			return -EINVAL;
+	}
+
 	mutex_init(&st->lock);
 	init_completion(&st->adc_data_completion);
 
@@ -1457,12 +1466,20 @@ static const struct of_device_id ad74413r_dt_id[] = {
 };
 MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
 
+static const struct spi_device_id ad74413r_spi_id[] = {
+	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
+	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad74413r_spi_id);
+
 static struct spi_driver ad74413r_driver = {
 	.driver = {
 		   .name = "ad74413r",
 		   .of_match_table = ad74413r_dt_id,
 	},
 	.probe = ad74413r_probe,
+	.id_table = ad74413r_spi_id,
 };
 
 module_driver(ad74413r_driver,
-- 
2.37.2

