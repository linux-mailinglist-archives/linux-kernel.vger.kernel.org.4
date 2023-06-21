Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8877389A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjFUPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjFUPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5AE6C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f87592ecaeso4665270e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361828; x=1689953828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=CSv88/ZWPsCkujCLeQvR5zV6QJ197upQiupFOf7hhQJLU4holZQmyEM8afOeiopPJI
         rxkkXknIdFBsXaGs9e5eQl8cmqwLLSitBBUYN4EkfgWs1N3I08bYlFaMCcxWlpL00o5R
         m+Z0PytTuM0BQ2VA1FUXHz93HaoWpBMXD7Xg1oI0Iex7kwBXSFxukS+BVYvPEM1Z+x/J
         1MMnplXM//mLc8MN0qTVv7Q3KJFsN8GnzobJyIhzjWXEbG/2zt6VldBu8G2I7bJGs2ei
         Te8uSE3lkY289Edv22F486sKBj0Hx/GJT7tkzQsTOMVS4qqtocy0eoZE2IXrcvMDnFyM
         oU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361828; x=1689953828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=RzF5212KV0+5gpC5Jl/buVLs3fA1bPNn7hGGPC0Dw6No3SbZoRdbdcfAwENkZtruNN
         pXCUmOdcs2LkY5PlpiGeUwj9ToMByGIcY8cCjVoZLPjyKiJPUyPG4nSP1Uofho4pKbpw
         p9HOq92bZN1o39vAiORFGvS5YZZnXGTExoVKQXRUYBvNpmsra42Su81v1zyH2wLrgDs2
         9FD4XfgPYbrufC0TAW6LQQxHhs33FFph8weXK8SCg7cKnNnKQcx2aAPRZmvCKyxAQWjV
         R5x/k88jRXVd0IhzAAqxsQyyDE3W3Yss2/Lv12iA9I3YTOpJdO1muBLSnZtCRRsdIApg
         0EYg==
X-Gm-Message-State: AC+VfDylMB5LF9R1GRMJfiwiuNhy1AJ9BS0P/W0dlEnP2CUtdeYKQ/+E
        0DzyGCkTIXytAM///ZhvJZ/KMg==
X-Google-Smtp-Source: ACHHUZ6zjgqtk9I7hnzpINsxw7Jk5ONzx9X2XtIX2vI7/3ICM1PCWSNZh/mAZPlvVnMabN82Dm8Q4g==
X-Received: by 2002:a05:6512:3b0a:b0:4f8:6fe9:3c9c with SMTP id f10-20020a0565123b0a00b004f86fe93c9cmr992970lfv.49.1687361828170;
        Wed, 21 Jun 2023 08:37:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:07 -0700 (PDT)
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
Subject: [PATCH net-next 06/11] net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
Date:   Wed, 21 Jun 2023 17:36:45 +0200
Message-Id: <20230621153650.440350-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621153650.440350-1-brgl@bgdev.pl>
References: <20230621153650.440350-1-brgl@bgdev.pl>
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

Shrink the code and remove labels by using the new stmmac_pltfr_probe()
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index dabf05601221..20fc455b3337 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -46,19 +46,12 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		plat_dat->unicast_filter_entries = 1;
 	}
 
-	/* Custom initialisation (if needed) */
-	ret = stmmac_pltfr_init(pdev, plat_dat);
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 	if (ret)
 		goto err_remove_config_dt;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_exit;
-
 	return 0;
 
-err_exit:
-	stmmac_pltfr_exit(pdev, plat_dat);
 err_remove_config_dt:
 	if (pdev->dev.of_node)
 		stmmac_remove_config_dt(pdev, plat_dat);
-- 
2.39.2

