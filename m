Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4D67768A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAWInT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAWInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:43:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D9193E1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10028834wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Yz4ZDu0mhl5KPN2z6Y4aarA8Bhnf1jEGoG09a//y8=;
        b=jGCU5Z5/vXpjPSDf60ve9bcSmYJtrvrKZJBERfFcOrKEtlRpPItjU4E6SCT1m9FelE
         plFxbMdJ/3YzfCaUza/6ZIi/yxXGrHjol0TUqMgXDGlHxCUdAY1ymfwiuhNiozISMxGy
         7Q062gR8mKXB17O7QQFw8IrD6glb6TsEDHga+KVFbNp0nfsR3vX2JrrKr6ZtzQkF3l1d
         cYgB1EFuyVO09R65dqRIsd8DNnT063rX2e1sGva4xNEdqr3HXkoBI2ptz1cazg6iyIFE
         ieGHB8NBMwAoyMEmHKC4+p7TsLfypeA5lLc3Q8ixS09uZNlB4zCGGBr9BLeOjSgEq/d1
         fy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Yz4ZDu0mhl5KPN2z6Y4aarA8Bhnf1jEGoG09a//y8=;
        b=atM7Hax6cNLhVcTKJlxx8+dLxE8K157AKAYEaIEWtQmdlosIVCnt10gWtIXV5xBP+X
         WZTJL+xriHWBrvT+V0zDi6I1yr0+idF2+ZmfW/TiQYPEMX2s4KAuUWPxfrxbQpeoKqST
         +9yzj8Uq5V12YD3auln43oRSXFPGgCz4NCg5Hgkm1Qp52QpuI+iW6MBDN99yjZtEfaLn
         Ubi0SVs6AWi2O1AkyHiH9LZQogDXgSj5LV9A9uQku4vfDP4Kf/ZCukturN5VrwRKBQ8+
         pXxm6PYwIbGJEPQQZEkddSNdCAhIpVv2vM/oMCIKzStYh6r87ax6D3OT/GJe6ssDlPj+
         uwBA==
X-Gm-Message-State: AFqh2kqIXoucBig6xYHwV53N2/PO+DI+mV6JV1SYYR66Nlvcf/NokDjK
        Lys8723srnxbd9Ft7lidBG6Mow==
X-Google-Smtp-Source: AMrXdXs1eL6EpA6P5/0bpARWrrm8381CzHWg8eVSlRG9XUUpJcg9hivkGc30aScLffpSH10N2JMMkw==
X-Received: by 2002:a05:600c:1c8e:b0:3d9:e5f9:984c with SMTP id k14-20020a05600c1c8e00b003d9e5f9984cmr23439461wms.2.1674463390029;
        Mon, 23 Jan 2023 00:43:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b003c6b70a4d69sm10974120wms.42.2023.01.23.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:43:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 3/6] arm64: dts: qcom: sdm850-lenovo-yoga: correct sound compatible
Date:   Mon, 23 Jan 2023 09:42:57 +0100
Message-Id: <20230123084300.22353-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
References: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
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

There is dedicated compatible for Lenovo Yoga C630 sound card
(documented in bindings and used by Linux driver), so use it along with
a generic sound card fallback. The device is actually fully compatible
with the generic one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. None

Changes since v1:
1. New patch

Bindings: https://lore.kernel.org/alsa-devel/20230118101542.96705-1-krzysztof.kozlowski@linaro.org/T/#t
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index d9581f4440b3..d55ffd69155e 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -511,7 +511,7 @@ dai@2 {
 };
 
 &sound {
-	compatible = "qcom,db845c-sndcard";
+	compatible = "lenovo,yoga-c630-sndcard", "qcom,sdm845-sndcard";
 	model = "Lenovo-YOGA-C630-13Q50";
 
 	audio-routing =
-- 
2.34.1

