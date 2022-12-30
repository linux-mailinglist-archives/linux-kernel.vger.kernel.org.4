Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624E465741C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiL1ImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiL1Ilp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:41:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F66FD13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k19so2606762pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9QXXi64w5AkU0+SlZ8zyP2UpGIuUHr0Btt1KBRAP8A=;
        b=IvF0oXD98yyBIqJq+91laACS5kfVQK2q412wkuezxYCvLA0lRlwFwYxUfpurelPzpr
         xcHz5E9MOKe5LT4ggXttZ6W+FX0gMgXwGfz4TDWCHwDy7BGGlhn67taNPTvntvbk38t1
         I8k2KnjjDamTOPL8uNTa2Jbxkrqv0Gti3JuhM+YvJTjm/U4kCZgfzZiz0eUSytiPx4uo
         PE0jeUZg0G25Dg8dQRgGQX7fT0+v69nM7x35iibVLlfaxLQtedX8JDseRMh7kN4Si/WZ
         Em3B54menA+Q92ONQkA9iJiloH/RbU5kjuj1ewOxyP5Lr+xFGibrFacCQUc5MYjn8iI8
         eTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9QXXi64w5AkU0+SlZ8zyP2UpGIuUHr0Btt1KBRAP8A=;
        b=Crr3tn40XUscv9/D8KnpXtQLO6n6gLhbqzKjRS75/flLpfc7U+pONAvd5+olzZnRdo
         c+V3F81tsLWb/quLcjRaC1vvBkX/0I6oLWxglrDTYjoutcldE1kz1t3zzjUdHhF+cxSo
         m2rwVnJYLllW4UDx2lt0HKS1m+7gh0sSBBARJBWKIaqSOXTHdY5b6TjwmN2+QHZwbXjx
         VsR6PAvmW8XhlJNLw2GVid3S3J3/R141EXvStO6dnp+bG4RW9FPWDTYTte/ecdsLKkic
         lQRW0A3ijHIqgvyTmUT47qNTv3qcDVinCeL/Zj9a5uzPiRv2PeXM2xwfZ3qCvoxg6VGp
         drtw==
X-Gm-Message-State: AFqh2kqxPsl4lLXxiAnToPrTVR5XlLfMg+yd8BAzeJln2V+CY04+ZS/e
        y5WEGChQxRY3U00CBKoSjqe1
X-Google-Smtp-Source: AMrXdXtlsfFLE8Oyyf/2hwR+62V2eL//nmMUWLdt1iOWVVGNeRPnx2Wie08yHGNPwOCkqf08JFraOg==
X-Received: by 2002:a62:f20f:0:b0:56b:b890:6ccd with SMTP id m15-20020a62f20f000000b0056bb8906ccdmr24974575pfh.4.1672216888505;
        Wed, 28 Dec 2022 00:41:28 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:41:27 -0800 (PST)
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
Subject: [PATCH v5 06/17] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:17 +0530
Message-Id: <20221228084028.46528-7-manivannan.sadhasivam@linaro.org>
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

On SDM845, the size of the LLCC bank 0 needs to be reduced to 0x4500 as
there are LLCC BWMON registers located after this range.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..4db68d4d78df 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2132,8 +2132,11 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x01100000 0 0x45000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

