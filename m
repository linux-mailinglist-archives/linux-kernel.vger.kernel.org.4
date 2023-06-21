Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209D77389AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjFUPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjFUPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF91FF2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so7545865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361832; x=1689953832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGD2YNQo5DCptfM/plxJR3RlHOdJ1opqXIoNZJpMScQ=;
        b=INYNN1dz0gWjscIjzw8UtsEksmuIN5TllH30vYEzWIJjI/XN4mMGeBoiY7Y5XeQ/MV
         dZQdk+Txvg8zLoqET1De3mQ2qah+eU+uv9xFt2U1EVqc7GsUf5cWliGG6gr9Firtaogs
         amX4HCMgtPHjrkoSlqgq2cgHIAr/N6fFv6tkR0CtQDNBNURaXRXGWfIw3+ZcuIKuHXj/
         Q3lU1XAFbedveozvSaSw21nwM8AwPbSp5Ygdo5ska0ouusbn9WCq7tMeoK88rqpM+fPi
         idGAcKQ5SkNkWKICMcZQ5aPNeZY3VmGwrEU1mqdPSI8gCbZzfKf3LSacBZ5mRBQiAfyu
         RzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361832; x=1689953832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGD2YNQo5DCptfM/plxJR3RlHOdJ1opqXIoNZJpMScQ=;
        b=Jd2T8Dw1yr5Bat968k2QaALr+2iPkX9jtdpuO/72HoMB28LvOk1MjqIZOZaZtePWPK
         220ZHZxI1GBm93Y1HsbYh9GtPqWwmaqTppydcE5Asq1VrE3gQrhWff69bK9b4s9kWYcc
         Qqizo59vO3xzSiO3h/dNd8zAHSEi89w5rXmyLduO7n8p+qmy0Y7QLD+I95pPOdAQ/hWw
         Mw0qZehsOxPR8c6GK5qVNvSwdts6yUeVYZ06cncMsJMzqwePlyKRs1GDVEkoGleJM3M8
         n3GCtkqMPyh5acSZNHZgyIZ8rNpuZn0zoieUw6WvUD5wuOX0Rlu+Wq2gAqyzMvYSIY3I
         wQfA==
X-Gm-Message-State: AC+VfDwZvZWDDw7CzKQ64PgqlvY7kPZj8lPx2Mp4VPDdJHTKHRawnnPn
        A1eIguZh5TLAkjM1hk4YAN52Gw==
X-Google-Smtp-Source: ACHHUZ69sgYoTgZluegZ/SRfV86MRMgLoC7Hzm7bkGWZ5zV2hOQoqblgZYilUY5Pkexsl1OEY22JNw==
X-Received: by 2002:a1c:6a1a:0:b0:3f9:b8b1:9d2 with SMTP id f26-20020a1c6a1a000000b003f9b8b109d2mr4122895wmc.33.1687361832707;
        Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
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
Subject: [PATCH net-next 10/11] net: stmmac: platform: provide devm_stmmac_pltfr_probe()
Date:   Wed, 21 Jun 2023 17:36:49 +0200
Message-Id: <20230621153650.440350-11-brgl@bgdev.pl>
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

Provide a devres variant of stmmac_pltfr_probe() which allows users to
skip calling stmmac_pltfr_remove() at driver detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 30 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 043fdfdef6d4..6b0dce6cb661 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -797,6 +797,36 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
 
+static void devm_stmmac_pltfr_remove(void *data)
+{
+	struct platform_device *pdev = data;
+
+	stmmac_pltfr_remove_no_dt(pdev);
+}
+
+/**
+ * devm_stmmac_pltfr_probe
+ * @pdev: pointer to the platform device
+ * @plat: driver data platform structure
+ * @res: stmmac resources
+ * Description: Devres variant of stmmac_pltfr_probe(). Allows users to skip
+ * calling stmmac_pltfr_remove() on driver detach.
+ */
+int devm_stmmac_pltfr_probe(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat,
+			    struct stmmac_resources *res)
+{
+	int ret;
+
+	ret = stmmac_pltfr_probe(pdev, plat, res);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&pdev->dev, devm_stmmac_pltfr_remove,
+					pdev);
+}
+EXPORT_SYMBOL_GPL(devm_stmmac_pltfr_probe);
+
 /**
  * stmmac_pltfr_remove_no_dt
  * @pdev: pointer to the platform device
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 8c1e5b2e9dae..c5565b2a70ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -29,6 +29,9 @@ void stmmac_pltfr_exit(struct platform_device *pdev,
 int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res);
+int devm_stmmac_pltfr_probe(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat,
+			    struct stmmac_resources *res);
 void stmmac_pltfr_remove_no_dt(struct platform_device *pdev);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
-- 
2.39.2

