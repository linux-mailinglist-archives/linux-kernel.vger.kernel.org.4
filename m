Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC92617D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKCNBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiKCNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727511C27;
        Thu,  3 Nov 2022 06:01:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d26so4939766eje.10;
        Thu, 03 Nov 2022 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkllNL0GpBnoMQ1ygISVBZa6WEvqeNfaI6WJdu1D4w4=;
        b=VAhuxo/HphVdvzXuW55OopJQAiksaZpXvmCmywuzIHtLKBLEmdBd6Txc8PU79JITD9
         hj4n6jiF1vPKzEvbfPTys3wEsYuaOrIExll7fIIwIMyfSNa4MS6oNN7by7GHPai0D4SD
         LZkPaOFaaP4Nf2BYXcX9n8qjxrB8PlnDc6xqJoMkCiS8IuGXg7xXAqZ0QZiJW6ZXqbMD
         nDJJ//X6ysGLLATOw4F2Ac6u0LB/vYhlP/tma3R9wj/AdjlRlYuruEfEeNnAo/zCiLxm
         paTr+7ZfDvdFj1Z8wgQcDnQu8earV2Vhxafjxda9uPAANx2kSpCp3vZLFkEcrN+5Zhro
         YqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkllNL0GpBnoMQ1ygISVBZa6WEvqeNfaI6WJdu1D4w4=;
        b=EbNO9hmv/dBQt1yF10dLk6xlcC21aI15tZzuCI0ysTUutK/KScRsUhUtYIy2uKgVNu
         GvS/oDxGwlyxKrq2A/on47es2DtnuUWxOAaITNKV31E5DIdQ3wQSFvTczwcGQ6IK+qq5
         BBlyK8L4Psd5Cr33j9TkxK5R5JuM0jQd7cFGHSMhF49mawrYG6XxDbWmh7HUJfbGwm+b
         0Xl1dbY+7Hn/IoQcktkGf53hXjEKKqPOxpaYitKh0Ah1m41H94t5YPjZAoIDrxQOHsKV
         zgNXFLA8+1t50lkZyTuNkCuhN72WVNp7rj0xH8MkAnl4wWp+eYnKgw+i9P0VfK/x9gIB
         wjlA==
X-Gm-Message-State: ACrzQf0hd95lZXdNpISqaHFH+Aj13B6e4DsCNnI75ho9x6bWm36G6Dsd
        grv+nnryaKnp3Bi4THFkwrs=
X-Google-Smtp-Source: AMsMyM7g3IAber1AkZaVhWDf8v66sbnzYi0hRpK71LFU68OctnyILSiTweb3Yz7CMnRNVLpZj+XCeA==
X-Received: by 2002:a17:906:8469:b0:7ad:dd13:571c with SMTP id hx9-20020a170906846900b007addd13571cmr18956805ejc.141.1667480464365;
        Thu, 03 Nov 2022 06:01:04 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:03 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 01/13] iio: temperature: ltc2983: make bulk write buffer DMA-safe
Date:   Thu,  3 Nov 2022 15:00:29 +0200
Message-Id: <20221103130041.2153295-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
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

regmap_bulk_write() does not guarantee implicit DMA-safety,
even though the current implementation duplicates the given
buffer. Do not rely on it.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b652d2b39bcf..ca1bb5f48988 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -209,6 +209,7 @@ struct ltc2983_data {
 	 * Holds the converted temperature
 	 */
 	__be32 temp __aligned(IIO_DMA_MINALIGN);
+	__be32 chan_val;
 };
 
 struct ltc2983_sensor {
@@ -313,19 +314,18 @@ static int __ltc2983_fault_handler(const struct ltc2983_data *st,
 	return 0;
 }
 
-static int __ltc2983_chan_assign_common(const struct ltc2983_data *st,
+static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
 	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
-	__be32 __chan_val;
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
 	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
 		chan_val);
-	__chan_val = cpu_to_be32(chan_val);
-	return regmap_bulk_write(st->regmap, reg, &__chan_val,
-				 sizeof(__chan_val));
+	st->chan_val = cpu_to_be32(chan_val);
+	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
+				 sizeof(st->chan_val));
 }
 
 static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
-- 
2.38.1

