Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47062BA49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKPKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiKPKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95813EB5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so29185183wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZcB8b5Z3j9vFZzAUVrZnbh7ZZWrhF0/RMOeyG1Wfw8=;
        b=A73xZBjWyzaG/ZPC/8WlqziAsZnllsBcQR6LJluvdGb1h0D8hsmAUvseo+TyQzVUoR
         jOv0yZrGpMdNGOGHxrQEO1b4B5Jt/FLGO8134J/caBJ6k0rAjXEaFKElp0I98N35k7c1
         9gmtwTIc8h7BRXHsutz7r8ylBLYLMlKN8rLSpRMgkJeuRmV7sJrtcSRe/fcsjDuHqZJE
         KrdnGxjJTUBeMWP/6j+8W8WVnek/Ict0br/H0NpEm0SaJ1+pjEN54tKTALbCMvFqMfzk
         Evan6QP+MUcxFT63ocDMl5/BJcB/uSJsxnMRehZsZ7xtDPuLsF8v/0tMwDZWuiH7ljYO
         bAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZcB8b5Z3j9vFZzAUVrZnbh7ZZWrhF0/RMOeyG1Wfw8=;
        b=Vroq4yKCKJfCagoOhy1ahkB+pr7yaEMzN+SRRyFKMgCNeYlnT2A3s14sr5+IWSgii7
         hyu4zmOUDvSpTKSqy8NnNH52O0gV3k5zr1z+TsWaugwPZHFRHSE0NP1JTe7jE24v2cWb
         JgR/mofgnQsOxE3VbEdA8/VxDRAxC4OmOMmvdpEpboMuKIL9VYVpHHSCySWeOVCgxEWE
         CiL7DuuVcs8UH9626GN4uNq+UUpTY2qMmvxCFRuMJp1IHbtwgEy7SiPe7jKWSAZBFzul
         pZqiJT3nCwA27MHGRppJUIFi1IhTbw2AD+Ffdve+SppDiGWJudItFG2hXJW1EVKcskC6
         bypQ==
X-Gm-Message-State: ANoB5pnxjbWXM6Uk/TNRMw5qsk0I/G9Y51kAQ3EYmGYOlyL9aqCOceq6
        0cWo1XJWdl6rtTm9Dsg6Wp8Ybw==
X-Google-Smtp-Source: AA0mqf43NM8GvnHTbudKu2+KXY/mGKp4jvKCDHz1SKkriHr+2V42Zh7WTi2ucRmDNgRn2KNAjR6x6A==
X-Received: by 2002:adf:f18e:0:b0:236:b8b9:b018 with SMTP id h14-20020adff18e000000b00236b8b9b018mr13815712wro.596.1668595393326;
        Wed, 16 Nov 2022 02:43:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b002238ea5750csm18010846wro.72.2022.11.16.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:43:13 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:43:10 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: sm8550: Add interconnect path to SCM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-1-379eec11d841@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add the interconnect path to SCM dts node.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 07ba709ca35f..9e00778bb600 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -300,6 +300,7 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8550", "qcom,scm";
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 		};
 	};
 

-- 
b4 0.10.1
