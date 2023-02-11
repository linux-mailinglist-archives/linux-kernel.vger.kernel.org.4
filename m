Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55D66930B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBKLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBKLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:37 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E7861B1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p12so149037edc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JwitY1QgTn2wW32f2EWY7DiZlNcao6/ffQYXSOSkgM=;
        b=O2U8bA+e0jscKVKwDF0a8uCnoSzlqs7txUc0HGXN02xC3KZQJlDAqLn1sUEKNd5OVr
         iSSvt3UnibYkF9OO11S5b8Ralk/c2YrEm/sY4+lmKdkhK+8MHEqeK3OG3vkQzEehqKwD
         FUn+HrGX6NNWa2I2DVgNIWf5NThDSHcTN0aiqnZVaSVqzON9lgEl9d8wWICYdGkxJ7vA
         WFc5EKn0ESHhEFYGwkDew5kNv3mNs5NlV5MOjO1R1S5LmO4eULFaajuJQxYOjTheKo7O
         dpSFQGN8Fgca3qM8tnNY6n+qCYAmPIduPjBwsZdxRTCwK8cKnsqG+iuWZ4iau9d3TnVB
         S0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JwitY1QgTn2wW32f2EWY7DiZlNcao6/ffQYXSOSkgM=;
        b=oYGGqx23eC8yr5587vTv9dwL0XokeDD3g/+Z8bm2QXmNR5cBLyBXHWI2f/FMsqQxRP
         ZmdJ7G4Pde/VDhKmmeeWAKe1tP1DoW4+XtdhHpDqq1tmL2TdrT2SdcsmGE2MVevG3joi
         Vy5FD1+AnM8lwqLddrTq2mDIlOvDEzhtoBfYaepxOieclDG0eU23gKO2FpPZl4Ff0LDE
         YXLiJVZhRxe6H7I8fgECbLQRbpDhBFTuaXLyHqSErQGyovwIVLsDezzukHkFPdvtllb8
         7kfg+tiIpkQ62zHnRGTRfj1ZVF0d6roAVWYHiAjKCXDbAReR0uHgVCvbGoJpus7AcZAL
         tOFA==
X-Gm-Message-State: AO0yUKWavx6KpTk0FkbxOByZJ8O7O2rd9blG8vRXoQB2wgRp+shC6/25
        lqDZZW//U1wZBkvvkMqPwcdImA==
X-Google-Smtp-Source: AK7set+5vO+1Ck1DQ3INwwqy5E/BdOgVL2kZKgDcsrrpla4szX11tmr1R+9AGyjoXLstmBaceGUPfg==
X-Received: by 2002:a50:a402:0:b0:4ab:554:37e9 with SMTP id u2-20020a50a402000000b004ab055437e9mr14341402edb.41.1676116333351;
        Sat, 11 Feb 2023 03:52:13 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:52:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: dts: qcom: sm6115: Use the correct DSI compatible
Date:   Sat, 11 Feb 2023 12:51:10 +0100
Message-Id: <20230211115110.1462920-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the non-deprecated, SoC-specific DSI compatible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index bff067ed2e94..15811be82acc 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1447,7 +1447,7 @@ opp-384000000 {
 			};
 
 			mdss_dsi0: dsi@5e94000 {
-				compatible = "qcom,dsi-ctrl-6g-qcm2290";
+				compatible = "qcom,sm6115-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x0 0x05e94000 0x0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.39.1

