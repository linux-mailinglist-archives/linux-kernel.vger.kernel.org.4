Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1C72C434
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjFLMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjFLMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:30:30 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311210EB;
        Mon, 12 Jun 2023 05:30:17 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686573016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcN60f95EyHfAlDdNZvBkHTH/4nZm0eD62az2U/xx6A=;
        b=Ipm5aZF+MxH/0yVuujxyILOsgp7H4wrDD1HcDBSi09vhPAyrcu2+JBURS2FlQBRIUAlqTt
        Jja8UVv5RfwlSCpisQfZAi+JX+mnr9jfrnLQbZ4mfwqDrFFED/4zlnwVQps9w3ZSupCiNk
        ohfmRQj3WQO3uzC705E0o6llbnpkmI0mUiudj1ZwkHwyelmftlADuFTTZSa9vFGDsL0zUI
        lGj25+tvQOdtgrO+Si6qOQI6Uj+ZgCzP7CAjP9LBgiBoKzutzcwnN4qBA5APJBSyb2hRQN
        wr844zVXq1KfJhygxGHI7bXDY9iXpI/s/91pWfjjSYYDaYPBs75MmKoQOj9Qrw==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 16402240019;
        Mon, 12 Jun 2023 12:30:15 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 07/12] iio: inkern: Use max_array() to get the maximum value from an array
Date:   Mon, 12 Jun 2023 14:29:21 +0200
Message-Id: <20230612122926.107333-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612122926.107333-1-herve.codina@bootlin.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use max_array() to get the maximum value from an array instead of a
custom local loop.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/iio/inkern.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ce537b4ca6ca..ae1a41d3a559 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -8,6 +8,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/minmax.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
@@ -875,11 +876,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			return -EINVAL;
 		switch (*type) {
 		case IIO_VAL_INT:
-			*val = vals[--length];
-			while (length) {
-				if (vals[--length] > *val)
-					*val = vals[length];
-			}
+			*val = max_array(vals, length);
 			break;
 		default:
 			/* FIXME: learn about max for other iio values */
-- 
2.40.1

