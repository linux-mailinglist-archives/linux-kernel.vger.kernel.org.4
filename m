Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB37389A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjFUPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjFUPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74D2105
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so7544475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361826; x=1689953826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=zAnRcyEUDD5wtE0JhsBJCTGSOI9JVuvZGa/odSLqFHGsQXN85gQbvlTZBX+am6cdI+
         wCvXHD639o04po8/nN9twgtY0tb8Ta1S3yBXDl7G0Fd9XQKAb1wC9qdjPaWIBd5mOT48
         7zeagteknLjoF5nSF0V7R/AtC20zPvspcgJBBYFLMPkitQz6gJSXwUKaWBwX5jxjEOHy
         JOpbdPE6txob69F4MW2cyB9+zk0UbktknOZ49yzYBKDghJy0OqxuCH4OAwiGOYqiNK5A
         L8qJa5APnKWbZKMZxsy51rLkI/usP+ajNckWWYum2ZWXFca8SHEIjTp4o0UIVhnnXfW3
         mt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361826; x=1689953826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=KGQQ52bfsCUTLIy5AONqfVG56qR778GGjxk0W3Fpr7fHpLHShBVLKmL5PYuNDHL9qo
         ph2w/P4CGpRBrjFIavsaoTbIJFkChd+l6GLEBOLHt70NJuCoGWwx4Z3NH1IgkAkF3Y7Z
         u3fUXHIA0EiX0ZVPQY7GVDbFoWINdJFHIMrgk/1xC9zicTTQUWfv9meSL3870pQmnxv5
         A+d8N3JDJJIdejNlNnIHJGe3hHZVaDBo/+STybenXDubgqG1RskDoebVZN4WaWtJKRnZ
         kQrLy5I3tYq1Jq30ct6iu7Xf+hZBRtiERLsvu8/zuflUoJwf0v92wmdE1QVsskw+f1j3
         Q/kg==
X-Gm-Message-State: AC+VfDykFWQpvTpGxC9uoG6uq7YNIFIUworid1AW49u3MRFKkgrZxCOA
        YIw4gSR/WWkN8XSregeqJQSMPg==
X-Google-Smtp-Source: ACHHUZ7xPJZ1J9M1CQ6hghcx/4kh4qmQUTaDMOedqzbwk1iUrz91I0UBgHrzOTPLQtNdytzHq/JnJg==
X-Received: by 2002:a7b:c391:0:b0:3f9:b3f5:b8f with SMTP id s17-20020a7bc391000000b003f9b3f50b8fmr5845974wmj.34.1687361826051;
        Wed, 21 Jun 2023 08:37:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:05 -0700 (PDT)
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
Subject: [PATCH net-next 04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
Date:   Wed, 21 Jun 2023 17:36:43 +0200
Message-Id: <20230621153650.440350-5-brgl@bgdev.pl>
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

Shrink the code in dwmac-generic by using the new stmmac_pltfr_exit()
helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index b7fc79864e8c..dabf05601221 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -58,8 +58,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 	return 0;
 
 err_exit:
-	if (plat_dat->exit)
-		plat_dat->exit(pdev, plat_dat->bsp_priv);
+	stmmac_pltfr_exit(pdev, plat_dat);
 err_remove_config_dt:
 	if (pdev->dev.of_node)
 		stmmac_remove_config_dt(pdev, plat_dat);
-- 
2.39.2

