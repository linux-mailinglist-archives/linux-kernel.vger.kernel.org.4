Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD76DA251
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDFUIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbjDFUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:08:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2093F9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:07:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e18so40643271wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m52Fvcr35MflUMHJTsLpmYtRZScsn7h+EREVPBWogx0=;
        b=FtP0/eW7E1kTl+x7xopru+dzz4dGbL19ET6V852K4bydrN4OVov2baH8oQ2bxfW1ou
         A2a39Zix/GM6gMJnX3LlTU5gFFKaQI5/oAEsLTJRp2Gc2h0KhP5oiePvszdIyU0WWDNF
         axa61RPGGTix+oVcDM+4+9skVyk2fCbYP07Smr+3mqwFk/ZsjM4BXHia2r7Clwf30bv6
         ASbVp9SpcFg4FNN4LLy0uZKoxtCN+GtEA2y/mZMsdl+Pl/qkQ7fm8IIrKFJsnTQ7BH/W
         I9G/QNaeY2ErIRzIBkxX3bK126H16Mi/6wLdimXnO6EECDY9RW3mFmDMCpeQ4tc+NOCW
         1Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m52Fvcr35MflUMHJTsLpmYtRZScsn7h+EREVPBWogx0=;
        b=5tJMoZHQvA2eS4oyruFMWyvQSLvWGr+ATwfQe5YgvtXUmZhprCpSyvr9MA3pajzIiK
         oQMvD0RV6ziUr1g0xsH+eBBT56PQCbVZyZrU/caGabN+wecES/uOg8fm8yDaYpYNK/Tj
         Oc/B09VpiSrk1+YSFgGXgSZfrnPJna54W40QEMzD7IVWoXNCgDfuD+2+gIa7PfmXS2mp
         sgaza/ZlVuxcxdBbdvZgLeOK1wYgQc4hCsDutWy+WWRF0Mqyt/4rjdgJajYR+8YnFrGX
         eiMk5M0TU6TUPI2mDALIIio5kJHOrd0xIo7uJEdv9aCtvOBdWl+8BUpZriFOvImYfRtq
         3gWw==
X-Gm-Message-State: AAQBX9f5GdzrGTleFmofIt1EAW0lqLhIiQOf8OIG0dPMex+JnAprlJYU
        m4Q0xf4gFE/EcD56lGRbdr1R2g==
X-Google-Smtp-Source: AKy350aE3QvSbgAyL1jPQ/oye/qNMJsQBTxvNUiD8mdV9ti66FilDN16i33EOIAXyrZasngdBRMRWQ==
X-Received: by 2002:a5d:5103:0:b0:2d3:fba4:e61d with SMTP id s3-20020a5d5103000000b002d3fba4e61dmr4436015wrt.12.1680811674335;
        Thu, 06 Apr 2023 13:07:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 5/7] arm64: dts: qcom: sa8775p: add the pcie smmu node
Date:   Thu,  6 Apr 2023 22:07:21 +0200
Message-Id: <20230406200723.552644-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the PCIe SMMU node for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 2343df7e0ea4..9ab630c7d81b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -809,6 +809,80 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie_smmu: iommu@15200000 {
+			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x15200000 0x0 0x800000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+
+			interrupts = <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 925 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 926 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 927 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 928 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 952 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 953 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 954 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 955 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 956 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 957 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 958 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 888 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 843 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 844 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 845 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 847 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 855 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
-- 
2.37.2

