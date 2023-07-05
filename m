Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48C74872C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGEPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGEPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:00:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6641712
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b700e85950so9845571fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569209; x=1691161209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe4Ake/cHImZdWZoJWmQjPiokOYwW2OaAbg/UtG7OHU=;
        b=rY77fwho4p3VPXl0MSDA7+J/heawgwk1ghYc+wIqUGed+Rk928Pfi37SjnGeeacD1D
         7TDVSusK8qpXL8IIEIj89YnF5LZyn/X+I5gcYdGa31gNti72Is3aYt3qRja3kgcQgsj8
         WmHHLmpV5uzuA3ijiuHVX8T6L1jctE/ibHm64VGsCkRldyPT5mVHiDl05rJq/H45mkCD
         rn155SFTZIMljCHIZddAzNPNcXcTVp8sLtzz+HXs84gbijEldTMjPXnWtBW7fPI4xFoQ
         eXepWv+H/G5orqOEN3ZK1DvRfn5YxfbxdwftoPZZnOKxjXh1sSZuZ6/1sDzKMdNjJzdL
         d4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569209; x=1691161209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fe4Ake/cHImZdWZoJWmQjPiokOYwW2OaAbg/UtG7OHU=;
        b=UOlBA2GK12W+VIBuxKcPilF/xjJxwN1+LmhefKz1PzMWZRSvCYVfWgGyShVa9xybEC
         Wowxlx0YfzDtTALxfDbaCRzON37A53mdCWAmMz3++vklBFexwba/dWJIx4fa8Pr/ynuw
         3VuQkPIxW++FVPu7Ic/96uoHuA5ukCT8rMuV/O4lOw9rmeYhT7C7ARGZErLjXopjHRHo
         M5WtaQ64Av2QgFsmQqc7cbpHHwJ7It04qMShjNivW9WNkxrdLHZaFagvJXv7UTmE8c9v
         F8ob8i8Fgs5dktz3XS9xSvg+0tyPWL3DwqcDWkwgKIxK2uxLjrlDX70BxWlGtLtfTy+L
         Y8tQ==
X-Gm-Message-State: ABy/qLbhYjBOlkyOjmHUPFeVzloiHoS5qk8ZIugroKerpK/KfQpJxkHT
        jRDaL6iHStEmzDGCXRgte2lgQA==
X-Google-Smtp-Source: APBJJlEtfBhxCl/vm9hf2dNh2Cx+vVpBUNL0/G6yuC1l+C/+FpzpvROTRUdP1q2gTlg1BPHPKRb+Mg==
X-Received: by 2002:a2e:3019:0:b0:2b6:d57f:d81 with SMTP id w25-20020a2e3019000000b002b6d57f0d81mr10345911ljw.53.1688569209110;
        Wed, 05 Jul 2023 08:00:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e87cc000000b002b6ee1e8893sm1404520ljj.95.2023.07.05.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:00:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 05 Jul 2023 17:00:05 +0200
Subject: [PATCH] arm64: dts: qcom: sc8180x: Fix cluster PSCI suspend param
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-topic-8180_sleep-v1-1-c5dce117364e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHSFpWQC/x2NUQrCMBAFr1L224Vt2mLxKiKSxKddCGlIVAqld
 3fxcwaG2amhKhpdup0qvtp0zQb9qaO4+PwC68OYnLhBzjLxey0aee5nubcEFMYoAWF0bhJPlgX
 fwKH6HBcL8yclk6Xiqdv/c70dxw8x2TqGdwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688569207; l=1177;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fKCnerWNyiq4j5fa1J8E6eCzQXTmc96oimiC9IVeZTo=;
 b=VR50xzgY7tjhfo20QT6fz9vF6uwly14RcRlq1URPt+6AeRIlL8zuoVhQfSZzklnQ7T8YLDYxP
 /cjtFQLsgJ2Av1dXXQEgE20ZJOnbo1zSHegfD7M1m3tPaLnn1Qk6cM+
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

The value was copypasted from 8150, but 8180 expects a different one.
Confirmed with both downstream device tree and Windows DSDT, not tested
on hardware (sorry, I don't have any).

Fix it.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index be78a933d8eb..e58f931c2e45 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -298,7 +298,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x4100c244>;
+				arm,psci-suspend-param = <0x4100a344>;
 				entry-latency-us = <3263>;
 				exit-latency-us = <6562>;
 				min-residency-us = <9987>;

---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230705-topic-8180_sleep-e40beb42250a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

