Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8A7504AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGLKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGLKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:35:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA21FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687446eaccso6007332b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158106; x=1691750106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaN+I/hkvd3QzA25nZ6WowbgECymtQYUL0zIvSOgjdA=;
        b=Jyf/llO9zDG95XBi4fykEL2PWj0+zccIkqTmLzo2dX+Ef5w6epDK2uAV7H94PVzhsK
         niuFYZmdiaHWGo00Fhk3DcywRcZqHQj2jo8eTDDXreAGKvmwBhTPlLQfqxRwdeTb5GVK
         YkNC3Nj/Uo2lOdas+p0y2EIaAz/+5/PMJeZI5qIoQYRfjb7oA74/J6tAG7uefCVR21rt
         qUdzVnDAmzQvGN14Aejj24wLU1JuTsSjcFMh1/2AGfzRP9geKckbo/aGvUz1ArwSikPN
         gDky1uiKJQzKzkRBXFxI3FuQdE4gkKoDrpU8Yx+h4JAoBYIoDXmlVvqQ4hJpZ6g0Jd0S
         wRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158106; x=1691750106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaN+I/hkvd3QzA25nZ6WowbgECymtQYUL0zIvSOgjdA=;
        b=Wqx0WLE7NW7zsYGuzdeLeLS+gr2np+IMiDTwyRc2QHCumClH+cE8cdbZGM/lgbdMZg
         xHDIl4v6ipPMyDNYwApAO9eqgxKV4bgwquhS4GcKAkB8NLmeC37SVIRpu39NbpnBx3XF
         0mu4st5VRToncsjB4mI2tvC1Kru9XjYuqDAMI3Rq7KIDCkXczzwOGz4PDAB5NJQFCgym
         9mreQ2fuSWHC4hSYkO+QSXqiOrTO1ZU+aZ1d1eN0AW3L6lfDlzVN2gBFMmEZL2u/poE+
         DvkCDb8KgwEKCOoUkDVeUX8trsBBLQ7IxVuK2KvyaJcvav8U4zJov6RRdYcDtIqSS/GJ
         bMqw==
X-Gm-Message-State: ABy/qLaS4TAF6sQhBHZwHfgFDCC7qLDjJfJw3odF/i1ewkaNbRFl0rCG
        RkpV+jd9y3X6qojx76TiRczW
X-Google-Smtp-Source: APBJJlHiGA6H0kaANzNsWCCi3R27jt8fDpV3Av1v/qRVTqtsSGWR2FfuFiowPVfnA/ydlLHk2sAe4Q==
X-Received: by 2002:a05:6a20:3ca2:b0:132:87da:5b57 with SMTP id b34-20020a056a203ca200b0013287da5b57mr4375593pzj.59.1689158106553;
        Wed, 12 Jul 2023 03:35:06 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:35:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/13] arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
Date:   Wed, 12 Jul 2023 16:02:07 +0530
Message-Id: <20230712103213.101770-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS host controller requires interconnect path configuration for proper
working. So let's specify them for SDM845 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e04a3cbb1017..2ea6eb44953e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2607,6 +2607,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 
 			operating-points-v2 = <&ufs_opp_table>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {
-- 
2.25.1

