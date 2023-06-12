Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4672BC90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjFLJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjFLJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39912717
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so29316175e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561882; x=1689153882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNG+hKxvwpveqfTw49rcUFiC9HYNGdqxVXCMwf/CgoQ=;
        b=Sjg97FxEsWi1+NhQKvwlVEh51XvKpb7L8qjO3eSPmnCp+RHYjPs6m0g4elcX7e4Gmk
         q3U1vLjkmrqHZnROyBs/n7xJkk00XMII9dTC69A/BMsdgUAKh6CQ1iVENWho3ieFJxOn
         kpyrUeEyJN+JmDe79C2O+6cXxwvHb2t7vltcUEEX9l5t3wSl7DONd9L87ujMUkqnmc3f
         QLazLkrv1GDOV/9vOl0n3uQDl7CvHNk+dcol5Iwbbh8SCOOuXpQsG0n4CHEkKYj0lKtl
         KjhlWUbdcnrDvJneJ/NH/roITps7vNV+XakPuvBg42ntql0DPxtDl5zempMyWZOl9HON
         Bzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561882; x=1689153882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNG+hKxvwpveqfTw49rcUFiC9HYNGdqxVXCMwf/CgoQ=;
        b=JXb51bHR0SUFE5qKOkmDl1YxDCEr7G/IwzVWlTx2nD7IR6kmDPPbBdVweYgtQCik7v
         DRccZYDPDtH14JILNIa3Ed2Rz7N+ZjTfpxVy9dwmV5w15Oj9sFQcUQlq+qQ/nCdkYL0Q
         PtQmMBZuBSweJ2gO5Arpf3eZJbNmiMYyJgDmneoattREHalG5MSQlZ0Vl/KSt0Yv3xbe
         3v2sx0lJCkJRQLtkqXp5UNGul0fc4zQj0/MZOJnqBmEbNzQvKWMAkoPH3a+6XedEW5kB
         KVx1p0AsG3EjjES7OlLb7b5LoJpTlRx/wEyjMpjY4Af2p/P5Ocai94RxeCW+fNk5PT2t
         sfXg==
X-Gm-Message-State: AC+VfDwo6HEIwX8j7BDLPZ9Op/SYLiYxjKFbSnRIg2REzipWnfoL+ASO
        lO/8mjMC5jbBc8y7KvQ1TF+Xyw==
X-Google-Smtp-Source: ACHHUZ7VSDx8D3GXZ4VcJcb/TSs+3b96OTltaJznbz319l8jyj/BU/MtAxrNF5k8MF/YomUni4Onnw==
X-Received: by 2002:a1c:4c0c:0:b0:3f7:3699:c294 with SMTP id z12-20020a1c4c0c000000b003f73699c294mr5458505wmf.29.1686561882035;
        Mon, 12 Jun 2023 02:24:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:41 -0700 (PDT)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 11/26] net: stmmac: dwmac-qcom-ethqos: remove stray space
Date:   Mon, 12 Jun 2023 11:23:40 +0200
Message-Id: <20230612092355.87937-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
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

There's an unnecessary space in the rgmii_updatel() function, remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 5b56abacbf6b..8ed05f29fe8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -117,7 +117,7 @@ static void rgmii_updatel(struct qcom_ethqos *ethqos,
 {
 	unsigned int temp;
 
-	temp =  rgmii_readl(ethqos, offset);
+	temp = rgmii_readl(ethqos, offset);
 	temp = (temp & ~(mask)) | val;
 	rgmii_writel(ethqos, temp, offset);
 }
-- 
2.39.2

