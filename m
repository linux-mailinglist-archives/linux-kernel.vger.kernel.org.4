Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5676A83D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCBNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCBNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:49:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FC1968F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:49:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b10so17731960ljr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+ofG8dUGNkU80FPnV9zgYPR7u97jlgEvn4xxyg8nqc=;
        b=FjTnBw/d3uK0G5/Bu5xpEc3T16eLRNS45XsXzqBA/NMTjVt8E3FCPFH/Px+NCN1Tv2
         3FfBr12gK6XmyNZFNcjfMeQ6mYgXJCJrHjKNDZWAXJ+hNBj+tq8fvpLoBbrCvii6vCoZ
         1FyGU17ZZ5ifnaW2xjNHknJPgQL7vJJtp6t/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+ofG8dUGNkU80FPnV9zgYPR7u97jlgEvn4xxyg8nqc=;
        b=ypITLxSSVdE+WtY3WyPmaVgeT7JB/pYECLkyqhwDE6bb5URPR9++/VIYzchoq4aHb3
         8RNVZlNlTINusDelLlfVBjBW/epY68hj0clwv88EprX2uX4dchb/svx1R1hR2/s0shMp
         gJxkLCoNQMFU2jXb5wqC2n4PPLChaxOmNiPEgQtUgkGD/SVFIDBcYOhpraNOp3Pqi5Rm
         kA/Zvd3S97HmHSTv4DUWOQLyBTFTR/TFYkVVU/CBcJWi7t6Lz7h7wDNWGi3zPQB3FwJ2
         OvG4IRGbk2nNKoAr74u2MAs3hKRJ4HcrtopHmkx3HUuUNZ+jbh550XYAl4Hz/HXRvHTw
         DyTQ==
X-Gm-Message-State: AO0yUKWTuZesm82DL0AdpdCV6Wy1JAwGTyPoyHrCULPNUtLYeLOppZ4R
        GOwZvLan/QV8vSJP0sCt9wSBqwernDlLEDA697Q=
X-Google-Smtp-Source: AK7set/O8Ekt9ie7aM7GDWhsjBP5dvMfJdAo29xBF3dJcnaylSSOtFq2jwnvQZpTT12Xegj//2LX7g==
X-Received: by 2002:a2e:9415:0:b0:291:90bf:1cc4 with SMTP id i21-20020a2e9415000000b0029190bf1cc4mr2841936ljh.26.1677764966880;
        Thu, 02 Mar 2023 05:49:26 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004cb3e97bff8sm2139088lfg.284.2023.03.02.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:49:26 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: ad74413r: wire up support for drive-strength-microamp property
Date:   Thu,  2 Mar 2023 14:49:21 +0100
Message-Id: <20230302134922.1120217-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
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

Use the value specified in the channel configuration node to populate
the DIN_SINK field of the DIN_CONFIGx register.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index f32c8c2fb26d..cbf0f66fdc74 100644
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
@@ -261,6 +263,19 @@ static int ad74413r_set_comp_debounce(struct ad74413r_state *st,
 				  val);
 }
 
+static int ad74413r_set_comp_drive_strength(struct ad74413r_state *st,
+					    unsigned int offset,
+					    unsigned int strength)
+{
+	if (strength > 1800)
+		strength = 1800;
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
@@ -1190,6 +1205,9 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 	config->gpo_comparator = fwnode_property_read_bool(channel_node,
 		"adi,gpo-comparator");
 
+	fwnode_property_read_u32(channel_node, "drive-strength-microamp",
+				 &config->drive_strength);
+
 	if (!config->gpo_comparator)
 		st->num_gpo_gpios++;
 
@@ -1269,6 +1287,7 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 	unsigned int gpo_gpio_i = 0;
 	unsigned int i;
 	u8 gpo_config;
+	u32 strength;
 	int ret;
 
 	for (i = 0; i < AD74413R_CHANNEL_MAX; i++) {
@@ -1285,6 +1304,11 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
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

