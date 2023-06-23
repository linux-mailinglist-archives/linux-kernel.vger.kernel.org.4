Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6CD73B475
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjFWKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjFWKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DC26B8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31272fcedf6so429230f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514664; x=1690106664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwzdC7/KLQBqsNQ9Z3vvCuyrSfrs5l5gzbo6Rxb7/UU=;
        b=MZzt3xHdJawMjIK2dNuZKH1MQAxlWe/r3rUMF7qW6PE/PRdd83nOCHtiSYTzTXRTZ8
         DfOMKIIuYCA6SbO8krzJuZyLEsx0eVPqghCXPV+sPuNm+1HPkve4i02Da+6rBpO85y/U
         rAdHs49OjoVJ3tZNdwKgQ1kUPXnK0ApbjXvXPWTz1dHPYiI3DO0f6+ZtfK7izZev9wkF
         PzKEunjLx4Vz3uIvjNBVRPvV/vP1u4Xqy8DsZWnsOpKdwZthRS7FxV88/w3hXWX7XAZD
         IqKK82p2schhSdroYHKUEzX13ZeE6Tw1/zETkCK/zS9zBVC/kTT4RgzP3yzWBrjB17kO
         1fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514664; x=1690106664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwzdC7/KLQBqsNQ9Z3vvCuyrSfrs5l5gzbo6Rxb7/UU=;
        b=hULqqyi2gkuTOT66DLXy4xKC1/ruOYTdDeh4e0F+k/zWijZVfA3vSUII3B3skdimQb
         mOuzuRFrznv3O/X4zwTaYAVXTq1BBxMnATBYjF2cEcvlOWwmYNHXZ3bgO2HTZ7LIb1Hu
         qSFZp9RtWQAbNbTyi8o2x8ZHZJpy/jw7V+MfzZTf0mxlpdrd6DkmwCJaiX/M1ZkTb2TN
         SBHo1KiXQpaLB+dpFQIkKyfBMPqV5Lb8eTB9V3uuE+06QuUTjL4evGoUBnTNvpu9of3L
         2Tm7PZnFkLXX4MKwrVtE/SmVa9vx8dC9Aw7W8DSDn5rhN6t7eP/vPVtpo5XysNuzAWOB
         CN6w==
X-Gm-Message-State: AC+VfDx/9q0OZF1HBkCyL542FKUZAWbMHosbb5Rbwdg90b6r/EoJKznB
        4wiIRJVWnVuzZAuunslj6M8WqQ==
X-Google-Smtp-Source: ACHHUZ6X6W97yIjboRztdBubzybbieSu4zcX8uLRfqburrXXcSEhYItvMiMQsetiDQMMc/Ow/qJ8uQ==
X-Received: by 2002:adf:f650:0:b0:2d1:3eb9:c3c2 with SMTP id x16-20020adff650000000b002d13eb9c3c2mr3471562wrp.54.1687514664694;
        Fri, 23 Jun 2023 03:04:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:24 -0700 (PDT)
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
Subject: [PATCH net-next v2 03/11] net: stmmac: platform: provide stmmac_pltfr_exit()
Date:   Fri, 23 Jun 2023 12:04:09 +0200
Message-Id: <20230623100417.93592-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

