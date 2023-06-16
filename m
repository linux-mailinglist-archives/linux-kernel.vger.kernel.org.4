Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5A73348E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjFPPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjFPPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:18:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438330FE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so58951b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686928701; x=1689520701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Nhe0vFqRJeb1rQZmWBqjIq4WANx09DJJT4hbC9des=;
        b=QwpecvflqoGMWutvgaPcnPls7DoObDDt0d0vjpKsZE6NG1fUoWbpGIAIbISWoE12o9
         Hls8pUslxLD0pUrP38RxhYHlsV2zpEWl+Sff4pDuzEc6iMzkP9epITtxGOCV6uGHqKYH
         wpa74oTP7DJWe/n7NZp3wgbzqYdIg9kCTuHro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928701; x=1689520701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Nhe0vFqRJeb1rQZmWBqjIq4WANx09DJJT4hbC9des=;
        b=g89cKlUNJH7pVUjc0KTq92C60AhxZpJYIhh2Hc2vw0dmoujYVMnqTSrXauFtz52BSg
         3w2vVucZj+phc5XxiiA9qQFCEb0XrP+AxG47wA5+KXOa9GrHNIj9rrf5fx7OLkQpVLVW
         iRmJIQARsq95KFauef8kmIbnA4fvpzMw/qK1tZ3izj5LylzHX6EosLy7Az/V7DH4UGX3
         Q/O7tTEdWvHE61lm/68km4KnkLl4X+EWhrqP7ZOywR+CcO8kFGLuIQKjty1R5GwivbtK
         5D29xq8hLwLG+X9kGrWyLdL9WRsxC93fTuG5ujZPo1PzsBisuf5r681GgOWRPqQeZnet
         2+QA==
X-Gm-Message-State: AC+VfDwPvgtvUVEaRq0h2KaHlLQfG1KkG443rL/pRFqvcXXy4wVF1RIy
        ehj/lruG6yxmzeQzyb4GQ9dnKw==
X-Google-Smtp-Source: ACHHUZ5kULJgYYKPVBKzjr2NKrXoKtFUZad8SKsKaJsNvvuqBIOeHlOBYw+g/i2luJy6VuTljO125Q==
X-Received: by 2002:a05:6a00:1392:b0:651:3e9d:2a05 with SMTP id t18-20020a056a00139200b006513e9d2a05mr2713555pfg.19.1686928700957;
        Fri, 16 Jun 2023 08:18:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3cfa:2bcd:1a5:27ce])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0063d24fcc2besm4593656pfn.125.2023.06.16.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:18:20 -0700 (PDT)
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
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for IDP
Date:   Fri, 16 Jun 2023 08:14:39 -0700
Message-ID: <20230616081440.v2.2.I3c17d546d553378aa8a0c68c3fe04bccea7cba17@changeid>
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

sc7180-idp is, for most intents and purposes, a trogdor device.
Specifically, sc7180-idp is designed to run the same style of firmware
as trogdor devices. This can be seen from the fact that IDP has the
same "Reserved memory changes" in its device tree that trogdor has.

Recently it was realized that we need to mark SCM as dma-coherent to
match what trogdor's style of firmware (based on TF-A) does [1]. That
means we need this dma-coherent tag on IDP as well.

Without this, on newer versions of Linux, specifically those with
commit 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache
invalidation from arch_dma_prep_coherent()"""), WiFi will fail to
work. At bootup you'll see:

  qcom_scm firmware:scm: Assign memory protection call failed -22
  qcom_rmtfs_mem 94600000.memory: assign memory failed
  qcom_rmtfs_mem: probe of 94600000.memory failed with error -22

[1] https://lore.kernel.org/r/20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid

Fixes: 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()""")
Fixes: f5ab220d162c ("arm64: dts: qcom: sc7180: Add remoteproc enablers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I realized that this needed to be in IDP as well and that the IDP
patch actually needed to come _before_ the trogdor one given the order
that things landed upstream. I still left most of the description of
the problem in the trogdor patch, though. Hopefully that's OK.

Changes in v2:
- sc7180-IDP patch added for v2.

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 5 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 9f052270e090..299ef5dc225a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -393,6 +393,11 @@ &remoteproc_mpss {
 	qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
 };
 
+&scm {
+	/* TF-A firmware maps memory cached so mark dma-coherent to match. */
+	dma-coherent;
+};
+
 &sdhc_1 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f479cab8ab45..a65be760d1a7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -369,7 +369,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 	};
 
 	firmware {
-		scm {
+		scm: scm {
 			compatible = "qcom,scm-sc7180", "qcom,scm";
 		};
 	};
-- 
2.41.0.162.gfafddb0af9-goog

