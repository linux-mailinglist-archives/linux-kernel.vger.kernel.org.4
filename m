Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3C6D75A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjDEHcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjDEHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:32:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA755B83
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so38680487pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/RYbIoQQSZn/Ts++Mp2c4kDKlRAoOOYD0ApgKEdtIA=;
        b=lyhGsVY1vQFoMeLY+50TIZRwxNd5jChMWgIvDu3C/FldFAKe1fJ3ClrarWz8z9nWwj
         rL5UqjtZBxxCcSYz+YpSv8XfckdvfPGuqxxv5Dnd3uFT0Uq5WdtOkCo1GrFWzXItJteh
         yd8ms6/Kj0pwZ+bBaHWS4ip19Zv8Kalz7cmZy6y4cmhqV8VNnV6/VDJL1L94ki/j/Geg
         fzRmn83aQt/RV70zDlHcdmybcbFmMw4bikjMzjXqvnsdyZDPj4O00ZyFNEnHCT5itJ0l
         JPBFV33WnRsYYVnGNa/hjn9UyT9tzr8BzVatYwFpk4M4c6Kq3IDNfOKLGctQzt2s+XoV
         zV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/RYbIoQQSZn/Ts++Mp2c4kDKlRAoOOYD0ApgKEdtIA=;
        b=QVU4I6lScWzDDgT3pPyPMuxdyfV7wXdvmnrJbe6JmJfeWMPVJ1hInpGt7lwPtbIM+S
         XO/8/tIR/tlFNRCREQsfum/rsgwtoS/AN/naqcgIimkHnh/igJaMvOMFuBMsx2beW2/k
         ZsAtgm60JauJQqT7XR4ItaEns5fJaycWA98ab6bqlYwR1K7UOGX6MeWw8TP/kY5MU2Pe
         4ewFvCiJpUEqiUShr9/jC6/Zhk4hXXZS/53Qa16c9E7kM+DiE7/VQ/l56vgppUQevZ5/
         mnOJeYW15FYWq+GBokpMq1qI6g74DeLmW9MPGLo91Yla2uIJXdwVCcBGjfYx7XxsvABE
         y/aA==
X-Gm-Message-State: AAQBX9fcjclQUA0RUHjCDbfqk0ssgyGv6pSQlOdw6ck7zgYb2Id+vyR0
        YFkHSjA1bRGlDjUrfPvLxkdBaw==
X-Google-Smtp-Source: AKy350Ys6drDPHCet9DtT/cKfLm2OOTPb2BT5ByEy4pWcuzBZvtfJ89SK62yA4t77q7SN4N4aeChuw==
X-Received: by 2002:a05:6a20:6690:b0:d9:3440:9a26 with SMTP id o16-20020a056a20669000b000d934409a26mr5155435pzh.20.1680679898522;
        Wed, 05 Apr 2023 00:31:38 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:31:38 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine support
Date:   Wed,  5 Apr 2023 12:58:35 +0530
Message-Id: <20230405072836.1690248-11-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8350.dtsi'.

Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
[Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 7fbc288eca58..d0677d9076a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1730,6 +1730,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8350-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm8350-ipa";
 
-- 
2.38.1

