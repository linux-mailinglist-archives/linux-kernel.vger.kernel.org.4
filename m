Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC671817B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjEaNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjEaNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:23:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A61AE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so1181605e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539377; x=1688131377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFK+Ou6t+IM+Z0lJFsVgxMPKX7db6qU21GRYqBnVGs8=;
        b=xheckUJTFHHmw4+nyIEBDwWhPOuL3vNKlQo5u212RJIkGqB0ZD30MnU7ZHr5rC/T4u
         MrR4IesMXrVF2zTudxQF/tx/VlT3exAyrfdtPMtHmFleB2shWS5Z1IHFzUDcy+Okd8fm
         ud/KpK48LlzoZWJY3QwpGOa7VhapJvoik6tUP1WAmT5bbv8gLgsIDzgekdghaBBg9TcR
         l901P//oMpyKUdJ1dwtjVYMRJVFMfBhhP0P335oOalSNIQcaolStpPTFoTM+Q+lanTWp
         qLeuRVO10oKbCP/2izLOCoMb/Os8AHwyB2V6duXywxrqzTsl+W4iDd0uDDhqYcmlZFEV
         qVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539377; x=1688131377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFK+Ou6t+IM+Z0lJFsVgxMPKX7db6qU21GRYqBnVGs8=;
        b=HFZrmsNKvncDyRblsh4rjkxy94CljqniztwDIcI5Iiaa2otwSMga+ncopTUc+stc/b
         7+ql5YfWHUhiJlzsYIOWnkAONZF7BYbfJbEl8qCGAmqxFoXLsWsQpTPJPn5BSy+YiYAv
         A7XtGK6wXbQuNCZUGW864uXS8tIsEgsDAombFUcW5h8pdpfWixKrBSWzlL7EsaaW8usN
         1gblpP5ZvRlqz49wGzoX6ldFo/Jot/gCsBLLMEA8Gok74Zp9eqbzgzFzxMco4WIsFXEa
         VNnJLODS3LiGQVzMGBnqNdnRO82Exs4r9G0QvTQ/8SVIIlHzb4A859g481EzPYhMD/yt
         7Szg==
X-Gm-Message-State: AC+VfDyq0+fQ562zZQPMGdtLZ2aiVB94DHrSLBXZG9RMH9/98oC4hTNj
        NSraYyOXwKswDcMgbGNzu15rWg==
X-Google-Smtp-Source: ACHHUZ4AkcgCPt1BOGb6Lkh6GQHDiODuTCyRIATpixy8K5JY7ZGBzaZZQmjg1UxN8xHAOlOH9yiwVw==
X-Received: by 2002:ac2:5df6:0:b0:4f3:b242:aa98 with SMTP id z22-20020ac25df6000000b004f3b242aa98mr1822980lfq.30.1685539377267;
        Wed, 31 May 2023 06:22:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 15:22:42 +0200
Subject: [PATCH 8/8] arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-rsc-v1-8-b4a985f57b8b@linaro.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=1011;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3LQbT1pkRcM60cyga6zU0z4GuxAMPjHrb5uo6UzkAYI=;
 b=Qt8SrZzczur1fTmSMEih1/4sXuG2wBrLyUhegwmgObDm6zu6aVcZgfgo883vtVdYv7Eq/MOZp
 vxQB0wJ3fvZA06kosIaS1r3hX01+7SKs0Mhnoc7nvCKPAnImrnb99XD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 75cd374943eb..6a06373a3779 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3621,6 +3621,7 @@ apps_rsc: rsc@17a00000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS    3>, <SLEEP_TCS     2>,
 					  <WAKE_TCS      2>, <CONTROL_TCS   0>;
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";

-- 
2.40.1

