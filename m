Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC7605A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJTJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJTJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:03:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7C196EDE;
        Thu, 20 Oct 2022 02:03:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t16so9662420edd.2;
        Thu, 20 Oct 2022 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsbaewV9DVD6hC+LhVH29kK0IrjFkaoSLZjl3o+0gnM=;
        b=OJMnkNseZoxkZNSn9kWzz7OlkLoAxWgdg6PimTCA8ja+dqkWffM+gonl20S4ZJcEL9
         SD9EHJ2IkWfkYXgM9c/eSsMQQgvlyGfiiLn/XGNSAVhehZyML/EP9iuwfFUZyXAWzjoh
         /W1s6R8tPzq+IjaUE0e9GYE3ou3uczcOXfF7ep+v1lJ+YIpMQ2AJtI8lgwE8xDQQ8k3K
         3SD1bKfnx3SRwaaGAUM37cDuYQmkEU0fEaYNmF59rOORGEwFGzRXiirXYhSB7nn0Syre
         DWi42Cajp6hyCtQJM+z17zzSb5iBv0qv2+pJIy8zOV8FHgEDpBUKRdZpGeNfq4mprq0H
         s9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsbaewV9DVD6hC+LhVH29kK0IrjFkaoSLZjl3o+0gnM=;
        b=LawnNFO1+/032vj7QoJNTHY9Yq8lxnx2sll4Qi7mccOjtr9cj4zqq2uQrEx++RdW92
         w3zpLfuHtKT6JtB7FN9GgXDgl5a6QvoBSzfMN6uhK4jxOSY3NE62WKZyVTdWFbwru+PG
         i1AoMtEuEpmbqBaFhnEvmuNpvo9aloOtpCpaH194bT/7v61ITkiboXzjaEOql+it3WYD
         /A+BMT3Do5e9s5qnCHyxZ6AM5mqYlDj6o1dHyp1SYARDHJnulGa3GkHTDfNOPEERTDNG
         16iQ9KyPjZnoVilj8GT0sRsTKi5yziwdY8sdI4X2l1igvgNEOpRnAPsbijuLdVcIu9YB
         5LjA==
X-Gm-Message-State: ACrzQf3VNl0sz+f0zZ1/lCjLQ28pr3RCHpL9sBYmbEvYJYj+YgLIokEW
        ndoJyujIw2pKi5WYRH9NN3U=
X-Google-Smtp-Source: AMsMyM41u9D/nKzSbqSc3iSHNGJeK5D8+uxRGDgReXOFYSMlOphCJBz+OXIeMkYdzTsf0BoaVGRPJg==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr11276180edt.381.1666256594270;
        Thu, 20 Oct 2022 02:03:14 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007933047f923sm1668381ejf.118.2022.10.20.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:03:14 -0700 (PDT)
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
Subject: [PATCH v2 2/5] iio: temperature: ltc2983: make bulk write buffer DMA-safe
Date:   Thu, 20 Oct 2022 12:02:54 +0300
Message-Id: <20221020090257.1717053-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020090257.1717053-1-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
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
index a60ccf183687..1117991ca2ab 100644
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

