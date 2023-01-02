Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EC65B256
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjABMsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjABMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:48:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09E5FE0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:48:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m6so31060243lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+B/2MT9KOw7iDSSgcxQCDSNt6KQrJQRbxT0rQMu0cg=;
        b=hONI5Q10Qo+StGwWC+GrLjI0E9DJcHhX8ebnDsfSBup8VwcsrVu9mh5JvdKi2aiq0g
         0Ftw1UXkvPL46zxaOAIpBbGtVpr1IQ6Rm3u7hhLsdcimvKAUVmtrZkJviC7PpHOjwXRO
         vuwIEAlCnqmB5DMaQle25ZZkX3uma7iuYZU6vR2mXvHkx8lll0uYD2Oj2jRH72aq2MTy
         iEUqfYyLV/K9+D4jeHwC1VHgaKn/deQwb4rrBEPOMR2OKShzr9lKNbK0RRZELyui3P4d
         +MhBTQyusS7MCisclA3iNO66pq9b86jvNIW7bHgSPpQWnokgvLYoDlGnDi3Hy+Zb1nNS
         AA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+B/2MT9KOw7iDSSgcxQCDSNt6KQrJQRbxT0rQMu0cg=;
        b=FIz9jrSgsjsKDVJuIyXr3Z0Ji4A4lbNXh8qVd3rLnWCZD6WgfqJpYGYiAzZCmGLQtK
         tw7hHX5RSoN8mPdOraacxTW8rCvRglQEwWOyZgVUcjuFVXLK8fIPmR6dB7RQYcymMvWp
         cRLJ20pEzUyPyEK6Yv+L9V3/MmvnUTV+xEZKycIavu2wrjtZtnceogOHKx7kuazdWeVB
         jWj2hJwRza0h3QrKajR99PBSUe5S7OP3yTeFQaaiozr25iUB5a5BLBjLGonNQNwJZtGc
         Ai8qlwU1UwXCL6/avx3uxqam3nOrPUnWR+v0zfdl3erC6p7XdtdBtVmm6m88V3ZgqFVd
         te1A==
X-Gm-Message-State: AFqh2kpVLpivTv9BjepLSPQcOAwePmahOzyslHPBSCUOv54VaQQpiuGW
        ovmksS//ZpODdfA/P7+NEj4r9s95TPng3CGH
X-Google-Smtp-Source: AMrXdXuqLEYh6ksSaIjjO+1QQ01igF2Kvvpvqt8ZvgjPBdzwcxhDYNGyAbSXdwsw7bB4ie1ntN8hMQ==
X-Received: by 2002:a05:6512:c23:b0:4cb:3e21:94ab with SMTP id z35-20020a0565120c2300b004cb3e2194abmr160035lfu.15.1672663682770;
        Mon, 02 Jan 2023 04:48:02 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b004cb003c3b2dsm3656482lfr.175.2023.01.02.04.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 04:48:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8450: disable by default Soundwire and VA-macro
Date:   Mon,  2 Jan 2023 13:37:34 +0100
Message-Id: <20230102123734.478433-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Soundwire is a bus and VA-macro requires a supply, thus both are
expected to be explicitly enabled and populated by board DTS.  The
HDK8450 already enables Soundwire devices, except swr4 which as a result
of this commit will stay disabled.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 4de3e1f1c39c..d27a8f42d522 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -516,6 +516,8 @@ platform {
 };
 
 &swr0 {
+	status = "okay";
+
 	left_spkr: speaker@0,1 {
 		compatible = "sdw10217020200";
 		reg = <0 1>;
@@ -622,6 +624,8 @@ &vamacro {
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b_1p8>;
 	qcom,dmic-sample-rate = <600000>;
+
+	status = "okay";
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 61575f6fab0b..e241c05bdd77 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2143,6 +2143,7 @@ swr4: soundwire-controller@31f0000 {
 			#address-cells = <2>;
 			#size-cells = <0>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		rxmacro: codec@3200000 {
@@ -2189,6 +2190,7 @@ swr1: soundwire-controller@3210000 {
 			#address-cells = <2>;
 			#size-cells = <0>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		txmacro: codec@3220000 {
@@ -2256,6 +2258,7 @@ swr0: soundwire-controller@3250000 {
 			#address-cells = <2>;
 			#size-cells = <0>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		swr2: soundwire-controller@33b0000 {
@@ -2284,6 +2287,7 @@ swr2: soundwire-controller@33b0000 {
 			#address-cells = <2>;
 			#size-cells = <0>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		vamacro: codec@33f0000 {
@@ -2300,6 +2304,7 @@ vamacro: codec@33f0000 {
 			#clock-cells = <0>;
 			clock-output-names = "fsgen";
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		remoteproc_adsp: remoteproc@30000000 {
-- 
2.34.1

