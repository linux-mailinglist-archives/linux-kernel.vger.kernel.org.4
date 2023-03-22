Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399EA6C52D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCVRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCVRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:41:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD662315
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so76051757edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679506918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpWxR/gTt4DLuz+zmuazaeln3zBoZsZPPWaZcqn2/bQ=;
        b=nd5y78/mszFE6ancuRU8iTYbEtBIvT/jLdeUqXlkJBCFeeZsH1dBOQvkRK1TXW/nFs
         QeuRGhwocVHM98F2WfBlJ1QBZq2gMNKa9mSvmOZgsjITS1eFwl3glMaZf6cisQGBKoYL
         75+0eppPO85erkmXdJKnU4VYFH4nC6+JNDY/wvgrT9Cx93dx1eC6yw+z+yl0C9n6PnuV
         NzsJrfetQ8bcr4BM4DcZ4N51GR+7a5eeSpZ7TPwk7h7Y9Ctjgb8cn3IiStBgWiy5cvX0
         AXnsCQCDHwzIPZNjDc7O+TeNNif8rVqsQTJNhgslxLuRzUMGljiNDVzYalIO/HhxXJjM
         oYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpWxR/gTt4DLuz+zmuazaeln3zBoZsZPPWaZcqn2/bQ=;
        b=OR2i6oT/EldctYndCX7lXCkXoCxQLNNBhMQCaOhafESE+4pv1Eyl09I9xqUSDn4N30
         ocLGGrmiyTDvXc/v7qyJVAGanjMaqRiMUjYE7tCsoXGvEirYWHiL1bKakIDpYKv5zg1S
         kNcylzqECxNI8AZujllKGDXq+IOVTtW6RdW12EHPVFsIefTdgsjEHRjsRqCg+ZHX7Nqk
         tRKdqGIonCgOrEC5kYVcVK09LtuBMrALLTRzVSGNzuCUrLHNBo+SPJvHY3ZT5/syQlKL
         qAE6KYEGIsFgtEHCqlbbry0WlguX5wWBD3PdDaZULX1Ij1Cs/MTdvBKDSDO1Dpt3zcOh
         hVZw==
X-Gm-Message-State: AO0yUKVTthnjukxGTaYKc7pxNZsSj3+qiGn+7BEpqVi6uo65okJXq2z1
        Gz3cDBDy5kQFfWZUD7litl7U/w==
X-Google-Smtp-Source: AK7set9kuEl2lv2FQbyfUPXtW6efYZDecgF0km47C9M/H4GkcoaCgOcq8yFSJdYOkm2oA7tB1US15w==
X-Received: by 2002:a17:906:f0c1:b0:931:6641:9897 with SMTP id dk1-20020a170906f0c100b0093166419897mr7537242ejb.44.1679506918201;
        Wed, 22 Mar 2023 10:41:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm7548088ejc.29.2023.03.22.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:41:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/11] arm64: dts: qcom: sdm630: add compatible fallback to mailbox
Date:   Wed, 22 Mar 2023 18:41:43 +0100
Message-Id: <20230322174148.810938-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM630 mailbox is compatible with MSM8994.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0..e9169876da6f 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2268,7 +2268,8 @@ gnoc: interconnect@17900000 {
 		};
 
 		apcs_glb: mailbox@17911000 {
-			compatible = "qcom,sdm660-apcs-hmss-global";
+			compatible = "qcom,sdm660-apcs-hmss-global",
+				     "qcom,msm8994-apcs-kpss-global";
 			reg = <0x17911000 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

