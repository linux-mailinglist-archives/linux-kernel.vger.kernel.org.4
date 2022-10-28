Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936B26110CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJ1MIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJ1MId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:08:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270C1D3C61
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so12464380eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHQKP2WRD5u3btbTtOeqec49hRgZbwQ4CBFF9a5nqqE=;
        b=aGwFe+cjRvwTlK/2papTY0NVUyA/CNvUDd7Ev8PSs7yCSU2oteW21EellklP66v9ds
         KIYAGe72henmkXbOHWcpsAw58ZRYYMlpzkKBdaCouisIXGjNeM51l+fnfJRVxG1rletI
         EPXzN4DAf60BpUAWAbETa5/POlpNbDYK+iYHgr7+UjWvlhn0BdPoajyLi7DiXjHXFwF7
         5TPDEa8qo7ijXEhleBE2QqZNKhrlKHap8MyfC1TGoapKM6mOWs2P/uSCQrd44bALdrCF
         c11TcvVoG1zlPXxj+G4To9A4lW9xGGQgZppO0futtKUYoXc/s+PlauNCETyZezF549/e
         GGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHQKP2WRD5u3btbTtOeqec49hRgZbwQ4CBFF9a5nqqE=;
        b=B5hXrFEIVISHoQcNqecZbfK+/y39dQ6tmUAphkbnIN5ifD+XvptE6uDYLQVzYHIEzM
         m2ZVyL1ZthNVFE7Chd6X6jldMEMlFnD0GJa3bDlJXv87nZbkMMXl1XD+scU1yc+aAKdH
         1SC/Yqjki+SMdHB3qzChJ3vM30vF0axfMXlC1LyNEoH4wxHfxzYRnplOSYTzHWh0+lWP
         rylJ2aD+/kLJX57EvwGZWTBpezYHRBRyU4+Jiz9rFVHNnkEGU3+mAjGUlNRZY6jcAxxg
         aWnEY1t6OfCcVagbj2qYPlkutA3/Jp2DAbKJV4EPoRWMmHs+TRY+Qpl+ul/yj2LythDF
         CmYw==
X-Gm-Message-State: ACrzQf1teCS2UlvvPRpHYOj+spoZ2tVlcBODpBp9OEIBzgX6ItBemTrj
        zHPwC0HVB3p1lMjxhNCo5aeEkw==
X-Google-Smtp-Source: AMsMyM6UPjeZggV2ofJpsk9MB/vfhKTLc/1WSnx0EL1Rb6b9o80UYFxJes1SuMKfqvZxbCq2MkoKbQ==
X-Received: by 2002:a17:906:9c82:b0:781:5752:4f2b with SMTP id fj2-20020a1709069c8200b0078157524f2bmr45370555ejc.561.1666958910136;
        Fri, 28 Oct 2022 05:08:30 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906124d00b00782e3cf7277sm2067258eja.120.2022.10.28.05.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:08:29 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: [PATCH v1 5/9] arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
Date:   Fri, 28 Oct 2022 14:08:08 +0200
Message-Id: <20221028120812.339100-6-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028120812.339100-1-robert.foss@linaro.org>
References: <20221028120812.339100-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmxc power-domain-name is not required, and is not
used by either earlier or later SoC versions (sm8250 / sm8450).

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e72a04411888..606fab087945 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2557,7 +2557,6 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 
 			power-domains = <&rpmhpd SM8350_MMCX>;
-			power-domain-names = "mmcx";
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.34.1

