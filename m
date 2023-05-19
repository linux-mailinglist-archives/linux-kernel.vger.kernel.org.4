Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCDD70A1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjESVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjESVsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:48:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B71B5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:48:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3491609fso802374b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532929; x=1687124929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRz4nt24YoTgBoEZH5nQGl99Iug5W32/X3YqAbF3Tjg=;
        b=M5qZR4JM0bZqUzJQPC+1FWw1qHJWVn6H8xdlxkrYVAAswm8AYAsYLNXvOTLAnu3dh7
         vFaaM/eb3pPNBfOi4OT6yuBXUgZGFkZf6Z1l9Q6pbpInOAaJHH0QKBlReHQXhPVUNvpb
         SkBIGtZIbrAM7Fyyar2ZytHkCDw/XjoDRG7lChn3oXvDpWSIq323IUH72Ry2TQfRT5Hf
         YsBf5Ww74CrZKHcmwzYjgJ9e8zgVCX0hY660ETc1eDD1FWJO8jBquOyNw/83Z90tjJQ1
         AlVoEb/OCJYmwjf6VC2i4fegsdbojsV8sh7mqPfwl+Co59j0N7BPVnLNKqDG/bOr27lk
         hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532929; x=1687124929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRz4nt24YoTgBoEZH5nQGl99Iug5W32/X3YqAbF3Tjg=;
        b=FutHUVq/tm0srXv86RhsOfNQMGpuStwYOS0846lgSfebm+ZSousWFV8ubjnXtORgmE
         5b2sjP+AGydigQO6kjCPHc4OlhxjCSaYUfKwRcS9zfLRh5I55XTfIA3rgiX7pdd+heIO
         ZOQdbL4RGBJrnQU6Qs6OVB+hBwkOiHNiFujkOSduHNgq6YeMGdNsdnjs7zApQ/fglMKO
         z6Qa7ViglcHixQQGWzuSqlx25WHNT3VGZFejfEn6qx28eC93TaaP8DA7CwTi38nfaZOe
         rsNc99JsBDQOnzQJDwj3AWXv2OYMV/IKdoPfQPzaOxNUVDIDWl1VsqcCfNc0BCEzqI+L
         gywQ==
X-Gm-Message-State: AC+VfDw5Q7iulIAp1Wdwh64pTeKin7Z/2TnAGuxvqPzBy80/KRug9mqH
        l0yRFzsMzq58F7NCjmkLEUxVFw==
X-Google-Smtp-Source: ACHHUZ65tMdVhoCNqi9JkinRNUFIzI5t62KLUoxk97wjxXxoakWh/FqGsyx3YOYaxbUBxtBfTDWKRQ==
X-Received: by 2002:a05:6a00:14c4:b0:63b:5496:7af5 with SMTP id w4-20020a056a0014c400b0063b54967af5mr4749990pfu.1.1684532929470;
        Fri, 19 May 2023 14:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:48:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v7 03/11] arm64: dts: qcom: sdm8550: Fix the BAM DMA engine compatible string
Date:   Sat, 20 May 2023 03:18:05 +0530
Message-Id: <20230519214813.2593271-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation, Qualcomm SM8550 SoC supports BAM DMA
engine v1.7.4, so use the correct compatible strings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..e477ea391e93 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1839,7 +1839,7 @@ pcie1_phy: phy@1c0e000 {
 		};
 
 		cryptobam: dma-controller@1dc4000 {
-			compatible = "qcom,bam-v1.7.0";
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x28000>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-- 
2.38.1

