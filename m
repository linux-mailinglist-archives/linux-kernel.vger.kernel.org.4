Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2315A6AB706
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCFH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCFH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:26:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91001E9E4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:26:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec29so3655167edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 23:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678087598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU/N2SZuHfp40jH83jpd6W5fBvF0TFtfLtqFPBncCHU=;
        b=IvRC69OqO80YWWxd+2ZG1Wl3b8cSTV2LvUQMot4vby8psEzDMuqCBUjC/4nmaYDz2F
         e7C3QCqB1b2hWolvI1LhEB76WgvLNsjIX91ngrA7fjD+QJjQbDVGoqBxrE+HbQu8PkaR
         hWfDpCe6SUoIxbNumtDKkzZZRh3ne/Ao5MhEOxm7n27laPduKZNvg9vg97INx9dxKC1o
         58xwi9jpij/bppIv/OTxpnNnOwlq0j0EETP5BfUCrnCgPJ2blK+XTB6+YnaEWgAFhqZV
         nUpqTYr9Wx0Cvu0X4EbYSyyUxd4kMzo/Yixn267cuRGsc1gOQUvhaw/JGLWGCYUM5+iG
         gCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678087598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU/N2SZuHfp40jH83jpd6W5fBvF0TFtfLtqFPBncCHU=;
        b=tkV4jMJuGO4NhwIVAidZWtiHxvcyZkNweBKf7dN4IT8Pf+pVQu+sDdpdXEZgJW7G5J
         +7agzAw61v+UqDwkRjz6o7LlDQx2NKw7c/SchVSU91wfoBWDCNfc9lU3SHM28RBGxfpg
         owAVBN0J+KvTjIXt0n2/PqoknA9Y7lfN+Dk6EhWBcYbi4lJrYzcHh/6jzq/TNJkHZ/KY
         2XZOWzUCt4gF17INGXCqIEqzytJQcwdJC2MGEmoKlCTF6w7MiaWdMpuN+JW2TnNrTNGX
         oJeF0ASgLxJEusQcD6ug6nu3URDlwQ1V1tjwDwELmazVVNEF1uEcdUEwEBYTwaHdVFif
         0iOQ==
X-Gm-Message-State: AO0yUKXgyuEmLbw581dfnZXGmm3Xy+5Vn/OyZJB8HPjt12NxHX99ni3x
        NmHpQ5715m44KT21sNx58SkEgg==
X-Google-Smtp-Source: AK7set9UWU34DneSo3jycrjlfyMHWDeqxBV0XlGd3ZRAVIFkeGm10o/WbZz70NiAEcMlulT3RS3Gsg==
X-Received: by 2002:a17:906:da82:b0:88f:9f5e:f40 with SMTP id xh2-20020a170906da8200b0088f9f5e0f40mr14276040ejb.68.1678087598216;
        Sun, 05 Mar 2023 23:26:38 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id t26-20020a50d71a000000b004be774e4587sm4652020edi.80.2023.03.05.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 23:26:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: sdx55: add dedicated SDX55 TCSR compatible
Date:   Mon,  6 Mar 2023 08:26:18 +0100
Message-Id: <20230306072618.10770-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
References: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
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

syscon should not be used alone as compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index df7303c5c843..72de632b5265 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -385,7 +385,7 @@ tcsr_mutex: hwlock@1f40000 {
 		};
 
 		tcsr: syscon@1fcb000 {
-			compatible = "syscon";
+			compatible = "qcom,sdx55-tcsr", "syscon";
 			reg = <0x01fc0000 0x1000>;
 		};
 
-- 
2.34.1

