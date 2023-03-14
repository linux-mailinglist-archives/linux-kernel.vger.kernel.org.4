Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AA6B8A93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCNFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCNFiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:38:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10180E20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:38:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i5so15436122pla.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI19SzWU19Jvwkg3ef2zRaEcka9BD7PAMWjZH4lQqmU=;
        b=VehbRZ9HI2q25B4xg7E8Jfa/ygNAp+s0KAwxKx+kKk4J4Vl3IQB7eaQMNY10EVQ7sf
         N+PnFR8ojSrT36Tji5CIyMz7uzVRX81HaLIewO8I/jL5XdAUTtScqS/MbScm1f2eFCIY
         Al0ZYjLlnURB8MR+kWkchaULqd3u4Z3SV3kyfxHR5ptJI/LuJ/BPij+UAlt+y6thDUNz
         imqZcK3EEnImSqiY2HXUHTSAHm5SVeGTvMLW/OGdOBaHikByZVPH0hKWWBwoi8O8L4bh
         U2KDwF/CQkphEGgN0cqVb4eDmwdOkDn1pT+P8tAain2jdbCtuC+VKWcMabZr68dbr+yI
         PfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI19SzWU19Jvwkg3ef2zRaEcka9BD7PAMWjZH4lQqmU=;
        b=lBdmiFb2wOMR1xE12hUNjuuxk/p6/xe1Bhb+/S+biQje43YMQ/qAI71V2MAczVyMan
         E5mE4i03p/NzESMlKJiUjzODDWFLVWNxmR9uYO5ghQOhveirzR3J1mYGTpZKu+9wJeJH
         j+fV4t0GCuCXM5O9Xyncsai5uHPQ+QTrtLNVPXWPH6I75yxUnIzVmwgrdKbDFAFpztQr
         1P7QyrWpCTzHKs2nm/2ndeFbeLrEElgN1RYqTmeRbFj3YIGbbKSgYGkeiylq+UNcJhq0
         lKv0QfJIuPLFIBjgXWjdJH35/rkJbpXNW+dlLGsooPgOj5/9BT/lbtfGRlskD6bhWlzZ
         cizg==
X-Gm-Message-State: AO0yUKWc32yI5LVJAIOy2zFcoeqUgWnkU+Ux7Eetyvqt9MIRKFyN9Zuy
        2l7zZoGFgTZk5sFdc5EycJsZ
X-Google-Smtp-Source: AK7set/eXfChg5Yn1tYaNg26DAfAkIgkEqbtc6Wi/ANEtvdhyowyjk3Djb+lMgwKHQnDaSM7DRmbeQ==
X-Received: by 2002:a17:90b:4a04:b0:233:d10f:5236 with SMTP id kk4-20020a17090b4a0400b00233d10f5236mr38003944pjb.28.1678772285127;
        Mon, 13 Mar 2023 22:38:05 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:38:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 06/13] arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:18 +0530
Message-Id: <20230314053725.13623-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..f5262ac64a36 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2983,8 +2983,14 @@ opp-6 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8280xp-llcc";
-			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
+			      <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc4_base", "llcc5_base",
+				    "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

