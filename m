Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9853699820
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBPO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBPO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:57:07 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D454561
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:56:58 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b16so2204240ljr.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNZb9+LtgOPB5nx7aOjdrhWOzr4hEeUenj9snV+d+v8=;
        b=VX+hSkQ4DsAL4scU9uwMTlVBha89E/tZTBODBuRwHH+noKYA3b5IrmjzYwXZlDZNqI
         7WaIR8F26POUW80Q1aVuWFKd8z4gd6tLhcjX467ueNSNQPk3ctf9DzcTulBk/O2q7BaR
         dIxhyZeoGedk1RFRm3oPKtZgosXui3JVWAOnCPmM2s07MpO6BZTRuRcAb6xehSs60wh9
         jtOoYr6wyy0YCNil9u0YI5kUgqVBtOO1eeITpSkKAJg10XulMvnqZsi86SXV1MKo9sO+
         dxp5BZ6KF1b48v+S+asFHa89kE1SOHv1J4G0YrJnAjM5h8cIV4HvyN0qzOAYDgVnpP72
         NjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNZb9+LtgOPB5nx7aOjdrhWOzr4hEeUenj9snV+d+v8=;
        b=EDCeIskyvPzD62W3NtD+eWRdsILerw43KTwTHyEsrUxNT3MuvHX7EUmr5ojd/ENzvW
         Ygo2v4LD+MV2cZYUi1Uf8tdv0Fo/NHxgcFHumrztewV7/pSLb+Hwxr/zb6pdFg5of/gW
         AYJK3b1sKOgQO3MdxGdQX5/hfUDV8Xt3d96AaF5dcYBxU3JC3V3xqdEsXEScnK7qvkHX
         vKWdIXkoXSSp8dUuEc0FJcHfpyKn2cY5jTvytfU14OCzYdl3ygW4KZ4X9G0ueeQWHQGW
         747/+JPcxOJk50pqMupQjRnicJzvpX9TRkumDvLwCPPkyJzggwpcA0Q8vtEps8mHcjGf
         xa3w==
X-Gm-Message-State: AO0yUKUlYZ/ndxnfytp9f9IyYa1KKb4kiSK7Yaw2OgkKy3N7S4SnFbHk
        RfdgTcVxY164vQgc/o6ze2r4tg==
X-Google-Smtp-Source: AK7set9J7sGBjDvZYo3KM3A5arAbmcbrbZLwzsN8bfzBzkGG1cpfOdELc5O0LriLynryZM7VdZbJ1A==
X-Received: by 2002:a05:651c:89:b0:293:4b8c:3b82 with SMTP id 9-20020a05651c008900b002934b8c3b82mr1812980ljq.9.1676559416682;
        Thu, 16 Feb 2023 06:56:56 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e1f02000000b00294619d902dsm230012ljf.112.2023.02.16.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:56:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: sm8350: Add qcom,smmu-500 to Adreno SMMU
Date:   Thu, 16 Feb 2023 15:56:46 +0100
Message-Id: <20230216145646.4095336-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
References: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index f9822afedd89..07349d37f852 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1932,7 +1932,8 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8350-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8350-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.39.1

