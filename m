Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133C1702C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbjEOMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbjEOMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:19:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E72DE58
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:19:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f450815d02so39601845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684153152; x=1686745152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L912CSeolNZtYdQ8RZjTKt4b4LSvo4r4682xBt0zJjc=;
        b=U+ib7nrp1j5RymaVeBottDtU2UQWB9P+aB7p2Kk9adtcpQ3b48jVgUfn+o15WQwh/J
         VZ+z0d0KjsTba6bzI2SucZqskj6kRcMw+HR4/sWtEI2tPD7/dOcXDeXeXL94BVFDWJor
         L6kYb0568hAlcDzqPVOtFBFc27Dg6/2icQXSnPvoVgos49/fSF7CsO7Xk8ErEn/WOZhV
         FYdAg1m2u20V7ajVbbLbHRk2/e10Vvz80LkYxH2v0ZW+1LuWlxW2tkM/fYWE3ioQdNJA
         9rwJGRKCOjbL1lt5QkoriHmW97ru2MLaNgp44pvlxQVZFhBNLz3nNRK+HtyKNupygwai
         uDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684153152; x=1686745152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L912CSeolNZtYdQ8RZjTKt4b4LSvo4r4682xBt0zJjc=;
        b=QhNiuRNNnk66Q2C51bMXN28xFqJZbcqCgmc9YadmLxHeMZ6VJd2VQuSeN2TWJayU1b
         p1mwFdo0u0M2+B06QRpCv1LRnXR7A4Gl8u4mzWqQb2TfHs3U0w7oq5Pb2o4TexV4cFbn
         dqw8bfBgXayE/htrJjvsBzPF3C0lifil18ODmdbUU9Sz4lB8P6Ptca06b1vcrQ9l+EvF
         S+QsLCovMpH5NWUakV6w9s2VJCuax73s/iQpvwTTQ2k6QoGXncpyZP8w91hYCvyvRIsx
         XGMcUChF0JrzCUF315Hhn3JOtgc3TO5YNftzz9/Ab/uwOzYa+pGQrejsICvFEBBunmX+
         geRg==
X-Gm-Message-State: AC+VfDzbhKj0H1v2sDi7J6OxZTDqQwEhXxRH2Xyj3BjBKwsK/35ApokG
        sJWiEVi1T8VaYP3hfKoa5oJKyw==
X-Google-Smtp-Source: ACHHUZ4cjC89qH3/rJziQ7Tbr+oTbvM0sVWCqTBk3NprhE9Hucvy65oL/bFZblZQcoXwom6wcpCXUg==
X-Received: by 2002:a5d:6591:0:b0:2f4:4e1a:bea2 with SMTP id q17-20020a5d6591000000b002f44e1abea2mr22755001wru.59.1684153151997;
        Mon, 15 May 2023 05:19:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1388:9f6:c7d9:3b77])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d428f000000b003062d815fa6sm32361582wrq.85.2023.05.15.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:19:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sa8775p: mark the UFS controller as dma-coherent
Date:   Mon, 15 May 2023 14:19:08 +0200
Message-Id: <20230515121908.303432-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The UFS is cache coherent, so mark it as such in the dtsi.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index c5e2e3256bc4..c0717dac100c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -605,6 +605,7 @@ ufs_mem_hc: ufs@1d84000 {
 			power-domains = <&gcc UFS_PHY_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 			iommus = <&apps_smmu 0x100 0x0>;
+			dma-coherent;
 			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
-- 
2.39.2

