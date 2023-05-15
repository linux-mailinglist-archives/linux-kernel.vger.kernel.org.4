Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8170244C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjEOGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEOGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:17:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E31722
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:17:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5208be24dcbso8801542a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684131464; x=1686723464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DY/Tvek46OkRim5dYg2uuI8WkPZBk0b6iwqvYb0rtSM=;
        b=SHQD3SCR9W+xMBa5+chJhxwA/WtZwLNXlmU69gJd0tzp7gXBkk5GmihQlO83gvhqu2
         ILCPJqysWYqlwQC/4a1tMhGE4nX7QMwQoDG1A2s7ZGxk/BPKLuxDWcvMbbPgRwWyiBta
         82f2sGFYCBKjfzsdc8HdtI1PSDcX/gCsQURSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131464; x=1686723464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DY/Tvek46OkRim5dYg2uuI8WkPZBk0b6iwqvYb0rtSM=;
        b=dncAwKY4+kcSbt93qvyQiCAtPmWy3nKKyUuM4VRHwT8wvoRCtBpAwIoqNDTVe8Vjwk
         e0d4esL8KZPf2Au/Ee5cmDUQ6yefhrU9Vy3z5pbwgQk7m+Ukr9aTPrzCjhOE+8xxW6Ye
         jJT4t9PF1vWZgk/t1effEH7SwNZLlp8bsb1vVPdMWyg3yUn4vush84RorkkbnGZEpPt6
         OfAXlvzYnUwSjNXGaAkb0Bej4ZioOhUHgCBcnGOPWHWbxY29suSjNsLHhjzy0nxN+TG/
         DbtfHrHZnWyQBEdCrreibTsdYk0Atq86abvV6fF47v84tlVVMM1pxlNd8w/GwQCNJzxH
         sR7w==
X-Gm-Message-State: AC+VfDwr5/SXeo4Hq7pfMaLeUx8GeSFeys3CsrJEYLF+ai1Vth9BRjKA
        FAE7aI+2k2xVRk4qVSA2e8FUiQ==
X-Google-Smtp-Source: ACHHUZ52DW6enl/aNrixK9TkcAw1Q3rEqPtBBG3wTF5oS74t9pGxSj4R90JS+A4/OvgNSW7wfSaeSg==
X-Received: by 2002:a05:6a20:144a:b0:105:dafa:feb3 with SMTP id a10-20020a056a20144a00b00105dafafeb3mr4095639pzi.61.1684131464030;
        Sun, 14 May 2023 23:17:44 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:cdf5:d894:a1d:dc15])
        by smtp.gmail.com with ESMTPSA id 12-20020a63124c000000b00502ecb91940sm10680495pgs.55.2023.05.14.23.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:17:43 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fei Shao <fshao@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] media: mediatek: vcodec: mtk_vcodec_dec_hw: Use devm_pm_runtime_enable()
Date:   Mon, 15 May 2023 14:16:10 +0800
Message-ID: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pm_runtime_enable() to the managed version, and clean up error
handling and unnecessary .remove() callback accordingly.

Signed-off-by: Fei Shao <fshao@chromium.org>

---

Changes in v2:
Use devm_pm_runtime_enable() per suggestion from the previous thread:
https://lore.kernel.org/lkml/20230510164330.z2ygkl7vws6fci75@pengutronix.de/T/#m25be91afe3e9554600e859a8a59128ca234fc63d

 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 26 ++++++-------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index b753bf54ebd9..e1cb2f8dca33 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -148,20 +148,21 @@ static int mtk_vdec_hw_probe(struct platform_device *pdev)
 	ret = mtk_vcodec_init_dec_clk(pdev, &subdev_dev->pm);
 	if (ret)
 		return ret;
-	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	of_id = of_match_device(mtk_vdec_hw_match, dev);
 	if (!of_id) {
 		dev_err(dev, "Can't get vdec subdev id.\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	hw_idx = (enum mtk_vdec_hw_id)(uintptr_t)of_id->data;
 	if (hw_idx >= MTK_VDEC_HW_MAX) {
 		dev_err(dev, "Hardware index %d not correct.\n", hw_idx);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	main_dev->subdev_dev[hw_idx] = subdev_dev;
@@ -173,36 +174,25 @@ static int mtk_vdec_hw_probe(struct platform_device *pdev)
 	if (IS_SUPPORT_VDEC_HW_IRQ(hw_idx)) {
 		ret = mtk_vdec_hw_init_irq(subdev_dev);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	subdev_dev->reg_base[VDEC_HW_MISC] =
 		devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR((__force void *)subdev_dev->reg_base[VDEC_HW_MISC])) {
 		ret = PTR_ERR((__force void *)subdev_dev->reg_base[VDEC_HW_MISC]);
-		goto err;
+		return ret;
 	}
 
 	if (!main_dev->subdev_prob_done)
 		main_dev->subdev_prob_done = mtk_vdec_hw_prob_done;
 
 	platform_set_drvdata(pdev, subdev_dev);
-	return 0;
-err:
-	pm_runtime_disable(subdev_dev->pm.dev);
-	return ret;
-}
-
-static int mtk_vdec_hw_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
 static struct platform_driver mtk_vdec_driver = {
 	.probe	= mtk_vdec_hw_probe,
-	.remove = mtk_vdec_hw_remove,
 	.driver	= {
 		.name	= "mtk-vdec-comp",
 		.of_match_table = mtk_vdec_hw_match,
-- 
2.40.1.606.ga4b1b128d6-goog

