Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B2B62994E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiKOMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiKOMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:53:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28427DEB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:53:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j4so24326705lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8KHnTj/YFCzSOX9ZEAT6Fa91rq0mFq6fNTw+uKuopU=;
        b=tLH14OARfm6+zkP/36KVsrjMHQeJoOLbty1k0OlMQ9JQICJyaFquDimPjRUJNdJi1u
         SraSWjMiFm/ADeRMmb/YN168ZP0jU7QDLbKICFweeWnkVF5CmjtmL7iZsgSzamrzePR3
         7X9hU1D7g7P5XAOVSrd4XiTbVn81ZpAl+B760XIImUB+/JWGHauWChUJ2Z99XhU5QfjF
         ihPusPhIrzPNX2Qq2q5gfSUAld+ONKScAj8jpiwGpGP+4LuotnactaTJHHA6AkOL95Vj
         mX05OCNn6Qj8mqjFwLB6XRAgM6Yj8uYoxfwMWCpDsUsrK1xIMyqGwF+bVv6mxYKlZmmS
         /+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8KHnTj/YFCzSOX9ZEAT6Fa91rq0mFq6fNTw+uKuopU=;
        b=icXfPpxsUulSm+gthAALKl4QLcLDKBYZOeP7JLhu4YpgMGHzFic1YcaLrQBaQlQkuG
         +RLIi+qWD7VbdVDgKRp1HcamhGCWpwrsnNaeVgBXhBGnEud5iRC40gQk3YThsDhZ/Mix
         eC9V18OX0uBKIBtEkGAm+wuGqup/n6ZvLlwSiS2oP8weBl0CCylWqRP37QGbeWac76IJ
         TZjYDQ8odNdm8DmsxoJQCq1u6i2bX52LDQbCzJxsOO/hO5YWLwUMZ4QP5BJJQhX1RYXN
         WheNjdmRILA09kxn603cLql6amvdo8+SAWzEDKR6FSAL519KnmyR32vch1RijBBqpuP4
         SQBg==
X-Gm-Message-State: ANoB5pk2ae+W3WmBu/hH0crO44lRS4PGO4g1LrExUXvK6pExC8gyIC3l
        7Wbe/io7ua3AKczvkeM9pFqs6A==
X-Google-Smtp-Source: AA0mqf5s6ZA1Hl0NIjaX1O37HGFJaQRcICMsI1pNRllQ5rGUBjfXGGzgxcbJfnuVqIohY0yWNWhiuQ==
X-Received: by 2002:a05:6512:3d8c:b0:4a7:5a63:71e1 with SMTP id k12-20020a0565123d8c00b004a75a6371e1mr5913770lfv.399.1668516797281;
        Tue, 15 Nov 2022 04:53:17 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b0049110ba325asm2177224lfs.158.2022.11.15.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:53:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: msm8998: add MSM8998 specific compatible
Date:   Tue, 15 Nov 2022 13:53:09 +0100
Message-Id: <20221115125310.184012-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
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

Add new compatible for MSM8998 (compatible with MSM8996) to allow
further customizing if needed and to accurately describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index da2dd87e3f4f..320a28232a32 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -900,7 +900,7 @@ anoc2_smmu: iommu@16c0000 {
 		};
 
 		pcie0: pci@1c00000 {
-			compatible = "qcom,pcie-msm8996";
+			compatible = "qcom,pcie-msm8998", "qcom,pcie-msm8996";
 			reg =	<0x01c00000 0x2000>,
 				<0x1b000000 0xf1d>,
 				<0x1b000f20 0xa8>,
-- 
2.34.1

