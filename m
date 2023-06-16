Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6D73348F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbjFPPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345596AbjFPPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:18:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087930FF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666aa1b79a3so775320b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686928703; x=1689520703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bzr12EWQk1Ia1QIrIwm9/FyosBVEjDXlJSMbab2hS4=;
        b=LUUemacRAYGTnOP8agRg8L7wFh3FfgjT5qcwrPkVa2r7X32BpPmPLJs+wZcR7Cuj1d
         LRkHyFDtzuJGJ1WRqyRW1P+Sg8ebz6yvixHJPDQeiDczvn7dK6E3rVErs+O41nJNWW8l
         w5XzPugEJUYOu7KbDIOLAkAKN92EWh4EMk6iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928703; x=1689520703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bzr12EWQk1Ia1QIrIwm9/FyosBVEjDXlJSMbab2hS4=;
        b=aECKcs7yE1abGKs6rzy8jGim14YjEqHQXvghoVepciDbINwx1Oq6Spd1SkLPJY4da5
         S8egi9YGXw/Wuu/FGtZwFpuGCVRMDonJobDLjzfNlASUaK9l339ZMrWj3JO+qnN4zJXD
         vvv9wUFZDI5wACrocKH53fW1qYDXLBDZLDiIRt1L8op3P7h3faiwTo4gIUMXtYJ/lJ9X
         Bd2Slj6T2wax7Fxdon1cKE31UYG0Rtn5tuDsff5bAF5o4X5crKJgNW+a2fgekbMP0RbL
         ZdmVln6FxI++CMhHLAnj6ChV/E3tOExq82sISiEpVDCEpFXF/AP8Ww++xsg3YWkH0ZrP
         M3dA==
X-Gm-Message-State: AC+VfDwjKpGeKO4Nz3IpMVegijzTKEOi6qt+qv54B9FwOPTZuHZtYiDY
        QUIf1a99QOkQr0v5UXDs02uCKw==
X-Google-Smtp-Source: ACHHUZ6q/PKHT/Y8LJI0/Lhl1x89/ervnctEFB9g0IQqT1NdRVzz9jh8vZkPG/Uu4lHnWKRC4m93Hw==
X-Received: by 2002:a05:6a00:995:b0:664:2f24:5578 with SMTP id u21-20020a056a00099500b006642f245578mr2788544pfg.13.1686928703185;
        Fri, 16 Jun 2023 08:18:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3cfa:2bcd:1a5:27ce])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0063d24fcc2besm4593656pfn.125.2023.06.16.08.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:18:22 -0700 (PDT)
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
Date:   Fri, 16 Jun 2023 08:14:40 -0700
Message-ID: <20230616081440.v2.3.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor devices use firmware backed by TF-A instead of Qualcomm's
normal TZ. On TF-A we end up mapping memory as cacheable.
Specifically, you can see in Trogdor's TF-A code [1] in
qti_sip_mem_assign() that we call qti_mmap_add_dynamic_region() with
MT_RO_DATA. This translates down to MT_MEMORY instead of
MT_NON_CACHEABLE or MT_DEVICE. Apparently Qualcomm's normal TZ
implementation maps the memory as non-cacheable.

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Add comment in dts.
- Moved scm node out of pinctrl section to the proper place.

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index ca6920de7ea8..1472e7f10831 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -892,6 +892,11 @@ &remoteproc_mpss {
 	qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
 };
 
+&scm {
+	/* TF-A firmware maps memory cached so mark dma-coherent to match. */
+	dma-coherent;
+};
+
 &sdhc_1 {
 	status = "okay";
 
-- 
2.41.0.162.gfafddb0af9-goog

