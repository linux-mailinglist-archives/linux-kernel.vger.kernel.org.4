Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3B6DE1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDKRJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDKRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:09:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7814690
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:09:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a35b0d130so210596866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681232983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9SxlcmeObYzS8Fp2B5Ly5eIBlD9Df8fw8jDrfxuB2I=;
        b=X1jxi9RoB5VaFZdoe3FRaxwMcnMHJbQQmtALVHDqPSFjX8nQM/tEgdzij9WWb/6kOn
         PB6doZahYWV9ORUgw4XLvzdiwGd27JBMD3mQqZKCzwPtdsuJyiCejTXB/pkVWj+RB023
         1X6e0N666IvvZvObQcEqkaeLeK4vZxa2HZMyiHLT75ehPG4Ofo4sKfM6bxJv50kDLNEX
         Pg8u89ylk+nWuep05ujYV+DjCH/2yg7WwzhB0J6l7ME8N0gCXDqcjCMoYN7hEsfDrQPN
         Nf+9PnhDcGWFVhdb9qsQnPkRZMnrSUZwXgzHUjUk5Nbxi72x8R7wRH37Onc/76uTMSFo
         PG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9SxlcmeObYzS8Fp2B5Ly5eIBlD9Df8fw8jDrfxuB2I=;
        b=3ymZB96bckmn4ZqLDwFPxIyA3hfernuH2v/jgpaANOKN8LoaXz4jbBpD94BIZyG0k1
         hDH9GVJ2p8LwoIdDcrwn8QartiRjI2tHGqxyZ6a3QQw68W0PQdShf+GJH5Abb86v96o7
         2sFZ2ovns7WzPhBEBETs5cdNZ/wO7ZSC52DUXY46Zg4new85ZgMSpd8QiNxn24BNWeWQ
         1AKHsRo19wqaY8oRi4XyIPIqMcowL5xE0s6sdJ4rSttMiq3nHvuFEeIGA+jACPHS6iTF
         hsv1U+2VwQBN5DhnKpsqjFa0prDRZGesno+a+H9T8eO6Hpuh2OrlB2OEe6BtFZKLOjrT
         xtjg==
X-Gm-Message-State: AAQBX9dvdJGyH4GZ55e4JvJhVbQnU+jYXghQUA4c97uXfX9DkmUYTynz
        MoQItsRMAU0dcBZK5GUo7L/3hg==
X-Google-Smtp-Source: AKy350bsAUOhc4y4f5Ru3Vp1ZKmVGS5b/u0biKZd50s1bReuD1OcBZkGl0oncQXLLhDEN6HJBEJR+w==
X-Received: by 2002:a05:6402:356:b0:500:3a14:82c1 with SMTP id r22-20020a056402035600b005003a1482c1mr9363234edw.41.1681232983342;
        Tue, 11 Apr 2023 10:09:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id a22-20020a509b56000000b005048c1f37b4sm3544311edj.64.2023.04.11.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:09:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom: sc8280xp: remove superfluous "input-enable""
Date:   Tue, 11 Apr 2023 19:09:38 +0200
Message-Id: <20230411170938.1657387-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This reverts commit 87e1f7b1a041a37390bf4fa7913683fb4f8d00d8 because it
removed input-enable from the LPASS TLMM, where it is still correct
(both bindings and Linux driver parse it).

Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/b7c9ac38-6f9b-8d05-39c6-fee9058209a9@linaro.org/T/#me6c2cc2d87c17c0f30f541e8161a84fdde69f5f5
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 7608a4800732..ef9bd6ab577d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2725,6 +2725,7 @@ data-pins {
 					pins = "gpio7";
 					function = "dmic1_data";
 					drive-strength = <8>;
+					input-enable;
 				};
 			};
 
@@ -2742,6 +2743,7 @@ data-pins {
 					function = "dmic1_data";
 					drive-strength = <2>;
 					bias-pull-down;
+					input-enable;
 				};
 			};
 
@@ -2757,6 +2759,7 @@ data-pins {
 					pins = "gpio9";
 					function = "dmic2_data";
 					drive-strength = <8>;
+					input-enable;
 				};
 			};
 
@@ -2774,6 +2777,7 @@ data-pins {
 					function = "dmic2_data";
 					drive-strength = <2>;
 					bias-pull-down;
+					input-enable;
 				};
 			};
 
-- 
2.34.1

