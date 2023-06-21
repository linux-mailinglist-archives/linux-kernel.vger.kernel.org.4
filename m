Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957677385CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFUNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjFUNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:55:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD3199E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:55:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so8464205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687355744; x=1689947744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGiINbu7foWgaD89gaNM9RV3a9vEUoSjU+97idyE2Co=;
        b=G5MLNwrMO/ygECl2UrKnTU4hYZAPfCguFUUBoqVRG3tRN7Vb04To5n0wDzGBF6f9uu
         SrAyU1MPLRIzDsEAZZzVc3u9m29IKIkNND81q1leCLtwqeXIqNaoqKGegINEEVVhbawA
         lExWWKmCn1a/dyqWCjd/GKB31g6qHiPLXntc6CxZGa0j3MtIG9oO/SDZMLwTiUdNZw9w
         mEuKhbpeXSqFRWSbmSWMxJ2wNF63e7yMjAtS8xw4UircxJRfc2yFhtDsx9nR76005mya
         rFBm0l+tgvZwCeuNJklbDwxyzx8/AjGTKlDRwZY325eNt4a324SQDVm8GJNdTefEaaAw
         eoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355744; x=1689947744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGiINbu7foWgaD89gaNM9RV3a9vEUoSjU+97idyE2Co=;
        b=eKbu/0a648+oA7zlDTQSMhD0v0jKJ/WLN3f0QTDtiFeh0FonADLfg1dnNOwEeb7hDd
         WMvv29oYMMd1y+Us3reE/fKGCzE+QjUNy7Nxz+bgggRih6u5kEjohBXKN/79GslASAED
         G2NRC5A+O++TDxr3JHlx4y14LNZlqdeaydHZzCiWiqqmDi5BGKCvhaapABDXPECBMEwH
         IwKZj3DVWedCoZtsPvpC3Ekaq4v9VTgAxMSW7U86KpLT13kRaCrDf6+f45kcdcLQQ3ki
         akRBLME5/4qr0EV7Ez4NE8EKpeBSrWE1wDm+4D5T8OLvnQFGh1TMJlhcfPAEWJlKiwqz
         pKGg==
X-Gm-Message-State: AC+VfDx4B7Vs04EjXqVeBmwe3Ws+B5oj87g1joK3qLxCFWc4dTx+Zd0B
        slREXtGa1K3e16+1fQau2qqY1w==
X-Google-Smtp-Source: ACHHUZ6lpAkKw4lUE1mi/nl5WQy66Jmf4UjvJOEHqcX5UnW2U7zvUnOOSSgljBc/dyx9VV5dVySgcw==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id 6-20020a05600c22c600b003f9b244c294mr8259781wmg.35.1687355744011;
        Wed, 21 Jun 2023 06:55:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003f17848673fsm5069294wma.27.2023.06.21.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:55:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net] net: stmmac: fix double serdes powerdown
Date:   Wed, 21 Jun 2023 15:55:37 +0200
Message-Id: <20230621135537.376649-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
stmmac_open/release") correctly added a call to the serdes_powerdown()
callback to stmmac_release() but did not remove the one from
stmmac_remove() which leads to a doubled call to serdes_powerdown().

This can lead to all kinds of problems: in the case of the qcom ethqos
driver, it caused an unbalanced regulator disable splat.

Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 10e8a5606ba6..4727f7be4f86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7461,12 +7461,6 @@ void stmmac_dvr_remove(struct device *dev)
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
-	/* Serdes power down needs to happen after VLAN filter
-	 * is deleted that is triggered by unregister_netdev().
-	 */
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
-
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
 #endif
-- 
2.39.2

