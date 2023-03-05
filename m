Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241F6AAFCC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCENAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCENAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:00:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676613501
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:00:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so27868187edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678021204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNKyJU1A3nLwDda34mLuDwFG/maQC3XyDeMuNX3xXp4=;
        b=DuQqpVqWqkDcnZ5wJyh9qeMFxmaMM/Z29HaavWPQd8TNmpY/Tuk1/365mL2793g2aE
         G9OLQQtfwZrOHmNLNT+hlaS5naPm8kZ6dWIwJEZ8mxeSzFwaHmTlXcZlJ/FHPBal1C2L
         BJdsLKre9MPBBfNxoPuRheDgK2yiqQw9iYYh/4LENSPGP6hv/BDrI36MTK3aXxGrJFbF
         N9VHzMBQdqkjv0gzJLSvTXZ34JIWuWy0tfLYsBMlzeL4zpl8ggE/IVoEy6UKkxAo9r0n
         Qp4jw3JLFPyIyV2UO8LPACGmNEXPWycRC/RS1v6X4UYSz3cgoTW9NiUPMH/8ROSp66Ij
         EGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNKyJU1A3nLwDda34mLuDwFG/maQC3XyDeMuNX3xXp4=;
        b=Fa6NJ7c8LV7AOhDksDYq87TGooPRRyin7KCcYwbF4SC0XuEIeWhmUpI06+qUPhNBw0
         Z74yJR7NIp2A/zkekVNRXy/ghn5ELMLyFETAfL0Js68HGqLqy2A/W65ZxnTEoQcdgYJD
         o7EwDiXHjx5iGD6YYIE9fGJOwti8HyHulEYyxe2LWKKv9NjaHKLr1WmdRLj3R4MB75PI
         xIrfDBenxTatIWtXtjVFQDxrHribOlWE3wmKX9ZGQNgeOmQ3dKbEiz2ObIP8tJP59NXP
         9l7XtqTKTcKwc99246CAY0qCGTtS5rEa7denxNnQZYWdV3laVNTs98vypPfWcC6inIbv
         YA3w==
X-Gm-Message-State: AO0yUKUfdYZipDw3Ff/Er128K5Lyp7DiT8A3sCj8az75pjHLrewCCerW
        R+g+fYmskV+KG9TEy/UTZbudaw==
X-Google-Smtp-Source: AK7set9rquQezkG6Xk+UIYKhZg4Z4FqygBpWq34M6yQvQ1hYS+ni+lMnbRHzT/boF68vndSpz85c7g==
X-Received: by 2002:a17:906:7f83:b0:877:a3c4:807b with SMTP id f3-20020a1709067f8300b00877a3c4807bmr7656238ejr.68.1678021204861;
        Sun, 05 Mar 2023 05:00:04 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906078f00b008ea8effe947sm3193158ejc.225.2023.03.05.05.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:00:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/11] arm64: dts: qcom: msm8994: correct RPMCC node name
Date:   Sun,  5 Mar 2023 13:59:52 +0100
Message-Id: <20230305125954.209559-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings expect RPM clock controller subnode to be named
'clock-controller':

  apq8094-sony-xperia-kitakami-karin_windy.dtb: smd: rpm:rpm-requests: 'rpmcc' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 9ff9d35496d2..768fe2326933 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -242,7 +242,7 @@ rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8994";
 				qcom,smd-channels = "rpm_requests";
 
-				rpmcc: rpmcc {
+				rpmcc: clock-controller {
 					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
 					#clock-cells = <1>;
 				};
-- 
2.34.1

