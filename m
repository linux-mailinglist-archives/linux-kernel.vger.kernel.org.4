Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31B72C344
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjFLLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjFLLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8A6591
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so5059585e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569471; x=1689161471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCDq0HPnZ/JW4aurWSialUZv9qnBUgo1v/zNc5H3vQE=;
        b=TI8xXEHM0E1duX465xqlvlQJlUBu4kdYnE/gYUVnHchpW9NmMKbxTZ7pvXsNZ97Pyw
         VdSzV3IKFrAyAB5rXaWDofX5i9clGbUukci0IVENYxvf3rlTsTWPLmnoSv10Ew19MEdg
         l/YWMLYmrX+0ACs423hIDEnPAGTFv2+fxo8R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569471; x=1689161471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCDq0HPnZ/JW4aurWSialUZv9qnBUgo1v/zNc5H3vQE=;
        b=VP183/FDEDvQjH6DyK+U+WvbQuUV5/QFpWMk2MOETYea1+GCTmT5zltSBkkt+eFTqb
         2hTsnrtVqTjbSs+oBSv0BG4b/pG9D7BfLiTFReFqfbtk3KNDFE4UNcTNv3R6pTYWEqLI
         qNcm7U5xPgNSjIb1Rn4UWuCVIIkuokAw++p01Y8x2bEsved5kk3cXbDxxG7M/+HDQYic
         SnhkkavmCgKRVdiBO//Z9YJCGQwws7Jb9YWyCgq30EqoBA4r0Kf/Qf/nTlzQnI4t/BMI
         LCc5iSp6TRy+dwmgaFudV7WKdUZW+BoOnxNXvCsWJLZTXMjW6jdzgyWLlWJaMe7FM92P
         fgkA==
X-Gm-Message-State: AC+VfDwnZN5QlG/tO9ddPurwqxWT780pJcWyZd7JzLQlWUmVbLbQKFCD
        dXy1iMZhCmZHHb3T74lzVhwtow==
X-Google-Smtp-Source: ACHHUZ6Y1cn5VIj9cr5Vm+dkpSLxN9iimVWfRCdcyU5A+yKCFy5s8duTk2D/jOxfIOpE+OpbfMhrww==
X-Received: by 2002:a05:6512:3133:b0:4f6:2e4e:e425 with SMTP id p19-20020a056512313300b004f62e4ee425mr4005082lfd.50.1686569471577;
        Mon, 12 Jun 2023 04:31:11 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] rtc: isl12022: trigger battery level detection during probe
Date:   Mon, 12 Jun 2023 13:30:56 +0200
Message-Id: <20230612113059.247275-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the meaning of the SR_LBAT85 and SR_LBAT75 bits are different in
battery backup mode, they may very well be set after power on, and
stay set for up to a minute (i.e. until the battery detection in VDD
mode happens when the seconds counter hits 59). This would mean that
userspace doing a ioctl(RTC_VL_READ) early on could get a false
positive.

The battery level detection can also be triggered by explicitly
writing a 1 to the TSE bit in the BETA register. Do that once during
boot (well, probe), and emit a single warning to the kernel log if the
battery is already low.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 1b6659a9b33a..690dbb446d1a 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -280,8 +280,25 @@ static void isl12022_set_trip_levels(struct device *dev)
 	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
 
 	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
+		return;
+	}
+
+	ret = regmap_write_bits(regmap, ISL12022_REG_BETA,
+				ISL12022_BETA_TSE, ISL12022_BETA_TSE);
+	if (ret) {
+		dev_warn(dev, "unable to trigger battery level detection: %d\n", ret);
+		return;
+	}
+
+	ret = isl12022_read_sr(regmap);
+	if (ret < 0) {
+		dev_warn(dev, "unable to read status register: %d\n", ret);
+	} else if (ret & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
+		dev_warn(dev, "battery voltage is below %u%%\n",
+			 (ret & ISL12022_SR_LBAT75) ? 75 : 85);
+	}
 }
 
 static int isl12022_probe(struct i2c_client *client)
-- 
2.37.2

