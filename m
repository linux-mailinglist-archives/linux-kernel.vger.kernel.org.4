Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF47389A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjFUPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjFUPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C131FD4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f901f87195so39703715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361823; x=1689953823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=dkyDfYiIBxOJV2hxR/4c8Uta3MSZJK6qmT57b/J+17eBqI0hCGQ4XExaV4F7mYh4be
         VgT3ePn99e8bol/sXnx1xvaO+w76lIn+/zPxUZDiMYIOPqYTFeXmZfLsWUl39mCAqHVm
         HmyVVnGIWuw9CPtJxjxzHypnrORSkLN6pecDdYnUN5jV4DzRvqFQ+pZ6CnSJD5xIYOKa
         B2ovTwgnrU+dxC4JIU+t0UGPXJiIBbiAJrMXERMaiJ65jYeyaF0Jjc2Ovwlz89sqjlUT
         c2h5du2jStF+P4xOeLkev3lON5iHC9iTT22u8lbT6RBnHQbRkWakb1/EofidM1kHhnNO
         VpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361823; x=1689953823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=GtU7RWZ7TkJSgJtwjwRK5hQMSZECyjMTRnEZV8hs9eT0kB0XzujyArg0TauPolhCrd
         MCOILj7Dm3YRgEa24Ulqums4B2V2UDgLEFJwy6hkyCF4yc1gvgXwRI4KwcG0NJVFW68A
         NrdTIjA/Q7HS+1r/w9c9H0y0JJxmOharwSnTQ50b4qLx4tuombuWBhxxjxEseexd+nCv
         uVrBTn+s/0i1bIfX6bBeIleASSAuAl6czqQKohcBCeQGRLnLrboZCckokylmdivFJZDO
         rgZCMEwUm6rq4eK1dU9jnNVih+zdcRK+BcS/MYCzrPIDJ68hLQG3n+zLU/JswKOM5Rro
         H2OQ==
X-Gm-Message-State: AC+VfDyMrrDf+xorpQJZ3n9gUCd9azjPUmqbhZdeDbUS7UibSXv/8QEf
        77hxLxIiuPDPPvJzm77vSe0DIQ==
X-Google-Smtp-Source: ACHHUZ6ZDp52UApJ3piW/H11lxFyTw3oeRrK9CSYjqYjy6prgfBnCMfLOO2kaY9rWqwnOQ/4eCyV9w==
X-Received: by 2002:a05:600c:21d8:b0:3f9:bc32:ca6c with SMTP id x24-20020a05600c21d800b003f9bc32ca6cmr2740533wmj.13.1687361823489;
        Wed, 21 Jun 2023 08:37:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:03 -0700 (PDT)
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
Subject: [PATCH net-next 02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
Date:   Wed, 21 Jun 2023 17:36:41 +0200
Message-Id: <20230621153650.440350-3-brgl@bgdev.pl>
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

