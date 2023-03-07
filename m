Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF996AE0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCGNn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCGNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:42:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F92A6C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:42:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v16so12224881wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eeel5XHVDoFzIY2YG1FRNg5liLwMdDxd6X70lesaeNg=;
        b=cbqb/e/w8w236fE3rmjvQsm/3PyhLPMdyuWqyoTBlqyuTuh4Zx/mzq9dD/hjQM321F
         EPB63dMqDynEzEDCff8rJuhWAX0PUbR47loqbnjH60nmVA00l41/8wBdy7xRukr/QcUB
         ++pbWDmgErb4+w499XFEq4DfaPlLlTf3SdD8SrXqLCdEL2MyhQvoRBTKg20+piBh5+m/
         CCCuJRSWnewbDQIs/r6yxYgEhDO4p3noRsmSDMMaAnHkeTvDz7rQxGYCDnkyJAU1AC7U
         1dy7QQb3V8jKCHqPH19PBYbF6nyFthwQQZ6D+8uFXby+DfyGtvOZHdG91NHBDkmmwQ5u
         OPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eeel5XHVDoFzIY2YG1FRNg5liLwMdDxd6X70lesaeNg=;
        b=utvmEGMdRPDD6VEx7X2/uFyUeDI+AH04OC5cj8Rj3YsBteZbcoi9GOi5f8hsTygkCG
         nGsFCmA29W84sYF2tboaaJ3IeLbyWaBpPaPnMWkh0h7mcEhL8mb9D4xtfc1tluI7OAdE
         48DJq6JEBdaYqgjK/jkiwLt5rP3XfJTfAdx8+NuNURXBwNOPTJTEM1d44nNrNKWdFWkr
         iTXifj7U4BjQznvy7oeUalh/q+Q3+Z4+y6JioJNaFNwFlcmNp1Y405wHkRiBCBvU8BYv
         k1CfPrajAUMiuxofVmugntvX26pRtWAUYHO0c2YPB8X4v7LOEWFqy9Hm7H0CLPtUhpNl
         I4Lg==
X-Gm-Message-State: AO0yUKUqAgIiPmCYK2FPy2FfgAi2irLuvBdlQHiWoW1g+V2gCwKBaWm3
        HiZ8D+cwE6jyg7/6vPoybEWYeA==
X-Google-Smtp-Source: AK7set+aspRSIaTh4/XbS+bw8KYAx2Ifi6PVWrobx0AWeOOli8vUV5Ail29oq9+yZ42Y9gSmbdGEzw==
X-Received: by 2002:adf:ea90:0:b0:2c9:d90c:56c3 with SMTP id s16-20020adfea90000000b002c9d90c56c3mr8924250wrm.53.1678196568111;
        Tue, 07 Mar 2023 05:42:48 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d4dc2000000b002be5bdbe40csm12495589wru.27.2023.03.07.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:42:47 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: fix memcpy's number of bytes in lvts_calibration_init()
Date:   Tue,  7 Mar 2023 14:42:45 +0100
Message-Id: <20230307134245.83599-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126161048.94089-1-bchihi@baylibre.com>
References: <20230126161048.94089-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Replace memcpy 2 bytes by sizeof(int) bytes of LVTS calibration data.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
Rebased on top of thermal/linux-next
base-commit: 6828e402d06f7c574430b61c05db784cd847b19f

Original email :
Hello Balsam CHIHI,

The patch f5f633b18234: "thermal/drivers/mediatek: Add the Low
Voltage Thermal Sensor driver" from Feb 9, 2023, leads to the
following Smatch static checker warning:

        drivers/thermal/mediatek/lvts_thermal.c:562 lvts_calibration_init()
        warn: not copying enough bytes for '&lvts_ctrl->calibration[i]' (4 vs 2 bytes)

drivers/thermal/mediatek/lvts_thermal.c
    555 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
    556                                         const struct lvts_ctrl_data *lvts_ctrl_data,
    557                                         u8 *efuse_calibration)
    558 {
    559         int i;
    560
    561         for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
--> 562                 memcpy(&lvts_ctrl->calibration[i],
    563                        efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
                                                                                  ^
This is copying an array of known ints to a u32 array.  It should copy
sizeof(int) instead of 2.  It only works because the data you're on
little endian and the data is small.

    564
    565         return 0;
    566 }

regards,
dan carpenter
---
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ddfdcbcf6d86..b505c6b49031 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -575,7 +575,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 
 	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
 		memcpy(&lvts_ctrl->calibration[i],
-		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
+		       efuse_calibration + lvts_ctrl_data->cal_offset[i], sizeof(int));
 
 	return 0;
 }

base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
prerequisite-patch-id: 73be949bd16979769e5b94905b244dcee4a8f687
prerequisite-patch-id: d23d83a946e5b876ef01a717fd51b07df1fa08dd
prerequisite-patch-id: d67f2455eef1c4a9ecc460dbf3c2e3ad47d213ec
prerequisite-patch-id: 9076e9b3bd3cc411b7b80344211364db5f0cca17
prerequisite-patch-id: e220d6ae26786f524c249588433f02e5f5f906ad
prerequisite-patch-id: b407d2998e57678952128b3a4bac92a379132b09
prerequisite-patch-id: fbb9212ce8c3530da17d213f56fa334ce4fa1b2b
prerequisite-patch-id: 5db9eed2659028cf4419f2de3d093af7df6c2dad
prerequisite-patch-id: a83c00c628605d1c8fbe1d97074f9f28efb1bcfc
prerequisite-patch-id: 56a245620a4f8238cf1ba3844dc348de3db33845
prerequisite-patch-id: 7df24b0bf11129ddd3356eacf192cc3fdb2bcded
prerequisite-patch-id: 3213ca70cb5b26d54a7137ff40ca8cd2a795c414
prerequisite-patch-id: 6c2202e85215d1c7e8ab16a6b85922e994c68d9b
-- 
2.34.1

