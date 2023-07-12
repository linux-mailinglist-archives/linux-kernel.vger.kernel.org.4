Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC075047B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGLKdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGLKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:33:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BB1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:33:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so3369105b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689157993; x=1691749993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6D9impE6kDqR+MOUS2gWXvCWxf9bLcZG7WLF2GZCOw=;
        b=yPTF5eeyltGNe4OPQRL0FXXtPNN5FOKzWo+QTfOhBuG6vj+IzAgHsyligmMB5TG85d
         Bg4RfJVVBq2qLd3zmDw5qOMjsFTN+E6kFqAYrRuGuARxTkhROU/NvEYTBsLXrYkWMMkl
         dRv1hRSO6T2cCF5qNS/4XVO7nVlxIxTKxUBK9NOcEKjCWIkWtivNTfGuX22mynePRCDs
         sC4M7+kwGCQ+GRCRb6UIqibZ7YMrjjyGVO/Q6VGtINk7QOBlRl0duveiyotDwfnbm9uF
         5yUigbVoA525pApabMvXAuzAuG5iKYjPyoKq1ygzzXpeXkdruD9JTxmFpuNE7rBCbfAD
         DSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157993; x=1691749993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6D9impE6kDqR+MOUS2gWXvCWxf9bLcZG7WLF2GZCOw=;
        b=bN9HLQG2Cmmbus7wIOPb4dIcIfpkawW8OhwxycY4U8qFtpLxRl+5L4/2zZQvPSUKhq
         cyUlqMgQfnCXvbjqxx7z798pc+7ZzJNGOTyDOwMScJhrHu6NQcLvcWsZ9zpUeQQRBzYc
         rKE3OYHYR/bkHG7Ejf6CLaVqhQQU1Kr/MF952iRTnfR2sg6pYh5PXwKOv2IT980N9FdG
         HqFf8V7T/P1s8C5cu391HrN3VspSmYrtrGSNgQQcq4zn+NCmsJsrbD+5tkRqb+SzHOKP
         51sBoQ2llU6BPTCE91VGHu4OiwZ8CgocEDSoNQ54rWLf9HPnzvQFcQGbBL61jaJYhWgX
         MReQ==
X-Gm-Message-State: ABy/qLaoG0ZguAR4gPLgPCMeHHGn5Hcs1wOvSta666UiXCaDoRgWAA69
        Au6FX2HbfLu+6gcc4RDcTYyz
X-Google-Smtp-Source: APBJJlHf30dmK26GqEO/H914oHTcdhTgS5gtZuQ3zdReK1fttlWO6njYB51WvmaPHzSHv4p3myxrjA==
X-Received: by 2002:a05:6a20:7daa:b0:132:79da:385a with SMTP id v42-20020a056a207daa00b0013279da385amr3313155pzj.23.1689157993659;
        Wed, 12 Jul 2023 03:33:13 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:33:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/14] arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
Date:   Wed, 12 Jul 2023 16:01:58 +0530
Message-Id: <20230712103213.101770-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC and it's GDSCs are under the RPMh CX power domain. So let's add the
missing RPMh power domain to the GCC node.

Fixes: 6d4cf750d03a ("arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP")
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 02a6ea0b8b2c..9ed74bf72d05 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1207,6 +1207,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
-- 
2.25.1

