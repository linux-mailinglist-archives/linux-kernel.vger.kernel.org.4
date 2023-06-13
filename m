Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E872EBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbjFMTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjFMTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:14:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2601122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:14:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso7498063e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683642; x=1689275642;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=635jy0e2lhv+fSXWusJ9DIeLST1wGeeAsUy28K1WJGY=;
        b=wKr5ulDRcUGas1ZQElff+75ttyWitE9A2pG6uIyMcsh9rbZNbpQQPGy0e3xduAGF76
         Dg8nnEIJGJAUnmqy9boYhZZXK5gqC4C1mgb1HAgvcZtiPrVXIURc0dBwOQOEWNyyroXq
         OXx22UUciThFQdfHJwzcuRPOPwhNQcFuSrHEUQNR1XFFrF56vz9qhdLJxj1oi+ztIiGY
         SH3cUlbqNGlWOdtchsZfmfGSe+DeykDru7LMjTqS7Uv7JUaMOaJXqtrs3xZ2PLs6DLNf
         NNr4X1ynAyzN9nkcEqe/OGt10fyC717jFt1AP/tNZPolq5hOgKFcJdPIj1OmWu569VHv
         jVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683642; x=1689275642;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=635jy0e2lhv+fSXWusJ9DIeLST1wGeeAsUy28K1WJGY=;
        b=UdwYWpaeBswV9dqGXXmI0YMb4cm9YKVVrMClbnMeZu+KYuXjNmbGuRuvYqFM/2DC06
         0rgSbeLRGotz5d9Jm7Fw426NFhUvvDP4cn/ObN0UKPAUBmhsKclptPeM9kqi8qq7D6DO
         ELG2EKiKw9/PpWA1GjFngoSfmHGrtWltAGQCIt5KuxJ53d5YoD+PtR5IWbnuYbOjhR/X
         eEVX6eUF4eroVVLh4m3PnfpA5ASRi+uDD+MpmYkSkHkTETNKaqesoiIp6hsGCPu/mnor
         Gc6flbouXVleExT4O63flKl/4tz+kB/RiRfUmRzadEc4il/ebmgc9Y5s+Oma5bIOwPbL
         vrxw==
X-Gm-Message-State: AC+VfDwaZZgDS6oUi57rtsIXY09qzuboZzGE5ZJVu/QbV5ISE1q42roY
        qCA5CwEnec8CWNbxlB5TDU9rPw==
X-Google-Smtp-Source: ACHHUZ55beN8wEnTRnmUwg8tqV6a5fXlfZlqoktgNmZpS1/giMsp6FpkoM6QbtOQkicojGYauLAjyw==
X-Received: by 2002:a19:655d:0:b0:4f3:5038:5857 with SMTP id c29-20020a19655d000000b004f350385857mr6843243lfj.55.1686683642073;
        Tue, 13 Jun 2023 12:14:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004f01ae1e63esm1848443lfc.272.2023.06.13.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:14:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 21:13:47 +0200
Subject: [PATCH] arm64: dts: qcom: sm6115: Fix up cluster idle states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-topic-6115idlestates-v1-1-fa017052319d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOq/iGQC/x2N0QrCMAwAf2Xk2cDSzon+ivjQdtEFSjeaToSxf
 zfs8Q6O20G5Cis8uh0qf0VlKQZ06SDNoXwYZTIG1zvfj+SxLaskHImuMmXWFhorxuAHut0dx+j
 A0hiUMdZQ0mxx2XI2uVZ+y+98PV/H8QfLQ2YCewAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686683640; l=2325;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ufJhln1rknyOKoYvw+gm0MwBsfp76sKNCVfI2Po21t8=;
 b=27kXMW5EZ44Lbx87/FcPywSyvc5LxOtI9IAN063mDoObOoPsmxZiyav4YbG0+wtrGPnaX9WAT
 FliyoOQjYNcBgSpap2gGyIce5BCP9qzaFLDO8QAkVk0NwYjsL6jpXBW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest nibble of the PSCI suspend param denotes the CPU state.
It was mistakenly set to mimic the cluster state, resulting in poking
PSCI with undocumented 0x2 and 0x4 states (both of which seem to be
implemented and undocumented). Also, GDHS cluster param was wrong for C1.

Fix that.

Fixes: b5de1a9ff1f2 ("arm64: dts: qcom: sm6115: Add CPU idle-states")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 55118577bf92..07d8b842d7be 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -225,7 +225,7 @@ domain-idle-states {
 			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
 				/* GDHS */
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x40000022>;
+				arm,psci-suspend-param = <0x40000023>;
 				entry-latency-us = <360>;
 				exit-latency-us = <421>;
 				min-residency-us = <782>;
@@ -234,7 +234,7 @@ CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
 			CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
 				/* Power Collapse */
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x41000044>;
+				arm,psci-suspend-param = <0x41000043>;
 				entry-latency-us = <800>;
 				exit-latency-us = <2118>;
 				min-residency-us = <7376>;
@@ -243,7 +243,7 @@ CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
 			CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
 				/* GDHS */
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x40000042>;
+				arm,psci-suspend-param = <0x40000023>;
 				entry-latency-us = <314>;
 				exit-latency-us = <345>;
 				min-residency-us = <660>;
@@ -252,7 +252,7 @@ CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
 			CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
 				/* Power Collapse */
 				compatible = "domain-idle-state";
-				arm,psci-suspend-param = <0x41000044>;
+				arm,psci-suspend-param = <0x41000043>;
 				entry-latency-us = <640>;
 				exit-latency-us = <1654>;
 				min-residency-us = <8094>;

---
base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
change-id: 20230613-topic-6115idlestates-ba341792ebb2

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

