Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2936C7B63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCXJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjCXJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:28:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5244C2D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so1036436wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679650133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la//61tmt1JcHM3ugdeN6VnhDtVEZYhOaulQ5DfrvTk=;
        b=Sb6+xZo54omB6soda+f0C+zM3HVRC8Sy5SrF+pvYfdroivYt2p7mjmIHNxxCgRzulF
         /fQJnFwQcN12UMOg5qlrvttaKkj46Yh9ef3CUAGxOCVX/Yaw/l2+zgsicrSyfQMh08bB
         sL/WHdUdE+H2MC/fZmN09TE1F+LmZLAxxqr5tSzbdWhhvYQ5Q4G9LN8VYC9muharWc8d
         hcnbOlmvycwCT+hvr1TVyPrqb8/v3xn7K2RVAodsg4a9wdoN9gZ4MWQUFsVC+0c9pWc5
         PgkL/lJ+zYylW9lXrvLikPItQZnPnv9dpPMBN+TIp5A6c0n2KmPnpothgOm4yVd60xSh
         fkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la//61tmt1JcHM3ugdeN6VnhDtVEZYhOaulQ5DfrvTk=;
        b=X5EG6ck3BKRsqkhwmfbMEGA00ZBGBCwxgMR1T8uhpmVmlSnZ0tdaQbYgl4IiBBcI6q
         ublYc+sAxNA4ky/r3aU5s0H+LnoLruAwb1CMB6wIhjzKrxJM0YMRgNsy9to6Xi6wymce
         IqO8Hlim35SX+GYI/4ypHTfONAxGYKA8jNCkCxqWSON7vY7xetPBaZoUiMmFaizGGEDV
         xBRtoAc/dkBjNVzn/UTHT7fbypkAXbmVtlborDsHHA6pgDXZpZW/k+bQZ674yFaNyCRl
         qWYkdKXpQ5wYlysqbxtbrHDcfnE71MFeULAoKxDhWR7uOXQIFNEeyviV1vr3Wuc0msmt
         Syqw==
X-Gm-Message-State: AAQBX9e5HQgATLHzexLPOedvaX6XVLrZHJuximsIMMV6Y6V0Pu6yY5Ka
        dv7aeolIUh5n7HHzxp0MmjsyDoAd3BfTMJho7O/NCA==
X-Google-Smtp-Source: AKy350YgMPjfXwGTXE1iW69hMKX4XP6SaWX/WffDq3iU5AqJk/AmwqDuqeQazzIsxTnXts4iWN82Mw==
X-Received: by 2002:a5d:51cc:0:b0:2d2:5396:ad98 with SMTP id n12-20020a5d51cc000000b002d25396ad98mr1400212wrv.21.1679650132831;
        Fri, 24 Mar 2023 02:28:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b002c5a790e959sm18029980wri.19.2023.03.24.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:28:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Mar 2023 10:28:48 +0100
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8450: remove invalid
 power-domain-names in pcie nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-3-0ca1bea1a843@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following DT bindings check error:
pci@1c00000: Unevaluated properties are not allowed ('power-domain-names' were unexpected)

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index ff55fcfdd676..bcb51e612261 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1792,7 +1792,6 @@ pcie0: pci@1c00000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_0_GDSC>;
-			power-domain-names = "gdsc";
 
 			phys = <&pcie0_lane>;
 			phy-names = "pciephy";
@@ -1905,7 +1904,6 @@ pcie1: pci@1c08000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_1_GDSC>;
-			power-domain-names = "gdsc";
 
 			phys = <&pcie1_lane>;
 			phy-names = "pciephy";

-- 
2.34.1

