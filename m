Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3186718164
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjEaNW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjEaNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:22:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD82123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so3127225e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539368; x=1688131368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtyrqdTWQcpyKl/kqFYipYrPO4h9o2BturowbZwWg50=;
        b=PnygFpmsP4XDLrc1sbNSX+SaH/yPGxZFhlYEKvnyO7HwfGYw4+b522olTeCAwlBjJm
         WPNWVlO2DVoz6iA0qgVuvZHwMNSBi6+BGJjSB3DBmoet1m5SB6KJMtK0znvtKYR+22PT
         r0Ynusu/TrZNREo+MYwOAidMSusPA8mf5pOTQDBgD9z+rDlzdQCjZNyouKR4X3AB7EDt
         0nHWeoVA7Cz8HY43hjiq1MyJ7+yzQXWZaRDQIrVX+tEtJir5MCbC58yii/+d7KNnLiE+
         fy2knePgF6PKgzvqSBwPqkaTeeMtGVXGs7m3fRUiG5w2RVoKjE0KBPh7uhvgqTElvU0j
         ch2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539368; x=1688131368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtyrqdTWQcpyKl/kqFYipYrPO4h9o2BturowbZwWg50=;
        b=N1nvNlivx5n4WgRmzWa78iM5O7ZxHlPHj8Htse1EOEoC/RKO16SJdilfAnPBMobmG9
         LfQs5sOxnAcgBb2armg5CeCwHvZtk+2KSFo5Z/GxaB32JIX96hdyFxOoyL74vEzjVuKY
         jMbLwlsP/mrU+2CM8y2hxQKsTT6/0xor9OwseLxr3r/KT9aQvFEZqIwTkAMA/fCLI7Qe
         QyVRjstdng8Mbl+Esp7t9igB80YYkBGpzs/R8psacuFtt7CVeg68/us+H0Jm5g8Ud5Ou
         4HAycCIYCWIqcRK5WCwpu7bfR3uEmpk4Ho95weSjScyBNH+oxJlqbJvqr0tqMutAhLTe
         LFDw==
X-Gm-Message-State: AC+VfDzH0YwM2FLAiXfcpSLcIvd2ycyGgmVCWotELgeYKMkIptIpfdWB
        q1HlL+tDZfDtF0pzHqzHufCx2w==
X-Google-Smtp-Source: ACHHUZ4Mv2gd/xa2zr6hrKHRSrLA6yH4TWCYgO7H3a7ogK4GJ6qZeYKZYNQ3vVj0GKfot50DQtsO2Q==
X-Received: by 2002:ac2:483a:0:b0:4f4:ca61:82bb with SMTP id 26-20020ac2483a000000b004f4ca6182bbmr2743707lft.45.1685539368528;
        Wed, 31 May 2023 06:22:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 15:22:37 +0200
Subject: [PATCH 3/8] arm64: dts: qcom: qdu1000: Flush RSC sleep & wake
 votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-rsc-v1-3-b4a985f57b8b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=1027;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TObQ9wJAJgJwWqQ5Ixf0yflCFVNt1QkEEHiCMIA7XQ8=;
 b=sY2igrHYMkKIIn82pO1xm4mjQC+2D0hOpPwiNmbXxsM8LJiqZ3ofxrmnxykQRUEpkyRwZj/8O
 Ae+3IBDD4o0ASUc/CzU1GpUnHc9r7ESy37zSi5u7kWSZgIZPm/3Qxau
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

Fixes: 6bd20c54b589 ("arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index ddc3239478ae..4bc8c77a3538 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1252,6 +1252,7 @@ apps_rsc: rsc@17a00000 {
 			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
 					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
 			label = "apps_rsc";
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";

-- 
2.40.1

