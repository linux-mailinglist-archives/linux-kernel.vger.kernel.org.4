Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C06B8C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCNIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCNIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:05:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5D7F039
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so14318962pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3jjAvyClxqCSaG5sOi6OveXFyY33UJ9o9fFaRGOIoU=;
        b=TPe49wQ55ZzjXtL1UhusZl5uDaWHm9T2bYehPMS/MgB1zXGYXYXd+Il8eMkq3hVezK
         Jxl0H1dW3Z4Dh4DnVnxdD0GHDOrGhsqNw4XajjmEk5hadqij+8/HsaCK9GeAJPmn6L8k
         fE6nt06k4eCKMBmVEkHElAN+09cYJ54nbpSIlZ9OChY5I+SEjKp/b6pTMc/MYOSJr2CZ
         zCbaVqG1lIED2bPKylCCmXu3LWAUAMeJLRF8aW/v/SAuhl0RwicXXGaR1xT0ryQ9omzu
         bzYWCTAN81C88SbdXaG3t1p7iCLwuqq4cmJJEOv92d/SWrW42hyHuijuBC0tcAlzQFP+
         3rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3jjAvyClxqCSaG5sOi6OveXFyY33UJ9o9fFaRGOIoU=;
        b=tNo5Ypr/pbvpFSdfJ5ku9XDwWT1Q5uTeeGXkI2n89R6ap2tTUQ81y0Yc53qmZGOl0+
         t09jkITOArgk3tqEH1SLWwD3BMcNRc3yuO7jrT2THx7nXOa2tSaPxt0IPEG5F9/rMZLW
         /CCqvKcanciTc2rPcN3AXfLkgfoDCzAQgzCbo9EVc9IrofLkTSBvPUE8RJchl4jxTJp3
         RYW1h3VByq5xjQvQdzYvu5iVJ9ODXbBE+8nvXcE1vMr/WCi4P6h1yCV0bDcud3n9uBIS
         Dkl8WxMHLTu4oZTSeBRP3kTUz7idmj1fNOLDjiojvHdEXyRMk9jYzu4dbHZgrfbNhALO
         S5uQ==
X-Gm-Message-State: AO0yUKXzFxOP+sFRr2E7rm1XJSUUpkCm8V/ogblnRa309UHptHUTRmrL
        sq3ODkbh/473OFXH08BAx9RP
X-Google-Smtp-Source: AK7set/YSOsQvqiPeL9DG52pW06edvX1Z7qaNl3Bn0+V0f31PkjxqRhu0MdFbr9SW/n2qr7smeYKQw==
X-Received: by 2002:a17:903:41c9:b0:19f:380e:9cca with SMTP id u9-20020a17090341c900b0019f380e9ccamr7917000ple.20.1678781124191;
        Tue, 14 Mar 2023 01:05:24 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:05:23 -0700 (PDT)
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
Subject: [PATCH v8 05/14] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 13:34:34 +0530
Message-Id: <20230314080443.64635-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
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

While at it, let's also fix the size of the llcc_broadcast_base to cover
the whole region.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..afe74db1f5ae 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3582,8 +3582,9 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc7280-llcc";
-			reg = <0 0x09200000 0 0xd0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

