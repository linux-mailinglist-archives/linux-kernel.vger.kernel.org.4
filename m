Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082973B657
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFWLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjFWLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:33:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4CF19B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:33:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b4636bb22eso9133041fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687520016; x=1690112016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EANxw9UBUzWA7WzQeG9K7sXYK8CnMSeZWX1OlZIav4U=;
        b=Ix2dqtFrBO5aUTzp+iN7g0CGvt+EuKluKaj3KRVutb8wks84LIrJDwiXxfqZlgNbMk
         YguVNrMfj90prDQWzbBkDEzAdDHGDvP0DgG0seT0YrCqxWz70Fy30LrPxHAhH9rrPTfr
         V4svsdUztNIRRO9MNIm+LeTlcGxbjRq4nX/mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687520016; x=1690112016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EANxw9UBUzWA7WzQeG9K7sXYK8CnMSeZWX1OlZIav4U=;
        b=EeG/vOl30nI1EZrycZbQzyDcsR/OJpN1lVr4DGsCVuwdWYqRYSOmNoddGUfhnscm2V
         GML4M5KnijsIa9YfGMySKtGh6H/0he3rb0xQvyEylloIkBguJ4ecnAc3u85MF2SSs+2E
         ASDGYQJZw5JV3MG2vWDtgyi/oW+jnzK6HuVzVh6jCAhKkzzhSZA9uZ2a2PCC9G0Rei41
         gvFqp7zlaYzg8bIkQJlwvSJW1xb12s+E84FlPSjAPsYxCkuy7sjQSxKKeQkrxCAH3WdR
         M77MWVanfqAhb9A0MFK6Z5z/Soh83l4gSZX9RdxtMV43Znku9+I+wJs8lrCCOHkcAtUl
         mbrQ==
X-Gm-Message-State: AC+VfDzeOioxwLogh6hmoqvFXAKK306YaJIMkpgovSIu0t/pSLrI4WV+
        K/sH8TTFNJN4fHjRFLvIi1oyIQ==
X-Google-Smtp-Source: ACHHUZ5qLRdl1/GZ8d6A85W9DZGBD6/3iSjmvHvCKmLac3QS4zT/ikOtVVLSZqYIVfruHpVOybcfYQ==
X-Received: by 2002:a2e:7d0f:0:b0:2b5:81bc:43a8 with SMTP id y15-20020a2e7d0f000000b002b581bc43a8mr5965742ljc.0.1687520016335;
        Fri, 23 Jun 2023 04:33:36 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n10-20020a2e720a000000b002b471efb253sm1711605ljc.46.2023.06.23.04.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:33:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: addac: ad74413r: wire up digital-input-threshold-microvolt DT property
Date:   Fri, 23 Jun 2023 13:33:26 +0200
Message-Id: <20230623113327.1062170-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The threshold is common to all channels configured as digital
input.

So far, we have not seen the settings in the DIN_THRESH affecting
functions other than digital input, but with a4cba07e64e6 ("iio:
addac: ad74413: don't set DIN_SINK for functions other than digital
input") in mind, do not read and apply the
digital-input-threshold-microvolt setting unless at least one channel
has been configured as one of the digital input variants.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e3366cf5eb31..efdd7fdd7ab9 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -129,6 +129,12 @@ struct ad74413r_state {
 #define AD74413R_GPO_CONFIG_COMPARATOR		0b011
 #define AD74413R_GPO_CONFIG_HIGH_IMPEDANCE	0b100
 
+#define AD74413R_REG_DIN_THRESH		0x22
+#define AD74413R_DIN_COMP_THRESH_MASK	GENMASK(5, 1)
+#define AD74413R_DIN_THRESH_MODE	BIT(0)
+#define AD74413R_DIN_THRESH_MODE_16V	BIT(0)
+#define AD74413R_DIN_THRESH_MODE_AVDD	0
+
 #define AD74413R_REG_ADC_CONV_CTRL	0x23
 #define AD74413R_CONV_SEQ_MASK		GENMASK(9, 8)
 #define AD74413R_CONV_SEQ_ON		0b00
@@ -1446,6 +1452,20 @@ static int ad74413r_probe(struct spi_device *spi)
 	}
 
 	if (st->num_comparator_gpios) {
+		u32 thresh, val, mask;
+
+		if (!device_property_read_u32(st->dev, "digital-input-threshold-microvolt",
+					      &thresh)) {
+			val = thresh/500000 - 1;
+			val = FIELD_PREP(AD74413R_DIN_COMP_THRESH_MASK, val);
+			val |= AD74413R_DIN_THRESH_MODE_16V;
+			mask = AD74413R_DIN_COMP_THRESH_MASK | AD74413R_DIN_THRESH_MODE;
+			ret = regmap_update_bits(st->regmap, AD74413R_REG_DIN_THRESH,
+						 mask, val);
+			if (ret)
+				return ret;
+		}
+
 		st->comp_gpiochip.owner = THIS_MODULE;
 		st->comp_gpiochip.label = st->chip_info->name;
 		st->comp_gpiochip.base = -1;
-- 
2.37.2

