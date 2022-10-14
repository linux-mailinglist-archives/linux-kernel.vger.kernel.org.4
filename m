Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599005FEE08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJNMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:38:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD64181CBB;
        Fri, 14 Oct 2022 05:38:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so10129373ejb.13;
        Fri, 14 Oct 2022 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7mYLPEPKWu9N8919p7W8oTtu1bgP16uSXO3O83LxDg=;
        b=T/OcKc4ihARIGSuKyeS9MHQ/l6zc2O88xzLIjNnid1vjQCK+mOicR6ObKIJRPHJ4Ns
         Qz4upE+/NBcHtjZ3ZC+LLw7cM5jYgK2gx3Efff3GwGWgtgZ/Q8IWbVz3ROeqTss3hXLT
         fXm+M6r8H79P2XXeNo6xosnN0hJS89/IQT9ULWiYfakQKLtDcXbxFQQ1KQueulDduW1D
         fqam+IRW0qHaapRDGUbWwrPEkLSS3J5EWF3U7t/i8NQRBCinL/UuzOqDXnB58WSsW0F1
         n+JgQRpbw+GWPuCRW1JCtSV6u5M3ejut5/LTK5CKgK0XKoyuD1p6JWp1/A0j+Cond6BF
         Y5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7mYLPEPKWu9N8919p7W8oTtu1bgP16uSXO3O83LxDg=;
        b=0m5jaDzN7aGhJrqKmZUEBa0MgzXlxfpfKnc6oWQxJsKD+fQxgrcyEmErFD34K5weKp
         +IsW3adfSm990W/n6Vr/tA2t4MUC0NC8SE00OVhI9pPmXI7TAAUD37OXyFaoMAUX1nZl
         oBeojCrDI0wKPZIT9dKkNgL6ek7Oy3Fg8lZClveYREtMRYAbYSK+2bUoDOQihV9dCxib
         ENNw380zCR9fIGQd3TJPBuvLS4zSImXIVaEr+krHy+0yY8YEdp85st5wJQpvAQ6aU7HM
         50VLDdhG87HRxHYc/KRm6mf3yhVziiVeeXiTPn2ONtcm0SMp6BYqVCRs1N1nz2HridEc
         2SVg==
X-Gm-Message-State: ACrzQf2UCPH2puCrvsgUhHibeDEa9TruLsxKhjR9LhhWXL7bm67thSLj
        4Vm3rpQqclG1XO54O0hdIok=
X-Google-Smtp-Source: AMsMyM7r69vjuegy+rlo25IgQClJvdhfNYDgJ66ZU/2B8U6of90fcQ+amCCQwVYo1U1e15qrNqWDjA==
X-Received: by 2002:a17:907:75dc:b0:783:9c71:5e20 with SMTP id jl28-20020a17090775dc00b007839c715e20mr3402589ejc.125.1665751083450;
        Fri, 14 Oct 2022 05:38:03 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dk24-20020a0564021d9800b0045b910b0542sm1774756edb.15.2022.10.14.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:38:03 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 1/3] iio: temperature: ltc2983: allocate iio channels once
Date:   Fri, 14 Oct 2022 15:37:22 +0300
Message-Id: <20221014123724.1401011-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014123724.1401011-1-demonsingur@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Currently, every time the device wakes up from sleep, the
iio_chan array is reallocated, leaking the previous one
until the device is removed (basically never).

Move the allocation to the probe function to avoid this.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b652d2b39bcf..a60ccf183687 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1385,13 +1385,6 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		return ret;
 	}
 
-	st->iio_chan = devm_kzalloc(&st->spi->dev,
-				    st->iio_channels * sizeof(*st->iio_chan),
-				    GFP_KERNEL);
-
-	if (!st->iio_chan)
-		return -ENOMEM;
-
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
 				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
@@ -1514,6 +1507,12 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
+	st->iio_chan = devm_kzalloc(&spi->dev,
+				    st->iio_channels * sizeof(*st->iio_chan),
+				    GFP_KERNEL);
+	if (!st->iio_chan)
+		return -ENOMEM;
+
 	ret = ltc2983_setup(st, true);
 	if (ret)
 		return ret;
-- 
2.37.3

