Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2C68842E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjBBQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjBBQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE982412E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so292026wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoMXeKnsBn9bGKhU85ct9VeYJmN7vekWfB8yOeCumio=;
        b=FXd36WiQtISj9JTyCDvqu8GqGDTcn+ZlzeHhicsywNk3qqclTVCvmfEtwVX0qZxJ1O
         CipUAFrzCSxEENyXhpRVfb73yndGCx1RbUE4Iv9Bn6r4x/WF1BEu+7jy0p4KdUqugyP+
         1rNbL3/6VD3YAWwD/qA0VsynLf5OU3QJr8E4gmKOXK50mAM2HkerfyX0gwiY9XW1OgN3
         OOV2RkCPCxhROcnnX6NxRUIozeRVVzuIyYxOY+7OFSHWxywoPm6DYCUTPQqaEghiUpkB
         7dCNKh4qRtintFPbfVEAzr89lSUf4rvfKANoEiN2karq9RZnOANGy9X4O13qWqPYjIAa
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoMXeKnsBn9bGKhU85ct9VeYJmN7vekWfB8yOeCumio=;
        b=bqsDQIL6mFSHD/ynuxKV76wcq25klARaXMugGUaf/ehN1VQBjB7X1ab76jGAb1xXN6
         X6xNrVu9pHR1rhaNbLguSOhqH/0StJj6G+DNtOX/Zcf8tILlMl4JkYkV8wrJOUseGZDw
         uPQssGC0H800PwyPuycq2gdMGzO361adSJZ+ijwWPqZcjCQLBn+WnAU8crXznLmlDpz0
         UtLtuSNUQMoF9bgZSImWlE3xgG2aTgY9TG6/Q582SWmri8xG2EpaUUmTT5SZR/l/ZKJD
         s9II7fyel5SsukfxIuGFC8Nucz32kLPvN7G/dEzQOxOPEMR4o64MXfFCFfSafZQ66Ul5
         m6MA==
X-Gm-Message-State: AO0yUKWWzCk/krZ+TX1nA9s2ck2bIABlAGfZicdRjz4P2Zw+GN1Pli0/
        hLxDV7GHCCfGc4JoLVl7M5RXaQ==
X-Google-Smtp-Source: AK7set+LQmzwXJ3pNYuNfoCLMeLz7R5bDcF/Hx7PirX4ID2ekvu5R6AMgGu86wtny4D1OgVJYIPpYA==
X-Received: by 2002:a05:600c:154f:b0:3db:1d7e:c429 with SMTP id f15-20020a05600c154f00b003db1d7ec429mr6701102wmg.40.1675354787220;
        Thu, 02 Feb 2023 08:19:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:46 -0800 (PST)
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
Subject: [PATCH 09/13] arm64: dts: qcom: sm6115: add compatible fallback to mailbox
Date:   Thu,  2 Feb 2023 17:18:52 +0100
Message-Id: <20230202161856.385825-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
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

SM6115 mailbox is compatible with MSM8953.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 50cb8a82ecd5..9dd230617af4 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1945,7 +1945,8 @@ wifi: wifi@c800000 {
 		};
 
 		apcs_glb: mailbox@f111000 {
-			compatible = "qcom,sm6115-apcs-hmss-global";
+			compatible = "qcom,sm6115-apcs-hmss-global",
+				     "qcom,msm8953-apcs-kpss-global";
 			reg = <0x0f111000 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

