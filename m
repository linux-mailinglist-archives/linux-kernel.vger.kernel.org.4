Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAE655CA0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiLYIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 03:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 03:37:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25BCEF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 00:37:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so20916198ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwvUk8nCc2kiHmnECJ1iMld3VFTwbnQ/Nb7HP3LTcH0=;
        b=NkivvfbR9LwyzM3qir50hBLkzuM5o1CupKhC9o9epUuPyHJlZxQpbm//x0yfHXZO1W
         ZHrk2ojmM3lFFarsZgtwZDAtktz2mPZFWGnaYswffE61Cir7JXL7zrX+S0++hA/WXvnZ
         NKuBjZ0oHDs1rJKQ6HwKWj2E/VZ1KdIJwyiq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwvUk8nCc2kiHmnECJ1iMld3VFTwbnQ/Nb7HP3LTcH0=;
        b=3uZC/YAYULKeWDcdDtwMt2QA8roiS8aYr4K9+JTIcYDY1pxIcLC4tsbomA/7ednsk2
         ZFKPYy6hYYbVy3DztcZXJWq03ubGGJyhIjY4nzOZolOnNWI7+WRUbBxFrEs/a49pCvhV
         WO7dHG1lX3nqydH5LSYs5tNmTZOJyAu35iQ13km5NCsqi7r679IuXyn3CuwR6EcM1us2
         ImhWx8u3n06Kf4ToeQOlWevwwYa1Zz8ZqcootgGfD5WpQRyIeoqTSbsOt+MxPcOLlQD/
         Wsm6ArTb/q602RNL8QimQpjdvW/0wmKqOfV7qTD6jhhZwzwSTqtgzkTrG0kcCK116S3j
         kBCg==
X-Gm-Message-State: AFqh2kpQezKFxA0inGV3zRuD/5UswEFZtgJbGgzvo+WnDcwDUiXXB/Di
        Fr66gMMBEqpsyT7iE5CWECmVNQ94eta1c3/B
X-Google-Smtp-Source: AMrXdXtctEnrY7BRtuyWPRfRNReCXauW0JyxwX55iNIt3gYShGUR3OrYY1oNkh8NZTlL3hiGNxWilQ==
X-Received: by 2002:a17:907:3888:b0:83f:757e:f182 with SMTP id sq8-20020a170907388800b0083f757ef182mr12114821ejc.65.1671957438627;
        Sun, 25 Dec 2022 00:37:18 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b007ae1e528390sm3378820ejo.163.2022.12.25.00.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 00:37:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 25 Dec 2022 09:37:12 +0100
Subject: [PATCH] spi: mediatek: Enable irq before the spi registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=S9r6wjmERP8avI49s18Jhy8ipRj4r0kR4VhZqUULP4Y=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjqAu5PnnA9Qc3bEgfnFKq/SZnVuwBousGA4xtFKDt
 WjkgicOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6gLuQAKCRDRN9E+zzrEiLy/D/
 9U86jlFiSKdjPyYa5uHCJN9qD94eSk9psQFmvWnfmiPLfrQssy1tzhSlNyfqQSLZYIt3MqYaQIlb23
 doEsdMl3TUww8eiAR2xkEWlKmU7v99oSDeagkN4Lu8xGe65Sqq/48QFEgJX32CXUbpGXQjYfgK7Ki0
 lcPjp/qjB+TU7FfwQ15+Xi1+W4Uh43/LGA/y6ZuLF7cn5hnZQdEp8QdgHIuDMOTgadPAZhJfW67rx6
 nMDq3gfCrobTYpc0eb9cu04B04MOOqFAyLDyzIhMxiocd002uWttTeV7+tMVl4PnKHeKO3R8CqjzFO
 6HURnumDGJ6HE7FZBacH6hav347sLuvO6KZhqyJJfOM4z+wZScSEu3/E0xcpoScqBkrKDlVM6p345M
 h2b4YZ34T++fpmeCqg6mAXh+q0PItKBT13pLL3l+9fM/U6ZhYdtHhSqgKLF+Al1M1PKGDe+ymQ6MoA
 MqICUc68JAkf6FZtUnmj/WXVMqAKLC0Pv0HYHxBURjz2vqHTYBj8MQXQ5BoRBPXtveGCB9y9TYAy2U
 YnTnIaWc5nr/HNC+EDJnx7+q2uave3m7QpVXtodJdxPUJIXcWQAYijS6pR7Nzt1NUQceSR65Iwdf9C
 C+s8AvOuqoDkdNLn4QFmSIRs8kd8isb5jY1YvrgBdKKw8tvUiGFkOwR+Vbsg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the irq is enabled after the spi si registered, there can be a race
with the initialization of the devices on the spi bus.

Eg:
mtk-spi 1100a000.spi: spi-mem transfer timeout
spi-nor: probe of spi0.0 failed with error -110
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000010
...
Call trace:
 mtk_spi_can_dma+0x0/0x2c

Fixes: c6f7874687f7 ("spi: mediatek: Enable irq when pdata is ready")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
spi: mediatek: Fix init order (again)

Hi Mark

Here is a fixup of the previous patch. Daniel, can you confirm that it
works on your hardware? 

Thanks and sorry for annoyance. 

To: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>
---
 drivers/spi/spi-mt65xx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6de8360e5c2a..9eab6c20dbc5 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1253,6 +1253,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		dev_notice(dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
 			   addr_bits, ret);
 
+	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
+			       IRQF_TRIGGER_NONE, dev_name(dev), master);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register irq\n");
+
 	pm_runtime_enable(dev);
 
 	ret = devm_spi_register_master(dev, master);
@@ -1261,13 +1266,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to register master\n");
 	}
 
-	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
-			       IRQF_TRIGGER_NONE, dev_name(dev), master);
-	if (ret) {
-		pm_runtime_disable(dev);
-		return dev_err_probe(dev, ret, "failed to register irq\n");
-	}
-
 	return 0;
 }
 

---
base-commit: 45b3cd900bf8d1a3cd7cf48361df8c09ae5b4009
change-id: 20221225-mtk-spi-fixes-99c863a6fdf1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
