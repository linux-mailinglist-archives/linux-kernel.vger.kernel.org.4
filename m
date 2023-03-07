Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B307A6AE0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCGNiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCGNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF7525D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:38:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f11so12137016wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFz3DL0wcsZVMgUUsHXDAfK6kJlbLDI4poI1FgV3Faw=;
        b=o+72SkNnGvUEZIoRxtbUn1yxoMbJK4ejWB7UdQfvn95oxQ1qGBRQkmTuvFIHCKSEQD
         6V5Sb6way+IpVf1rC8Ts5ep1iztmQ7/B5Y21IzuyFDdX+ydu10oWZgvAd0kfo1C0jFU2
         NXTAAd8/JNFFoLXX4Rcp6pauvrWKWmbMd1vPw7jlce/er2GgJSWLGuHD0rRIfYnu19Ml
         4vgQqfv+uSE5DPvKzEY6foTsKhTkpPVp93OodQ6cgqwHb7g2vuwjKwmV3bpdPPwELa5m
         gZQr4IFv45Lh0vAKTshQ6V6mhjkdZSkHBM2U1mSk8lPzeCubKqrGFKAAhOLrd582PJub
         NIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFz3DL0wcsZVMgUUsHXDAfK6kJlbLDI4poI1FgV3Faw=;
        b=1EiokEpdg5by8R0Z8Ml6fuiZUpfUgVY+MCQJdB76ujxQZFBpfId96rcoJQJTLkJcbv
         On458FEsH9Po+02f/JUn1SOdqyw/olAzriVUSGlluVMntvdcO3NXew6mtQw83SwKODef
         c1hg+xEcTqbdQkMBC3+EpAq0TLrK1ykAHuk8YQaPXuQzYup5RotodG4yYUJjeoYnf3Ts
         Mu+tb/mpmP5R8r60xV5yuuX2IX7h7jnq80hB4nGtO97HbM0kFIkQ29YHSeYR5pXza1yL
         JaXPhfZUixs6wLAcFyCdxHSbIM2yWetPaw6wtFyWyxmwFIR9GIqmz/L2JbB8iUPNHmbq
         jqVQ==
X-Gm-Message-State: AO0yUKXDYBigAaoLdLUoKWuq5HHypKFGw4ZNG9VTHcwmZBAtuWYN3XH9
        gTBYhY63Vg65zN9kLYl8j5EWyw==
X-Google-Smtp-Source: AK7set9FSAFaADctvHU6vRmP3wIycBL+2ZqOFueq/Gl1g4rVDNPyVhEDXxA8gJtuA2idcajBArYPsQ==
X-Received: by 2002:a5d:66ce:0:b0:2c7:8f73:7700 with SMTP id k14-20020a5d66ce000000b002c78f737700mr9276509wrw.39.1678196279346;
        Tue, 07 Mar 2023 05:37:59 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Mark Brown <broonie@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 05/11] thermal/drivers/stm: Don't set no_hwmon to false
Date:   Tue,  7 Mar 2023 14:37:29 +0100
Message-Id: <20230307133735.90772-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal->tzp->no_hwmon parameter is only used when calling
thermal_zone_device_register().

Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
effect.

Remove the call and again prevent the drivers to access the thermal
internals.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/st/stm_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 6f2bad8ef82f..903fcf1763f1 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -558,7 +558,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	 * Thermal_zone doesn't enable hwmon as default,
 	 * enable it here
 	 */
-	sensor->th_dev->tzp->no_hwmon = false;
 	ret = thermal_add_hwmon_sysfs(sensor->th_dev);
 	if (ret)
 		goto err_tz;
-- 
2.34.1

