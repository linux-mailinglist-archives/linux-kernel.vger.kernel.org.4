Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40E6D873A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDETsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjDETsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:48:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59F7684;
        Wed,  5 Apr 2023 12:47:53 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1F72660319A;
        Wed,  5 Apr 2023 20:47:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680724072;
        bh=DMsss3S5xTQ3vBQF9dvbUFqzefuTEWVYo2dfHUqUcKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhdI9GvKF1tR9YsiQ78zOGCUmuzVrO+6ZU5PjS22PcJ6tifbGaFJaWAvTBYA8mmTL
         R02TqaFtoOxFRTRHoOC+moQt7c7eJ3Mg0mSw5dB97ALq5SJrXqtbgXqwf4Hqaq+sAu
         EZeHz1uMmydtWi52bjqoPDwKv8dF2fWvX2YwCjk1pLoFZsKUQFqdATeJ82IId4Yirg
         lKrszM/2u/2iX5ahgiLSNRZeM5z2O6sQxCZLdS0o428EVcuEu9KxkJ+O6i8hVz49W8
         xho/+Qw7Z/p8nUjCidl/DE7hKGxsTIbeJhXrP4A4lPjjrwzSEsmSuDr5fiK020w0Nh
         rBKHwQBBBGp1g==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 2/8] regulator: fan53555: Explicitly include bits header
Date:   Wed,  5 Apr 2023 22:47:15 +0300
Message-Id: <20230405194721.821536-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f2a9eb975ab2 ("regulator: fan53555: Add support for
FAN53526") the driver makes use of the BIT() macro, but relies on the
bits header being implicitly included.

Explicitly pull the header in to avoid potential build failures in some
configurations.

While here, reorder include directives alphabetically.

Fixes: f2a9eb975ab2 ("regulator: fan53555: Add support for FAN53526")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index d0c678767294..0754c370a21c 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -8,18 +8,19 @@
 // Copyright (c) 2012 Marvell Technology Ltd.
 // Yunfan Zhang <yfzhang@marvell.com>
 
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/param.h>
-#include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/fan53555.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/of_device.h>
-#include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/regmap.h>
-#include <linux/regulator/fan53555.h>
 
 /* Voltage setting */
 #define FAN53555_VSEL0		0x00
-- 
2.40.0

