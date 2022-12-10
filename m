Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA664908B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLJUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLJUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:04:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A94714028
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:04:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so12199852lfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI0a0GEkM+OEMminGresAON2Q/s+/NfY86fzKXWDTVw=;
        b=morpBfXAf66+6TMe3djDbtuV9+H4QQE2nu/zabEQ3yhmBHe+zwSaaq2svVix8I7WTe
         mEaiiBlObLnTB8VjMFjpWlcI64j2iEdr/03DSgNd7c7gvb4ezZH/jWUOG30jL5BGRuiZ
         RuLn4acdY3NsnKU2GFFq/dpljzLK9SFkFzfWYgW+7VBRQjOjsaeN4j6oxaC0tdibaHVk
         w/7y7dN/UHUJIMxxJGsnEmLe9C+y54rqroF5rON0Eze6hnRFXYTzbmnDkNrgRt4qYizX
         sF4BuxzwlZdYEq/BJFyJpxRgKb/jB8qWOpWpMNb8qBpSoy4Yzys9/smvCQNm1h4teRBh
         cWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI0a0GEkM+OEMminGresAON2Q/s+/NfY86fzKXWDTVw=;
        b=kCBL22dM48dhPq8BJTKsKr7Z8bDYbFV4sFemWqmIBS1LuBJmR8CPqGa8vZcHna8A3h
         6A6uQYZAMCgAjUQDqkTl2NOXfDxtgJwA0H8/4i9Ycx+dpxl3LYMLDEWlcQUiQzgIgAw/
         Te4tX3piABsyzdc0OLX6cwdZgNhvE7GoQtYJYYJMx2du9vrymYJG24DxodERIu/Z5m1V
         XT/SRmLDqf9oKTK73/UTrwWuFfUaREncewinStpPBKzVtY5y6BeLwo93zceGPprMCItv
         O/pDnbmAksmlAB6IG1/Gmrccu+iOlSa39+HgJijgNGBwR0jktmkNITfOc3w0a+0fGpZJ
         l6cQ==
X-Gm-Message-State: ANoB5plLdIS15Sst+6/OUAw9XfJEB5cn5rjGhGDRijIzXg9/sFwskw1Y
        KcWBzRNOZ7eXVWc09qW2ZRPLZQ==
X-Google-Smtp-Source: AA0mqf7OsBhvRPVML+WArCnUjkiZQbo4rQEkWkqy4vj/GGNZ9OUyzx0/x4iggr1aSaKiyspbiRnFmA==
X-Received: by 2002:a05:6512:261d:b0:4b5:d:efb2 with SMTP id bt29-20020a056512261d00b004b5000defb2mr3978255lfb.14.1670702657093;
        Sat, 10 Dec 2022 12:04:17 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004b4f1ea713csm839628lfp.73.2022.12.10.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:04:16 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: msm8996: Add additional A2NoC clocks
Date:   Sat, 10 Dec 2022 21:03:53 +0100
Message-Id: <20221210200353.418391-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210200353.418391-1-konrad.dybcio@linaro.org>
References: <20221210200353.418391-1-konrad.dybcio@linaro.org>
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

On eMMC devices, the UFS clocks aren't started in the bootloader (or well,
at least it should not be, as that would just leak power..), which results
in platform reboots when trying to access the unclocked UFS hardware,
which unfortunately happens on each and every boot, as interconnect calls
sync_state and goes over each and every path.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 95dc10a1deb2..616b5b1b1fb0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -826,9 +826,11 @@ a2noc: interconnect@583000 {
 			compatible = "qcom,msm8996-a2noc";
 			reg = <0x00583000 0x7000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
+			clock-names = "bus", "bus_a", "aggre2_ufs_axi", "ufs_axi";
 			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				 <&gcc GCC_UFS_AXI_CLK>;
 		};
 
 		mnoc: interconnect@5a4000 {
-- 
2.38.1

