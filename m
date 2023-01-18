Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB06720D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjARPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjARPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:12:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46454458B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:10:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w2so11009348pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=WNcEJPVHob+I5LkpCpds/u25pLXDuKLU13sQsuZ8KBFq26kQIcok8LXN7g7/Gkq5qi
         9IyXPvPwKwP2zrabInA+cD2HLSM57cYWhP63aHKz8JE8tz48WX0BV0qIGEDFj7HlWiH9
         uLt0DK8WfNX1EONBZAvo4vzPm8hRYhjeI+oqmOCAagCpSNXXQP27q04vQMqWeLOaxM7p
         C+ThtPZL5LOYKlUUjNWWiz3XLqgkSi0CLIVd4bSRcqXLjxyV1lPfZ3Z3/BR1GCjfraQX
         I68fd6iahaLc34gTFjd6Zl2UHiEUnJD90mqdC96jkSIQC9SIbpmrT/Z18xKQRyqhlICk
         jw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=B/okae0Q6ws0nCbZE4RtGfDPOXMyKjCyT6iu3KwjxLrgEfRO7693m0aspJSBsRf0qC
         +YnJp9yMO5lKX6eKZO00jyrBL9mw+1EHSaMz0pMC799lTAUknqXkV0Hl2FcIkUC22xzV
         CrFdqgfhRWKgEZJnHAzfHczo3bO84UIrPpjEbZjU787SbkdNr1+Anu24bUreqObVKGKT
         JtQmohZYdpFbDK87OR32Fwmt06VwUWDsxnZzDy4+OoPCxAZQnvozg7hf0fz7+tAIeido
         jOJOiGRNHZPMJljoZ1RvMyr+mefMSF9VRLMgn1+vtT2KuAW2q7cZlv5HCNC8nz5LufzP
         ekTg==
X-Gm-Message-State: AFqh2krf0nGfZDLF7/SDEdkpNDwEylljSY5P7ZijpvAZvasmIcrA5CJV
        4UWIE3iC5ZVv2YJBlP0Xz/yK
X-Google-Smtp-Source: AMrXdXsEh0cnadjqjItUJG/4Fm0w2vGQPPb7P8Y1iRppsvWrDTO5Amgm2TqRzvNQHBUehU+y+MpXuA==
X-Received: by 2002:aa7:9204:0:b0:588:4739:9a23 with SMTP id 4-20020aa79204000000b0058847399a23mr6962640pfo.15.1674054631338;
        Wed, 18 Jan 2023 07:10:31 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:10:30 -0800 (PST)
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
Subject: [PATCH v6 14/17] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:39:01 +0530
Message-Id: <20230118150904.26913-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

