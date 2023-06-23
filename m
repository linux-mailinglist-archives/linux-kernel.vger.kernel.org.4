Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A673B481
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFWKFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFWKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31672113
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa7cd95dacso4783795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514667; x=1690106667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=Gmn4CPGBxppaf2DODUZSGsz6WLHyEDshmlrrZb0eSOwPmIpH4TMuoDUOKrGpHn9Di3
         P8M3l7gt3UFAvZyyQWDyxXYnl8qMIi4/FtrrFaWROrxh8NDVim2nsZv1aqTr91wzvWcX
         8ZYBk22LyUUzPiEASzIKPB5n8dD87s82maoXgJdq7z9mElBSIqvAf+dI5PwTl1avMDjT
         mO1X56utPBOMbxw8KqBMay4XGZh7apBIwzpgtGWkOdTlPJVn7SNLg+EMXZQFdk1f/OZ7
         SR3Q8XTLp04H4Q9yL8yG8w/P8TZ/jsiQo27cA8fP3rNJ6ghcUO4Dva+oMElyJr2IzCnE
         Hslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514667; x=1690106667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=dW6Q3kpPRZHRFe5zezMlsSMDHrx4xLL+tClBK5PYoaukmTxItJdFjbrdn/bsqSbJUj
         LGRhidGyuKdsd66GBAKhHhIwrETIdeeQaBq/Z08QdVrOdYMlC7xyoQn+ChHHHaLbODxV
         /KqTImliWaVnJaMFvCPg/cl/WvSInBxEYo3jjnjKMjE4vZms4b89vnkyraU8V/snH2TT
         WAyD441ISpvTPisZf8ul3j6IZDR63+WGI4AzHoAT73iw2FCJIWKUk3IrjqH96pAolwXN
         Ob6fFOooJsw4Fpf8POw2NA482gSuVrSNaxBzY+gaw/cP39Td6hPd65hcjNrfb/LzWnp0
         uIAw==
X-Gm-Message-State: AC+VfDwaSCPFUqlh5gFdxPOyiedZ461FT8EIINm/ezOq2MzMz/FpvPzS
        VhHoAOqKJSGZ8E/5o8YEgAS9Wg==
X-Google-Smtp-Source: ACHHUZ5fYRMaygvi2CJWcmAn7/oTOJt3J07hgY5PtNkWFV293rqUyRH/TNtyiRVcXAUg8vmlR8vUqA==
X-Received: by 2002:adf:f607:0:b0:30e:5fe4:9cc1 with SMTP id t7-20020adff607000000b0030e5fe49cc1mr17926510wrp.29.1687514666860;
        Fri, 23 Jun 2023 03:04:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/11] net: stmmac: platform: provide stmmac_pltfr_probe()
Date:   Fri, 23 Jun 2023 12:04:11 +0200
Message-Id: <20230623100417.93592-6-brgl@bgdev.pl>
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

