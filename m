Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CBC6BB5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjCOOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjCOOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:12:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C25A028D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so14973212lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtJ3vFNxN3ulWegLUMLxPGL5fEpN3EwC/SH8BmcFyaA=;
        b=r5bmp5Qi8GsB9iOnryLlnMBm6qMhM3jE8e/AWc8v/jVHcajTLDlslJwCIcOBBcHWVc
         y11HdcZJ8EJrDylYysW+brO87vMx/MHiqCbDA+VeIqhAIio883RtITf+Ko4yQMEo2B9r
         NmhZ/+XYkXR4gHK2Fpn3G7lJP6Amz8y13ikCwMsfkTS/a+C7eAKvzJMzNp2aHJKW+Ped
         aGw7qOmTDCkroXtE/biZj1aEQ0fwiutwOBXZJNxXK7r18hzfpefUMSsRhkOukfXFXnLG
         l2IoXeyeYqgLlMshOd8u32rhL7yEss4T327JhozOwijEiF/CRWmBZtm+aCc+MN2KTOL0
         rolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtJ3vFNxN3ulWegLUMLxPGL5fEpN3EwC/SH8BmcFyaA=;
        b=fYaQSlypQ2t7K+gewvrJSUkHJDfKXQpVN26Y80Gk6xXlu0yPq1Cvb+JhcKE16gVHCG
         wO7ylpJOXnF/RVvQcnwQeQs4uBcXnJtVgshqNNlr/jeLNjj3V6f8pqmEEl8Hn0kg3t6D
         +AEjJQVjCK6Nn23pwnN4jMf+zG5om45BS6aA6Hk7TcHl3vKh+YZY1AyS9NU1YlBCEXJW
         Z7SlP4UbSZCXLoM5n2+mQJju/ktoLh/+VMebhF0BYcYnHBaN0zNwzpsNTilm9dP6bC/q
         RKN9dwmQDIhd5uvTkk1U/KR2pBIzJ77C2RltTPSN5HS0s44Zl8XT8nxDfkBbTXK7jQTJ
         9l+g==
X-Gm-Message-State: AO0yUKVyitYD4RPpJ6l1iUP8w6nanNbVIP/Qp/d+3YC0iNfC9F0dYsq/
        qLEgPw8af8to4MlQqIS7BrPnpg==
X-Google-Smtp-Source: AK7set8U2f2jJCQnZGyHhK2xJ2jiR6mdyeJRvBJFzc4XJF6ufYMJwWid97m84I2qPGtny7eB77zUTg==
X-Received: by 2002:ac2:4297:0:b0:4cd:7fe0:24 with SMTP id m23-20020ac24297000000b004cd7fe00024mr2186112lfh.27.1678889502079;
        Wed, 15 Mar 2023 07:11:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 15:11:25 +0100
Subject: [PATCH v3 7/7] arm64: dts: qcom: sm8550: Use the correct BWMON
 fallback compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v3-7-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=915;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dMLX1nr86ibogtZfftMqjl+ZEaZVlp2gW/2Ekfh4Qg4=;
 b=mMcmR4y/gsZjUv2tlyJ0SIklkEDolVPgP57/9+mWsULUFgqpDVqjV7uPqWeWFjPx1kCvQH2+XD4H
 91/t24IgDvQwqivh8870zKvltnkQHeHB0FsUya3rbMU+kimWCO0Z
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct fallback compatible for the BWMONv4 with merged global and
monitor register spaces.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 25f51245fe9b..b5488c6822bd 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3391,7 +3391,7 @@ opp-8 {
 		};
 
 		pmu@240b6400 {
-			compatible = "qcom,sm8550-cpu-bwmon", "qcom,msm8998-bwmon";
+			compatible = "qcom,sm8550-cpu-bwmon", "qcom,sdm845-bwmon";
 			reg = <0 0x240b6400 0 0x600>;
 			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;

-- 
2.39.2

