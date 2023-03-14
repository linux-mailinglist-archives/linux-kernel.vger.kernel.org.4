Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A206B8A96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCNFif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCNFi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:38:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE695E23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:38:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x11so15395110pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI9fzySm6xkOQqRMGGXIyCN4K6R+WsFVLi5pzorIgXU=;
        b=d5ZQV2ydVI01geYXvAQj5/TBBA2ySilK/UW1mFJZI52HJwmb5qN7pKHiQNdc7IPu5j
         RG9DJpQlvLpxHzOU4kTTbWEEhpUqQuooannpDsO/wLrC550dFviQSQxM4g/5Jd9f4gr2
         VWjsndOhKVT2ZaCBsG2seVjWUOkqD3K7Lhh5BMeHU/Mn8wqGJ3qbSphVuoaMxRteWAbg
         eQYr51+IxLDVnUh5xqK8MMp37SkDMy5UCXMLhKtao1OOi9R1YedrBCwz1ahP1znhCFsk
         DWliHgFf6GSHAHfQdH5Xg/HUNImvg9DE+uEL5YXLuRp37ndPYwPseU45gcUYUC9Cp4cV
         +oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI9fzySm6xkOQqRMGGXIyCN4K6R+WsFVLi5pzorIgXU=;
        b=cSfBOyOctu8KEadya7mdg8qQquzesyNOQklxgZedgv/H6iIb7Cefmb/EisDAV5rIhM
         BMHNe8UhhgqnJ3OoZJKWWOmaBtYG7GMCp6cOddINr6cvfGLk/jQZpN9LU/vAW19zTG/A
         OmX1kNHX664e2W6lYuEJobzV224d9e2BSgm1JLuBiavuqJLZX6c+GrkF7dKFV6artvqo
         09Tj+H8YtAUV1NTSRkxOGhimizDsDopvAZJZC42nS4K8gwqfd4+F8NWvHjjym2J9AhRA
         osOOm/ibAlGoDzNMgcj2xVOPWNncani9XO3Ms8gSQ5yGvTHavkErB98Q6kjWWsuiUeY+
         Y5gw==
X-Gm-Message-State: AO0yUKXDsMv7+L9rQYdGCe/ewyM3TXlVQo9mBHa9G4W6b0+tDO2EeKT1
        8rkrUR8792osopZ8GTDD2Rai
X-Google-Smtp-Source: AK7set/MiYHQ07R6aEpBEs/D7Laob1xfMs4uwXLunFGeuHmxs8lmwVdy3Adj1L89jSeLvQwbtNvdsQ==
X-Received: by 2002:a17:902:d50a:b0:1a0:5652:6168 with SMTP id b10-20020a170902d50a00b001a056526168mr4292773plg.58.1678772289881;
        Mon, 13 Mar 2023 22:38:09 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:38:09 -0700 (PDT)
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
Subject: [PATCH v7 07/13] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:19 +0530
Message-Id: <20230314053725.13623-8-manivannan.sadhasivam@linaro.org>
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fd20096cfc6e..e316a4e4b5aa 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1772,8 +1772,11 @@ mmss_noc: interconnect@1740000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8150-llcc";
-			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

