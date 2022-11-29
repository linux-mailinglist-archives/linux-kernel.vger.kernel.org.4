Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE43B63C9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiK2Urw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiK2UrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F827DCC;
        Tue, 29 Nov 2022 12:47:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u27so12876305lfc.9;
        Tue, 29 Nov 2022 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OJbaeSPcoUQhtrSfuzPP+5Xvz9tDw3fpybywrDiLB8=;
        b=isX5XESaqTPO6t/rIUbSKYmN1N1Dj6iJFY4zi9Q4/cAMTUMA+sX9eL/49g1tvW5Zny
         rAca4oqEK+DqAek0wERHVCLD3nTdFRwhJ7CscGnoZnKgDpL0RV96PvAfAIqLnEPejxoM
         Yz70Hahxo6+2JtIbjtQI/tF+uwgYYQfI7G2PF6wHqtAGplmUp3c3i2383B0fjGEYhPQG
         3i0FCQ/bMG/t3hW1gfm48IPo7p7q53Y1WNf7Vm9jVHFQjcZs6NNLl1/yY25IilHBTgYW
         bXwk4v9GIAhdmaByNwQsi2txZf/Fko0Vc+SJq7Zc3vPhfnL5cdFq+b5qiZmrl5oAnlB7
         7f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OJbaeSPcoUQhtrSfuzPP+5Xvz9tDw3fpybywrDiLB8=;
        b=QUHnfYkaD9Vf78nDB2E7TCX+8F0OJMUO9guAATUppNIxK1GSmmuEEA62FJiE3EvOe/
         Hbs34j9iARrEBjTiXC+FssIdl+anebBP/IcPmB+FW/wT6lmGIs/L296XSaod++L7mouW
         h7S50LtZIFfK10MZGMjVoztiQ1pfyvSOYGufPnQ1+7D2eu/eDVgF5tUpyQTiqownlIPI
         LieXDnLS6k4GStd20gWMp5jpOiwVXreoGM3NBR5eg8yHWf3Tlsttfv024W1Z/8KuoeOA
         0o9iiDxJJuOFC5eaNVBZGvwo++mxv1Gyz/gRkxycjvXzaQU4igGWqjMP04Idu3guiVYq
         CRJw==
X-Gm-Message-State: ANoB5pk1oEWa53CziN+5UXLLX+eX/u5+q8Nx/XPssRp1ECyXoAQDVfsb
        nCgajG5nfT7lWvutXbkevu3r0A+ENYI=
X-Google-Smtp-Source: AA0mqf54SpyD4y7QdMfh7uhy0hQf6/Lwg3RHDJI54U1OkTsCBQXvOVa2dmVDRScLyX0IIVI4Pm8Ing==
X-Received: by 2002:ac2:5f9b:0:b0:4a2:5163:f61b with SMTP id r27-20020ac25f9b000000b004a25163f61bmr19237522lfe.177.1669754839327;
        Tue, 29 Nov 2022 12:47:19 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:18 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 12/12] arm64: dts: qcom: sm6115: Fallback smmu to qcom generic compatible
Date:   Tue, 29 Nov 2022 21:46:16 +0100
Message-Id: <20221129204616.47006-13-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change fallback to qcom generic compatible
in order to prevent reboot during SMMU initialization.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 36d1cff23d10..b00d74055eb1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1222,7 +1222,7 @@ dispcc: clock-controller@5f00000 {
 		};
 
 		apps_smmu: iommu@c600000 {
-			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.25.1

