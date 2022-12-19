Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73636511F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLSScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiLSSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:31:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57513F92
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:31:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u5so9946950pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=ga502bOhWRtauXqhYFIN4d5IGCYE3moONP/VI56NzvMKYIF1u13sEGcmQtV4EcnIWP
         vFMkPvBbRcYXSlVUj/dtbcDLd7cUD5MUUMb6qRJBR1wTsmXIGEZw+qLB2LzAx+TX/c3a
         VxjHJ0dHvClPk4UPqC5o1DG3hhiF9JVxSLJxHCd6l8OK2hG19cynwaw/75T25RgYkRsM
         Bi6lHWjVheVtUXSlv0bCM1/NZR4AOcgcJoiqz+sgmmuoP6GT9TRzYxCpnx9RQBjQrHuL
         DZVNk7+yKfg+JVr3gA0/yz3W+5PJDWigUGvAx3Nq5emGjIzGKSpE/rM147wYa/tk4BrN
         F32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=PW7wFyCk9ktKfqfGW1D1/bZ3EQbPMQdJvuigqFJhxBw+f7SwWcHwHf8iW7URhhmR1e
         3h/5Y2c7XTSU40u08ahdXNGIG1k+EbWT7JDFgIJ2uHq3RuPzzE9z83kDWL/I+m1BLO7K
         BEJRmYB9gaLS7HiF6QvRKmQymJBqtMBKDYP3nlhiSi967QlCGbfLiHPTgkHfHZtBqJCO
         QMDITjupjrbmI2iXGhPv8f7C/fOpSNcE9c98yO2o6TW/yyAemO8yUGjAyJ+JPgb13LsU
         ymzEi0tICDlTujxu4qpixKTDHY9O7DXFn0EPy/R/s5/77hNv+wA9A/gyWlMDL9s5Neug
         sBVw==
X-Gm-Message-State: ANoB5plLBLVq7QE/nC1oPuwwoG+YMlaVKzXF+efjj5VT+fudsZcOGxXy
        mQaNtxE5WNMQxdOEBdwAQFFh
X-Google-Smtp-Source: AA0mqf51DRME4KIfhB3G27VvO2P1fI6ju/rftgyBR1c1ALoMHerqGxr7crrCwFKiZPlgceg9JCrAYg==
X-Received: by 2002:a17:902:bd44:b0:18f:9b12:35b5 with SMTP id b4-20020a170902bd4400b0018f9b1235b5mr32051121plx.13.1671474670268;
        Mon, 19 Dec 2022 10:31:10 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 08/15] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Mon, 19 Dec 2022 23:59:51 +0530
Message-Id: <20221219182958.476231-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
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

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f3..d1b65fb3f3f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3545,8 +3545,11 @@ usb_1_dwc3: usb@a600000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8250-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_2: usb@a8f8800 {
-- 
2.25.1

