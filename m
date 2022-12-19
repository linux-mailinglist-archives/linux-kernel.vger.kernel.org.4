Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104A6511E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiLSSbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiLSSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:30:39 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E413F0C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:30:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so13993372pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny8LRDxtkCbzVPxZcMEK/2xCa3Cj3hxgheO6Po9c4/Y=;
        b=tB2+zNdifqJx43Zq7xsEiADY2KICBO6LNu2vOB17V8vgf3gGuVSsSUXmFOk+zIMYYj
         grPk6u94bQVO7MthbPVxPNnvFXSz/XPjoCHUYEpjJ6VrZ4RF4lhGSYVuaUypKhlxJ4Ae
         /S5+kihxH6g9u8iv0uqf1hJccEuw3i7P33U1/A6EZ5diXUsG+OmoSDm2hWuhoqPJcUD7
         cLohC/xwLAfIUVoFQFnkvsjgI3W0Lt+B4Q1I/ljTnTo6SBE9mTilVPWsjVinbEnhOK9K
         xWMiKLZZsJquwOuwhNkW+LisL7n5pjzb/+Y4tuuJlQkQNN/VbX2UhBNczWGQJ3UV2jwt
         4zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny8LRDxtkCbzVPxZcMEK/2xCa3Cj3hxgheO6Po9c4/Y=;
        b=H21+XLiv5bcCI8f3PMXTqAjz9OSTDQ5MHTt2meq9NcfGugkAX04OTLvqM+DEjptCdw
         QXjjdBVpoDin2LXJlgYYkpmpwR3QpUoJQ+90GfqFLvBCxlRAIxEcZxCsogDWM7k5ciVV
         v1vWTq1OGDsBGiQy+GQxMLZNrkHOnlmEFfVt+2b2dYsOZhQK5TYufEpyEhBZLa570ePW
         EZaH5rRZctYqBmqCYrPajndMlQhSH0fixbqsgy4LSPzvXIcMV9d/Jp9kinepYId2SoQc
         QRHZe0p5nUBDxj0P0xUZL4RNJ+K+Nb8MDEK4XiOCHmGx60I4hnHFD0AnRtjq538Vxp3B
         IqDg==
X-Gm-Message-State: ANoB5pmj6ysxqgj6rwUFTWHLkiFun53fRJ6bto0mHOwPJ4RkH100vrWp
        qfr4fQOHtdII8fGR07nBof3F
X-Google-Smtp-Source: AA0mqf5/cenMPoMuIXAkL0WG0vV5r1zGlGHw9yznkIgiC1bSLb5/Nxcc7WfDjvnnu5dhBB/SveI3ng==
X-Received: by 2002:a17:902:f211:b0:189:8f0c:d314 with SMTP id m17-20020a170902f21100b001898f0cd314mr39360915plc.39.1671474635867;
        Mon, 19 Dec 2022 10:30:35 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:30:35 -0800 (PST)
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
Subject: [PATCH v3 03/15] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Mon, 19 Dec 2022 23:59:46 +0530
Message-Id: <20221219182958.476231-4-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..e1c0d9faf46e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2132,8 +2132,11 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x01100000 0 0x50000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

