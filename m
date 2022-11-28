Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850163A648
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiK1KmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiK1KmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:42:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E87E23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:42:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n21so24642065ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHwI3XSCF9Xm/ixf9DTP//TAdCfsw6W1NfmGmHA5OdQ=;
        b=jFIMFlldtEvCwu8Q/gTU08imnzn/u59isuqigG5cB1thrAPA5enOekfgksDpNGCIjl
         RlE6WINsuSe1QttAPSF364HJKHx63RvdOxVYn2jwQnFRoLoHWYFBUP4zVSmzqEmtaOxi
         83J3x5bWzv8et/sWtfW3pJfd1RGXQyL25rqdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHwI3XSCF9Xm/ixf9DTP//TAdCfsw6W1NfmGmHA5OdQ=;
        b=KElc8Kx1+I9Ge//Ya8DI9PXVVryxJp6DdTgmJO4Amw50SpCK94FFSx+yDbmHueEjc1
         dnDGlsfihTNJldCFfzZX12W98OvcZMzdAl56mJoOy714OQHoLfOS9uSG1w5lWEfPS91y
         DycpBgrTQoBjCKes5/SfZM+mx5gCZ77xJhz5XTsP3EHgKSE7/qe8toSmygY2z8bPIn8K
         P7vLmvlbAD2ku0h22cFABxrzfSqCRyAc6nsYhjkY6iHDc4fRzdmiWFjcpQjhO4y8K3Jf
         bhJ5dB8k9s+sE72FXzJIXr6pZ2rZ36LWeUudpqcGY6Cas2iIoL3kU3tHYsm1eE1CJd4h
         8ByQ==
X-Gm-Message-State: ANoB5plvxPLulf/o4iOCL/2UphE/IRH6G26sce7TZ7oqa9ZuCHxX6WWj
        iTVeGqiRR19b89wFS0DOmllFoOakGRETrmEZ
X-Google-Smtp-Source: AA0mqf42ArB0GBRjO9LWcoJg3tUHtZk7zSGSmz+eSpPHBPRTTeYGEtoeCsSCKZdAflmzETXsNYX5Gw==
X-Received: by 2002:a17:906:4dc7:b0:76c:42b4:dea4 with SMTP id f7-20020a1709064dc700b0076c42b4dea4mr41621528ejw.515.1669632127028;
        Mon, 28 Nov 2022 02:42:07 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s5-20020aa7c545000000b00458dc7e8ecasm5016597edr.72.2022.11.28.02.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:42:06 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 11:41:47 +0100
Subject: [PATCH] drm/mediatek: Implement shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221128-mtk-drm-v1-0-409e7f2352e4@chromium.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=D8I9JOrNxoD2noU7pEX1LXJY3rKJrpr+ZszgfEs/ju0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhJBv4JRMG5RtbNGH7d2EK8qRddHPwpyqgEl8dB0w
 qgvWDvSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4SQbwAKCRDRN9E+zzrEiKhUD/
 46D0NWufCT7WFLGRhWIEGihB2is5rM/hVfj14gKOm5QldGwqzlGHGgSfucN2P5UgNl4BgG0FoSMCec
 z9DA8sFbd5OM82xnz6X1Br6XrdeLQuYdH/3HP5zKC6Sbv6qb56m+i9BYOIEw6Ii6YwYrsvoVe19Bs8
 uTtwv/j4m7uSivKnlf7bh4vSldbnbOgsaVfvwArKpRH3few1WPMpCxsfHT8jOML94ppHCuF2yH70SC
 ykkb+4lSJAfo18CEgBCPBkcEds2g3IlF8DIrmd/ZaYLe6/hfNHbbWuZCMJ7q2Pd8QLlvlpJb3TP4m5
 9VZRHwE3YZUk/az8KVfHziDjHCWOoJO2XyxqLVkHeQ+w83Msd19ZjIR6VckY7f8clKJcmmJrw/qWm1
 kwdl15//jHM1FD1JdFDyQZ2d03EXIzOf/Nk1HYkTb2oGWZD8JM1cYe6xttf/5fdPySaW5uSb0OeIBO
 nxdu1lMWPl4uwoHPOp7q2yDHw0uqYhnLmaQOLQHnOuQ1VA8+2DnB7hDwnv98SvVZipsjLzyc7iOEzn
 b9OluLsSYeM48PPTdM5B3LyqhKRxX/KFoxR5vBrJDGq3mUOGTLTQIZO/ZWefjFDwBN4uhc+b7E6jzB
 p1hnRnV3eIfB2eTmRVABxxMSabLlV0bX4rDoSS+bgU94gqvUhDEBSSpJYzUQ==
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

Poweroff the device properly, otherwise the device will not come back
from kexec().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 91f58db5915f..51dbd85796e9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -829,6 +829,12 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_drm_shutdown(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &mtk_drm_ops);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
@@ -856,6 +862,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove	= mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221128-mtk-drm-ca6c5ac6b389

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
