Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EDA7389A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjFUPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjFUPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC4210A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f901f87195so39704415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361827; x=1689953827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=G6zYz9cKoSNRIVlhsRux2o+ct2G37TFxEQtQQVXLGOrYecbehoGdxONWH8lp7WkNTZ
         7KMH4O2hnylqp7YUNNwIGyorY+eT/iE/kuv74lWBsVrEaOvH3eHxgd9NWS3iwiuDqn08
         pZu6f1/jsxiy8/DZTT6w8uFkt26l1A+XYmazHQgKzYJkWYB9N39o57Kmjg1fn4H+AaIK
         nIAofbGW5NZ0oVR4Fh8U4u57UZINc9copdCKprqr7ZIEk78QDbVbNOYsYPISczGi0zMw
         RAH9Fb02vq6DS22CwN4VHCOK1HHQfP0NvUHuaTTrVww5MX8yolM/P6F9eTNz6mKlqz0q
         ZzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361827; x=1689953827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=Dkj852aLAdsJF+hUHBi6tCPawORF1ARrYY7RK7cW9GI2KgPAbNBrsTKIhNsSnrveJL
         6khvb7Pl69LCHaCWPSB5EEcZCcq15cjV4j6cJlRuTNrGWL33UHMRZ3hZBr0qA+hv9F87
         8JJ7mHxrogsgHYxI2cAB4xI2Vd3v4qjbVaqIKKfsF62wit9cTIM3y1/B/khXhZexNX4s
         9ig1uJz/nZRAN4fL99qEjd+DS4qgYDKDcWmj6ctMK8o/Fuwx6YF3WOVch2CoMesEH9SD
         eOZ+XPlWLlGIZoeQfGOvrGotpyarUN9nsFFCX7WjfOoqJTRtFNfs9Em/vzbrCiu15Fxe
         7a0w==
X-Gm-Message-State: AC+VfDy7Hb6h8UOTroNO9Llu2VctUa3C54NB5HRdo9BAWv/zRuW4cIer
        SAxjSxm8vtc4HI5h0V6OMrHBHw==
X-Google-Smtp-Source: ACHHUZ7El/Ih0d2Yz/gKGvMngTDUjCNwXQ864fWEFUCB1ReXz/MhJ1k+riyAXlWajUNesQKCvoVyww==
X-Received: by 2002:a1c:f616:0:b0:3f6:d90:3db with SMTP id w22-20020a1cf616000000b003f60d9003dbmr13811551wmc.3.1687361827133;
        Wed, 21 Jun 2023 08:37:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:06 -0700 (PDT)
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
Subject: [PATCH net-next 05/11] net: stmmac: platform: provide stmmac_pltfr_probe()
Date:   Wed, 21 Jun 2023 17:36:44 +0200
Message-Id: <20230621153650.440350-6-brgl@bgdev.pl>
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

Implement stmmac_pltfr_probe() which is the logical API counterpart
for stmmac_pltfr_remove(). It calls the platform's init() callback and
then probes the stmmac device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 28 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5b2bc129cd85..df417cdab8c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -734,6 +734,34 @@ void stmmac_pltfr_exit(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_exit);
 
+/**
+ * stmmac_pltfr_probe
+ * @pdev: platform device pointer
+ * @plat: driver data platform structure
+ * @res: stmmac resources structure
+ * Description: This calls the platform's init() callback and probes the
+ * stmmac driver.
+ */
+int stmmac_pltfr_probe(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat,
+		       struct stmmac_resources *res)
+{
+	int ret;
+
+	ret = stmmac_pltfr_init(pdev, plat);
+	if (ret)
+		return ret;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat, res);
+	if (ret) {
+		stmmac_pltfr_exit(pdev, plat);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index e79134cc1d3d..f968e658c9d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -24,6 +24,9 @@ int stmmac_pltfr_init(struct platform_device *pdev,
 void stmmac_pltfr_exit(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat);
 
+int stmmac_pltfr_probe(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat,
+		       struct stmmac_resources *res);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.39.2

