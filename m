Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10660E9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiJZUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiJZUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:04:17 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610B110B10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:04:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s17so11503710qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pco6XP3zzlzKkHJ/8k4uES/pSob9fk0mMY+1kXvS6TY=;
        b=JwHHwywsMb9iQbsPockEFVNMIDxExD2U8RnZfFgB5sQQbVmOePQhpU9USsB3t6B4/G
         zkJ3CUAaXNGbx7oJwoAUfWQV7Un5b1XTA3KE6NIZKMy31msSxtkbl/Oz2hbvWn6DSPhg
         OKS8lKgs2mmDQydn+5wXf+POR5Xxmt7cRj9uhLrvE5RZ8BDRn/eB4VnauOM1i+XixRWS
         flCvJGUQAQTvC6QWgTxiQ4gBzNzqKTyN74UeL+tpHpOUb5NRuhTPg/vPh/8rpPEGY0Ha
         TKnai6UGH+K8DOJE2r7vPETcoOjka7kmBg6S5PlWlOAlC5/x8JoaDg3VTYS5mDtywi2I
         AVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pco6XP3zzlzKkHJ/8k4uES/pSob9fk0mMY+1kXvS6TY=;
        b=dFbxmsCQo7IdBGsr+PQy+7aNWumg2mDoeLBXtNZy0+IAWiPvbkEc9DHT6vapCWbD8S
         6l/ajQ8OwCGELMLbnRYZ/F+vA2wQ6bjfVXLP9AjkBE1pnj5W5m1+QgTT+Fh7m8SjIVVG
         oqP/ZmVGJUJfSlB63hvW0tZyiOI4xWTsRQUmEKXvLBtYVpi2jrXO0tD9ufGsL19FBTx0
         nlMs3TlhLm/MUfQz0d/dKxWk3WFFmYZnn3Pr+EOpZEnEcUWMfgEugWW88yigkLS0wAEN
         VIivqBC0ahi7oJmoR4Q7uxXXMgc32EhX1fSsMadB/+oo2QfxBQqDlJH3nNFry9avsfbk
         9IAQ==
X-Gm-Message-State: ACrzQf2ifB9KDkD8q3XrIMM4N3m0Nt0MZE2rzW+5cmgfn050QbQMOJ86
        fswNnXukfMg+neiUrvJlhcAj4WYU7c6CNg==
X-Google-Smtp-Source: AMsMyM6IbRSXEB6Fmc2djOZ0B0rJEV/aVUdSza0WpoDlkxwlChcr7aww0a6H3dSgeptN56TRdQMPyg==
X-Received: by 2002:a05:620a:13b6:b0:6ee:cf79:bfa1 with SMTP id m22-20020a05620a13b600b006eecf79bfa1mr32285840qki.15.1666814645256;
        Wed, 26 Oct 2022 13:04:05 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id de30-20020a05620a371e00b006e99290e83fsm2942089qkb.107.2022.10.26.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:04:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8450: disable SDHCI SDR104/SDR50 on all boards
Date:   Wed, 26 Oct 2022 16:03:55 -0400
Message-Id: <20221026200357.391635-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI on SM8450 HDK also has problems with SDR104/SDR50:

  mmc0: card never left busy state
  mmc0: error -110 whilst initialising SD card

so I think it is safe to assume this issue affects all SM8450 boards.
Move the quirk disallowing these modes to the SoC DTSI, to spare people
working on other boards the misery of debugging this issue.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts | 2 --
 arch/arm64/boot/dts/qcom/sm8450.dtsi                          | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index 718c690af8ad..ae8ba297b0b6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -556,8 +556,6 @@ &sdhc_2 {
 	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
 	vmmc-supply = <&pm8350c_l9>;
 	vqmmc-supply = <&pm8350c_l6>;
-	/* Forbid SDR104/SDR50 - broken hw! */
-	sdhci-caps-mask = <0x3 0x0>;
 	no-sdio;
 	no-mmc;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1df5c964c6f7..6800e05a549d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3412,6 +3412,9 @@ sdhc_2: sdhci@8804000 {
 			bus-width = <4>;
 			dma-coherent;
 
+			/* Forbid SDR104/SDR50 - broken hw! */
+			sdhci-caps-mask = <0x3 0x0>;
+
 			status = "disabled";
 
 			sdhc2_opp_table: opp-table {
-- 
2.34.1

