Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A966C52D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCVRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjCVRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:42:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803062FD0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:42:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so76205093edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679506920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1F9tu8q22e7TPnIRSmkbbzCKgmYN1GLyyizNdJqECI=;
        b=zJajpTjdREnHXh9vs0CbZDswvMUQD7ivzc3S8soQ4nyzHHuDE0axg/BL1oOOenv7tV
         6/+7IG8b2S+wMVtkxQQUgj9A287ef71c6WI4MwoYieROe+O3QR2bUA8lPXxCpgFsfQtR
         XfGQYC76KH7m9fh36L0iOfmRplLjckNBMA3wEhPUQLmTBglV8SjK289O1gMxQTCvWi8p
         4PGqBPKlyX1Eq42q66GgAwEyncevS1csnfQCctmcRlwWRftrq8H61mD3NCjhZyuasX7d
         Xx8nOcf71fUwyR8L2Fhu9+dy7329pQCoIho/CNZUCUoiuGEDijh07bhh6jZz1MDiHwRX
         qdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1F9tu8q22e7TPnIRSmkbbzCKgmYN1GLyyizNdJqECI=;
        b=CNnPUYHB3bxbEhjSXmY6c8ikYI+6jm6htt5MviujR1eJngasEUI+Kcuht4XiWwHkid
         fbpEbv1oEJKwKZEjN1TTuC3p2MX0SA6w6FW69XrRHSP0UhEufaedRHZxe9gpkTW9HuV8
         NAWGING/bhbzkf4IdwaSLG00L7KvdccXdpPiB/sRlu7Svlhu0VW97say99s/vg1jq7EK
         oxICM3Fh56/Y5+HefTXty+OvL902WHp91YY0KJTzbIxBXwGgbQALKgnXyOeE89NreCCo
         STtCyecRsfwk0id16U4jibPd2x9p0hiO4uAMZkcRBuFEax2vZ3hyiaR5umfoVnzvX3xL
         BYLw==
X-Gm-Message-State: AO0yUKVACad2TY0FE8tOeNq4lbK35ml70JJOsBb13nQiKMoLOm7LMMDL
        CLuHOCdHwtjZrWD/BKxnWVgt5g==
X-Google-Smtp-Source: AK7set8VXQimrOYdIiyXOSbM18UdoWnfkrSBtKU48D3lu3nHUA1mzq5g+P0hdIyw3okkkc6yr+3O9g==
X-Received: by 2002:a17:906:2711:b0:92f:13b9:d498 with SMTP id z17-20020a170906271100b0092f13b9d498mr7500638ejc.36.1679506920227;
        Wed, 22 Mar 2023 10:42:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm7548088ejc.29.2023.03.22.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:41:59 -0700 (PDT)
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
Subject: [PATCH v3 08/11] arm64: dts: qcom: sm6125: add compatible fallback to mailbox
Date:   Wed, 22 Mar 2023 18:41:45 +0100
Message-Id: <20230322174148.810938-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6125 mailbox is compatible with MSM8994.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 65033227718a..225c03f4e669 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1211,7 +1211,8 @@ apps_smmu: iommu@c600000 {
 		};
 
 		apcs_glb: mailbox@f111000 {
-			compatible = "qcom,sm6125-apcs-hmss-global";
+			compatible = "qcom,sm6125-apcs-hmss-global",
+				     "qcom,msm8994-apcs-kpss-global";
 			reg = <0x0f111000 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

