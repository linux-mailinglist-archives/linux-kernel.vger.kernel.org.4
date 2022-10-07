Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E35F74F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJGHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJGHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:55:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7FA3F6B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:55:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qw20so8938067ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAsasmO7g/6k+o87zhE3eY9RjJZRdde+lIh1KAwHyqU=;
        b=GvNuFPVrtrMw596Rv+jIptEuBFw0MpxQ7nzQ5TquuYZgP1HWdJlQxh0rKhl0FsXx6N
         wq4dUBu9cRkHn7jn/jsy6y5083zt34pXeSd7685JwSpOPE2ihzpyCLK/WzHaAs6zmJvo
         /1DQIuVv9s6YXSP+aadyQivDtxtr4NICM8YyGoXwYHvVPizgeK3t10woTTMPQ52azK8R
         ZoE22uo2O/LtYKmNVxj1pMUWuB5/8co9Ox7TwFhw9UpnQQ2poQRGNUb6OK+82O+EczQE
         n/XbvhG+1SfIHYAQrprWbo6DbgL30kWmaN91o8bSlq4/+avovt0m6kVPVOh4gk7lgMIk
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAsasmO7g/6k+o87zhE3eY9RjJZRdde+lIh1KAwHyqU=;
        b=CPeZGu3QQHI2L/rUbWqvA7RSAYamVQthKx8YZ2EENU/0nCEo7YQg9lduzRQFEM/sea
         sEI3zXt98SWTgv7uvQ2G9DJ7O8LLzIqBMB9AI+HThmQv9z8vbvLQdiBg37AQRzfV6lxO
         UauiA6y5re8wBvhH4vy1Xyc+KiWiHLO0Go2gRWigKY8bj9cJ5hM4OsBfz+gacsFwtn1S
         M/oi5tAP6Ca5evS77t3jj2MVB+vr4XYzKW847OSiB810tVBkdzIu3mJsaimbAdGdWmYD
         RTQPPGH0JS1t37TVWF0vMIA++QFkbRuinxJeA7b+Dmdcl89HsBW6jkWONd5Fby2Pu3FK
         jqQg==
X-Gm-Message-State: ACrzQf3b0XhnMLV14fHa88cdpeAyp1K8RQfXF3L7EspiSRtXp1MujU7A
        o6bt0XKk+/7mexnJauy8ZvwzQg==
X-Google-Smtp-Source: AMsMyM4Wa5/r7AkPfMTO1KcRDqVn3IeXxzQ5ysyTXBnV/hSpQ4VeJnwsOLblARxfOivJzWcCeXRT/g==
X-Received: by 2002:a17:907:7204:b0:783:e152:f1f1 with SMTP id dr4-20020a170907720400b00783e152f1f1mr3112681ejc.119.1665129321410;
        Fri, 07 Oct 2022 00:55:21 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-094-114-232-236.um31.pools.vodafone-ip.de. [94.114.232.236])
        by smtp.gmail.com with ESMTPSA id hv13-20020a17090760cd00b00741a0c3f4cdsm782281ejc.189.2022.10.07.00.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:55:21 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     robh@kernel.org, laurent.pinchart@ideasonboard.com, wsa@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 3/4] i2c: muxes: pca954x: Configure MAX7357 in enhanced mode
Date:   Fri,  7 Oct 2022 09:53:52 +0200
Message-Id: <20221007075354.568752-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007075354.568752-1-patrick.rudolph@9elements.com>
References: <20221007075354.568752-1-patrick.rudolph@9elements.com>
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

The MAX7357 and MAX7358 have 6 additional registers called enhanced mode
in the following paragraphs. While the MAX7357 exposes those registers
without a special sequence, the MAX7358 requires an unlock sequence.
The enhanced mode allows to configure optional features which are nice to
have on an I2C mux, but are not mandatory for it's general operation.

As I don't have a MAX7358 for testing the special unlock sequence the
enhanced mode isn't used on the MAX7358, but it could be added later
if required.

The MAX7357 enhanced mode is used to configure the chip to
 - Disable interrupts on bus locked up detection
 - Enable bus locked-up clearing
 - Disconnect only locked bus instead of all channels

This configuration protects the I2C tree from total failure and attempts
to unbrick the faulty bus. It's unclear why this isn't the default
configuration.

Tested using the MAX7357 and verified that the stalled bus is disconnected
while the other channels remain operational.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 46 ++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 4b63b1eb669e..992976fa6798 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -57,6 +57,37 @@
 
 #define PCA954X_IRQ_OFFSET 4
 
+/*
+ * The MAX7357 and MAX7358 have 6 additional registers called enhanced mode
+ * in the following paragraphs. While the MAX7357 exposes those registers
+ * without a special sequence, the MAX7358 requires an unlock sequence.
+ *
+ * The first enhanced mode register called CONF allows to configure
+ * additional features.
+ */
+#define MAX7357_REG_SWITCH				0
+#define MAX7357_REG_CONF				1
+#define  MAX7357_CONF_INT_ENABLE			BIT(0)
+#define  MAX7357_CONF_FLUSH_OUT				BIT(1)
+#define  MAX7357_CONF_RELEASE_INT			BIT(2)
+#define  MAX7357_CONF_LOCK_UP_CLEAR_ON_READ		BIT(3)
+#define  MAX7357_CONF_DISCON_SINGLE_CHAN		BIT(4)
+#define  MAX7357_CONF_BUS_LOCKUP_DETECTION_DISABLE	BIT(5)
+#define  MAX7357_CONF_ENABLE_BASIC_MODE			BIT(6)
+#define  MAX7357_CONF_PRECONNECT_TEST			BIT(7)
+
+/*
+ * On boot the MAX735x behave like a regular MUX. Apply a fixed
+ * default configuration on MAX7357 that:
+ * - disables interrupts
+ * - sents automatically flush-out sequence on locked-up channels
+     when a lock-up condition is detected
+ * - isolates only the locked channel instead of all channels
+ * - doesn't disable bus lock-up detection.
+ */
+#define MAX7357_CONF_DEFAULTS (MAX7357_CONF_FLUSH_OUT | \
+	 MAX7357_CONF_DISCON_SINGLE_CHAN)
+
 enum pca_type {
 	max_7367,
 	max_7368,
@@ -82,6 +113,7 @@ struct chip_desc {
 	u8 nchans;
 	u8 enable;	/* used for muxes only */
 	u8 has_irq;
+	u8 maxim_enhanced_mode;
 	enum muxtype {
 		pca954x_ismux = 0,
 		pca954x_isswi
@@ -113,6 +145,7 @@ static const struct chip_desc chips[] = {
 	[max_7357] = {
 		.nchans = 8,
 		.muxtype = pca954x_isswi,
+		.maxim_enhanced_mode = 1,
 		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[max_7358] = {
@@ -452,6 +485,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 
 static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 {
+	struct i2c_adapter *adap = client->adapter;
 	int ret;
 
 	if (data->idle_state >= 0)
@@ -459,7 +493,17 @@ static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 	else
 		data->last_chan = 0; /* Disconnect multiplexer */
 
-	ret = i2c_smbus_write_byte(client, data->last_chan);
+	if (data->chip->maxim_enhanced_mode) {
+		if (i2c_check_functionality(adap, I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+			ret = i2c_smbus_write_byte_data(client, data->last_chan,
+							MAX7357_CONF_DEFAULTS);
+		} else {
+			dev_warn(&client->dev, "Didn't configure enhanced defaults\n");
+			ret = i2c_smbus_write_byte(client, data->last_chan);
+		}
+	} else {
+		ret = i2c_smbus_write_byte(client, data->last_chan);
+	}
 	if (ret < 0)
 		data->last_chan = 0;
 
-- 
2.37.3

