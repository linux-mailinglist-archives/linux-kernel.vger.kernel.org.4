Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40623731893
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbjFOMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344783AbjFOMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3018294A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3110a5f2832so539289f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831288; x=1689423288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMgaAHe76eIn3F9IB6JgFSErZkAha9wqjAecsB/W5Vk=;
        b=v/JROUtIn1Fn9P10DPijytJUNeMgvE979wcEBNHrOGUdG6qtCKQ7nd6DTn78TsgPK9
         oUGOJElAik/a1BznjNO6USDB/u5nHsu/PStgHyApHHv40RgcfIHdXONrGyB4WGs3N9q2
         P63IyhbcJA1JqCZcROq+tanvqlpIehMj3UQRBQ+UlGU+jlpNfEMVUEz0MEtBoShEy4ZU
         AQ/i+SxJff++kZZD7Sf5WR8dfphK1E/o4XQNiVfem4vMTW3A/Bom43nQ69X1BXRfPwkq
         wfno0VaUOkbOKuWBS3EM/692Ilu/HgF+kCT3+x3uTUUE5d1uhem6sSeoZ6PbKoMXoxD3
         UQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831288; x=1689423288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMgaAHe76eIn3F9IB6JgFSErZkAha9wqjAecsB/W5Vk=;
        b=XVo7Y6GXTPPJFlKkeWVTpQADdtsqD/4ptsMwwSYPTU0B6IxHld8CXVeRqSDaJBDVHt
         6+t1QYh5s4a9hPQ+NvTN9ArUDqilvThNXeTMtKF+AaWQIdOhm7Lf584up4qczb9lYTAn
         tB1Q2/yGdKEyDOKgdEoCXJWRgCPhssAAvNbxMPFJqQchdwCR7XJjLy2FLRaR1HeztEEA
         QGYXk18tCY+KEs3Gp00CKWH+/UwgAfD+hGNLBff6xY8Bnfboop2JECOhpjW0GJF2wwa1
         7zn/9t8nYofzr0bi/Kc8oyKs+s/EHKfoNAIeAP26U38TimofwSdSNF80WZGymDlYqTjL
         bWwg==
X-Gm-Message-State: AC+VfDxtVZ/koQEZSx5dNBeJayrcVzratKZ7JmaySXFywovDartL8ViN
        ocPM89vJ8q9zzNdc9BF0KuQ44g==
X-Google-Smtp-Source: ACHHUZ7hpsGhA1APGWhKHqXJARHR7T/asvTIBCcezaYjJwRDKg1LmwDvqWkfZ7PEzsLAv9Oam4DVuQ==
X-Received: by 2002:a5d:6a88:0:b0:307:f75:f581 with SMTP id s8-20020a5d6a88000000b003070f75f581mr3870500wru.18.1686831288107;
        Thu, 15 Jun 2023 05:14:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:47 -0700 (PDT)
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
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 11/23] net: stmmac: dwmac-qcom-ethqos: remove stray space
Date:   Thu, 15 Jun 2023 14:14:07 +0200
Message-Id: <20230615121419.175862-12-brgl@bgdev.pl>
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

There's an unnecessary space in the rgmii_updatel() function, remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e3a9b785334d..ec3bbd199501 100644
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

