Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD067504B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjGLKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGLKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:35:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5710A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6831e80080dso416863b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158129; x=1691750129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaN+I/hkvd3QzA25nZ6WowbgECymtQYUL0zIvSOgjdA=;
        b=ZiC652OBhgqv6XYu9gc9HvivSB7NPRBi8kvXhs72d4wiyGzAls68DTH3KQe5lcr83B
         PkslsS04t0Kqtq4ZJyQ6OFpMhflZm/D7mFhaPgjfpqfSBZflcZmgj80FZakq9/SNnax3
         qC9S3trz3nYmoOcqIwlUIjlJmWvClJkb9iU/McNSqbKut6eKljvlzn/nHGaPg6+9GDcF
         qJSWks+WjwvDCsxssPyEhVgICwMxGTw/DBQSlLIE29WFgQXTcrp2egGeRHOqdGjCWQKC
         0y1puY+FBpuJqZXGR696dx2zwLDm69Ct6DVuzmPBhhh08SSuXeWY4/sLzHTC9U4TMUpy
         FAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158129; x=1691750129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaN+I/hkvd3QzA25nZ6WowbgECymtQYUL0zIvSOgjdA=;
        b=d1Oz5ND/QgroQLa1TqiVYud7/KnOyxnZ0QUkHFaKc2ixI7ysoOxsr924wOoO+QX/bU
         h/d4PrVQPimqQf1BvZMdnc5bbAIYIaCBJqhafYoe62V65h+RGgHbmuwc072yg3K9Qm0T
         A/xwl4DScYEDpG/ZUWBV4ZPdEJVyYAlYBFoOCLWnZQneYrVjQ0pkbRppS5QSfa7E/Bzw
         msH3W0PpDbGEDTCmaycWmLE40UNk37GacHNfejNDIeVKIoCQVKmz8YtVpTriAy7V03K5
         ZVnc9c6/VQbd+DV2omktUzBsSAcpWm8Pf1K6IVZKidBMI1Cg8MdClcpuxOOAqoCTGOvp
         Kv2A==
X-Gm-Message-State: ABy/qLaGASx4IThf1m1cbGhJI0lY8zLT5U0dXvGH3VnKc+8Y57yuIuvl
        GssZ3IH7BwjoDzaSGoo4Vs/Z
X-Google-Smtp-Source: APBJJlGT96aPB0muDliICUoW0oLT2ftBSuX4exK23vui9iDUtvLdh7+UCQ7wCUGHQpBRWLy+76hMQA==
X-Received: by 2002:a05:6a00:2e09:b0:676:20f8:be41 with SMTP id fc9-20020a056a002e0900b0067620f8be41mr16906598pfb.16.1689158129570;
        Wed, 12 Jul 2023 03:35:29 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:35:29 -0700 (PDT)
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
Subject: [PATCH 12/14] arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
Date:   Wed, 12 Jul 2023 16:02:09 +0530
Message-Id: <20230712103213.101770-15-manivannan.sadhasivam@linaro.org>
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

