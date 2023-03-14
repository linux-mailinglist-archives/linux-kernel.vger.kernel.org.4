Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122A6B8C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCNIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCNIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:05:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C70A87DB2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k2so7829942pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM/W3mGHWee04PiGhWaePDSEFLq+5Xz9JBoWs5RSs+4=;
        b=RDGwems7PyJZDZ29pYgfkme1i95dPUInFnXwzopbD6Em5qAza9fIY+En5MtKlgSpqG
         YEPMHWlaC2/G41YoL0usMUjvOqq6fkjWNI2RQgNUSoJ8ZfjSU3PQicRblMHRdBichWpX
         F3V6cYIEFrkj1FxBuPNHqp7ry3wbusvjYzSCqEJZbieoKqxWeyfuVvMAI0tNXSlv+lmJ
         EahXwYc/ksWZIJKinruI87wppf+TUFSw2IyyVpTBJBR1ED8VZh8ycFvca2pz01phKde0
         xD8pFjaG4RgYhg3aupoOE+6jC1Dq4epW1Hyjzh1dH5/bF5+H5p4UWzBpA4HgQPTBrXiz
         3+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM/W3mGHWee04PiGhWaePDSEFLq+5Xz9JBoWs5RSs+4=;
        b=CTyPSGm+aQipB3q4I2pS0FyjdU7PgNsn4PnyQPu/tPjT8aP7/iwIFxuYRoRS9P+H3m
         d/mVKxBaD9nNHhxxw6FoyPC3WNjr4P8MAmjYZuHB4woXSgx9GhO6XJLpwgAcXWWv6apN
         l/7AuXa1iU4iMYcxeLwxK+9XlnxtGpaskGcZXapBcR8Ycz5PTk5maIAi1FHaW+CafpKN
         tFYz3Ig3dkIl2CJiIae1ky8zWCsT/Rz6I+kxe9ejHyOSFUIyi5lldoLBhWzrjfL8VSlA
         6xTgIKQGeer6RAC/gXnP+zyXGdijrka7ST1diBdzlVi35syNZmVlS7UQzchPDX+zzgT6
         QKzw==
X-Gm-Message-State: AO0yUKX3cMtgaYVSzksO/zUEIrdJr6m8+uipDYHxp5f8eGfmJPdKcEo7
        cQ6AjR+YTQioq184hCQCpJ3T
X-Google-Smtp-Source: AK7set/EBRWn+iFCvwCLybzCKfHdXTnJNY/XzNdvpeEfeBdb0/V4NEbBLT9p7swb5llI6OB4biA5cg==
X-Received: by 2002:a17:902:d502:b0:19d:16e4:ac0f with SMTP id b2-20020a170902d50200b0019d16e4ac0fmr46377415plg.5.1678781145728;
        Tue, 14 Mar 2023 01:05:45 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:05:44 -0700 (PDT)
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
Subject: [PATCH v8 09/14] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 13:34:38 +0530
Message-Id: <20230314080443.64635-10-manivannan.sadhasivam@linaro.org>
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

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..3fefd8cbba6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2204,8 +2204,11 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		compute_noc: interconnect@a0c0000 {
-- 
2.25.1

