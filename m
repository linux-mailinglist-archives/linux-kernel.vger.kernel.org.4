Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52F5E7F72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiIWQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiIWQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:16:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDF135047
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k10so1065742lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Fxkwow1Xm3fK1Et6nbVH+mRVG5q33XL6HKbPhtZeFeU=;
        b=zVQQekk/Mlp72KLlSivea4gGYJ3+w8T0iZz9rqlmj1KrQoqhrt5CMvAKI+3nytIvf1
         b6PHZ7jbhUZWnZHnLm8zYMZo7jScJv5N+k1SIAWM4gUduDVyapl0IpqVTcguifIgJDyu
         2WxK1oNB9kTTAqUPljJvjjZK0l6emoxCpd59vCKRxMlMHSVkrMCHYXKsH674AwvVNO6A
         1STnB9IJIh47ZHxyS1Z6vXe2NNamlMgvzv4H4S41vzaX8nuVPBnHm0IyaH6yFTOqpTZU
         hfPqIbix3VMl/R8F7Ynh79ME2INbUWU15CBagKknzqbz7JtGDF0+qxSLQJ7GKfMHuzfP
         5RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fxkwow1Xm3fK1Et6nbVH+mRVG5q33XL6HKbPhtZeFeU=;
        b=4EIZvQOblDEdkWD6YqoEBi084qmwadc+eBU7byMIQ4wIs9Klg+xO5UTZJAH3fXdPcI
         gcZiSeLOcv5/JGm3raKKfrwcd/swUB8OP6BDsnSfcpxoDXTJZR78RyKAxIICZNrEHxln
         MQaxhpa8DKCVCMu1hUPmsPvlUmkkV3mtVKY2Eauvktgw4mnMg+TLdDZJ6P7PSnz8shyB
         q0ZDlN71KrC1ph3TjV9lHHp+7tbQKzAkCojT+Y/pqgLFQrGpqiMTqZH42XOrHzpfaRxK
         AN1WqKzM/EoFYHdLuAYXeAaGuuf0QVzgWnyBsoInULjo2iU4xdfjuBoJ8BgwLtYtih3w
         prlQ==
X-Gm-Message-State: ACrzQf19lg9YLZdWYGVKvOI1mTZP0sfDbHcNdBiES4SAPiiwHWd4mTNc
        JSh0eOYFaGX2BblhzFC3XyTECQ==
X-Google-Smtp-Source: AMsMyM7DOObn6h8MdzBToiTAMWV4GmPp6zELz5cw/q+cXHcV8zqF8A6H+UUYK65xFZ/CBSUZ2fa2/g==
X-Received: by 2002:a05:6512:10ce:b0:49e:ad1f:3d7 with SMTP id k14-20020a05651210ce00b0049ead1f03d7mr3327874lfg.609.1663949772788;
        Fri, 23 Sep 2022 09:16:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25cc9000000b00492f45cbbfcsm1493491lfq.302.2022.09.23.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:16:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/11] arm64: dts: qcom: msm8996: drop unused slimbus dmas
Date:   Fri, 23 Sep 2022 18:14:48 +0200
Message-Id: <20220923161453.469179-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
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

Bindings document only two DMA channels.  Linux driver also does not use
remaining rx2/tx2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2c5908d104f7..8b31f4655cb8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3313,9 +3313,8 @@ slim_msm: slim@91c0000 {
 			compatible = "qcom,slim-ngd-v1.5.0";
 			reg = <0x091c0000 0x2C000>;
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&slimbam 3>, <&slimbam 4>,
-				<&slimbam 5>, <&slimbam 6>;
-			dma-names = "rx", "tx", "tx2", "rx2";
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ngd@1 {
-- 
2.34.1

