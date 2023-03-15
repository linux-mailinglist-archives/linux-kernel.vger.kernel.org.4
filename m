Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E556BB5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjCOOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjCOOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:11:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B140664EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y20so1898694lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqvdp07J1HQLjVavRExVgoZODvgCx91QmPizlq7Sg94=;
        b=wj+H/ZKxHvYweQFezs3ZKdnU8Q1gnb+TlnRTdhbCS3/LlQz369hyBlu1fFt175i7OC
         YO5DOErPxyjDcbUHr8DmM667zEvIa4IjoQPsWv4YTCmV2hXdEftwos3ix8XuqyiaCE4n
         qAJUGHZjbn0IDuFFEbYva1RV+Y7AkZ0KU+18iEcyLwKJR0+2ZJYTS1UW69k4My0UBfEy
         9iJ103JTQrR2uStCp2mwtX8dQkkJK/Lc/mYaAKk7LVaHCneST7dbtMx4x2FUbVt+INCD
         5Y6Gvil/+umOg+RwmKGQDfeDJ0+Wb5qYYf8nbZk4hbMsAYyJoX7luVW/re5UxATjINFG
         C/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqvdp07J1HQLjVavRExVgoZODvgCx91QmPizlq7Sg94=;
        b=vqWIk6TI5qqRtQdr4sLgIkEgrzr6cVuwewyzGSOJSf/Cpn/NX+bZLRJmIwXuANgxW2
         6hQRHpuxUrBGDA+lHrjiBVw3AmBpQefh15OmSaAPMgVNQTrPe7kkbMaDewEScJlqR1RZ
         uymHBe+uga9TjKMIz1bJGDgWxprEQuQ8V+OxvA9N8SXm5OMGbyDe96AfboM/e1bqbUY0
         aW4Y5e6FRA795udOJByOEbla97vUAXivtfVqoe5w7vSHKOBrzZEH+rgr39XnEnSd016c
         GjEPgi7PclDnR9hdtFFmmx/da+m2Jt3YKLk1/umy2SGyj/h5qUXWvneZ4TKUIBevfxY6
         hxbQ==
X-Gm-Message-State: AO0yUKWuA6xVFJjoNuIpw7DbOPYQQnnMQmiU8VgniOqmwy8TExXfmuAn
        ng/zq3nsY9FWeqgn793wSR7Nrg==
X-Google-Smtp-Source: AK7set+AHcT5QASEAJR/bf5kUGeTcpFKhBI86DCMSOaTk2/DhlWMFk8OmJN0q1mf+td2wEsxXOkwdA==
X-Received: by 2002:a19:f511:0:b0:4e1:b880:ba1c with SMTP id j17-20020a19f511000000b004e1b880ba1cmr1640962lfb.9.1678889494617;
        Wed, 15 Mar 2023 07:11:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 15:11:23 +0100
Subject: [PATCH v3 5/7] arm64: dts: qcom: sc8280xp: Use the correct BWMON
 fallback compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v3-5-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=857;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1DZfsRNhr1OAkCF3p7xVoJYWjPDaei4Vd+17mLHBDz0=;
 b=sGJ1D/caceEmjC9PDr1xTNrAWwLRHMU5A9DG7ARV3xwKMnXuVMIbV8nLuYpvCG6AFeE54Mr8C0Fq
 /rrLrJ1ZCJkkEg1yd++oIKpkXcib945I6leZTcr+xO++XLClL0Dl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct fallback compatible for the BWMONv4 with merged global and
monitor register spaces.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..131b99bfe771 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2946,7 +2946,7 @@ opp-12 {
 		};
 
 		pmu@90b6400 {
-			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,msm8998-bwmon";
+			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,sdm845-bwmon";
 			reg = <0 0x090b6400 0 0x600>;
 
 			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.39.2

