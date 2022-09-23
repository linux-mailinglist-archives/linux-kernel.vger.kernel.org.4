Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E05E7F77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIWQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiIWQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:16:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812E133CBA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 10so1061540lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BjjTPJSzqgBsq5wMwT+ax/tFG7nlLkeOxNbMd9/sTdQ=;
        b=PK9B28z08bhUKIQgM+yNx9Wz2ylSZRVEfmOQsW+mJVB0NcNNX0BhQFpVZGcnS4Wuo7
         XNB70x4DchMy/KTiKyXIkQPPEqyXaKBOKrx3rgNcbkRmGlIqWLMOcHGwQcRw5RDi5Pxd
         Q03XGAWPYkmybfnO6SoChG2NrYyRcpOoz2+eSdYbAyvpgsnxaBNHkch3HRxex1zG0day
         mJt4wtUWnXCCYQQxqZSHDa2mSGDgdJxyb8N/KMxV9bTxkNEnUeteOU+WKj4D1i58zE9t
         axWIQ1VHUPJNnpXmRU99tTSnF0GQZASHrPD0fPybzLhBGDikJO6gQ0wdnVzts6UKXBpg
         hvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BjjTPJSzqgBsq5wMwT+ax/tFG7nlLkeOxNbMd9/sTdQ=;
        b=t4iBwkSvBhz3i2gipgSGOJGcBRXm172+rEnHcDqVgyD+dNa2m9mc40JOWCvrB0E5E6
         Vhhz9gaQFTT07skOL6eEavomJTKUvwftEeI3TPuvtvlGcZvLqeOSK+BDS6fL5NbM6Rte
         B+c/VXXMeWyiqoeiyWvHJUznplR4K7QVH0tYJ4bOPZCIXFGBI3xELol+Qbw/7fB0xB39
         G3aEqY39Qj6gpAe10sQnAb75NXVaJK/z1qmPqfVdHv7rWe8BFFHxtZJY926BKVobLLsj
         mjP5/b5iPiw8DMyfx1CX9bcqHo1lCFTzN9SMV/8D4XgAFMbgs5L5L7q9efTDcsB/30x8
         wtvQ==
X-Gm-Message-State: ACrzQf30M/sxCi1lzlWKTWJnXGNoX7KLkbHecrRRC/gMzKtMJuts15KN
        JrzqOcuPnT5rZUmZitXFta/CvA==
X-Google-Smtp-Source: AMsMyM4yHwMG3ruTD0WvINGKfD4sELqhnfdUFK2QastRqloWz8MQ19+ebjdIznviMQ8MP2sJziO0SA==
X-Received: by 2002:a05:6512:3d17:b0:497:9e34:94f2 with SMTP id d23-20020a0565123d1700b004979e3494f2mr3391894lfv.285.1663949771853;
        Fri, 23 Sep 2022 09:16:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25cc9000000b00492f45cbbfcsm1493491lfq.302.2022.09.23.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:16:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/11] arm64: dts: qcom: sdm845: drop unused slimbus dmas
Date:   Fri, 23 Sep 2022 18:14:47 +0200
Message-Id: <20220923161453.469179-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
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

Bindings document only two DMA channels.  Linux driver also does not use
remaining rx2/tx2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2264bba69f84..1213f78a8b7a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3828,9 +3828,8 @@ slim: slim@171c0000 {
 			reg = <0 0x171c0000 0 0x2c000>;
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 
-			dmas = <&slimbam 3>, <&slimbam 4>,
-				<&slimbam 5>, <&slimbam 6>;
-			dma-names = "rx", "tx", "tx2", "rx2";
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
 
 			iommus = <&apps_smmu 0x1806 0x0>;
 			#address-cells = <1>;
-- 
2.34.1

