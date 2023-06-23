Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10A173B4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjFWKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFWKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7930EE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so705926f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514947; x=1690106947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ds8NiiaWx7S6UP8O9D/ooCMxtDTCkVYtSDsiDSpfu8=;
        b=05CEclI0RNBG811nHybT4Wf80lxO/5ncTBmCTBZUwmnZJB+wENLgDJW7YoVimVGpsw
         QbEv1xphO/vYaGbskQWEgUFe2Kvn4oRjin1OYZh4LYRrjviR8fy4G/sc4g2su6mEcnT8
         KKvz9uCVulrGi537aPDOocdZt4Wkpa0uBYxI9Blbu6aA0R+jAnuUEbgdDlHZy+hlTINu
         a0n9x6klMBJM6soYf5rOYX7X7auxd+l/YMQmNtj2DA22uNSlf6dBq7QYjYqF5SpMchKC
         H7530d/4fhVzqZ/TAABdazsKCEVMFA2MbHN/qQo0E4ldvwJyY9Yu2odiwa43pSwCJdY9
         ZWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514947; x=1690106947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ds8NiiaWx7S6UP8O9D/ooCMxtDTCkVYtSDsiDSpfu8=;
        b=iobX77iu2V3tHWHBlYH5suk80hAdO4ksxGX+XpPPVsn0kw+bjls9mSyloilFCMy3Sc
         bDNxAvTq11rpZGzokkpr3JqSD3wh43re9wog9jQbQY6OjgQkBIZL1RsLEhqHhzRDhnhS
         VtLHLmUaeG03O3yrnsYksfIstmbNSXFYO2VaRI75/xZgrEWWBHElXUBzTWcJVpaDi8Zj
         fi9di79WHzHLJm6b/Ck4gptdYgiN+pcIgD+xEV0jIsCDTAWJ2yeBDOOMY691GsnUjuId
         7qcW3kZpYVxVm+jJex5Xj0ntWDWZisuua8l0lFZLLOXG3RGfWJ0KO6JVYdc5Sb//auz1
         gPTA==
X-Gm-Message-State: AC+VfDx7PtspMR7B52QomRCHKavwMOq6nAGY0NJ+j7X35nJ403EK7Mzi
        mLuBoKOmphw0NOvmFiRVvrgjPw==
X-Google-Smtp-Source: ACHHUZ5upJVkJxHOJd3gKTPyf7WvTtsGYzbtpLvkW3EB4LbPt3cmjmcCo5+rWdFRVSnc5yhWB90msw==
X-Received: by 2002:adf:df81:0:b0:311:1cd7:68b3 with SMTP id z1-20020adfdf81000000b003111cd768b3mr21982343wrl.57.1687514947319;
        Fri, 23 Jun 2023 03:09:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:09:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 12/12] net: stmmac: replace the en_tx_lpi_clockgating field with a flag
Date:   Fri, 23 Jun 2023 12:08:45 +0200
Message-Id: <20230623100845.114085-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
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

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++--
 include/linux/stmmac.h                                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2d68a6e84b0e..efe85b086abe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -421,7 +421,7 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 	/* Check and enter in LPI mode */
 	if (!priv->tx_path_in_lpi_mode)
 		stmmac_set_eee_mode(priv, priv->hw,
-				priv->plat->en_tx_lpi_clockgating);
+			priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5a67af4526c7..0be3113197b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -465,8 +465,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->force_sf_dma_mode =
 		of_property_read_bool(np, "snps,force_sf_dma_mode");
 
-	plat->en_tx_lpi_clockgating =
-		of_property_read_bool(np, "snps,en-tx-lpi-clockgating");
+	if (of_property_read_bool(np, "snps,en-tx-lpi-clockgating"))
+		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 
 	/* Set the maxmtu to a default of JUMBO_LEN in case the
 	 * parameter is not present in the device tree.
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c3769dad8238..ef67dba775d0 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -215,6 +215,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
+#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -280,7 +281,6 @@ struct plat_stmmacenet_data {
 	int has_gmac4;
 	int rss_en;
 	int mac_port_sel_speed;
-	bool en_tx_lpi_clockgating;
 	int has_xgmac;
 	u8 vlan_fail_q;
 	unsigned int eee_usecs_rate;
-- 
2.39.2

