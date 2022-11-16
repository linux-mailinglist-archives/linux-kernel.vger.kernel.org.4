Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6C62C4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiKPQib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiKPQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:37:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14EA5E9D3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:31:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z24so22523304ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJHwbZILYP8+/3bf2ysPsIVRQOxo5OqcH7pSEuMOltQ=;
        b=EHJE2TianlnxZSWh5AX2cj7oS3YN5io2A5IS7W9w7oUFNYKGHhQKUAfX6ltTLajATj
         WsdYcogEBK1XpKLFmyz8rafYm7SUs5JJdW7nJFQk12O4vtyQ5nkP8wnGbhuppEukTvG3
         soUJGAnUrUju2fcC2n2DjfmQNDdMRaM16kIjr6ioSYt+RTracL5o/xOD8f/0FdRo1fTu
         FZPmh5ha6FdZoVCXcxj741jt/avqLts6tsj3tqUWfij36XN2blrZayeu6rUHSfbUkBgj
         MWNiN5k7v+/4Q/+JymaHipaShdxC9op2jFNqeXG88UvmiKOISKU2dJCxabECk8zM6s+c
         6ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJHwbZILYP8+/3bf2ysPsIVRQOxo5OqcH7pSEuMOltQ=;
        b=j25GruuUnTFG8lr6/jDBuNTEXdol4g7v9K3mUw+aBx8CgYMEfS/kWmQd3CDHN4/+TY
         9Q595hlKJYSYKP0ocB++SDe2xrIBM8zZTnLflDEpzhQKuws6lE85S8l69tKzzFYhYNN2
         NSTLWoztPVzrhc6mkYet98hs/DizFRFVV+X/Y9xEVEz7Relxq0OT3iNVV7Cpd+IYYRep
         4+mLKqMHKf8fGx5jxGmRMd9ULinFb5YYZ46hylis5Na1tXheMsyfcKmi9GS3D+TK2WiR
         C9BYsCjag9C49DMx2ujCwXmRuRKADeUQ/KZbjTly3aKXtZPAiZAxFP+aKuic17z79eR0
         iTmA==
X-Gm-Message-State: ANoB5pkmRgLYNZrAYFac+mA1IpdGK8PgPd1r/hg2tXj/IWLbBM6z73nM
        Zvn/pACDVyPS0a0NgENgOl4U9A==
X-Google-Smtp-Source: AA0mqf4bFUhLzqIBnykeRocSbGABvzjHGitRtbRH2WnARLS17Mr4SNSuhARK8RLFqjiHLi/3dE5cHw==
X-Received: by 2002:a2e:9ec3:0:b0:276:d9a6:dc00 with SMTP id h3-20020a2e9ec3000000b00276d9a6dc00mr8470050ljk.379.1668616307072;
        Wed, 16 Nov 2022 08:31:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b00494603953b6sm2673634lfr.6.2022.11.16.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:31:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8450: use defines for RPMh power domains
Date:   Wed, 16 Nov 2022 17:31:41 +0100
Message-Id: <20221116163141.177997-1-krzysztof.kozlowski@linaro.org>
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

Use defines for RPMh power domains instead of hard-coding numbers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 19a0f5033cc9..705e05588941 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2277,8 +2277,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 0>,
-					<&rpmhpd 12>;
+			power-domains = <&rpmhpd SM8450_CX>,
+					<&rpmhpd SM8450_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
-- 
2.34.1

