Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4421D714EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE2Qqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjE2QqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:46:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD77B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso4999100a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685378777; x=1687970777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6KztWxfOQw7uIdLc2nfQ4eiSQgNkopQmfDWyk3B1pA=;
        b=Gyt0f4sPQH8c/Yxoq/p6+y5qkwYSWa26y/xs3+N+ciE8FYOVZ7J6zlIPldqKZ9mZCy
         P8RQBP/nUCMXQSwSviRg4NilNzK3EFKIOu+HRNl9YROsQxVUO2lfQ5FGVe+wAFqbhKqP
         9taBOpLFmOR21sbKA6xg+kVTEVlhJd2rUoshaXHyy77vT/u7iAA45hq3AKMZ4RO3fkT8
         Vje55rUydVT+i9gCqmf+uUzMHhLge9Ezch2RLh3IUat5YaeUCrnZWOBGyBwXj0mlRedF
         LIlGr/MUwOq5qUS4ZA0BUs4CZsI4g/n0D+O1DxtLYFakPRdtH/8ldO2CRwRd7QD3veKu
         ZW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378777; x=1687970777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6KztWxfOQw7uIdLc2nfQ4eiSQgNkopQmfDWyk3B1pA=;
        b=iBqXAxVE0mzZdReHSC6j32YG48/OY9PsSmQuMofjqIKWZ7AsyYVsAAzQlFZepObtwx
         7oyWPk62WudshCA0n5oaFlAwz+WcrcRvunXam9lL9px5zmra0VOzt3I+dtU5DGBaXqqV
         AjL/v81nPo1sgtD6+rpoIfYXOi8HJMestNkb247sxdp42rOP4CfLCtjsDfTTVWTJDdRU
         OmvND2hldjgiq84epa9qQyVbecigeFITNqI1ocRwcPDxLEtYpBMjZnvlEepiHtxtfwjK
         rTCWgcbRs86Whhnz7si7lX9f7X2r9ynSfmp073bqOg6IIjpShHL/U2j7nLzq5L1YSkQY
         Ky1w==
X-Gm-Message-State: AC+VfDz873GBrR+ZmB43JNJ6lkjm9nMBSpdo7HdELPpwUKA7HWJWIQEE
        GWq0O0QNiEoQR+bhob0YBjjOiA==
X-Google-Smtp-Source: ACHHUZ4d9Ioo2R78/WrM/mfDBsIfkzraI/JknJg/l/cBMd2pPd3hVpvP1bJ2Sav3NgeP8b8Zr6E32g==
X-Received: by 2002:aa7:dccc:0:b0:510:ed22:db43 with SMTP id w12-20020aa7dccc000000b00510ed22db43mr228129edu.24.1685378776855;
        Mon, 29 May 2023 09:46:16 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020aa7d844000000b0050d89daaa70sm3248578eds.2.2023.05.29.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:46:16 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 5/5] thermal/drivers/mediatek/lvts_thermal: Update calibration data documentation
Date:   Mon, 29 May 2023 18:46:05 +0200
Message-ID: <20230529164605.3552619-6-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529164605.3552619-1-bero@baylibre.com>
References: <20230529164605.3552619-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Update LVTS calibration data documentation for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: Fix issues pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 31 +++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d5e5214784ece..9185d02003633 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -531,7 +531,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- * stream index map for MCU Domain :
+ * MT8195 :
+ * Stream index map for MCU Domain mt8195 :
  *
  * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
@@ -542,7 +543,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
  *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
  *
- * stream index map for AP Domain :
+ * Stream index map for AP Domain mt8195 :
  *
  * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
@@ -556,6 +557,32 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
  *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
+ * MT8192 :
+ * Stream index map for MCU Domain mt8192 :
+ *
+ * <-----mcu-tc#0-----> <-----sensor#0----->        <-----sensor#1----->
+ *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <-----sensor#4----->        <-----sensor#5----->        <-----sensor#6----->        <-----sensor#7----->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for AP Domain mt8192 :
+ *
+ * <-----sensor#0----->        <-----sensor#1----->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <-----sensor#4----->        <-----sensor#5----->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B
+ *
+ * <-----sensor#6----->        <-----sensor#7----->        <-----sensor#8----->
+ *  0x3C | 0x3D | 0x3E | 0x3F | 0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47
+ *
  * The data description gives the offset of the calibration data in
  * this bytes stream for each sensor.
  */
-- 
2.41.0.rc2

