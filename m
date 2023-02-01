Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F00686409
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjBAKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjBAKQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:16:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D153572;
        Wed,  1 Feb 2023 02:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45DBDB82165;
        Wed,  1 Feb 2023 10:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4FFC4167D;
        Wed,  1 Feb 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675246593;
        bh=KW9r2w3sR70m75wWgICIelAqw9kb2RB4YyHuGvDFwCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgPv53iLEN4VAiZA6SdmYXkco5vAXCAZeEtkTKHYDlcei7xDMcrt2LCfxPQ1kHJZ1
         gnkVoLVAjSvZJmtwhAFv9FjSlPA2oHzoYHKSW+n38niRDbEQI0/XJ16E9rMXtN6q5p
         kV4YyeAx2WGz5Z05hWmyWczk/nei8HcMHvdhExSDGVjgez+7dA7uJ6ugqGQeTQNtR0
         DHH2kwe8q2waCjB12oPznQJZDPA2Ufg61OYJ22mqx6xl27WokL0wHwWKqLaunJ0RJ2
         XCAkfalwNZFAmHODD9v/ZefKm+YljW76KvWOX7puqbN920reKf3Hi2erkxsWe2VpEa
         P+4EaiA8UlTlg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNAAg-00044c-Qx; Wed, 01 Feb 2023 11:16:54 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 21/23] interconnect: drop racy registration API
Date:   Wed,  1 Feb 2023 11:15:57 +0100
Message-Id: <20230201101559.15529-22-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201101559.15529-1-johan+linaro@kernel.org>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all interconnect drivers have been converted to the new
provider registration API, the old racy interface can be removed.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c           | 16 ----------------
 include/linux/interconnect-provider.h | 11 -----------
 2 files changed, 27 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 93d27ff8eef6..b8917823fd95 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1078,22 +1078,6 @@ void icc_provider_deregister(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_deregister);
 
-int icc_provider_add(struct icc_provider *provider)
-{
-	icc_provider_init(provider);
-
-	return icc_provider_register(provider);
-}
-EXPORT_SYMBOL_GPL(icc_provider_add);
-
-void icc_provider_del(struct icc_provider *provider)
-{
-	WARN_ON(!list_empty(&provider->nodes));
-
-	icc_provider_deregister(provider);
-}
-EXPORT_SYMBOL_GPL(icc_provider_del);
-
 static const struct of_device_id __maybe_unused ignore_list[] = {
 	{ .compatible = "qcom,sc7180-ipa-virt" },
 	{ .compatible = "qcom,sc8180x-ipa-virt" },
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index d12cd18aab3f..b9af9016a95e 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -125,8 +125,6 @@ int icc_nodes_remove(struct icc_provider *provider);
 void icc_provider_init(struct icc_provider *provider);
 int icc_provider_register(struct icc_provider *provider);
 void icc_provider_deregister(struct icc_provider *provider);
-int icc_provider_add(struct icc_provider *provider);
-void icc_provider_del(struct icc_provider *provider);
 struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
 void icc_sync_state(struct device *dev);
 
@@ -179,15 +177,6 @@ static inline int icc_provider_register(struct icc_provider *provider)
 
 static inline void icc_provider_deregister(struct icc_provider *provider) { }
 
-static inline int icc_provider_add(struct icc_provider *provider)
-{
-	return -ENOTSUPP;
-}
-
-static inline void icc_provider_del(struct icc_provider *provider)
-{
-}
-
 static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.39.1

