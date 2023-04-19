Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73C6E835C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjDSVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjDSVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378786EB5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c9so1775767ejz.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939146; x=1684531146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xwzESYBcFkWVxCoRTLhMhVmlvvQmCPBA/HaF9+KLFk=;
        b=KauRKVuDJmNop3F/MEJEhgB70ZJF3a0IDHUaXH+UWpgEH2Z5lNC5yEtlg6sbSqVsIp
         HmEXSn6vWPW1ljZGe3YWtw5kz4ItxRQioDKs2Jht8QBMAGdWMrKZuJmv6i8tjAhQCokb
         ZmYPGVmWzSS1UjtHvI9OYdbw1oPwwkNmdGvvRJypN6enfl91nFCLxxCTCYpdgSjMFdVd
         eyev2visAGQD/1T5RVwGa8SEsBDonOahxi4O96OKx/HUEpNwdTyGEzfK//G8+ckXlMy+
         ZTAghDM6NvCFU9o1Xr8tN/BLXixfHPeH2ggoD3iN6EKl5OQfP/w0qL4LbMNEuyTn8pcJ
         NoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939146; x=1684531146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xwzESYBcFkWVxCoRTLhMhVmlvvQmCPBA/HaF9+KLFk=;
        b=fLMxvfq6f8CqrAQ0JAR9fYW6cT+SSwiq9qe2R22/sjm5nq79KO3WVMDL5RXxhkSv/T
         nk0QTayowcnwhJXuoD3JymQjfvuAeUZDZ0sbFGwLQNMEDT3Rito1XwBZynwF7l2oR0Qz
         U1CvxJ0ueq0tvwFnTZmeUKHDi8UII6ZW+ZY9UZcQAxhumoJ4RBmj+E2Ke8NrStKFxNuu
         S1dbPoOg0V+kuJ6K/qZ4KyquQGYeKonNffJtWlszZZn0o+0aT12sLl3K90R6bFaAqiRS
         BYIEENFQyPZ29AjvpijK3Tr4SDEHt3lOhr6ppX5uKOcG+oBoIjJynWHXj4KQWgvKRlhW
         GwkA==
X-Gm-Message-State: AAQBX9cOgmhbtFuU/7QDKMN96figkFOvoKEaJefDm3qioS4kcXWOHbIE
        9IfgbdIqgU+VLONu8xrXSeUuRA==
X-Google-Smtp-Source: AKy350bSUS4CoZ0IcpPnT1DEiX6LXgcm7aWu61rhu4+TB0cLMKMCua+oTZ2GxzDhRZh3WnnSHsFt4w==
X-Received: by 2002:a17:906:eb4a:b0:92f:de0c:c914 with SMTP id mc10-20020a170906eb4a00b0092fde0cc914mr15335019ejb.28.1681939146690;
        Wed, 19 Apr 2023 14:19:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/18] arm64: dts: qcom: msm8953: correct IOMMU unit address
Date:   Wed, 19 Apr 2023 23:18:43 +0200
Message-Id: <20230419211856.79332-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/iommu@1e00000: simple-bus unit address format error, expected "1e20000"

Fixes: c0b9575a3606 ("arm64: dts: qcom: msm8953: add APPS IOMMU")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index d44cfa0471e9..4038e47a4610 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1002,7 +1002,7 @@ dsi1_phy: phy@1a96400 {
 			};
 		};
 
-		apps_iommu: iommu@1e00000 {
+		apps_iommu: iommu@1e20000 {
 			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v1";
 			ranges  = <0 0x01e20000 0x20000>;
 
-- 
2.34.1

