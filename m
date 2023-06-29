Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF54742D66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjF2TVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjF2TUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6214B46B4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688066286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCceMk07Z77c7iGv0vMNdhiFvW89N91YRXanb/xg6cQ=;
        b=dbw/GRy/ppvpcrIJA+UvpmnK6mnlb3nyXjJWy7e6uWDAFlLPO/XIM16tbm5SXUYXyFFOmn
        TBBFNM4TzRt6BKcGc1ChNB/JAIdEvmp+rG2lX8wWDwo3+X2pl6hrSM5bhMRvGq6PYXOExJ
        KPbx5OtuIfrADZPNfOSvF5hIjLIDYWw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-6s4JwX4JN4u7aREQZS0Slg-1; Thu, 29 Jun 2023 15:18:05 -0400
X-MC-Unique: 6s4JwX4JN4u7aREQZS0Slg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-56942442eb0so8801007b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066284; x=1690658284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCceMk07Z77c7iGv0vMNdhiFvW89N91YRXanb/xg6cQ=;
        b=As3/7n9KNVR9Vw3WPzleRjgaIQalQCNwg0hY6l1A8j6L5hCnLdCLm1al+q4K61DXlQ
         MBJELHiU4sEugQvVx/6S63l3MWQr00H3ZH6U0StbM7L0jHPpJcQZ8T6SEQYylGCo0V2x
         NuQJBBTcQYcz4dv+aglBvFbFFNFcDTBH7aogjhyACLFFhf9FW7tnIRv8S//p2UIHPKGc
         VkvG1tc5OMp4nVePsEsOS5nGh1avqsVs/aANEN3vaILIyJIZw5pKosBwEvP/66ErrqzV
         lTAzHD1rVYxgjBDkIwrHIyTu5nHkS1+oW+PAuEGlmTYx0Ss2DeGU6wWs0ICLQnvfuFId
         XQIw==
X-Gm-Message-State: ABy/qLaXjOKToy0HX7gMjuY8eEF8iIIvetrK+L4f9rGfV8MNjYPYc8r5
        eLmn48RkJG2xLcWwyNaD3iOIv3JGZ07mUmaCWAnm/55uzagJ05ncHflQSXQVwDsxGc29DnGmjFW
        hjnmJw7UAJPP1JY3P7XvSvJbLe6lM/NT594GqwRhjp7MFYZIPQ+EsINdywMRkmhkDt4CONH7wIj
        P9aixfXPVb
X-Received: by 2002:a81:88c7:0:b0:56d:43bd:5513 with SMTP id y190-20020a8188c7000000b0056d43bd5513mr352228ywf.5.1688066284438;
        Thu, 29 Jun 2023 12:18:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdHXzFMRozd6nGxf58W0Xv/QopKQ9WchA/okhijXMBtBl5YPN9hN+ACX/VQ9/Q0R3vF2Wxng==
X-Received: by 2002:a81:88c7:0:b0:56d:43bd:5513 with SMTP id y190-20020a8188c7000000b0056d43bd5513mr352198ywf.5.1688066284148;
        Thu, 29 Jun 2023 12:18:04 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id w127-20020a0ded85000000b0057085b18cddsm3052478ywe.54.2023.06.29.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:18:03 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in probe
Date:   Thu, 29 Jun 2023 14:14:18 -0500
Message-ID: <20230629191725.1434142-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629191725.1434142-1-ahalaney@redhat.com>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are useful to see when debugging a probe failure.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index a40869b2dd64..d792b7dd9fc3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -706,7 +706,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to get platform resources\n");
 
 	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
@@ -735,13 +736,16 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
 	default:
+		dev_err(dev, "Unsupported phy mode %s\n",
+			phy_modes(ethqos->phy_mode));
 		return -EINVAL;
 	}
 
 	ethqos->pdev = pdev;
 	ethqos->rgmii_base = devm_platform_ioremap_resource_byname(pdev, "rgmii");
 	if (IS_ERR(ethqos->rgmii_base))
-		return PTR_ERR(ethqos->rgmii_base);
+		return dev_err_probe(dev, PTR_ERR(ethqos->rgmii_base),
+				     "Failed to map rgmii resource\n");
 
 	ethqos->mac_base = stmmac_res.addr;
 
@@ -753,7 +757,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
-		return PTR_ERR(ethqos->link_clk);
+		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
+				     "Failed to get link_clk\n");
 
 	ret = ethqos_clks_config(ethqos, true);
 	if (ret)
@@ -765,7 +770,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
 	if (IS_ERR(ethqos->serdes_phy))
-		return PTR_ERR(ethqos->serdes_phy);
+		return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
+				     "Failed to get serdes phy\n");
 
 	ethqos->speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
-- 
2.41.0

