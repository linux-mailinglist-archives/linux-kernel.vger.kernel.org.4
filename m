Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E26D7436
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjDEGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjDEGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:09:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D749D1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:09:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so138583265eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680674951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLrsSAJ8p3jd3K7x7AAjzxofO9BqZ7nJB4RjRK8lmg4=;
        b=pwqX0U0JisZoRXda7JlmZpXwhUkGSTtN4YMTTpBFaf5HsrCnUAK13TcTR/UvYVBpR4
         dRlYhNz9wzpzZYDeEP/Zx8SJWvOxPdUwQ2Nr6eZoWG/JnFrKocLQ3WHOA+6cqvvLHzBv
         72j/V4tCStq4GgkifdagmotKfvbiJc8p9F9DNkHSzAc7bJEe/qHqSa26xYzp7etgRBkG
         IwsPH4sN/7pYq0MbDCNLMtZnv3d7pq2k7bX/gRoZDGLzGGaOQnzhvD164rDYoN3APnZZ
         NUAVZgJoQH0Ah7kPrwQBz9g/Y9Qryv9ytoYj4rP7RG96S8bNpmRer5/jT8snsMdwpBDX
         ckRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680674951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLrsSAJ8p3jd3K7x7AAjzxofO9BqZ7nJB4RjRK8lmg4=;
        b=kRAPZ/iFO4pJ7k9M/cTJmr9G52UPjO3PUFg4NiqEEZJJgxmsv0OMw6xXpffwJlc+gi
         EnPrWJW0PTu8+B1484mdLc5jt2J+1IkWop2biH/+h1HAXL9KpTIRzBhfGz+vFuvmwiBA
         3WpipyiaB3D3y8pCF1AZd401a3Syzr00mWP9EcG41QmEbLirzKeTvI0TYBRQzH2/6q8c
         qwBZp7vpjmC3NZW/ubtb3F6TMP9cWYvFss5bNAZjB2w6QSkxSnLOQft5Vk8JLtwpBXj4
         uTVFjHvkKn2kFE7qf5TzCK1nkaq09CXagYBIjvXBHeh4MhIh1He45K9/GDaPCgLju6WE
         XXCQ==
X-Gm-Message-State: AAQBX9f75gUo0+TUvaaug9Q3SuXOrHq1dcVKcqnxj/KmxDVRD3zTl21P
        0ICDaOPE59Gtmp2bVW8ehLlMUQ==
X-Google-Smtp-Source: AKy350ZKgOw7g2qw0vo8hOLa4k0CK7hi4jvIBewfRJ14ew+DsSC2qPTH0AsTBu39u+MqZx9ZmPR8Fw==
X-Received: by 2002:a17:907:a08e:b0:92e:3944:716d with SMTP id hu14-20020a170907a08e00b0092e3944716dmr2064487ejc.3.1680674950947;
        Tue, 04 Apr 2023 23:09:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b00882f9130eafsm6784643eju.26.2023.04.04.23.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:09:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: qcom: sm8450: label the Soundwire nodes
Date:   Wed,  5 Apr 2023 08:09:03 +0200
Message-Id: <20230405060906.143058-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
References: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
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

Use labels, instead of comments, for Soundwire controllers.  Naming them
is useful, because they are specialized and have also naming in
datasheet/programming guide.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index ce4b7d0a09ab..1dd000748f9e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2153,13 +2153,13 @@ wsa2macro: codec@31e0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		/* WSA2 */
 		swr4: soundwire-controller@31f0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x031f0000 0 0x2000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&wsa2macro>;
 			clock-names = "iface";
+			label = "WSA2";
 
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
@@ -2268,13 +2268,13 @@ wsamacro: codec@3240000 {
 			#sound-dai-cells = <1>;
 		};
 
-		/* WSA */
 		swr0: soundwire-controller@3250000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03250000 0 0x2000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&wsamacro>;
 			clock-names = "iface";
+			label = "WSA";
 
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
-- 
2.34.1

