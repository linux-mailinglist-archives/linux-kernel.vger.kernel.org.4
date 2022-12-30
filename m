Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8865742A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiL1In0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiL1Imz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:42:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71239FCFA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g20so2067098pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=uLb/ZHO9acuGXZNYQw0lUOz91UCx2LOPc+k611i5+YRtO95j5kzMbttDQBFv4WsN0W
         5COSlFAnhI/rFjK5rDSyMiedi+CJEIbfkD4ZT9RHzzNT5/NR/1lzYqMjpcwlT7EHaU+w
         SKhTfYGKgDDUV/8fsFm47WJBnV7GHvfU6bMJDpMJfghSd0cjU7bpHyJMzEipZxlTL7B+
         YNQROHCqIBlxEv0lIATl6vG09xNE2RBGap5dEbTV5Fm1Bv5E9ZklknzxFYjw89GU9Vy7
         WaTqqM1tS3GgpKQRLSbvKx0lO6daAXvo3naMY8avJXPdbDU/cXL6ZCGzRV4s9tK3bRQT
         vnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=haHhYxpqqBqBhCCWp6NcdC95Ar1rTz4JWgUGL+ndNohlbdk2sRxJKdBqT+f2k4QfBI
         c962ud4OZlfdBjXy44iU+S9O0+njS7p4s5mNS95cS1hHIEtM2S58iI9N5zooxRrNBsxT
         obKl1NXLK39nbhXwv4jKIJ+0hHI/xBIGnCLio41B0PpBj9YDen3qc5YtNU2oTH+XvLvC
         UgKml9GsJh3mJm86bf8HBgkInSSmaRf0hjJbbUU5JMFSMQaDsaom2Vk+u1jLC5c+KM9h
         5Pq9MpEa4aasW+cHJaJ1tSZlczWrP2XuR/FycP78RuPkPzf0k4BxLvsaEI02C6O8EwJC
         7Hzw==
X-Gm-Message-State: AFqh2kpKtHff+QBKBO2uKUDl1nX5FZueV8KqVkgi+WE0Nf/nyDMpTvYm
        k4KH7TclLZBEsEJryZUNpaPz
X-Google-Smtp-Source: AMrXdXuymwkmD8aRAux9K4d5I+wXwJyolE2y34HFPr4t+qgayngWSW2pHLm8hpfyJiQ/WKHrPHV9WA==
X-Received: by 2002:a62:60c6:0:b0:581:6b38:25bc with SMTP id u189-20020a6260c6000000b005816b3825bcmr5248457pfb.29.1672216926093;
        Wed, 28 Dec 2022 00:42:06 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 11/17] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:22 +0530
Message-Id: <20221228084028.46528-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

