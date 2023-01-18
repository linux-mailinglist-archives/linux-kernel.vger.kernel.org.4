Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060816720C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjARPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjARPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:10:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2AA366B9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v10-20020a17090abb8a00b00229c517a6eeso2641092pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=fuZe+rBBF8dNZgZ166UGWALWEqUi/EqjxyiDbf3I2knIvjilvd+rFGnFFZbeNtbshq
         dJCEoglW9mMo3fczTSmNcEo/eVJ6qwrHZdlvzCSH/FMGYGITVltBgcQB4mWqotbS6Rnv
         Km18GSOD/QKLSMmGSpr1GwoyMNukZc2JlXm/5lWpyKsud00rDKYHwbCcgC0SYvvfs980
         /CviqcY5RUCvSW2Bb7+pQf/oahJWOH77BTMEuRAAuQo7MQQWYSxCSeKOgGYLL++yVkHl
         +iqT0Zw7pB9HueGu6tr2mBEr3w68OdmwTgdcJYO2PiFzS/O4Llcs44sUq08cysL17/OD
         VpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=sWxEbqNk+9FyjGTshwlA2ksA2utXcb0LeAW8zf9/IuTkifJ0zG4jAPUwem4Vmuv/wp
         NAh/qAOammGH+3tCupUp5gpJ90SwAhYnZsY58h8LF9aG+RunYJDLPUJuy3iTnqTBI/Y1
         5MmBQJOKcoS6f6L+dDhR4ZzvLjgX4gfjPRsufCcEvw9gLfMOsomrluNL6JbgPSEnPwcA
         NhgXK57/q8Tt/+u+FsnRE5mg3aCQ8wrDl6wjN2BBUQzE1hVLE9JigBGPaFxFZ6evbEGX
         +3GAtAgmURo1vyIheDUQZKHcJmfJSoV9av1g8zr55I6CXAUG+ld2H48w6DcPEJ5PxtLj
         583A==
X-Gm-Message-State: AFqh2krIaGuVsKIK0Wo6t65+qOqrRzHxkzag83dlWBW9qh1t25DD1+GP
        q4AvAuaiEwzSiAKO2xPAZZpLLtMgFsatlEg=
X-Google-Smtp-Source: AMrXdXtzc0ScrQ4oiKZQSUbvx3A62txQrmHbGeMTTVpTLslEN8WG1ZhVA5Pm07yH/XqGthynf1nYxQ==
X-Received: by 2002:a05:6a20:6d19:b0:b8:4978:cde8 with SMTP id fv25-20020a056a206d1900b000b84978cde8mr6918596pzb.18.1674054598025;
        Wed, 18 Jan 2023 07:09:58 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:56 -0800 (PST)
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
Subject: [PATCH v6 08/17] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:38:55 +0530
Message-Id: <20230118150904.26913-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

While at it, let's also fix the size of the llcc_broadcast_base to cover
the whole region.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0adf13399e64..6c6eb6f4f650 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3579,8 +3579,9 @@ gem_noc: interconnect@9100000 {
 
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

