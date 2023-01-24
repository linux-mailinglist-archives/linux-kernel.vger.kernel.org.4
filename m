Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0167937D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjAXIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjAXIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:50:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855F3FF04
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:50:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12303725wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD52YgTCemzXDaGqkXika2VPrKf8oXYMlqk9+OcA3a0=;
        b=fb8siKApjjN82Y79a4FaMmlnBqfE9/H75opK/f+BiT+gO+kwA1oN1Lerem+/XP9TPa
         tB7wKiA5CIn0uyEmpEAIuu8P8up1wNzfdTmPP2QBpHwTPx4coDJLNG3iDwRj1U7VLJVZ
         e3PHLTW33hUx/ogizpxIWqL0vYQnkhIl1C75a0F3Ipb/3jz7CSUlZKSaMJU4Cr2pTXjM
         7QM37Vab/DuCIXj3miWb730VWkxQOlK5Kya8Hm/fMKg6D7G76BcInKWDAbbxr+tHVeHg
         skyc7chFX53yZZWQwKHZPRI5hg9LLmJw9fJ53IvinsQ7t6cMZoNQwpceeUmsGP/qvHP9
         ksiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD52YgTCemzXDaGqkXika2VPrKf8oXYMlqk9+OcA3a0=;
        b=P+oh7s6NS3jmml1D3MGTAxG1iK6/fWkbvPZ7K8NuLDM2aY4WslIDwOioTcNJhR8Csp
         /Ze0rfJxNr/68axRjmaiv90Y6KaPhXN1dcch6J4aPLu5KRmibRc0aXPUd8bszxlvXY3t
         9rjaZJOls4ed2zXUBVgn2AXLKmgD68nPWam2gWzMSvu9aJUy9Va+2AR/7MIFNCkQ07s8
         dhxMivtKcBa0sJQLZvE00RBNy9ybZLiFwSI9f0hK7Wq0q4D6UcHL/WakoeunVLv0itO5
         fF1YVNZmAYUDdL/p+emca8lBENANffAuF1MBz3qZUs6BHSyJtqgLUP8AH7HJJZmoCLHA
         B4UQ==
X-Gm-Message-State: AFqh2kp3oYu1bllW8MCW1riUQLtWGKWHY9eIMkmXwgQG6LK+wbQApA2P
        Zep9WsHglC/rNmk8QUEh/rZMqg==
X-Google-Smtp-Source: AMrXdXtz0Z3lKjCTtHVwHjLx/OF0OYLE6Qqbyu693AjZj7Epf9NcbIQvDwOTDl1IHJZQi5ByQDH1TA==
X-Received: by 2002:a05:600c:a29e:b0:3d9:ee01:ae5b with SMTP id hu30-20020a05600ca29e00b003d9ee01ae5bmr26905766wmb.12.1674550200082;
        Tue, 24 Jan 2023 00:50:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c431200b003dab40f9eafsm1340036wme.35.2023.01.24.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:49:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/4] arm64: dts: qcom: sm8450: drop incorrect cells from serial
Date:   Tue, 24 Jan 2023 09:49:50 +0100
Message-Id: <20230124084951.38195-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124084951.38195-1-krzysztof.kozlowski@linaro.org>
References: <20230124084951.38195-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial/UART device node does not have children with unit addresses,
so address/size cells are not correct.

Fixes: f5837418479a ("arm64: dts: qcom: sm8450: add uart20 node")
Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v2:
1. Add tag
2. Correct typo in commit msg

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5ba65780166e..873bc9c412f2 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1007,8 +1007,6 @@ uart20: serial@894000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart20_default>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -1401,8 +1399,6 @@ uart7: serial@99c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

