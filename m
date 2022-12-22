Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669576541BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiLVNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiLVNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:18:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45D2B262
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w20so1962511ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=VXe+Xf10elUr+UnSO49j92OhvgPpDswCeSmg+CP9iS6mREZbL8qbFc661pe6BPRjfQ
         S3oNVU7zYqI9S1bS7I58nmbbA8es6jmQ8pwyAbsbtAM9JJNu3C53jeDKRxU7zvt1xzSS
         ZFR7zig5z3K+G8wse0/DQhpC6YKUPAVB4WSwfAxXcprqqx7YKa4ShdLkmbLNPILPPFYj
         pS0zS4x976uQd/9EIjjzzwX5G9bm8b7a91lqP78l2dYEd86dCFaIDGRFs+0TZ00WTUC3
         RgkVd4NehMkFcgHCza83ksV8+nHNj/ZIlImHcPegVB9YmotZURTeMSUfuO0CHz9Ezn0L
         Dz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=i3G+jqZbTpE+f7I9nqBqIVHE/2glHvqNZbS14r5x6FanU4ZTwQoxH2YCf/q3mCOQS5
         sxnqumGLuaZ59mGDGiL01exJ0Im3SdeuG+Snb7LdscWiOOfJ/NK+qhSnHKsZ5fdzIQj8
         PzartqLAxymo+st/H2/4KkWCneqtU85JhG66ea1U8BYFm4O998tVEVdmRXoKlasrFAtQ
         lzPuZ/1Scf2qgk4qsTdUOy0Nmeqk0Ei4O20euwELWwembi51pvTGP92BeNqYNwleVZuP
         1U7Yg5kM+E5Vq+8UE2X1lFlGiF+t4tsDLo+jBRJFEQ/qRefjobb2p2TlSmCMO3OBaLsk
         kK/g==
X-Gm-Message-State: AFqh2koMyn5DaZieg8OR4Mz6k71UWmbnBpQUjWpW/So/7sEpWo6II2N/
        Gw8sUy51SaTh4jv6K7sQVwBl
X-Google-Smtp-Source: AMrXdXtjtf4dX/X47BtcJcA5+3mMzsRKeuSSmtjKeWq+FivoGU2p4egWef1dD/S8nEDd112vlehkAg==
X-Received: by 2002:a17:902:c382:b0:189:e3d0:2682 with SMTP id g2-20020a170902c38200b00189e3d02682mr6521113plg.30.1671715129086;
        Thu, 22 Dec 2022 05:18:49 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:48 -0800 (PST)
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
Subject: [PATCH v4 11/16] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:51 +0530
Message-Id: <20221222131656.49584-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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

On SM6350, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43324bf291c3..c7701f5e4af6 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1174,7 +1174,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm6350-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 		};
 
 		gem_noc: interconnect@9680000 {
-- 
2.25.1

