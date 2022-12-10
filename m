Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64E648E90
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLJL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLJL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:57:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF1210B45
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z4so7585915ljq.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8J7c5ip60j6K/JbDvYbnc+qe1oxX+R6vxNfFBKP6mI=;
        b=ILOeS5dw91ME9cPOMXoepd4GIifn49WO18NnhwymKNNVGi4DrN6ELixXe0frM5T7wl
         YkVEHac/CAhvGQrcqRmybyb7sgT54ynatCT3I+n/pk4AJ1sCodr7XbXHlTMIqrowZwae
         hb3UaqYZbrmG96Kq4cqfA5h8Mkq7Hmzh44b9plu3Jho+O/vpL/PJdnnq+FS0hxr+1A61
         zB2GHee7IW4QWY9QGIOV3vo7/hhye2q69WRTFgWEUnk1hFEeiWFVHcDj6Rr/9wQJMQ3O
         nB+PI+zl3e1Exjug1jKIVp755W0weAcuYt5YweoTYH7zCxNH64inQfPshuAVE+Qs61Mh
         enYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8J7c5ip60j6K/JbDvYbnc+qe1oxX+R6vxNfFBKP6mI=;
        b=jqvlsoi+XF+g5s+FW0IJLq9RjNglmOLEZMO7O7bS7A8gthLIniRV1lrHeJVGoizrQo
         XzGkjTw7rkQH6PO1xq2pVpVrRVYJsTHCK5O80cg6UW92Ua/gol4w2+44flGcadTQURV+
         q57P5TimKgLhfeQysaArUn8ROoGxQzVlc8woZbQPYbOq0g2oHoq5uk6tSIVBxf6InWAL
         wPH0syu6aGDkh3vEIV95H3EcM4L5KQgdsBOX7W84KlHa4ZUSxpkfYnkug1g9hJMjiFi7
         tRKa9PPDtFUMbXkUHU9/WPqHkeTZtn0Ql+NAqDKNf3ReJagO3Sx0iCK6XnoBYY00r/lI
         LN/w==
X-Gm-Message-State: ANoB5plgc2nJUUAjIkHgr5Fwodf0GnQWqJWnUN6p61NNDd7oe3aEYP8p
        xTkitaXneslB6mcFay3Cq1S/mw==
X-Google-Smtp-Source: AA0mqf6vpmIJdVDBE7/FGb0e4Pqz0d/BQUjfmTqyEnlhaRNCwVkfRn3GjxQOdbSgr2mCs80P1R8l8A==
X-Received: by 2002:a2e:8508:0:b0:279:f169:7a4f with SMTP id j8-20020a2e8508000000b00279f1697a4fmr2335629lji.47.1670673430379;
        Sat, 10 Dec 2022 03:57:10 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u20-20020a2eb814000000b002778d482800sm578343ljo.59.2022.12.10.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:57:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: sdm845: move sound node out of soc
Date:   Sat, 10 Dec 2022 12:57:03 +0100
Message-Id: <20221210115704.97614-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
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

The sound node is not a property of a soc, but rather board as it
describes the sound configuration.  It also does not have unit address:

  sdm845-shift-axolotl.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 573b2394e63f..14a409f22bfd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3972,9 +3972,6 @@ lmh_cluster0: lmh@17d78800 {
 			#interrupt-cells = <1>;
 		};
 
-		sound: sound {
-		};
-
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy", "qcom,qusb2-v2-phy";
 			reg = <0 0x088e2000 0 0x400>;
@@ -5349,6 +5346,9 @@ wifi: wifi@18800000 {
 		};
 	};
 
+	sound: sound {
+	};
+
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-- 
2.34.1

