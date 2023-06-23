Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1E73B47D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFWKFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjFWKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F092122
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3110ab7110aso496283f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514672; x=1690106672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii2x6MMLssuPPDNgYZGKvPLHM+c/zKC3YPgF49rTzdU=;
        b=xSDCg+lQUTIDMHwkxHAv0qmSrhP3TF+2Q+0dynApoIaSJ5GIQM6boUZKpmYDJLDuIP
         BOEE/sQ2caNPKZ1VaFG7OZwGiPYnsN9M90ejDCYrmbZJTTCLS/jfL3VuASK7IbdgtUm8
         6PpCE0fAhax4EJ36dRSkksMuIH/rHPH7J1PBgvNevC22JeNI4uq1L9CEtfIUlw0Iaq30
         WBH3cUDzzwurXlrJIDqzk3Vfd2W9XovQSWzJ+KylTKtr79sm7p8zwZZ4jw5WHgFoQLXT
         ORDkSaDF2Xep9pqXC8oU4uxnl3oy3wSOhvV8X/TirT9j0K6ocU4LZH7IT1DirOgPUW9k
         35fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514672; x=1690106672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii2x6MMLssuPPDNgYZGKvPLHM+c/zKC3YPgF49rTzdU=;
        b=dWhM32jJ8s0B7UMcGy+E+ogXi6CgaW3rnleSPUbITTcdeyynAe8QiZN1l8x8qEWfSS
         IDFo3dBz7pGfHQI/tkDw8cKGLQ5hPA6g7qCqd4FL2ewbXUSSOPVEhlwvUJ1iaB6Zro0B
         lbPk2T4ycnzwso3k8k/jByRxlbZGfdnvbaluOpzLyeA+SP/kE/mOWG/KlTZDN4bOY8Wo
         hN18E4LA1dk+XAybFmcO7BLuJfgcPMiUSkKBgFCWRH5BCtv89R8e7H1oIonjfdliNya6
         ne4lWIZwX8LUD22CLt69KpM91KvJFrWvtzBXTr60SyXJIyjUaLPZZvcQoVWRYOLdGm1b
         q3fQ==
X-Gm-Message-State: AC+VfDzshdgtaxcqmXnxSICof88b0Q9ugJEt72VDAWapB2dkGmkFbXXH
        fqqoGqkPGF8HpCubRo961GaN+g==
X-Google-Smtp-Source: ACHHUZ4zkuuP4XLvWsf7VK9/F+8V9/cJeGdLNhhFXFsK0B4wOm3wwwI0PE3dMoROI9fRkKxT0tyIbw==
X-Received: by 2002:a5d:6ad1:0:b0:2f5:d3d7:7af4 with SMTP id u17-20020a5d6ad1000000b002f5d3d77af4mr16354365wrw.63.1687514672396;
        Fri, 23 Jun 2023 03:04:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:31 -0700 (PDT)
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
Subject: [PATCH net-next v2 10/11] net: stmmac: platform: provide devm_stmmac_pltfr_probe()
Date:   Fri, 23 Jun 2023 12:04:16 +0200
Message-Id: <20230623100417.93592-11-brgl@bgdev.pl>
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

Provide a devres variant of stmmac_pltfr_probe() which allows users to
skip calling stmmac_pltfr_remove() at driver detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 30 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 82d8a1c76476..231152ee5a32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -803,6 +803,36 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
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

