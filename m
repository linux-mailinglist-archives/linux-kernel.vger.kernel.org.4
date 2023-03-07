Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584CC6AE162
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCGNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCGNwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:52:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1E85A45
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:51:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7258261wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678197107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eeel5XHVDoFzIY2YG1FRNg5liLwMdDxd6X70lesaeNg=;
        b=Zul4ruBfa/4iBgPzuTyulUW2npk8hslUuGmdoKV6W1NGhZCB2WsdJ6inQE0lZBH1ja
         v216EEM+zbVi2bi8qJ+6av8hAAMz8eFLlOAb7asF+k0yv0vaSLs4G7+b1jWMUPI7S58P
         nQtbgMwDpZd+m9lg+0bGR6LlrwkYm4APvCrSGsizO7k08F1vWO7QFlsR/tTldgtNL9wn
         odn8XpNCXiJxAm+B9iFaTHSrltoQQ/tk4RNFU3mdrHXiyHYQuLZDvnT50gOfO4oLcGRX
         LmRDM/uwVAnuvfZG/BFVOf2gRXoKbLRowc0lBaIvhe8q2awjIafGfEC6Cfs/xAZLS6Rb
         0Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eeel5XHVDoFzIY2YG1FRNg5liLwMdDxd6X70lesaeNg=;
        b=1SXHxhhVfxVHpcqqsIhDGY14j56Ad9k0Bfo6wRTVRgoARmmlHKrskuw+rt7hxq0j3w
         1MMGyNNpLlBNO90NBWStqWVAfZKsaJStVQtaY5DXtTRQRQfhKXsKVKEisjl3/vwov8aL
         2HuqpA09+mB5KiKZlIzqs9oZgQT5wqrqwIIngg9aW7oD25QFTf48mWZW5BStCXwCvmhb
         barA1sSNRkCKY5jH2ImtKoSNTtZ8QV2hNJcjGXFMwD3wXNPVA29buc2hzxRVEJfe4jp0
         3I7FOoOeztF+IZKEQ6PumA2wBsVr+zkkf85T4AuwamRM59a1q9+MWa2uPdgUXdkw06+E
         C0ag==
X-Gm-Message-State: AO0yUKVivWROxU6p4bL1vVuwMOSmdik4RujvLTZ0MmOrgw3hawWh8jCP
        vECHd2AFDuwdZLHIFKh65Tgrkw==
X-Google-Smtp-Source: AK7set8fzjhfw2Vzck5v/uH3rauzSEaxrWDWm8Wl3uUWZtgthYi3j6xE9TCTVnFUsIDO5+Vg40Sr6A==
X-Received: by 2002:a05:600c:3b16:b0:3eb:5990:aea4 with SMTP id m22-20020a05600c3b1600b003eb5990aea4mr13164051wms.12.1678197107500;
        Tue, 07 Mar 2023 05:51:47 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000114e00b002c57475c375sm12932964wrx.110.2023.03.07.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:51:47 -0800 (PST)
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
        rex-bc.chen@mediatek.com, error27@gmail.com
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: fix memcpy's number of bytes in lvts_calibration_init()
Date:   Tue,  7 Mar 2023 14:51:46 +0100
Message-Id: <20230307135146.86084-1-bchihi@baylibre.com>
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

