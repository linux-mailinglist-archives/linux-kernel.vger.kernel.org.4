Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E147389AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjFUPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjFUPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2701FE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so6385684e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361830; x=1689953830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXhQ0UIxbIRXJu72M9URbDfOLtQ/Rc/6HlYK7uavKwg=;
        b=ZKNhsBXVBWDsZT+gQdyHtPSF2CiUZVn4CH6FHKpTsKLUctQft/ssO2/+UcidIhXoYH
         yaRcbER3BLmJX2YRyh2Qvhy3wzwg0LeX6QpjXO0PvLPe7V4TFPTDbX0ZVff9ownq7439
         Q8Z7u3EF7o/MgMWDNR6O3IgHWvB5ArH6vvoJD4s16hZbMC2/zBfT7GJ6heD12O0/2E0s
         dbIpgvmhH2I+OKUzQxtKEWgGaisUjfeMOP78NKVcoOKszCa2f2T/SzgjG+ig5aN7ZH+2
         s6Z2FnCYcI4mE5O/rt3od3+4hevgnH0SYppx8dLK49t5XHV9TjyAF7SVqR7RLcEn3ynA
         p80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361830; x=1689953830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXhQ0UIxbIRXJu72M9URbDfOLtQ/Rc/6HlYK7uavKwg=;
        b=Q8EVd043pblr+VN+4gkR/zfwL6F1JPLTWSht+7OF2EGni26y8L3OI/qoTXyk1ig+yW
         vxJydynQiMTIWj2l0Ido9QSIwccS8n1At2XMHwM5hndr2IYeoC8++0P3TK+mC20Jf4Ij
         e1Wta5UtOcKFiWBh29UY6YQFP0O2mj3jduzCsCOErMJD4b8vaKI8YB6LFoQRy4bnb4c0
         tP3whoY7gvMqycnT/w6N21TLhsbdvxB55Y+zbN5IrqTg6WMjZjt5xoxubAs6JUf86Qjw
         4zrjsAIChbRC3DoPs/UeoP+DbtRCi9TUMjQ4kQYHkvwXM1fGEWRPGYOfD+/02xaIi0Qj
         EP8Q==
X-Gm-Message-State: AC+VfDz5WE9yEwrr/mBnObrlLQ2YzWuf2lqg4ru3dRBAQ0+z/05tF7fo
        v5vbkrNPQeMJsQQpw7m2KA+BgA==
X-Google-Smtp-Source: ACHHUZ4uJSo2gHx8ZKi/3Nrj3/6juOImyrIJVAJT2kltHhI9yCnZTfyVARk3e8AbVi+9c52J2HXnIg==
X-Received: by 2002:ac2:5f99:0:b0:4f8:6cad:aae7 with SMTP id r25-20020ac25f99000000b004f86cadaae7mr6596886lfe.61.1687361830338;
        Wed, 21 Jun 2023 08:37:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:09 -0700 (PDT)
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
Subject: [PATCH net-next 08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
Date:   Wed, 21 Jun 2023 17:36:47 +0200
Message-Id: <20230621153650.440350-9-brgl@bgdev.pl>
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

Provide a devres variant of stmmac_probe_config_dt() that allows users to
skip calling stmmac_remove_config_dt() at driver detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 58d5c5cc2269..043fdfdef6d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -8,6 +8,7 @@
   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *******************************************************************************/
 
+#include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
@@ -629,6 +630,39 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	return ret;
 }
 
+static void devm_stmmac_remove_config_dt(void *data)
+{
+	struct plat_stmmacenet_data *plat = data;
+
+	/* Platform data argument is unused */
+	stmmac_remove_config_dt(NULL, plat);
+}
+
+/**
+ * devm_stmmac_probe_config_dt
+ * @pdev: platform_device structure
+ * @mac: MAC address to use
+ * Description: Devres variant of stmmac_probe_config_dt(). Does not require
+ * the user to call stmmac_remove_config_dt() at driver detach.
+ */
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+{
+	struct plat_stmmacenet_data *plat;
+	int ret;
+
+	plat = stmmac_probe_config_dt(pdev, mac);
+	if (IS_ERR(plat))
+		return plat;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       devm_stmmac_remove_config_dt, plat);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return plat;
+}
+
 /**
  * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
  * @pdev: platform_device structure
@@ -657,6 +691,7 @@ void stmmac_remove_config_dt(struct platform_device *pdev,
 }
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
+EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
 int stmmac_get_platform_resources(struct platform_device *pdev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index af52d5aa2b9a..8c1e5b2e9dae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -13,6 +13,8 @@
 
 struct plat_stmmacenet_data *
 stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat);
 
-- 
2.39.2

