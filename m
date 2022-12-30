Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846126599F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiL3Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiL3PgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:36:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2F1B9FD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so1598422wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx/P0H2CQ9hUs3jLsvEBWmhDm0mKZhjWQ35wZVj/yOk=;
        b=EJg7ptfVAcWiReZzZY2HrzrYvyZW/xIfKIya2JheodCF/td/BvBzOUjdNtHsg0bukM
         xD7u06m1cIY4r38vtETGrgIeiak/XVcChCxIiB+uCdjQRSvvr2w1b8xuS/Rb78jZVtsX
         gABkF1ZpBq8zopfWHXFlwtE/RDF7Od8C3tTsUNDP4bdkB2HJJ4g6bLLRnKHfM4ub6Q5t
         vV5VusxpYFvOMdoJ3+ZNMv6/CvmiaF0+2uEfA3f6MBlE3+ADBz1xpmEUTz623gf8cl5Y
         S6Ewey7AM+Xo8Xho29fsueiAeb5nwZ1ekxMh1dgibeoVSxi/a+/Yx4ulAKp2SUp/1K/6
         xyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx/P0H2CQ9hUs3jLsvEBWmhDm0mKZhjWQ35wZVj/yOk=;
        b=QlLLY50N0BAl0vGfvWsDyr1Uaso6sT67A9an3knBcFUI9I8Jp7uShQBAPLUbfV2uT5
         pltORy2K7t9rPRAkNFig+cMJrLMeV0IKPkPrHtnm5kK6zEYheIYdiFZxQlnDhuJnPE8H
         4OUgWuaWVHrZuwkknjlyDh4iJnbKZ1kKpPEIsi1lXoXwimvKBz8RHPTsC134qNv3p84o
         JWobKVFEaaATdnMvFwdX5fviPoKE9CBdpWqQyKxCXEZ7eTxYOmgvkIBtPPhUxZJyj2/C
         THT2GFeILaLnr0cyGGx5371+b1Zt8p4txjc1ayUzlk9t+ONL+DOjHXn3ogUBCqwXwqDb
         LWdg==
X-Gm-Message-State: AFqh2krTCgxL6eZJ2n4xFnAxlu1rrZLugXg5/CwiVuqS7m4ji/+6qrus
        2X/VM5soimWC3eC5Se1caM7pYA==
X-Google-Smtp-Source: AMrXdXt8BV4jDrWcE//4gLN7FNNLrLb0XuE3b7WF+M76Mf4gqsHlAgIxc0o4VWtGfYCQNpbgV72OnA==
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id t11-20020a1c770b000000b003cfa18d399cmr23924928wmi.1.1672414573589;
        Fri, 30 Dec 2022 07:36:13 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm49857993wms.2.2022.12.30.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 07:36:13 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com, robert.foss@linaro.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 07/11] arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
Date:   Fri, 30 Dec 2022 16:35:50 +0100
Message-Id: <20221230153554.105856-8-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230153554.105856-1-robert.foss@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmxc power-domain-name is not required, and is not
used by either earlier or later SoC versions (sm8250 / sm8450).

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..770ea105a565 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2557,7 +2557,6 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 
 			power-domains = <&rpmhpd SM8350_MMCX>;
-			power-domain-names = "mmcx";
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.34.1

