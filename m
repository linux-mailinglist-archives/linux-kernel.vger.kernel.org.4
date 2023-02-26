Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446226A3516
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBZW4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBZWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ED193FD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r7so4412821wrz.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=r35ft/RkMStRpSVCURhPhaJIBRgTCDbZd5rsRy1lzDSGaJBVu0JesPbExfdnAl/Tac
         QJ/E2clO5AUJL6xFwDUY9RC+A1+OZ8/Ktob+21s2izraLFBE/7fmafkLEY0518MtAHZd
         Dd5jx9S5N52SF0D5hzj8gJtK39sVZoN849y19ktumbjZdg8NlfvCgp2PZWWQ/kmJVqjI
         98yOquyeMyGgAQPGzm3PpoI+0CzPODzVr9MfACHMTXcQtQi1oP1HYT0DQsY/3u25YO2R
         RhX2csnfPKk7g/qLUsN78CZm6qO/s/63714iS7J9O9zC18XL6/AEAXippjNmsrsJULo1
         WB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=TbylKbjErn/jl2EGqYVch6xI9xUW2L0DaE2CgXs0uWk8NbFFrzfOmxTFCgjV833AIK
         pT3DGHEyJmS2FigIvuhoBDL+EOucZOx49+IrP1bX9uXRHd08rylGTcueJlwQ1spOrwYv
         mXKmKyJIRQPQjZRJfelTTWXfW/MA044KICKpSrXmscv7ysdlS0WvS3ECDstp8tDmDSRr
         9I8/AqC65cbjtW7NvjZbWHpHVCvC9wpZFcHP1ZXYF5az0w+quUNVMoNAqisygVAd+FRR
         CMNFB6RiHWglxVLHWkFf7DBk2jRil6M+wqO7UkIE3GEopwu/P8GAu5Dla9LG+SvLDsAI
         SotA==
X-Gm-Message-State: AO0yUKXas1F4wd8WonXRqNA6o7EbIo4zLIRaxb/pIG+fvCN6599pFGMW
        Pw9TvAaJMNFTtT+Sd5UIoealkw==
X-Google-Smtp-Source: AK7set+aFBbx0k9w6xi5Qurk7OatUAxN2tA4hYnCGDRhDTiU1OPc7TFEWVrws76yIDHPzZeB9jitvA==
X-Received: by 2002:adf:cd0c:0:b0:2c7:454:cee8 with SMTP id w12-20020adfcd0c000000b002c70454cee8mr17637194wrm.1.1677452108846;
        Sun, 26 Feb 2023 14:55:08 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:08 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 11/20] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Sun, 26 Feb 2023 23:53:57 +0100
Message-Id: <20230226225406.979703-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 653439b965c8..6e78616a576e 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

