Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B869664BCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiLMTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiLMTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:10:50 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6925C44
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y4so4348929ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk8myMSZixEpFm7TSq22NpEC9ZPyK1WEgfZ1nKeoUI0=;
        b=LBivIO/xpTg0SgheLpW6nkV0gFksPw2fYej+MmIKLvy1qqUqyQxJeJrWIpSMQvex+0
         Um5DNqhVlKdLwfzxrh8PitybZB4WQzP9/fD+8pIpJaJxV4fK1u3ZDJyVv18FKLYSx064
         QYbslSZq7/aGYdTh20Xmuc/Rzy+JMNWAx8ZeWGkBfzKT5rrbP0e8tzwJzO+/ScHvNQSc
         Z4XnHtvkJOBuAIt3GHC1Ukp9wzyM5DR0QtJxFW+R0rNxS7kTcX1/jyCXsSPp5eEgAgd/
         knV7bux63l3QrXMuzzkS2Gm+FEqGOH2KsCCWwMlfEW+jLbThpu4M65pD2QY+Mg2OBlut
         aFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk8myMSZixEpFm7TSq22NpEC9ZPyK1WEgfZ1nKeoUI0=;
        b=pq5+ZbPKQmfpU4WN3ngdRpT/0XIuGR3DnEBGnPkXrX3B4H6NDCd/N03E2I1XWIsdRL
         butSZOjIHCPBYN8QCRc/mrHJ3JxlDEeSoOjt76KpEEJ+bYjyj8GGzt7MKNI8jNOTMjnK
         ggMnz7lhw4GgFJjhwl68DYyu5cmUK0J3xBYmtP5xb2ibW5sTjo/TBqpWFPY5UZ5G+Ctk
         vuxICrkPNiGM6vaEjSRlbhr8Y4IiLJMjk+/ghbJg5+bx5Y8ltcgxZZW5/wcmP0z3Zoko
         teyhKXLnoOP4xFmprThxap3QNj9dSBpXjo/z8cQ7KvjHF5adq8SO+HPAZHwTzycnIvNg
         uQRw==
X-Gm-Message-State: ANoB5pk0axw+o84MJyW+xZym0J4wTg9M+j7wjDBvnM5bCP2cCJAqyF+d
        QmfWDGkkdgKIPXno4vMMyBI84w==
X-Google-Smtp-Source: AA0mqf7jbQsikqDrllNs/d8q4yTeCugJEkCG+GWHORbxVOyVfU9XhDQuG66FPNRdNOOfv7/g6BvAzw==
X-Received: by 2002:a2e:6e13:0:b0:279:d056:21cf with SMTP id j19-20020a2e6e13000000b00279d05621cfmr7406288ljc.18.1670958648012;
        Tue, 13 Dec 2022 11:10:48 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651c119c00b0026dfbdfc1ddsm372023ljo.11.2022.12.13.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:10:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: sm8450-nagara: Enable PMIC RESIN+PON
Date:   Tue, 13 Dec 2022 20:10:35 +0100
Message-Id: <20221213191036.611241-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213191036.611241-1-konrad.dybcio@linaro.org>
References: <20221213191036.611241-1-konrad.dybcio@linaro.org>
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

Enable the power and volume up buttons, connected to PON and RESIN
respectively.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index e26bd077d3d9..1a0c26d84b4f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -643,6 +643,15 @@ &pmk8350_gpios {
 			  "PMK8350_OPTION";
 };
 
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
 	status = "okay";
-- 
2.39.0

