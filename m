Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D77389B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjFUPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjFUPhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066219AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9b627c1b8so26695145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361834; x=1689953834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=ytqBTHWqr0O6rcQRNtmKsh6dLK9ftebsw4tdZY0QALt/SZisDjORIlR8rIG6/uV3md
         Fi9A4HVDkOyoWSMA7Mz7056cAx44DmV7cxp+RvXiGtXEmoT53ssbK/UINJgMzKIxvjiX
         i6NQ8irc3evTR/v0RNBj96Z3U0BLUfvP7hZoPoOFthjN4cKd5kn+4dQvMOLTziRTaxA5
         C4MjpzPVOkOSoxgU8IRrMXT42kvmzDvulnhca8o+5D8Rm/UVKjTQQPM0hbKnRFubb8MC
         GcihCfDkvFZHTukagIqhhPGdtFVti8r8T6ObiUbjglX8KjcFlCqOoEerd/t0KuX9ecDg
         G5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361834; x=1689953834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=IrrO+gVaJ5f8eCzbqc7AFgDN7itRRTCN+Vpw+NtQgMajJ5qKoYGdXkLacDRSQkUsXW
         x2N7x+3vgUk3vk8i/Uf9THQyx7JZosiwrtWhSFPqxzh6gKIIjBgn2dW5rYV2cF0j9xRG
         IkaP7w0gO9cxW4J56nE5u0tqgO4495/9mv+IL1mogtr8Qs/2mgRZJJGe/NjVpXEnp1L8
         ZKvjeP5UF9N7OfECPIf9ierra5lCF14qooTcUYJb+TqyaEcoOePqycxWdPeK1qvEG5wK
         odUL+4Dlczc0oFzgtnFPz1kQrBrkfQPDRz5k7Oy7wFXwLkN/WnnoFjPpRuyUCQsv2mOS
         RriQ==
X-Gm-Message-State: AC+VfDw5X1nca/whzW1y/p2QtbJrfh1g+hmmHeo7qGGIVkh+EmA00B+H
        E6iqrMfGQctzT31/vxzghvC7Uw==
X-Google-Smtp-Source: ACHHUZ6vWMgzwi5LD2ZvSmbyFHyTJXtLbN1jGnRVAYlkgSjDYwX4jrJvwJ0I7n0yZevtJM1G7OlRsA==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:b8df:26ae with SMTP id f9-20020a7bc8c9000000b003f9b8df26aemr3963143wml.34.1687361833803;
        Wed, 21 Jun 2023 08:37:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:13 -0700 (PDT)
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
Subject: [PATCH net-next 11/11] net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()
Date:   Wed, 21 Jun 2023 17:36:50 +0200
Message-Id: <20230621153650.440350-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621153650.440350-1-brgl@bgdev.pl>
References: <20230621153650.440350-1-brgl@bgdev.pl>
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

Use the devres variant of stmmac_pltfr_probe() and finally drop the
remove() callback entirely.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 7b9fbcb8d84d..e62940414e54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -787,7 +787,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
-	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
@@ -801,7 +801,6 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2

