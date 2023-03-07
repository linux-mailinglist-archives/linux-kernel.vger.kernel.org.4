Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8866AE4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCGPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCGPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:32:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA551C94
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:32:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kb15so13582194pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+c6ysIsQPtFw8I+23hjGksOV4MOO6Pq+iyUAdEMcK4=;
        b=IsRYdtaDNDOFPCI4QwluVD+xTkpPDy6SwjfWN+YvsPky2BXlL4YUFaDodNLXugbIGR
         /h/LF/NbrrfybsLo+pfrJA3WgCVX1yj3JqIwP6LqdbnOgn+VfX2DYeqSOfd549Zgoj2W
         ZbmsCWfEj5JvGgxjjuEOWjQsOb3ObZHN5J4ZTjsNLs+andFNKRf+lUoeYEuCIerIygGo
         QpuU8r/TCvDqo/+jm1KwqQMdDPZwgaZayEjLvwEETSDFhT/WiZ9Q+xsjaWZdQJjHg94G
         1V2iYtRN6q9iLJKzvrsVuZjF5nQgdKp1elT+ZRQ2YeSXvh6fEi1liCyDL90nWeF4eNau
         qd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+c6ysIsQPtFw8I+23hjGksOV4MOO6Pq+iyUAdEMcK4=;
        b=65wqXJj9RWOoA3oCgXACppflvmn727D6W7EnJVikOUOi5AhZmxjin0vdUMWA5WTwiV
         b9ewxsVtxtfgEGz2KvDNDBwGGogLS5xgAn+50JUfarUj1vReZYZyg3EFZ676Iy8ixoK7
         /B1NwammHM2Ox/qFF+6cLtH0vLhPnaabYpi9oG5VQNwM9C5Ykvs4KV2aj0gqTj1K4TGj
         f1SIT/Jlhdsjtoki4nAg3dQcMWuex3H++9wcKtlX4cTEuSZe0Ni2RnkgXT5Itn3z56R1
         9jV/YJJqYNuYRrnGQTr8odx/vIQNAcMmGNDabEdEM2TXqKbXeA1T6R4rypfSo2TB9T8t
         GKEw==
X-Gm-Message-State: AO0yUKV/hqhEwakHE9oAo2dkDu54fwZ+JtytKieKwOHSQPRGehOKqjBH
        Mits1yj0ve1zXwqmIf5GZpC1
X-Google-Smtp-Source: AK7set9eTpJtpLR0lZFXkdO1IuMp1tfrjeVmLptOPoTB9NLTQlllzyIOOGRhTt0JpGR78Be/qU9nlw==
X-Received: by 2002:a17:903:11c5:b0:19e:e39b:6da3 with SMTP id q5-20020a17090311c500b0019ee39b6da3mr2209099plh.16.1678203130792;
        Tue, 07 Mar 2023 07:32:10 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b0019c93ee6902sm8541436plg.109.2023.03.07.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:32:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8450: Mark UFS controller as cache coherent
Date:   Tue,  7 Mar 2023 21:02:01 +0530
Message-Id: <20230307153201.180626-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307153201.180626-1-manivannan.sadhasivam@linaro.org>
References: <20230307153201.180626-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS controller on SM8450 supports cache coherency, hence add the
"dma-coherent" property to mark it as such.

Fixes: 07fa917a335e ("arm64: dts: qcom: sm8450: add ufs nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1a744a33bcf4..3ef47b4e9af7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4003,6 +4003,7 @@ ufs_mem_hc: ufshc@1d84000 {
 			power-domains = <&gcc UFS_PHY_GDSC>;
 
 			iommus = <&apps_smmu 0xe0 0x0>;
+			dma-coherent;
 
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
-- 
2.25.1

