Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398064BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiLMSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiLMSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:33:22 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1735D21E3F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:33:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g7so6371097lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l+ZRdexUJZDY+Gh4mGAra9DPiKGS/PdB/rIjuu7p+8=;
        b=yHSWR/sRtLF4N/ot8Q+lyX3uYvgn3mX0Gvmun4zuMErKRWn1mYfODYiewl5C5niL3m
         vDYtoMV9kzuYenEuGNvY7oUBrffH1oj0xtojxZxw5qX6R7elwiCPwK5AkZ3YK70G5FG1
         0FhZxsCa6fgR0JG/KUph3lEL5NDTSr0pjK7srQZXdPGpLshtlZGG1xrSIuCecw//Cei2
         xiusP+bo3viL/We2pZjwhSXKObhxKdPwlrGjH24NAnLsuXNxsxPj/pQnJVDOvAf2u3A0
         ts+v8gSoeO/OHPgTEn95aWOsi6U3jTtYVRytlZAbdSk6RfYzedNO/BNWhueUSavlltjB
         nD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l+ZRdexUJZDY+Gh4mGAra9DPiKGS/PdB/rIjuu7p+8=;
        b=FE73g9lY+qZXltgSM+g84hGpdarUkKSIxmQDxW3JA4OQelU3eeZM2IT3hd/ZQLiAzi
         BkfmKhqfcFEaiYXU7z9fuRHhZKZHPA1MrfEyVHeotCZaTLPTExRTL4u315fD/VdAH1Dk
         gWahaGb44D9cuguA5GsjzpzIZp660tsJ6mauxB+HfncRt5vA98DG16ltIrE3Fdrd/tfV
         KkHbgEMnaNYbf/qQYoOC6VopItrqkDnFcXx4IQ5PfrQkta+aJ2bLNzP/mIhSEhMW0qmx
         zSODJ96t71mtCUZjXj66ItFBc5pevq/GGpHijIgaZPVwkgi0CkOcU9xJiiMP3/oPg8OK
         uBlQ==
X-Gm-Message-State: ANoB5pko4qKyfqfBphU5BV+B2h8SJ0tysmAQ/NwC7CRs+FWp6Sbp0DVp
        Ymi8PFN98MT1tJaLGotTGsCfZg==
X-Google-Smtp-Source: AA0mqf6TZm7Tqi2o9NVrle+9b0P0OxDXJt5bOYFVL7Dwn2fjQXBfMO6pWm7fQHSO/SrA9aFf1cavTA==
X-Received: by 2002:a05:6512:22d2:b0:4b1:97ba:5716 with SMTP id g18-20020a05651222d200b004b197ba5716mr7566864lfu.0.1670956398570;
        Tue, 13 Dec 2022 10:33:18 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id t10-20020a056512208a00b004b501497b6fsm465963lfr.148.2022.12.13.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:33:17 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8450: Add fallback CCI compatible
Date:   Tue, 13 Dec 2022 19:33:04 +0100
Message-Id: <20221213183305.544644-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213183305.544644-1-konrad.dybcio@linaro.org>
References: <20221213183305.544644-1-konrad.dybcio@linaro.org>
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

Add a fallback CCI compatible, as required by bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- new patch

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index a8f8ffd728d7..a9ed8443ac02 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2554,7 +2554,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 		};
 
 		cci0: cci@ac15000 {
-			compatible = "qcom,sm8450-cci";
+			compatible = "qcom,sm8450-cci", "qcom,msm8996-cci";
 			reg = <0 0xac15000 0 0x1000>;
 			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
 			power-domains = <&camcc TITAN_TOP_GDSC>;
@@ -2593,7 +2593,7 @@ cci0_i2c1: i2c-bus@1 {
 		};
 
 		cci1: cci@ac16000 {
-			compatible = "qcom,sm8450-cci";
+			compatible = "qcom,sm8450-cci", "qcom,msm8996-cci";
 			reg = <0 0xac16000 0 0x1000>;
 			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
 			power-domains = <&camcc TITAN_TOP_GDSC>;
-- 
2.39.0

