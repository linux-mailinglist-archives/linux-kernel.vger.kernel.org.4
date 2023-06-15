Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C373187B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbjFOMPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbjFOMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B5C1BF3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fa23e106bso4894149f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831278; x=1689423278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjSnZtkEy2IHx9Z27pUOaut+Sqq7rTJg4leWlg3+sMA=;
        b=S3YuiYt1Tfk1dMOaH73iWIfI+zw24VugLD4OFmltkoaIXxDVTBcvacK+BkGHrwwN6Z
         2JMuXzxGkeeUEoPJPvhP70KHvqVEqbzdzllismuE9aPXdAi+uNMU6zgfWH0QO2jEBh3M
         RMrkkrENIQC2TmFX6lzDLWiEF8bBfBq4Vr9EmnicHbRBMTA9o/Z3c8KFge9yqtuOqDiQ
         2MEv9U1UPJjtW9Up6YxgNPaDMRvzdwyTmhc2FthAUIazjeo9kO3e9vlAkRvpYdHv2w6C
         64TCDxbbHVcmQoWAaMnM5riagf25/qYKMqPXI9Oq0yCczWQfGQ5ABk47bK3S2oppIbbm
         rrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831278; x=1689423278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjSnZtkEy2IHx9Z27pUOaut+Sqq7rTJg4leWlg3+sMA=;
        b=GFEthxL4TqnBLog9BxB9evdH7kuVcKHlRDoGiWAXDpmBP8AA8z+7vp7OIbeF42PG/h
         pLCA/733hx1lMbDv1kzw5IFXKF4N6m3jOrQ/dcAMOAcaAbd1XMOzMltnKCfGQhpus52h
         6TWLRt2jrCEzQy7vJ9wEsMtnyE916I266yNJLmOKYMBneevnyt/9A6AMN+jdHX+5ikqS
         q1ECN7/rp1mVN0swk/L74qX9VNhloARaLYYn3JnyDIEM8tmLgk476ueLLguLPNEVuRfi
         TolfY/b5m742BusBxGPqKg6yZmRNDt1AV+InMOAw9uBapTMpc3h9k+CtLjLVSO5tqmRD
         svcw==
X-Gm-Message-State: AC+VfDwGto/xCerAIJDJDhVUXjE5BQbaBSyXP9Ich310TqpQ6GjJmti5
        +m2wA1mw5sGh0RVqtjj+ide3jg==
X-Google-Smtp-Source: ACHHUZ64Ssgd1dkMFf7XZYJAcYYDG+P3e8rnIbYJ4voDDjcbv3TWkFYEyv+berE0V8xHHIdSkZYuAw==
X-Received: by 2002:adf:e60b:0:b0:30f:c805:5f07 with SMTP id p11-20020adfe60b000000b0030fc8055f07mr6772956wrm.17.1686831278035;
        Thu, 15 Jun 2023 05:14:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:37 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/23] arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
Date:   Thu, 15 Jun 2023 14:14:00 +0200
Message-Id: <20230615121419.175862-5-brgl@bgdev.pl>
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

Enable the SGMII/SerDes PHY driver. This module is required to enable
ethernet on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d850be05835..f62c96fd4335 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1367,6 +1367,7 @@ CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
 CONFIG_PHY_QCOM_USB_SS=m
+CONFIG_PHY_QCOM_SGMII_ETH=m
 CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.39.2

