Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FD5BCBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISMYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiISMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:24:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7182CDD8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:24:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b21so27749654plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=85YaJ+ireb/FRtyHjT/Ws8muuIzn5SK5AqIxSV1NVQM=;
        b=DAAYXaVclvaBPc/xmjSdBkEtPHl/zkMAZVcsKAIMZXN3G2CCAJO1CeLss137m6issr
         EYn+IutWnpWV/8CUYLCpwAqzCfczgOe8APmRj82XbENsnurMDMI6X9+fFszwNptY/A1p
         TJDxiEbAXMSztJBY6LgMu7WOmgJ/ucwz+DSBWlYgQnAtpdYADJD6GCjlHv8g2mBaOZLF
         Ncx9i6NX9B+1s4AOGEo+Yyp/uIvTzTYUD6ciUrmay+Yl6ADMjgWPAIwsj2hxQ0vR5J55
         orrOeZysofAd1NN/AI5mLd/gFGhUowoeUZpg8ePinuB39huP+R/qQSVXccLzD5++cSgG
         zfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=85YaJ+ireb/FRtyHjT/Ws8muuIzn5SK5AqIxSV1NVQM=;
        b=uqtTLwDolD6RYYbczSJJEnj0G5qHakBe6lQ3/oSXhIjSuroBXsJMX1ANWAAFG56Izu
         WREmuAH24LVogocUhvIaB0iCAuHEvjuyMq9jgIm4bap2ppvwx1zAzkskHTtZFP90YfbB
         jTPlA/5b19hU/hfHrcELtvizT/fOX8NVMEjRblR3bvWIxLQCObyirr26DZii3nVKWqP4
         Gh04TX1IGJWhqx9vNw/MOYydne0L/k2hPFBVP3AnX5M9cqErk8TfZis8gXxNn4RmB+bQ
         wZTj1vWXhZnKFCW2/W0TZC6njlYhHci5M/njKX2e1GpTs0Z8iUXGGcUKG/gdd6EggR3x
         e8MQ==
X-Gm-Message-State: ACrzQf3AKo9BclAQytI5ShETnRgEy13RujwQUxD90XvmC/nzMeT/Q2tQ
        9aFaK3rZpiRzyFKaVOYCN932yMoJjXjhFuvi
X-Google-Smtp-Source: AMsMyM7UHVH0XvyQfAT9lVMIt2PrUsHP5aDrI8DBJal4lwGiQYZH7cOPronjq4YUYqAD0Eggs5+VKg==
X-Received: by 2002:a17:902:8643:b0:178:a33f:aa29 with SMTP id y3-20020a170902864300b00178a33faa29mr3601434plt.29.1663590244462;
        Mon, 19 Sep 2022 05:24:04 -0700 (PDT)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id 126-20020a630484000000b00439f027789asm3518988pge.59.2022.09.19.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:24:03 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Neanne <jneanne@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps65219: Fix is_enabled checking in tps65219_set_bypass
Date:   Mon, 19 Sep 2022 20:23:53 +0800
Message-Id: <20220919122353.384171-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing .enable cannot tell if a regulator is enabled or not, check return
value of .is_enabled() instead.
Also remove unneeded ret variable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65219-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index b198dcc60bc7..c484c943e467 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -181,16 +181,14 @@ static int tps65219_set_bypass(struct regulator_dev *dev, bool enable)
 {
 	struct tps65219 *tps = rdev_get_drvdata(dev);
 	unsigned int rid = rdev_get_id(dev);
-	int ret = 0;
 
-	if (dev->desc->ops->enable) {
+	if (dev->desc->ops->is_enabled(dev)) {
 		dev_err(tps->dev,
 			"%s LDO%d enabled, must be shut down to set bypass ",
 			__func__, rid);
 		return -EBUSY;
 	}
-	ret =  regulator_set_bypass_regmap(dev, enable);
-	return ret;
+	return regulator_set_bypass_regmap(dev, enable);
 }
 
 /* Operations permitted on BUCK1/2/3 */
-- 
2.34.1

