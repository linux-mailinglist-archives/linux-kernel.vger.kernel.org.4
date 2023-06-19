Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDC734FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFSJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFSJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37B18D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f769c37d26so4012097e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166656; x=1689758656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbBN5UFZLskttS3+DKY7OChoCqIyyvgczJBfknfqHmY=;
        b=IgJbKu3j5ZSezHMCdBUh//m5BjaQnLUFHhTknW4VBcn4lAblpPaHRZ1Fg8mgLyOnwn
         B+CUjCvyLvpZTDweOBWlV32HEMP4jI1kCm9h7YK3xegxh0EEACGXSVwNff1llgRxdbrO
         DXmjRfKbyzieziwyN+VOYogRFr1BFhc7IXDOvjFOMNWalXxL5tdQxfLlQc6VN1zWe85h
         zUwDsXJqzGRXIv+fzm2VK6cnQ1rwqwfZ3VUJGKX6h356mJJK9Z/gt1Nev934IASlL243
         +fI1CPxpdHmWdipONXkkVWGAGnIDLLbPts0scgNsx2l/mmywhnkmXNKXxF33lllu0wZw
         ul5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166656; x=1689758656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbBN5UFZLskttS3+DKY7OChoCqIyyvgczJBfknfqHmY=;
        b=TkU4dRttBeHDx28CVsF3Py+blQZqGs3ts2BzU6Mghi0hKh3zabaC9jvTFq+p+CaeYF
         WCHAze7KKu7Jg8W3rICnLPn2+ItCDk5GVGArpEvCIfuWW1UjTOlRLVapXCrwUjBpwR5u
         jqdT0EOZTVpAG9skVuekfvSZ5HPTDocPO6KNHvib7q4WUQESdQ7a7UAgxgCFVyGj0Oyn
         EVAN1q8NGhnqwqeiuB4k6TeLWmycNeUmMan3Eu+bXKohsdxtasdKwwUL+LOEkXBmOhtC
         hl1S5OdJyxQYyQLT9PlCPYiCNGKUVU4IlWXawpAuBwJwM7ynT8BGcoUewBxr2Cfp13BU
         OpMw==
X-Gm-Message-State: AC+VfDx5qDgdh9MvOz/GVzwY3gMIGIQ4M5n6/jXxMTf3wu8p4XR4voSN
        YeyT6UpCcAnrZgeg+hwlE0rftQ==
X-Google-Smtp-Source: ACHHUZ7a6sBSYCvvGZ0rLeDvJ+aAMJ8hN0pO8v2WRQzU9PMkjFcqPr5PjOXONwRoBWWY5Umkpk3jBg==
X-Received: by 2002:a19:5e16:0:b0:4f4:b28d:73eb with SMTP id s22-20020a195e16000000b004f4b28d73ebmr4567389lfb.12.1687166655767;
        Mon, 19 Jun 2023 02:24:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:15 -0700 (PDT)
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
Subject: [RESEND PATCH v2 03/14] net: stmmac: dwmac-qcom-ethqos: tweak the order of local variables
Date:   Mon, 19 Jun 2023 11:23:51 +0200
Message-Id: <20230619092402.195578-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619092402.195578-1-brgl@bgdev.pl>
References: <20230619092402.195578-1-brgl@bgdev.pl>
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

Make sure we follow the reverse-xmas tree convention.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 16e856861558..28d2514a8795 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -594,9 +594,9 @@ static void ethqos_clks_disable(void *data)
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
-	const struct ethqos_emac_driver_data *data;
 	struct qcom_ethqos *ethqos;
 	int ret;
 
-- 
2.39.2

