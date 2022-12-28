Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D0657436
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiL1Inx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiL1InN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:43:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53160FD13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fy4so15636387pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=iIHueAUz0G9Q5Qor23ltImQgj8YpTUuI/PbDrcEdsTQqLprCC3c+/GhTb7Wa8hwNUx
         PTj4TdPafPSASxxhHacbBAnqwos9HjyGHVsNYQqclReq/BLKrfQgtBRzSghtWrSTmJgr
         44WjAWGVmA4fA5y4iGXiTIQ/qPE/dS5M/cAD8O/dQBXvu3PjOlLNfa/vzJDGvw8dag/2
         7UK57ETnT0B5AgeooJ4F67sjWayL28Auq/DQSzGPr6xsXLTDdL+urgDlAB0KI1IIOu4P
         YK0vbGYdX/80fFPCl9BWo543P/lHDM9gc5daGv3xZbhWbFMf8b/77TbkQTQ+08H5ZQDE
         o3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=12iG6LE+VWVtgV0CN1wY8C3kqsAwDVJvmVJHRsVSZooe6ow21+gPXmXTEZi5i7OhTk
         p0bAF2o0Xgenjcf4UeM2rsJ/lMNVsgMvmYisdhqpZeaMJwLPw/uZ8uh4Fv+GdhnZbP9p
         OdT196CrMgSsLVEzOtFSSjGeiaVPppSCfDtnQ6ufxiwQBjFvZIumB3wDppoX04X3GlDa
         4ZgcH8lURZ6VKgkClyYxY+GcljcR5jSHLblEfR5fN1Bil4871QidGiVPzwQoRMm5XN1d
         6U7oTqas+A+fFYl8if2PWZAaKNRojSoBuBGohgC/6CUNtXaCerqk8Bpz0VuLJw2aHAmX
         ra3Q==
X-Gm-Message-State: AFqh2kotJVKSafrM8LaS5FdkyU/2zVLG11QFD7ey2WbLNf+hkUR5/o8F
        skogCBswGMBg1XkuhubGMVw/
X-Google-Smtp-Source: AMrXdXubDuV4Ljz5PUmqbjDeuct0HvYN+u37AkAMnMvW2w/GVyk4a0aKPsRzW1uOqJG76o2FKQ4DcA==
X-Received: by 2002:a05:6a21:9218:b0:9d:efbf:787d with SMTP id tl24-20020a056a21921800b0009defbf787dmr29695708pzb.50.1672216948793;
        Wed, 28 Dec 2022 00:42:28 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:27 -0800 (PST)
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
Subject: [PATCH v5 14/17] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:25 +0530
Message-Id: <20221228084028.46528-15-manivannan.sadhasivam@linaro.org>
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

