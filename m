Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A197389A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjFUPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjFUPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA8E65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f769c37d26so8354899e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361825; x=1689953825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwzdC7/KLQBqsNQ9Z3vvCuyrSfrs5l5gzbo6Rxb7/UU=;
        b=JDQhrhG+gEzY/R4QQnG7RzCwbzoc1hFLLMgvZVVfnRJe8nxWvaKxhak6tsdD9HKRSN
         o/lnDk+VvBQg7o+rChNMyQLaPVIBXPRMD2cUj8+ENXruqpJo/O5v5LGKYi57J8Y2FtjI
         bYx5odt/A89YoCT1JoBn4vy8f24Lsz6Ze5+aI0q6t74ry1UKuuZVuDpiL9DsQxytoUur
         cyBJh2TlI0oRDBXw2mYVaGX4UWsJ+KPGznNoApHpRnvj9jT15KXWVCnVX8+GNbxQLrZY
         g2jksyNz0I7WPclj04bl5RlRfxvELs7ev3oKxY0iJIM/MMG2wLWSoeHnzx1RYbQ2ICJ8
         q34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361825; x=1689953825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwzdC7/KLQBqsNQ9Z3vvCuyrSfrs5l5gzbo6Rxb7/UU=;
        b=Ia47/59drSE2BN7vfAIJ6zOswjVk0Z4fZZspXH7qoh8ROrGndAJkoyvIP/3HX5trYi
         X+kkzmiwwQ5aICMFKxUEtKDTvMGhbdfxbWgoGjxgUbrFotXNKsAlr4a+hKpzGmBGQsBn
         co4VxHPFQUf0uLKZ1n1RvEq8gPRhnURoe1bYCNkqjkm4FbyOHOUPEuIUiLMR61LbP8jf
         TCNYPzyDxtV+g5KNfBrT0hFEpu7kn8WNfjYMdKvwbJWffuCvb5YjO1+ETPZb1Yp2y8E/
         S3ZtaTZGLWCUam/ijeBLIIuVPpR1eA1+62iTs8b+YgSEkP9V7t/kJ6E2PkW23DoKeFL5
         DCsA==
X-Gm-Message-State: AC+VfDyZq10ujtzYugvUPir5H/wFlQcFSBnbsASmrEGn84Gd0Hr6XTkB
        eUBt+i53WhbwDd0mGtw//dOzcA==
X-Google-Smtp-Source: ACHHUZ7/oqSJCenAAa8lnFgdX+Cu/iYwD4IrKqGSFvkhqDbvRPxiA0zrBKUV9uODTH007C1TlggT0A==
X-Received: by 2002:ac2:5b1e:0:b0:4f8:5d15:99e5 with SMTP id v30-20020ac25b1e000000b004f85d1599e5mr8290068lfn.32.1687361824777;
        Wed, 21 Jun 2023 08:37:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 03/11] net: stmmac: platform: provide stmmac_pltfr_exit()
Date:   Wed, 21 Jun 2023 17:36:42 +0200
Message-Id: <20230621153650.440350-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621153650.440350-1-brgl@bgdev.pl>
References: <20230621153650.440350-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a helper wrapper around calling the platform's exit() callback.
This allows users to skip checking if the callback exists.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 22 ++++++++++++++-----
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 41ca4fc9f863..5b2bc129cd85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -720,6 +720,20 @@ int stmmac_pltfr_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_init);
 
+/**
+ * stmmac_pltfr_exit
+ * @pdev: pointer to the platform device
+ * @plat: driver data platform structure
+ * Description: Call the platform's exit callback (if any).
+ */
+void stmmac_pltfr_exit(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat)
+{
+	if (plat->exit)
+		plat->exit(pdev, plat->bsp_priv);
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_exit);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
@@ -733,10 +747,7 @@ void stmmac_pltfr_remove(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat = priv->plat;
 
 	stmmac_dvr_remove(&pdev->dev);
-
-	if (plat->exit)
-		plat->exit(pdev, plat->bsp_priv);
-
+	stmmac_pltfr_exit(pdev, plat);
 	stmmac_remove_config_dt(pdev, plat);
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
@@ -756,8 +767,7 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 
 	ret = stmmac_suspend(dev);
-	if (priv->plat->exit)
-		priv->plat->exit(pdev, priv->plat->bsp_priv);
+	stmmac_pltfr_exit(pdev, priv->plat);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 6a2cd47fedcd..e79134cc1d3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -21,6 +21,8 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 
 int stmmac_pltfr_init(struct platform_device *pdev,
 		      struct plat_stmmacenet_data *plat);
+void stmmac_pltfr_exit(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat);
 
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
-- 
2.39.2

