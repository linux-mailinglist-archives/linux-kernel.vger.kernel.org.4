Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97FE6B8C76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCNIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCNIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:05:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB96F4A0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p20so15677535plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tE4o5E5NxTGWs0FFcIpd5GaMpz3q7yKukVUL4nRPNs=;
        b=SmbC3Sr+D60stiRGJZXsRljMJ9EGtv0OIO9wD1szac0xQEdjxAe3HoEMnXxycEv0M8
         SgvcLf4e0+XZgqSILauKVvLZbJZ5njuOxNi29bPYpN8NQ4hzlDFrXobTq9xd5ipr2TmM
         b1GG/vzvBYmfi1RgXuvJEn4n8sxU7TbMucES+ZhVvcYFv6x7k6PpgSXCBhaiqEZfF+oo
         uEE1P1JHVl9h3wE6fO84Lnr5vA+tkG+K4s1GY8AXFMPA9oPvOadzpP5IYecdldDz3eg6
         usnty6Hc0vl86IfjdVKi7B1igYRvEia7S3TJxla28WLeSiqpd8PCS9LyZGWw3fDtcf1k
         W7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tE4o5E5NxTGWs0FFcIpd5GaMpz3q7yKukVUL4nRPNs=;
        b=KKSis5qQGplOOzgrqeSkJVkVVungIyzDglysEnYhOE7N8Gc+kSIvpDJdGyDjAifiaJ
         MtmTapZkI/CnJusnteaJCuJ3FDXs1xmIAWGizL/6D2TfSUCAi8d6F3gD84VWcTlbecBD
         uanabvnzmrxf5aim6RdL6n6bt2TOqBJPMFSyUpMOAHbZqngjAsyPzlufaqRHAXy8RjHD
         2Tut5Phwz3hCy+PpTjMtFFfB3wWZviesAGUXlGm+7u2ZXb4TFv0VoxWBGzvbg3KQEhHB
         7rk6MH1c+KBeQ2o1ubqA0nhOAY6Rq0K+Mc99u4pNTpdwSF2VqqI3NyCn+KN9pswhssVY
         jhNA==
X-Gm-Message-State: AO0yUKWN/j5TcBfWIfngo5zkplrnCS7IozEbJEsZ5EZ7HviXmJaXMzhK
        vo6Seg1o51+csC7HN5usdiAp
X-Google-Smtp-Source: AK7set+A0dHBQOGRoBb3IGYCa3wKgRf9EDI9tNGdBjwCcw3Q/olMEHPtzMPMK9JzYYGiraLJjvCTNQ==
X-Received: by 2002:a17:902:f684:b0:19e:68b0:b06a with SMTP id l4-20020a170902f68400b0019e68b0b06amr46982825plg.50.1678781112473;
        Tue, 14 Mar 2023 01:05:12 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:05:11 -0700 (PDT)
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
Subject: [PATCH v8 03/14] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 13:34:32 +0530
Message-Id: <20230314080443.64635-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 479859bd8ab3..3bf95a12ebb9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2192,8 +2192,11 @@ uart15: serial@a9c000 {
 
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

