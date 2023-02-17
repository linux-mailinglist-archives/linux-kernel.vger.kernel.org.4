Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E569AA29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBQLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBQLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:16:48 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F2B658D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e30so756711ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmoMqnRP5kZAiXq2v7CNcctUC+zodegcmF76bZvlIAw=;
        b=c9ZZv4rfZBZFzWEA/W4nxzpP5BhRgY9jBI02O6onfHggcezzcuWXJYJqtcWCHbm0mT
         8znT6eB/RftHt6F5swPqmxl/ow+oPAX+ATKuAIWxQ+dbIZ8/154bCTfi8ccf7yFAVEfk
         89qRZKPexUTswZ3Uc/WpUy0jPV8Gvf6/YcG5UV7yMPgBlsj/tKja6DNIwal3/nkLZD8W
         pHqLuWe3ctTNUHjyBby4nO5DRH3/I75JCS1yL1I4Rbzhhhz0bGIedRXkHlkVGoKQKiAs
         7f6itx6ijSPdMoMVVMavTvdjc3s5LMwGyeSfYJqAyCOg3/LUBokSI+AHWypbR+kjS7ls
         KF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmoMqnRP5kZAiXq2v7CNcctUC+zodegcmF76bZvlIAw=;
        b=u3rIsufG6vTPci9T/iCXwZJjRP8UeY/87P/3dHOWi+R2qJOznNBuuh6/uRKyg8S1Y3
         CgOeSR6eAC+y2c8jJQ0a2g2l7tzb9Ia6IW9Mp5zT7zZzcNJdIk6rtvgQChwP5+8ktWsS
         v4IjpQcIvJ8hqa69ZbhGvPpQUtb1IHKqcznv8oQO1CCN0hhgUq4evv9ua7IVMPWRcD4N
         36f6oGCxJ4EnmxOr2OlVJTAZCMu+yxi5SXyawsxpByFAw3Quy0QV51Z5+7PsoVygqFeb
         j4sBNIPTVmqe+W+IiLbMwBpSLf9UBIQFIIBso/3WCkIcGhfdarjMEeougIyXnqU0c/el
         JhCQ==
X-Gm-Message-State: AO0yUKX+eIh/megMQnq5Ub2FN8LN1EXZeVD/6rAUsGgSsNT72wUmghi4
        PoibXukQ5csLU5JNQ+thgxG4ug==
X-Google-Smtp-Source: AK7set95lmN1eG8L+WqSsDgz3Maqx82n55DwsLlhEGEwttIK1QfQtsLZabqbklItAavuPKe3Mak4tQ==
X-Received: by 2002:a05:651c:1a06:b0:293:4e4b:bf5a with SMTP id by6-20020a05651c1a0600b002934e4bbf5amr1795039ljb.1.1676632586440;
        Fri, 17 Feb 2023 03:16:26 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:26 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
Date:   Fri, 17 Feb 2023 12:16:12 +0100
Message-Id: <20230217111613.306978-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6a0100822d3d..13f5526d97b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2701,7 +2701,8 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.39.1

