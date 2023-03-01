Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30266A6BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCALzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCALzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:55:17 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48632ED74
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:55:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h9so13680173ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w85B/ds8bah1X1W6vnJsNpYqcqLRHd9ikwsnw5xxH4E=;
        b=LDRjZdu0o8U35wWW9SM3dBhr4k26Z1BD/Gtfmy2AFX5eXEqKIUJrMjMFS9caVJ+9GJ
         nznbO9mYSol07bh99sFoF1QTFRDI9PGdN4kGXSY44SP1rZ3PmPp17u9j+Cc9FKvI0fZu
         8SyBPJgqYEJqLB26ukd9rN+EwDigc4zAN1c/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w85B/ds8bah1X1W6vnJsNpYqcqLRHd9ikwsnw5xxH4E=;
        b=jSlQwACeGjc4m8D8DHg2hRFhBJRQk8DHRLP6blIzsYn4EEe073UoN7MZwM+p4N95Nu
         NykLkUuHHKIS87t4hRSyDak5ZF8eEij997YdgVGDFEXqk4B0bWeYQxgZ35uZM0Q4uuZ3
         4JqX/GjRobDQ2WmRaVvVlY/fH+aNC76HSu1n0pkYT4plND7n6Fea5KET5QMWCKr2PKBK
         OR0j++y086j7PB3oo623XOUdqWX8g5CexejJa3pGPArz3et+WiDq7i6ZP0To/ZBTwOH/
         NcyiQU+399ZmbZdy++2iuP5KSc3suMOfpphboC32Gw13U/DuOreW291/1HWn6EGY0n4i
         SkjQ==
X-Gm-Message-State: AO0yUKW3jPeZC3Jqps6GEEw034ac/ll1yr9MHubP2kzNOTeKjZZFwZ0m
        C3X8Z55c1BkuVFDKkMjAaAGEAg==
X-Google-Smtp-Source: AK7set+Dy+OLzKZpmJhRw/aLsvwG2zeUj/R3+rmUKLGFe8tnnOQkM0y6PqxAOpDpbLdwwQkYISnuIw==
X-Received: by 2002:a2e:a4d3:0:b0:295:9c2e:72ed with SMTP id p19-20020a2ea4d3000000b002959c2e72edmr1898245ljm.50.1677671714033;
        Wed, 01 Mar 2023 03:55:14 -0800 (PST)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b002934b5c5c67sm1638885ljb.32.2023.03.01.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 03:55:13 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413r: fix Current Input, Loop Powered Mode
Date:   Wed,  1 Mar 2023 12:55:11 +0100
Message-Id: <20230301115511.849418-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver handles CH_FUNC_CURRENT_INPUT_LOOP_POWER and
CH_FUNC_CURRENT_INPUT_EXT_POWER completely identically. But that's not
correct. In order for CH_FUNC_CURRENT_INPUT_LOOP_POWER to work, two
changes must be made:

(1) expose access to the DAC_CODE_x register so that the intended
output current can be set, i.e. expose the channel as both current
output and current input, and

(2) per the data sheet

  When selecting the current input loop powered function, tie the
  VIOUTN_x pin to ground via the on-chip 200 kΩ resistor by enabling
  the CH_200K_TO_GND bit in the ADC_CONFIGx registers.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
There's of course also CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART which is
likely to require a similar fix, but as I don't have a ad74413r I
can't test that. 

 drivers/iio/addac/ad74413r.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index f32c8c2fb26d..f5d072092709 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -99,6 +99,7 @@ struct ad74413r_state {
 #define AD74413R_REG_ADC_CONFIG_X(x)		(0x05 + (x))
 #define AD74413R_ADC_CONFIG_RANGE_MASK		GENMASK(7, 5)
 #define AD74413R_ADC_CONFIG_REJECTION_MASK	GENMASK(4, 3)
+#define AD74413R_ADC_CONFIG_CH_200K_TO_GND	BIT(2)
 #define AD74413R_ADC_RANGE_10V			0b000
 #define AD74413R_ADC_RANGE_2P5V_EXT_POW		0b001
 #define AD74413R_ADC_RANGE_2P5V_INT_POW		0b010
@@ -424,9 +425,20 @@ static int ad74413r_set_channel_dac_code(struct ad74413r_state *st,
 static int ad74413r_set_channel_function(struct ad74413r_state *st,
 					 unsigned int channel, u8 func)
 {
-	return regmap_update_bits(st->regmap,
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
 				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
 				  AD74413R_CH_FUNC_SETUP_MASK, func);
+	if (ret)
+		return ret;
+
+	if (func == CH_FUNC_CURRENT_INPUT_LOOP_POWER)
+		ret = regmap_set_bits(st->regmap,
+				      AD74413R_REG_ADC_CONFIG_X(channel),
+				      AD74413R_ADC_CONFIG_CH_200K_TO_GND);
+
+	return ret;
 }
 
 static int ad74413r_set_adc_conv_seq(struct ad74413r_state *st,
@@ -1112,6 +1124,11 @@ static struct iio_chan_spec ad74413r_current_input_channels[] = {
 	AD74413R_ADC_CURRENT_CHANNEL,
 };
 
+static struct iio_chan_spec ad74413r_current_input_loop_channels[] = {
+	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
+	AD74413R_ADC_CURRENT_CHANNEL,
+};
+
 static struct iio_chan_spec ad74413r_resistance_input_channels[] = {
 	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
 };
@@ -1135,7 +1152,7 @@ static const struct ad74413r_channels ad74413r_channels_map[] = {
 	[CH_FUNC_CURRENT_OUTPUT] = AD74413R_CHANNELS(current_output),
 	[CH_FUNC_VOLTAGE_INPUT] = AD74413R_CHANNELS(voltage_input),
 	[CH_FUNC_CURRENT_INPUT_EXT_POWER] = AD74413R_CHANNELS(current_input),
-	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] = AD74413R_CHANNELS(current_input),
+	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] = AD74413R_CHANNELS(current_input_loop),
 	[CH_FUNC_RESISTANCE_INPUT] = AD74413R_CHANNELS(resistance_input),
 	[CH_FUNC_DIGITAL_INPUT_LOGIC] = AD74413R_CHANNELS(digital_input),
 	[CH_FUNC_DIGITAL_INPUT_LOOP_POWER] = AD74413R_CHANNELS(digital_input),
-- 
2.37.2

