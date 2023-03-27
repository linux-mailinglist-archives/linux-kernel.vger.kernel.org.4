Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABE6CA743
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjC0ORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjC0OQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:16:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2A49EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so36805065ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OUr3ek7eyRlv1LZDnFEQKf+EnBNrg4hiiPgZCQTep0=;
        b=MB4n3cSdQQ5K+mXJDqM/x8XmRm8dD95zP+nHF7wpJ6o05fae4xLkIFkJMk8lv5dax9
         DzL7RW8UXve8DqcKojY5q0ZJE2DdPTaG0XOGj/Ww2KgsgESqIectuh8IRZdJI1Pm240s
         +PIv/eg2yXOVHWl45sefRi30z9NC12Rpz9fIK03ryJqbcxCeoqPbDrC8YzpI3NoncwKA
         c1pc6F6CRyxTHG0FgQav+vxPuL7cDT2w7i2Vp2u5Va6qGrvwnlGm4RGWKpSdYw2d4ROT
         xeBztrXooB0ZuSdkg1JqzEJGo8eXShndMf7LY23CeDY5bS67MIxqT2a8UOjNuLzR8mbq
         UbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OUr3ek7eyRlv1LZDnFEQKf+EnBNrg4hiiPgZCQTep0=;
        b=zruALApAkispCR0iL4PnOnWv1UGkw5RxrfVdkFv5hkBOyK8vNXrKjiIvxAx5Cy+1cA
         2DT4Sokvdv5ko67oyq/nzm5gdhvDQgaRXTRkccRQghHDBELiOQdgdX7Jp5ImSwbHO9HU
         SN1y7zdgigEpW5OhcEMm9cE+hJ8ghvu0TWI+XAvgZmrVhLW9SDewtCdU/Twur/bPuNsf
         hMGmupgMJGeOaW7YgPut1Pm+s3qmH5AhtIHWgTL8cwV2g8PcNvrYh8xI1iEqJO6ryrlt
         h24DkpCRsPbsM/Hr1xtL/K7+YORI8o/fK5lo/+Cug4awJlKqK2oPCGipLWH2Q7+crNZg
         Js7Q==
X-Gm-Message-State: AAQBX9e0wrjkNlfLv5P1VnZHOEegR1NT1CuisilH0kdAWh5c6n0vJhid
        9Q1lt//F0gBOxQAp5QBaRdTORw==
X-Google-Smtp-Source: AKy350alMd1q+R1RdunDNEoilFSbZ6aX+GFNX26H0tNImhtvNm6bqJvEu0jxKgyhIXdshzciQ5fIFA==
X-Received: by 2002:a17:907:7718:b0:93d:c57f:b8b4 with SMTP id kw24-20020a170907771800b0093dc57fb8b4mr11881834ejc.26.1679926473395;
        Mon, 27 Mar 2023 07:14:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm11273339ejb.198.2023.03.27.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:14:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/5] arm64: dts: qcom: sm8150: add compatible fallback to mailbox
Date:   Mon, 27 Mar 2023 16:07:52 +0200
Message-Id: <20230327140752.163009-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8150 mailbox is compatible with SDM845.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 9491be4a6bf0..05c1f352f115 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4128,7 +4128,8 @@ intc: interrupt-controller@17a00000 {
 		};
 
 		apss_shared: mailbox@17c00000 {
-			compatible = "qcom,sm8150-apss-shared";
+			compatible = "qcom,sm8150-apss-shared",
+				     "qcom,sdm845-apss-shared";
 			reg = <0x0 0x17c00000 0x0 0x1000>;
 			#mbox-cells = <1>;
 		};
-- 
2.34.1

