Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9473B474
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjFWKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFWKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F9E75
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31110aea814so515438f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514663; x=1690106663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=VJVkqpM0z1wIlKhzeq04Rr7yyGW6m3B/0zSZk0ZF4oiorHhFrGx3eAZ1O4ghz35lwf
         2Vzj0yeKHFt8iyIvWIANy0BeEEJLy58mwkOpyJ8EUD5cfbEnin8OZiW5Qrfrhba4IafS
         AhgymSi7xoCo2CAObI5Le7wjzGVwohZoop4TrW0K1NQs6HjtaoIvw8x3N0+kNrhlaH5u
         c/9DBysGIZT8a3wYKYvZtOBcF/ETPZ+WRMljR5pIW7cK9jng1I/pvaqfvfNjG+c+Jlm6
         09/vv4XjZtDB+2OBy6nNaWUZoMVcVTMTyK/bex35Sk8ATc0doQDj7H5pCe/C1yS/tvg/
         WZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514663; x=1690106663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=eGWFojHHwTEZZxcRGvoWdkDqYQwFZ11mbJ1fFPqeQLy4YEiobf3QF58yWs5Kon28b8
         07+lzAqYGPtc+rJV/w32SE1D7MBZIzClLaw11eB2U7p0yev1C/oSdX5PFolXUXaotupE
         d678wolGIN8E+8FM9j8TUQTIqZMbXOaoAfP3aV+ZbZVkfh14FibrCZqNABvulAeFDoK1
         ijzb+NcTx2N0IFw9UGsLnFwoeCInMXUdBQeJKYPzcjFuEi3mtaeWp5c4S7jF+HzlGVtX
         Xcg62DGejsYWk0Cnm/qS95TqoZnkMEoA1hR/Rjuf8ZaJAr17iWBMq2k2HC9TKSffVarv
         xQSA==
X-Gm-Message-State: AC+VfDxsnrw1DQkt42jXxjSJJ40qMEhMBacyD/4l6yLqvoEbe24ITAXN
        /H8IGEdLHojSX9jtL9fl79yYBQ==
X-Google-Smtp-Source: ACHHUZ4BlcG23HC/pK8EJxlXEJOy4hJWAWELm8KN8y0FLwbTfwQ/yreCzwvqxmKh8BtYzNpWMvINCQ==
X-Received: by 2002:adf:e6d2:0:b0:311:1d4a:33e6 with SMTP id y18-20020adfe6d2000000b003111d4a33e6mr18600252wrm.48.1687514663606;
        Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
Date:   Fri, 23 Jun 2023 12:04:08 +0200
Message-Id: <20230623100417.93592-3-brgl@bgdev.pl>
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

Shrink the code in dwmac-generic by using the new stmmac_pltfr_init()
helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index ef1023930fd0..b7fc79864e8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -47,11 +47,9 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 	}
 
 	/* Custom initialisation (if needed) */
-	if (plat_dat->init) {
-		ret = plat_dat->init(pdev, plat_dat->bsp_priv);
-		if (ret)
-			goto err_remove_config_dt;
-	}
+	ret = stmmac_pltfr_init(pdev, plat_dat);
+	if (ret)
+		goto err_remove_config_dt;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.39.2

