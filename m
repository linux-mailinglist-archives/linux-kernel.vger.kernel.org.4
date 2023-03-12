Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD86B6A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCLSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCLSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:38:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2ABD335
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so40193837edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyROabzfNXFjzGfPmuA55zwQiucJjRNtPZvLnEFOd0M=;
        b=DoDElB/241YOsIJ7gmlQ1ixYxcb8JqUlSbhklKuqcSyg5vXI/z6NfKciWgTX8DLxJX
         lDzBRnPm7YetM84hdSEg6ZkbJB5SKpZ6LfERV/HYFr7FD5lsNM1BAtw8ZWSqggQtwrke
         ygLKoJ8I3GrajL4MX+c6eUQeKzoQeXHG32EqEZcfsc1jEUWL1f2CmyOsFEjJmwpgYsyH
         UPsf8y8ZvYAL1bJfkcQHsAXLVmYfipKFvkFDH0CANKXpBl3MM0pM8NBQLn7AePGM1KqZ
         +hYqYt+hxIxIujP+4Lg3s8qXsLcC5pMf3MLDALtedUINOYEM5dBLg5MS/rIWbu7DpDSl
         afIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyROabzfNXFjzGfPmuA55zwQiucJjRNtPZvLnEFOd0M=;
        b=bRcNd+vOyZabYT0NanRGohBRDvO45CGKqKhMkoYbEkRWN6y1vkOAwGLaXYnRhPyPZQ
         N/mnFLVbo9YIc2fiNcBgjyU/0z0ntKyfORW0coYGrdiqpkaNX/sqcuf8DYpjz+UKP9uv
         IsVkfplv/K4bCNoS+8RIHijx7tSN5+eqHfAeTIVslcKZq/E0p9uWdcDjP+4KS0gfw3SV
         K01xEKQix5cwttuUtRyhl9KcMw8xZTlPEc4z09LC2FnHEWhVhr98G9vfDBb0sryEejoV
         yrWD9TZO3vy6gRihRMVxjqa01EQLXOCvRkqpq+/0U9QXGxNN8M+NOOAdMJ1SG4nrf2Ew
         e2VQ==
X-Gm-Message-State: AO0yUKV1qglM6QoCP+AWw7hova/mP52Wn7eNCwqEeJLhcZ6itgF9Uj0t
        fsXXXN9drlzA8dXM9Xp9uQgHBg==
X-Google-Smtp-Source: AK7set84tJrxNq9eHj1GVH3942S8sEuNvOmwiWzGuX3JQjCsrSE/9vcrPaMD4RytD0vFAPzLVFasFg==
X-Received: by 2002:a17:906:8d86:b0:8f9:ed75:f962 with SMTP id ry6-20020a1709068d8600b008f9ed75f962mr34512494ejc.18.1678646193304;
        Sun, 12 Mar 2023 11:36:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709060dce00b0092669fb4ba1sm893806eji.130.2023.03.12.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:36:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator
Date:   Sun, 12 Mar 2023 19:36:21 +0100
Message-Id: <20230312183622.460488-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
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

The PMIC regulators are not supposed to have unit addresses.

Fixes: 60b214effb80 ("arm64: dts: qcom: msm8994-octagon: Configure regulators")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 4520a7e86d5b..0c112b7b57ea 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -542,8 +542,7 @@ hd3ss460_en: en-high-state {
 };
 
 &pmi8994_spmi_regulators {
-	vdd_gfx: s2@1700 {
-		reg = <0x1700 0x100>;
+	vdd_gfx: s2 {
 		regulator-min-microvolt = <980000>;
 		regulator-max-microvolt = <980000>;
 	};
-- 
2.34.1

