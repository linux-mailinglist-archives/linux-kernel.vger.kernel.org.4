Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E86B07A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCHM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjCHM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BD8DCD1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k10so41456289edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhp10S2stU629qD9YS+ysMNx0WGtHFXeXE+LpbX9C5s=;
        b=Lx3Z2q6vlGvEv7bwqRRTtU3bDX5i7au0D7IuDzTGBGZD4ukzPL1oc+BnMxl9rt1EY0
         423FCAp3S/eRX5j1yy5xlVgH1lViAqVQefarlPhH0mU2B9PPXrK0DSqJdMvUjhyk09cs
         twDXtcQbahhgA+Fsxj50ga0GkhgAXrRw+TQwp4Q0Ju6K+hv1q0VkZTFE6B2F12YJGLi1
         WIVyXZpa++fmfji0lQ3/64Xh+gamc9VQpT6WgWeyxaKmi+qXGlVSubrYFt/NMKWx+MwB
         NmxxDpGzyiNLwjmxf5K3m4iyfdfwpnXc/bE1e/iLMrD4NOuLuyCksA9LSuLDIGKtb3C8
         9T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uhp10S2stU629qD9YS+ysMNx0WGtHFXeXE+LpbX9C5s=;
        b=8F7tyQG/kK4ol6TWcuoWrdEU/i12IZmroDksuWwzSXk6tT8r3WylSbA8nWlLKBbTrM
         PmvuID18uvhr5I53hkkmVOQxc37d+2KZAMLspAnBV0l/nHoFSV2ONePmRS7jY11OaJ0V
         D1iQF2FyQBVl70YhTXMwmgmD9Ht7nCtAua/xTLG/nliU9i0+ChjhxQsN1J2lbERMAFqT
         OvZDh03RkyssRjPivopuiqBBqUBVF7druGTxT256tfi9RQzG+wbo+NUxR82qx5ZHExRu
         aJ+XmCnVQgY+hq7ozwAky7qPJnEMWl3r6FmHATWJVGj7C/7+E5MiWKy3IU6HBy4WUkm7
         BctA==
X-Gm-Message-State: AO0yUKWVif4ydfRoOKBp/kZwZ6QVgs2J9RoJLKvJ3BPMv+fPclpEojLQ
        +dxEWmO9rG4+RbyFnt/j34Qp1Q==
X-Google-Smtp-Source: AK7set9znPTpZVzAUYW5cm/yF9sR2ebk85j+sT9e58O7QKtPDsS8R5xIk15sDv41A/es0joryo/iig==
X-Received: by 2002:a50:ed12:0:b0:4bb:8e88:daeb with SMTP id j18-20020a50ed12000000b004bb8e88daebmr17299866eds.31.1678280356331;
        Wed, 08 Mar 2023 04:59:16 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 08/11] arm64: dts: qcom: msm8953: drop clocks from RPMPD
Date:   Wed,  8 Mar 2023 13:59:03 +0100
Message-Id: <20230308125906.236885-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
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

The RPM power domain controller does not take XO clock as input
(according to bindings and Linux driver):

  msm8953-xiaomi-vince.dtb: rpm-requests: power-controller: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 4e362b9012bd..da00c2f04cda 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -281,9 +281,6 @@ rpmpd: power-controller {
 					#power-domain-cells = <1>;
 					operating-points-v2 = <&rpmpd_opp_table>;
 
-					clocks = <&xo_board>;
-					clock-names = "ref";
-
 					rpmpd_opp_table: opp-table {
 						compatible = "operating-points-v2";
 
-- 
2.34.1

