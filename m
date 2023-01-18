Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3169671A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjARLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjARLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:19:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21894676F3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t5so29035149wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4h4mwj02VQM2QT5Jhg78WSnTdol3IH9qvJRJtozX8o=;
        b=vomJyRUrJLvNlMY1ZQgbdsDsx1UU/LL7olxLzA2w4RLVywXnCCg/92FUgIavvuXfjt
         9oMN0k3XEBFMy9YrfjdqxXgkkTy7a6sLydgl7leNPQsQD7ZiMlJFGH0+1FtyPXcmvXDz
         9QwC/cnGZYhjX7603YpzwrOIdvPxYFlGtHXfm3xnNfcz+g6TcisX5XMpI8Z2N21VfGjw
         lF528LzWQVfwixsuAxclvnhWFPd3A3/sePXYKVfOvVX6SwjuNtTsBNCUvsdXwvFYIvka
         rCBt9SBy9W9U4nTgy5DQ/jAHKFIRSVtRYL1K0BxuMLh3G3RarfWM4Qz/ZVFi3nzuWRfW
         QXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4h4mwj02VQM2QT5Jhg78WSnTdol3IH9qvJRJtozX8o=;
        b=Z48MhJL7VfwuFAWXZq09WVaj4Mbyl6wGaxBSmmcyMqqVJ0gSOB3dEWBmkm2WGNHEzv
         JBQ8vqmNCGuX03liKF+nfx5KDnRkTQ/VKyDq+uPi0WE81gK6CeDeO12Mg0uydEUqqynj
         76bFqVGdgNdL9uFp/LCEvqgx1biJdg9EcJ9QzVZfZ28iyxLDY8b7GQ7SoKU/F/NPuOAF
         7ZmdOHH9NDsRjAL9q79Pod8sl0Bc3LKlDz3DpHttrErKvEv5K0CORWI6xVdjwj8U/DZL
         BgeuLu1P/p0SLh9ltPlIat7ZucvizGPCsgBvzqZX6JD9R7LWFaULueu/ULPYDYsXpRQH
         DMYQ==
X-Gm-Message-State: AFqh2kpDmUxoCK6ct+yYecKUCnnbg5zxJTiDG9TuA+tNkLhHYOx38CSx
        FE8OjFuj8Xa//SEm266UHfAXglpuywwmOkbI
X-Google-Smtp-Source: AMrXdXt1w/LVgSXfDkHFXZl/xC1VdkFrMTumyZOJOrOWd728r2/b0gEtPJC3NQXZhQ0t8Pb2OVyiOg==
X-Received: by 2002:a5d:5a85:0:b0:2bd:f5df:2689 with SMTP id bp5-20020a5d5a85000000b002bdf5df2689mr5906564wrb.47.1674038102235;
        Wed, 18 Jan 2023 02:35:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm10076731wrb.13.2023.01.18.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:35:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 1/6] arm64: dts: qcom: sdm845-db845c: add generic sound compatible
Date:   Wed, 18 Jan 2023 11:34:53 +0100
Message-Id: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use generic sound card fallback compatible, because the device is
actually fully compatible with the generic one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch

Bindings: https://lore.kernel.org/alsa-devel/20230118101542.96705-1-krzysztof.kozlowski@linaro.org/T/#t
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 0d935c928148..4833e89affc2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -704,7 +704,7 @@ &sdhc_2 {
 };
 
 &sound {
-	compatible = "qcom,db845c-sndcard";
+	compatible = "qcom,db845c-sndcard", "qcom,sdm845-sndcard";
 	pinctrl-0 = <&quat_mi2s_active
 			 &quat_mi2s_sd0_active
 			 &quat_mi2s_sd1_active
-- 
2.34.1

