Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFD733492
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjFPPSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345923AbjFPPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:18:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A030FF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6667a0811a2so771571b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686928705; x=1689520705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIqsH2Iv+JcyNkylOi9qtvbVK2jAXhmRaUsdt3ONyh4=;
        b=GpPAIZitPXFRSuOZt2/v1lUUx6zLZ+8adsfg0EcyOH/0Zb2pls1gvbR0yXhpS2nQ1a
         udqKcrhHiCVT91HKPEz/QAZXyFMGjBypbLotzvurvYwRmhTXSWW3LGdCQpSqQeFArnhE
         XS9LKJvRnA+C8924skamWh5ZKpxdrCWSQLz04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928705; x=1689520705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIqsH2Iv+JcyNkylOi9qtvbVK2jAXhmRaUsdt3ONyh4=;
        b=Vden27sIY54XmRWG67esiJ3qrzv9+slQXZOTahC13XGaNbH8pUD0ij/ue3AphgpQWj
         6vNIZhRMRBxDB4Oo0b0IoO6KhrecxOVgg2Hh0ejcUyRHkb+Sk6Zm8xWCvx4DOobvMa07
         eYfowmUNtZNDonXrEkCkxhpzMjSInkBcHUXO4dwFoiiy5fMG+MO9k25zJlLnc9iWB7qr
         poHjwOq7z+fEqVv06VFOjNtAsWqDv/oK+dRFQVEywiXWSR8Ggeei8SXSyR3Idq4HnpnX
         f5J3DOtR7w0n958HqkzhX9dbK1htcyFBGKAR+WKeMP6rBVK0/s9w/tFvrIbF9kQf4Cby
         5EIg==
X-Gm-Message-State: AC+VfDwOZvVSvv4MxQLgWPxnywd2epnx6bizWaHy0QWkrMx4/ee8m7DN
        hZmxcvMDHylHfMBeMpPVseFiJA==
X-Google-Smtp-Source: ACHHUZ4kiLB93/ITh5JfoMue+NcL7jHg5BRy3O4ysBFELCyhx65drmzzRSsbFhR7aX1DfB3Ku3E6ag==
X-Received: by 2002:a05:6a20:158a:b0:114:7637:3451 with SMTP id h10-20020a056a20158a00b0011476373451mr2561868pzj.37.1686928705404;
        Fri, 16 Jun 2023 08:18:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3cfa:2bcd:1a5:27ce])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0063d24fcc2besm4593656pfn.125.2023.06.16.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:18:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andersson@kernel.org
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Mark SCM as dma-coherent for chrome devices
Date:   Fri, 16 Jun 2023 08:14:41 -0700
Message-ID: <20230616081440.v2.4.I21dc14a63327bf81c6bb58fe8ed91dbdc9849ee2@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like for sc7180 devices using the Chrome bootflow (AKA trogdor
and IDP), sc7280 devices using the Chrome bootflow also need their
firmware marked dma-coherent. On sc7280 this wasn't causing WiFi to
fail to startup, since WiFi works differently there. However, on
sc7280 devices we were still getting the message at bootup after
commit 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache
invalidation from arch_dma_prep_coherent()"""):

 qcom_scm firmware:scm: Assign memory protection call failed -22
 qcom_rmtfs_mem 9c900000.memory: assign memory failed
 qcom_rmtfs_mem: probe of 9c900000.memory failed with error -22

We should mark SCM properly just like we did for trogdor.

Fixes: 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()""")
Fixes: 7a1f4e7f740d ("arm64: dts: qcom: sc7280: Add basic dts/dtsi files for sc7280 soc")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I marked this as "Fixes" for the patch that first added the SCM node
to sc7280. Given all the reorganization of the files it wouldn't be
all that easy to really backport it to there, but that should be
OK. Things seemed to work fine before commit 7bd6680b47fa ("Revert
"Revert "arm64: dma: Drop cache invalidation from
arch_dma_prep_coherent()""") anyway.

Changes in v2:
- sc7280 patch new for v2.

 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 5 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index f562e4d2b655..2e1cd219fc18 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -79,6 +79,11 @@ &remoteproc_wpss {
 	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
 };
 
+&scm {
+	/* TF-A firmware maps memory cached so mark dma-coherent to match. */
+	dma-coherent;
+};
+
 &wifi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 2fd1d3c0eb34..36f0bb9b3cbb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -656,7 +656,7 @@ memory@80000000 {
 	};
 
 	firmware {
-		scm {
+		scm: scm {
 			compatible = "qcom,scm-sc7280", "qcom,scm";
 		};
 	};
-- 
2.41.0.162.gfafddb0af9-goog

