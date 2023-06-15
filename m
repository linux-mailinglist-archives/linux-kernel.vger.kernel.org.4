Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016BD7318A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjFOMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbjFOMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:15:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568662121
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30af159b433so7580209f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831294; x=1689423294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shVe7iXJ1awuGuKmYEwLb77YVMpGOLIOU4Dax+RDeEA=;
        b=dlDrDMLMnb7Fqq0jlcStDO6lq+BgV1BfRZwnKtZFFdb4XCdj/yS1mzXym+jFMCCAFW
         e7gmAgV+RXQSXrLTUFhmgTfDuga7xUrMOkEZucx+NwOVw2xhebk+U/OcZCJ1mX8ljybX
         n9K6gSI2fpxqPuQjXTfUX0EdBVZ8P9KiVOGqSNDqM1rg/Y3N6CJZcxz2gvWpmRzxduVN
         /JxdvSpLleT1D8Tnvkvw33d/dz8cC2YVWHwLtxy9s0j7+Jb9zNDSq/9VB2mXZ2g3EDdK
         BpXjShwkImCDkpDNrzFR3lQOvZsHH+V23Zb7CiSVLKAzYHIWPyxPmFDfc4uFbK2HY8Yh
         wmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831294; x=1689423294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shVe7iXJ1awuGuKmYEwLb77YVMpGOLIOU4Dax+RDeEA=;
        b=enhhL2xTXatUgo/MB2GwgtV97SH72LPNE/mMMB3M5VsJNeJpCC4m4+B39qUs49i/Sq
         eh+IWMPaQKUwOoG8+EuBTFBSAv3k8WvCn7+JKQTGNL6d8ObQb6/S4vBCZ3l57DwqbRlh
         h3CDZn6FhrF7/uc0RhqqVdIK035bvkm2qDterJBcCoafA27Mhm0N22uSJi/3zPizsIAt
         W8AGwhctUDXVHiBA0RBm3lE3/2mkjo8W8ydyn22s9VyxKWIKSqUBbD7FqSZKHqR8w1aX
         A1fWbUa5XS4+zmW8/uiYYXwUwuV4MdG0R887CU9sBBf5rbDWqgQ9i6Px2h+vcwJCHLMH
         86/g==
X-Gm-Message-State: AC+VfDx4DOO7ld4GpjZpvJItF/9Qsd9AwHzHsVqwsbiRGMdDizbjKOOI
        Q5pZekZGlFITKieXmqE9A7uOhQ==
X-Google-Smtp-Source: ACHHUZ4BkD4qzQRvEGU7o6thVVlbRBFaFM9VgeCVSPJzBcEEoIH1q6H2OVvNrwnKfIKircfJZPizMA==
X-Received: by 2002:adf:f8d0:0:b0:311:14ab:5621 with SMTP id f16-20020adff8d0000000b0031114ab5621mr1145607wrq.30.1686831294636;
        Thu, 15 Jun 2023 05:14:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:54 -0700 (PDT)
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH v2 16/23] net: stmmac: add new switch to struct plat_stmmacenet_data
Date:   Thu, 15 Jun 2023 14:14:12 +0200
Message-Id: <20230615121419.175862-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
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

On some platforms, the PCS can be integrated in the MAC so the driver
will not see any PCS link activity. Add a switch that allows the platform
drivers to let the core code know.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Jose Abreu <Jose.Abreu@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 include/linux/stmmac.h                            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa07b0d50b46..fdcf1684487c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5793,7 +5793,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		}
 
 		/* PCS link status */
-		if (priv->hw->pcs) {
+		if (priv->hw->pcs && !priv->plat->has_integrated_pcs) {
 			if (priv->xstats.pcs_link)
 				netif_carrier_on(priv->dev);
 			else
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 225751a8fd8e..06090538fe2d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -293,5 +293,6 @@ struct plat_stmmacenet_data {
 	bool sph_disable;
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
+	bool has_integrated_pcs;
 };
 #endif
-- 
2.39.2

