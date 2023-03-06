Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66406ABA37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCFJn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCFJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:43:14 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0D21A21
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:43:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b13so8945410ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1678095789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmz2nBmbaTO3qG2SmBLPZDQGKtRO+Ieydz7Ye8FP4As=;
        b=AvTMfeE/Sh6nyegcz8yd+g1v/9paXcicB1uPpofJwnbvMQyAlt7cBCR8azL8NTTpaX
         3/LNu8m+KawTxRa1AAlYWkPCX9viBpSIceGoQaeV+TqMVaYZao7zTjIaFnmjqtwmTfcy
         Hmw9mlQu0XaZlACc8SoMglt1BlDV8OpzJJoEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmz2nBmbaTO3qG2SmBLPZDQGKtRO+Ieydz7Ye8FP4As=;
        b=hugeEPoDlygYAtxbzKZyNWq+3RX7JHURJHOnN9Cz20hjZoXBYbWaAkmHZO4j3lUm0i
         A92MCWr/PAzJYbqQ/7q/mRVmshw+2HCHX4UhKkjfuoBY9GrnU41oJQAjN0gpo/vjM5eC
         IZ0iTb6KbOlT5P2HY0OOVTNv5gyrCqm3nM54QvP03m44gw3uiOujJSPrC9PqEbEe8Wfk
         O4tinkwM9Yh4uKEp0RHeW2wfannvrqLorg1dktYvu1rjmOv6dIGcJROr7DfkudJAUoUP
         aNCcojk0I5mZ1O0OCPDMUE9HkbLZ4igCy5KE29cUBGxlJY+ws5VZwZCqRs2+G0D3kbBw
         dQog==
X-Gm-Message-State: AO0yUKXkheZQW9f2y+nDHsanzBApUvrbWQ3TWQnTnLoMWWI7pfzSO00R
        dXnzt7yfmUKAygoStCmYgL1JKA==
X-Google-Smtp-Source: AK7set/pXVTPqmW95TTuDKezJ3g8v2qM1LMEWSb93i6C5mD8Y/D4z3Xo+hq6TQN0mrhY9LP5UzwdMQ==
X-Received: by 2002:a2e:1505:0:b0:295:ba28:a42 with SMTP id s5-20020a2e1505000000b00295ba280a42mr3214076ljd.20.1678095788912;
        Mon, 06 Mar 2023 01:43:08 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b002934ed148afsm1620091ljj.52.2023.03.06.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:43:08 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: ad74413r: wire up support for drive-strength-microamp property
Date:   Mon,  6 Mar 2023 10:43:01 +0100
Message-Id: <20230306094301.1357543-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
 <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the value specified in the channel configuration node to populate
the DIN_SINK field of the DIN_CONFIGx register.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index f32c8c2fb26d..4395758dbaa6 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -39,6 +39,7 @@ struct ad74413r_chip_info {
 
 struct ad74413r_channel_config {
 	u32		func;
+	u32		drive_strength;
 	bool		gpo_comparator;
 	bool		initialized;
 };
@@ -111,6 +112,7 @@ struct ad74413r_state {
 #define AD74413R_REG_DIN_CONFIG_X(x)	(0x09 + (x))
 #define AD74413R_DIN_DEBOUNCE_MASK	GENMASK(4, 0)
 #define AD74413R_DIN_DEBOUNCE_LEN	BIT(5)
+#define AD74413R_DIN_SINK_MASK		GENMASK(9, 6)
 
 #define AD74413R_REG_DAC_CODE_X(x)	(0x16 + (x))
 #define AD74413R_DAC_CODE_MAX		GENMASK(12, 0)
@@ -261,6 +263,18 @@ static int ad74413r_set_comp_debounce(struct ad74413r_state *st,
 				  val);
 }
 
+static int ad74413r_set_comp_drive_strength(struct ad74413r_state *st,
+					    unsigned int offset,
+					    unsigned int strength)
+{
+	strength = min(strength, 1800U);
+
+	return regmap_update_bits(st->regmap, AD74413R_REG_DIN_CONFIG_X(offset),
+				  AD74413R_DIN_SINK_MASK,
+				  FIELD_PREP(AD74413R_DIN_SINK_MASK, strength / 120));
+}
+
+
 static void ad74413r_gpio_set(struct gpio_chip *chip,
 			      unsigned int offset, int val)
 {
@@ -1190,6 +1204,9 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 	config->gpo_comparator = fwnode_property_read_bool(channel_node,
 		"adi,gpo-comparator");
 
+	fwnode_property_read_u32(channel_node, "drive-strength-microamp",
+				 &config->drive_strength);
+
 	if (!config->gpo_comparator)
 		st->num_gpo_gpios++;
 
@@ -1269,6 +1286,7 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 	unsigned int gpo_gpio_i = 0;
 	unsigned int i;
 	u8 gpo_config;
+	u32 strength;
 	int ret;
 
 	for (i = 0; i < AD74413R_CHANNEL_MAX; i++) {
@@ -1285,6 +1303,11 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
 			st->comp_gpio_offsets[comp_gpio_i++] = i;
 
+		strength = config->drive_strength;
+		ret = ad74413r_set_comp_drive_strength(st, i, strength);
+		if (ret)
+			return ret;
+
 		ret = ad74413r_set_gpo_config(st, i, gpo_config);
 		if (ret)
 			return ret;
-- 
2.37.2

