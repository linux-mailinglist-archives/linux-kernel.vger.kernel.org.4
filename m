Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1286AB7D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCFH6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCFH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:57:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3B1F90F;
        Sun,  5 Mar 2023 23:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AAE460C68;
        Mon,  6 Mar 2023 07:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC0AC4E669;
        Mon,  6 Mar 2023 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678089457;
        bh=VvEi1bhjAuOdojqZ0kB5zN8T8WUO6C1yhUPafjNRg6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVurN90/gXk96RSzY7GZDTnC21x+y3qKDrcjjDN0VsoOHYudeIi/Q1CaHA8pT4bDV
         jWO7kK4RSau4D5LWUDtXDdZC9/czoSrDlSjweh2GprwE3WbXQzS2iCTW7eU5o+znWn
         RKxwx1hohmk4upPgsQj5atkmFMD049Cf7pfeULbgQ6D8AsQJILez0m96VSxtuxKpfd
         fbn1TrZhlboLWMquCKDxaEe4hKwO1k1eLYZq73bCdPJQqoI0P3eEnxfEE2FsAW2lUK
         dTnSmVh3XqfnDDHuAYRiGpvJCW199S2n2nEa8L8jwBMN4nFIPobMhUZbXKQbzdw/zB
         cPWB/hhqHKJUg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ5jd-0000is-JB; Mon, 06 Mar 2023 08:58:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 21/23] interconnect: drop racy registration API
Date:   Mon,  6 Mar 2023 08:56:49 +0100
Message-Id: <20230306075651.2449-22-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306075651.2449-1-johan+linaro@kernel.org>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c           | 16 ----------------
 include/linux/interconnect-provider.h | 11 -----------
 2 files changed, 27 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7a24c1444ace..ebefd263ac4b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1081,22 +1081,6 @@ void icc_provider_deregister(struct icc_provider *provider)
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
2.39.2

