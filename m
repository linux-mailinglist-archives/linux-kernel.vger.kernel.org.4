Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49C627B41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiKNK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiKNK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:59:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5671C10D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:59:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e13so7726297edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JOm5jWN9xRPXYMdaN1ZlzDy4ypsi7edfBi0i6SO7gc=;
        b=nM3NZUpYdwyVsES7N6U6T76ClRffBnOhR6esn088EYMEfqK4S4nIxp1fAylrikCbWI
         xQHBPg2Rdj0+ZiOU/AQ9tKUUSMS5IAtiQYxSyBNtkpMOoSf8dsKQ4AMNjYOMfdJnqktp
         ctDywoTauajyHQKpE3cnnZHrBtmWYz1qLWAt3VqFxEzg9NWO3u+16z8gprxF7a/RU6wc
         Dw02ro4BmJlrQUM4CV4EorLStDPSHmLR2C0ei0t6+sttGMGXwURvfqwzALw3mgdgyYfR
         kXEQp+PCaZzSEtpu9ew9bOsKDSdynuUw4538JLDm3qScBctUuYJBidMka/tLnB6bmunr
         UYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JOm5jWN9xRPXYMdaN1ZlzDy4ypsi7edfBi0i6SO7gc=;
        b=mXMp0gL2n4YyYFAjJamPU+nVu1efCBEKI1d6/aGgbET2/dqxIot+20AULei05495/L
         VcCRnmNelMCri0LvtIA/kbMDeiEnFa0xwGgkQlMkcsSKPN9eSMOFlU/M51+gJT6UTU/w
         ZxbQS801To4IQraLzCsqSD+bqxyzZyP6PAIcLIDb/i6s+94rHf7ORz4AaYhSmaCirgjN
         /yuO6SZXHLF7fKDrwmoD2vrwGNIuS1ZHU8ZHQ+d3Ce3xqLeLrdvS6b3iCjs6ZBkZW+Wn
         idepgHOWtVaX7DxxBxwATpwF3tBcUlYORLjM0lvGdTOv9Q3WysvhS7mLLK2a+hbfuwYV
         G78w==
X-Gm-Message-State: ANoB5pm1faojjlaNdGMbz3fEeyweHqy4QP0LDOgxBmglMmPnP5QtIoGA
        wXGGQ1bKxBBiNd1cTSD0uk+0NQ==
X-Google-Smtp-Source: AA0mqf6ck6sr5VjIV3qZAV1xCIhLtYBdHOoAWciVdevXflpomoSIJedRguqrsRwdWZZgp2KB0xanmg==
X-Received: by 2002:aa7:d497:0:b0:45c:a651:8849 with SMTP id b23-20020aa7d497000000b0045ca6518849mr10643340edr.209.1668423560389;
        Mon, 14 Nov 2022 02:59:20 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b007a4e02e32ffsm4036308ejt.60.2022.11.14.02.59.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:59:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm6375: Add ADSP&CDSP
Date:   Mon, 14 Nov 2022 11:59:12 +0100
Message-Id: <20221114105913.37044-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114105913.37044-1-konrad.dybcio@linaro.org>
References: <20221114105913.37044-1-konrad.dybcio@linaro.org>
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

Add ADSP & CDSP remote processors.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index a904fe5dd9dc..ca2f99333abd 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1358,6 +1358,79 @@ dispcc: clock-controller@5f00000 {
 			#reset-cells = <1>;
 		};
 
+		remoteproc_adsp: remoteproc@a400000 {
+			compatible = "qcom,sm6375-adsp-pas";
+			reg = <0 0x0a400000 0 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6375_VDD_LPI_CX>,
+					<&rpmpd SM6375_VDD_LPI_MX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&pil_adsp_mem>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@b000000 {
+			compatible = "qcom,sm6375-cdsp-pas";
+			reg = <0x0 0x0b000000 0x0 0x100000>;
+
+			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6375_VDDCX>;
+
+			memory-region = <&pil_cdsp_mem>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6375-smmu-500", "arm,mmu-500";
 			reg = <0 0x0c600000 0 0x100000>;
-- 
2.38.1

