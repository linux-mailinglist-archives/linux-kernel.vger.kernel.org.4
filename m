Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1A690DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjBIP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjBIP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:58:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB4305E5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:58:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j23so2300242wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFLfhaQ4iwqIS27WBBe1IT0dnfELwqgDx52SPdNJ0CU=;
        b=mAcJwDv3DH4+UIqM7xycDueELLyoKt6zwnmeHFnmwloVob7CaS/3tx86GobzPO8PWS
         s2UNB7WoewXRRgj5QgzbdLxbER8die9x3xaE08/NZSd4a/wIk4qYMH/Xa17T3/Nw/wib
         gIhyq5MBN0a0btnVVthCZsG/dCGVAkarJddxV9UnwhuC5pw+DtHc/f0jd+S3BdQY+Ahl
         glsQnr1EWRZ7MMAUi00DoeABr8ZedPuYMlrQFQwrgDgQJ94nPjsexlgdJ5HghVmYW+A+
         j4TBRnbKgM/M4tjX/0lJlWyUot3ymrM26wNJRN5ysMGvZ1KJjT0rrvGtXqt8FHLZz9II
         wl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFLfhaQ4iwqIS27WBBe1IT0dnfELwqgDx52SPdNJ0CU=;
        b=HeTZ2QkRWkrZYNYYJW2kZwHK3uAdZhGz9IACVRbInrRFSpH+3eMrhHRnDF+z2nEJYZ
         ACuusyFhrixa8L3JiFqUfPS2OK3vjQzPBHJrvypTIahySVYyDs7uLnyl0tkhZwkd2nhy
         VqBQFWHBDqMcOzZxbJ02t7Jrk5llxESPqSxkqF4aMBY29JOftSNhEQdfi7s5LKN9JYAW
         LT6aw9StJ5FQ16rgYl6n5xZjctxrZmyqYSuJdBeGhgOlnuFdQp+T34glIlScUZA6AYqk
         Lp8q9pTgkYYhtWU1sFpR/g5YtMyVz7O6bRINbrS8UHnPrRBwd2mefQpXeVMNnIWmC1/9
         bYlA==
X-Gm-Message-State: AO0yUKXqV9dv9EpzAA9QueGPpPJi3B3e7dIN34XSbCSSawt3U5Re6SA4
        6XpzLnz5tPH6QjSwcsunZ1U9gg==
X-Google-Smtp-Source: AK7set81BcIxNdQXc1rpl5C1gjuvRL67C9FprLDdh/YRs2TfVNTy8WyRyiQJizqcSXwW+f3QJPo38w==
X-Received: by 2002:adf:fcc8:0:b0:2c4:965:1a58 with SMTP id f8-20020adffcc8000000b002c409651a58mr3112886wrs.67.1675958315742;
        Thu, 09 Feb 2023 07:58:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dd1c45a7b0sm2381583wms.23.2023.02.09.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:58:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm6115: bring back missing disable for spi@4a94000
Date:   Thu,  9 Feb 2023 16:58:31 +0100
Message-Id: <20230209155831.100066-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

spi@4a94000 should stay disabled in SoC DTSI and only enabled by
specific boards.

Fixes: 1d0d6a6e6f6b ("arm64: dts: qcom: sm6115: Add geni debug uart node for qup0")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 3eccfb8c16ce..39a63ff46fc1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1001,6 +1001,7 @@ spi5: spi@4a94000 {
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				status = "disabled";
 			};
 		};
 
-- 
2.34.1

