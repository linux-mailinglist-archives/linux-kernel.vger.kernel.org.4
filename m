Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FE6B8CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCNILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCNILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:11:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B1984DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so58343252edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1F9tu8q22e7TPnIRSmkbbzCKgmYN1GLyyizNdJqECI=;
        b=f2Eu63kaeQTRqeKNr+qOrOnkdgvaXs31dPYph5rXRTMv7MzDsdGetwEJQcv/Kaf11Z
         JbRLBfoYCCjqxx9ni8T1Lce798ZyHgOL1PIct2vGYmJWFr1DB1oBaujPd2gySKnibL3B
         BFPagEMgf5bMjaMCqnTMAiQU6+/BQSis8iDhqG1xEzes2V8h7ZVzwUKmC9ZfLo1ZGCCv
         nDdvlkFfHD30ldbA9BxkHfgIZ3FsFLjXsxJ1njXlLBu3CubELjhunv7pPGrlyu5dEE0x
         2U2k1Sxu86ARKi5/RO1kbcmYg9y1rAcNUUBeD0K3ro/Xml9x4b6OdZ+VOZKk2BPOQWDg
         vnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1F9tu8q22e7TPnIRSmkbbzCKgmYN1GLyyizNdJqECI=;
        b=4mK+sguc8VRm4J1Ts5lO1uKGjdIG0yUXEFF9Whg/ABBEUPrZHukZHTy+pqqjj0E5aL
         JIPKIgpAI4rm7PxkUxGhu5gedhUY3SVp34FlidSpVqpXpWGgb0AXH8QZiSvP00g7yoiN
         l7QUAD/5VJkdPVhRJ0p8T0Z2Nf4DC9/9o2e9Kp2VhevQVdQDLo5EWShOLnO6283ihWJ+
         PihOLk1B6C9twTWOb0NBcLoOkHIJqDCE6CiMb6zpPKwA8CWofQStw5q6KHl2sipmRxyr
         R5blw5ryQzeRR6efy+VDeNnK+qEtYrddudrRQc3WoGZ+EyIIwVXqXbDgwf5+tEj7DVfr
         vD1A==
X-Gm-Message-State: AO0yUKXlFAvPg2AAuN2qp1Wh98HolR/jEpidjEpsuDwtQ411qbzvIT3U
        B4nmat4uRQmMtJpYcSRa43Ixpg==
X-Google-Smtp-Source: AK7set8iH2ppO0q2PrDDxIPXp9g3xP4JPLypCbgj5GShf9YEISBysI0K18ZHycE3J+/yRn8XMnA2yA==
X-Received: by 2002:a50:ed06:0:b0:4fb:6523:2b38 with SMTP id j6-20020a50ed06000000b004fb65232b38mr8199416eds.27.1678781368954;
        Tue, 14 Mar 2023 01:09:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/13] arm64: dts: qcom: sm6125: add compatible fallback to mailbox
Date:   Tue, 14 Mar 2023 09:09:14 +0100
Message-Id: <20230314080917.68246-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

