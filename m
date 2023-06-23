Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEB73B483
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFWKFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjFWKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD12116
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so5779285e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514670; x=1690106670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cNHhMxhOfIzH/XHLTmouuIYkabX6E9UflfjKJEOOE0=;
        b=LdIUgCCTq0idPl/Zeo2cKCPZMdEeYGT8+6AR9Ux4KqGKZkPgzBOOMzv4sA+WBy2WLg
         /1aMqPBM7vFbpCy5AJOOimdCEtx2D3ZZw44YQZamm1EsfcMSUH94yIJeqkx0Lpu8Phte
         WfCZ4s5VMhUbuYpiqrwG5LC7/epRQImm+muTLLLVNX4EM8CXVtmn6y2Bcsh1NOdCrZix
         LU1qlkiC3LQF6fbgSKI1S3QCsYJVg2aiSCuhcLkwcT72Dwdy5PN51Vko3a6HLmWYZzXr
         Fh5xzD5dlNdgFtHvYXknQAVuVyXsTsVHNjaTOJ4z88Cyu5Uvbxo5xWZ+UvTxta0fkSRM
         e39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514670; x=1690106670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cNHhMxhOfIzH/XHLTmouuIYkabX6E9UflfjKJEOOE0=;
        b=BQCfSTOLlsdMGkepqKE+8JYXkGbZ7zVM66oZXsFdvM4QJmzRt49G4WK34T8TOoTXq8
         Estjc+vX5fX6F9L8Fy8pyGEDfeBs9XCszulmOtdkUsYFscm9oSrpjUvtFVE9K+oFPei7
         y65MaoeZJQQIDZUP5IFLJ8FgB5rBayctcwNxmvfFFjB/o9l6+kA5FlQAFSx/bQc+JOqz
         f2QH2VgBEKirHbq1+6WV8Z4HALtXK9QOXm6YSSFTTRwyndhKjt+21Am92DFlUb20MXyv
         g4093x2gJZ0boJcWvnQ5+v+vOClZ61p8a8EKnVS7c3Seogf3MiSpvH5laHU/qnA3yFMi
         HykQ==
X-Gm-Message-State: AC+VfDzb5LGcpcjlOuKrJ1uIIeJjQyY6Yh2IGw6LMKdgzLGgRAsr/2s8
        gWKmMIYidmaPiTgfXeZkDnSWGA==
X-Google-Smtp-Source: ACHHUZ5fFiUq67rJVfopwJJLocjgBdy8zJzhGhOVI52C/HVl5gR+sEaM1MNtJDXXtmhY23x6LvVKxQ==
X-Received: by 2002:a7b:cb56:0:b0:3f7:e48b:974d with SMTP id v22-20020a7bcb56000000b003f7e48b974dmr20647085wmj.27.1687514670179;
        Fri, 23 Jun 2023 03:04:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:29 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
Date:   Fri, 23 Jun 2023 12:04:14 +0200
Message-Id: <20230623100417.93592-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
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
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 41 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  2 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 58d5c5cc2269..82d8a1c76476 100644
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
@@ -651,12 +685,19 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	return ERR_PTR(-EINVAL);
 }
 
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat)
 {
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

