Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0291602FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJRP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJRP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D3D01AF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bs14so18394196ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB4pG/wpKwLSAILs9IcGtC4gbTwQNljlapP0erz1+Bs=;
        b=Ry/gKAX/ngx4cgGV/cyifxKrzZCaj65Gv0gXz7a8QKD7E4wJqsZG19WRsiriUYP1RN
         l343f1RyO9LQJmTATviNmsoVpm2p1znDRGoV32NysoAJi4t8n+oslv+8OJpzAiCEsk82
         iVhGVVgiFIdDbathwWj0cQHgRL/NzlpTFTjCF4xSwuCn/HwhwblbykfUKsXHRy9WurFm
         dguFAsbuZGZwkIwMDHaDKGqXmeIFdTLWGTbGlMJnim26FJ642syYC2xGwyacHO7//L27
         PR2qqkPYsM49HieuEdksYdEUvSK6Q/po4+OHHpgtuchRQqU9jSomo3BBVjHfz0wuZnvG
         8oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB4pG/wpKwLSAILs9IcGtC4gbTwQNljlapP0erz1+Bs=;
        b=hzf6aZ//Mja7OB6wsbG2MWKCK3Vew3pmJntlzHqzzgfV4eqlSEp9AyNMDJ/tSgNDCl
         wfJDxHPBHQG3v2Nsry6utF3YRkBvlNgbxnr1xrsUOhmZOr23JtKxEJU99Afct8kTd/Yw
         7ZoPUEDyJoUpidFVM8Bp4F2WLTMk3GmShLiGxa0vys5i1mpBHQW2PrcVXk/ZJWoT5wu+
         clJ3xPpzPpAQFdxu3WupTG4oszsgB/QtOkGlTy1ANenWNdVGheQZ4DSgFsdb4oxSW+Xv
         aedbvTZ/1uHWGtwS5Yupj0WwIWGz0YBsZBYJFQrvSV8JxTSDtxwHAtDGZjxfEqR6tFa0
         RCXw==
X-Gm-Message-State: ACrzQf2L8AYVyv3RLWRftdzSN+oXtfTlRSxH3jK+SQ07MiDp4zVcj3sI
        ocCjwWPXHmKE9ceysN5ACzC4zw==
X-Google-Smtp-Source: AMsMyM5twPc2ITOuTEJKpZgPVWCUSbiDlfm9WVX65TffEEHzazlwRJmajGAhVc64aq86VCC2AWXfWA==
X-Received: by 2002:a2e:bd0c:0:b0:26d:d9fd:f61b with SMTP id n12-20020a2ebd0c000000b0026dd9fdf61bmr1299091ljq.151.1666106939451;
        Tue, 18 Oct 2022 08:28:59 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:28:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] arm64: dts: qcom: Add power-domains property for apps_rsc
Date:   Tue, 18 Oct 2022 17:28:34 +0200
Message-Id: <20221018152837.619426-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018152837.619426-1-ulf.hansson@linaro.org>
References: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

From: Maulik Shah <quic_mkshah@quicinc.com>

Add power-domains property which allows apps_rsc device to attach
to cluster power domain on sm8150, sm8250, sm8350 and sm8450.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..ecaae6f5ee6b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4010,6 +4010,7 @@ apps_rsc: rsc@18200000 {
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8150-rpmh-clk";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..c32227ea40f9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4955,6 +4955,7 @@ apps_rsc: rsc@18200000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8250-rpmh-clk";
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..b5d036d72059 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2004,6 +2004,7 @@ apps_rsc: rsc@18200000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>, <CONTROL_TCS 0>;
+			power-domains = <&CLUSTER_PD>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8350-rpmh-clk";
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d32f08df743d..d32dcb042778 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2999,6 +2999,7 @@ apps_rsc: rsc@17a00000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS  3>, <SLEEP_TCS   2>,
 					  <WAKE_TCS    2>, <CONTROL_TCS 0>;
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
-- 
2.34.1

