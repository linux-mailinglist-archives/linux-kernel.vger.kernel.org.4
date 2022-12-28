Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7355D657434
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiL1Int (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL1InJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:43:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD3CD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:21 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 79so10171341pgf.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6zR8ugZMMSbsUYzZxGLGG2mvpL7z7iHt3BZjr/IYFc=;
        b=SEHAxbm/tlwxbMSvXx6Kn83W/mjgAGY97O8DA9p40Utz3/TdUra97SQthAuFldzs4c
         MopJ9AxP316k24yxgi+N9YA61a6iL7//vk5MoaxSfpwkCvcWEuvMTb+c/tMtjSg2pXYD
         6USwLwSPIuEOOmHQCSzUrCEC+Haz96l+Tk0WbxNLQt6Zn8dUIB43JJNKurRIXbPAczVQ
         vdR2snNFBpHyPbi8QDntU4OtHp2WrBJ1TKzjCY7xZcGylYTCSW1e8sqa9PqQuHe9uHyH
         fCbE3iCtQfSK3nnH4yOxugPpxc7iwHObl50gmgkVKW3CRn5McuEuTLXte0h0TAZpFDHl
         kFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6zR8ugZMMSbsUYzZxGLGG2mvpL7z7iHt3BZjr/IYFc=;
        b=IbVQLcLQWDq817bYNpRiQa4WHi3zLgU7Bpi2XgrPZs/08ER5xR+wZ5pPjBEodZgCjS
         eQyWcDHYqebYwbYZozpl6outOlawUHTqrT8rLE4CV17GqlBXk9UfP9quCmC29P9EI9E5
         3ueez2crH7bRHiIjdJKT9buCfzd9diGQB+GNnsZVdsSUxcsAVjR5NsjZ4ZRlxnuRbXiE
         jBxSYB0XTz4hyTlEMjsYZN2snZMF9KU3JCCNFxDjPy4RLD7nh+WSjVMKjsgjuHr2eSPV
         QE1JjKPX6qJ5mTTmEDTxsyuZmxkMg/DOlMtUHY0wVTCDmKLMWaQ6JktF+44xP2G56Yy1
         m4rA==
X-Gm-Message-State: AFqh2kqBpXnFhDMGB4nzYXFBIV6LRnhTXpfoBLFiBH5nV3Ig+Of1/nlq
        Xyv8saQ/nsymRAev/H3c8JSD
X-Google-Smtp-Source: AMrXdXsMqv2J4+7EQ7K+0q81giuxF+hAAR7j07C6EKMtcDjKLvEw/sT8ld3C/LgENPFwcw3yBVfmvQ==
X-Received: by 2002:a62:f20f:0:b0:56b:b890:6ccd with SMTP id m15-20020a62f20f000000b0056bb8906ccdmr24976154pfh.4.1672216941105;
        Wed, 28 Dec 2022 00:42:21 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:20 -0800 (PST)
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
Subject: [PATCH v5 13/17] arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:24 +0530
Message-Id: <20221228084028.46528-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 570475040d95..12549a2912c6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3640,8 +3640,11 @@ gem_noc: interconnect@19100000 {
 
 		system-cache-controller@19200000 {
 			compatible = "qcom,sm8450-llcc";
-			reg = <0 0x19200000 0 0x580000>, <0 0x19a00000 0 0x80000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x19200000 0 0x80000>, <0 0x19600000 0 0x80000>,
+			      <0 0x19300000 0 0x80000>, <0 0x19700000 0 0x80000>,
+			      <0 0x19a00000 0 0x80000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

