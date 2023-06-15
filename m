Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C84732206
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFOWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFOV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:59:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C32943
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:59:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b52864b701so702215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686866385; x=1689458385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAopO22c0cQo1B07Jq3YUI7vEfeeDJIOwK+yowMMuCw=;
        b=kYdPWziqJQTKOZXK/DeQi6LSn/tnUZgPUTDMltfwTCtwAYRel8VcpDykKl4LRwEPVi
         qd6MvPYft5hpQYDP1sqw2gwPNeAzZdnp6uRv7I+QJoFZRxcHOcusHGQ+kSUyNuVsWvjo
         Sq9s7pio/+DQg+rsOqUWZwpHNAb5d2osLyE7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866385; x=1689458385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAopO22c0cQo1B07Jq3YUI7vEfeeDJIOwK+yowMMuCw=;
        b=XYCaZwG65M+UH9Cvx3xrtIYDL9ODY9zXSeaX/JDHFQh1HajrR1iGp/gxQ1tTvo+8sr
         BPsClzPkE/IX0SUnjOaYH4fwbox/N5b8lqrR//UKXXvUi7DBLa3Iu0ea84JJRk7pU+xa
         WImFE2JI4GOc5JdFgWAc4usebTuoR54IoML2YSrKkpXqkWh2Fl0WRsiHw9+GW3EFzQy3
         PEAs6zvVhRP3wePuhRWEM43uwmqdIDCgUVzCKOdyKBhltuAX8Uad+/bUb5XAalvMp063
         7TLiRZCJhGF59uatKF8R+B5m6DpELn1KIymzwtW42B5TTgjTdmXOGGALHSWG4CvfHgjC
         KL4A==
X-Gm-Message-State: AC+VfDzlaKs+317S3XZ/8vs8cS1WDjDduW9bsWPVCBNIqhecKzKDJges
        UDufoWdTBd9cdAdPdb3UwEhgqA==
X-Google-Smtp-Source: ACHHUZ7ibj6YXo2cm2cUI3yIc/xSJ69nj5gKAmX8pc+S2mYs2ZfSzcz2E2uwo6sPZgJFvHj3RKf5Tw==
X-Received: by 2002:a17:902:9a0a:b0:1b4:5697:d991 with SMTP id v10-20020a1709029a0a00b001b45697d991mr266430plp.15.1686866384959;
        Thu, 15 Jun 2023 14:59:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3cfa:2bcd:1a5:27ce])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b0019f3cc463absm14525354plf.0.2023.06.15.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:59:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andersson@kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, sumit.semwal@linaro.org,
        Will Deacon <will@kernel.org>, amit.pundir@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
Date:   Thu, 15 Jun 2023 14:52:54 -0700
Message-ID: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor devices use firmware backed by TF-A instead of Qualcomm's
normal TZ. On TF-A we end up mapping memory as cachable. Specifically,
you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE. Apparently
Qualcomm's normal TZ implementation maps the memory as non-cachable.

Let's add the "dma-coherent" attribute to the SCM for trogdor.

Adding "dma-coherent" like this fixes WiFi on sc7180-trogdor
devices. WiFi was broken as of commit 7bd6680b47fa ("Revert "Revert
"arm64: dma: Drop cache invalidation from
arch_dma_prep_coherent()"""). Specifically at bootup we'd get:

 qcom_scm firmware:scm: Assign memory protection call failed -22
 qcom_rmtfs_mem 94600000.memory: assign memory failed
 qcom_rmtfs_mem: probe of 94600000.memory failed with error -22

From discussion on the mailing lists [2] and over IRC [3], it was
determined that we should always have been tagging the SCM as
dma-coherent on trogdor but that the old "invalidate" happened to make
things work most of the time. Tagging it properly like this is a much
more robust solution.

[1] https://chromium.googlesource.com/chromiumos/third_party/arm-trusted-firmware/+/refs/heads/firmware-trogdor-13577.B/plat/qti/common/src/qti_syscall.c
[2] https://lore.kernel.org/r/20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid
[3] https://oftc.irclog.whitequark.org/linux-msm/2023-06-15

Fixes: 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()""")
Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index ca6920de7ea8..5e1e7c5bd474 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1194,6 +1194,10 @@ &pm6150l_gpios {
 			  "";
 };
 
+&scm {
+	dma-coherent;
+};
+
 &tlmm {
 	/*
 	 * pinctrl settings for pins that have no real owners.
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

