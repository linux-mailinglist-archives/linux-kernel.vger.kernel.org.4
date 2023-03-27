Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F86CA4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjC0Mxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjC0Mx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BB198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n19so5010365wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqs1fkBQs8nw1jpdBWvEsWXPgVAImtCVIZ35WMtgf4Y=;
        b=LAausXqslBfOWHdLTIbdWiSB2uQLF7qvUx7rTugsESHd6BLL/Nxcz5U4OC6TMW+hf7
         RCiSKCzrqLEEYLv7e4AtCKh7wuoOJg7v0qb+8obWdAPQHescy6yuwryH90qv05cKjSfJ
         nVjO9pw2MatOvFen5n+tiYxzZbp4B3ybgK0pi/Fhx7/ExWiEGsfwH4DiB9tC81v40WEK
         CLY1ZJvdCAKYxN5xXI9vXpFnx/rvd8lOpMuzYQQr3ze1yfDD+McNOfSn3oEpQXgCfMEv
         c9jquI6ZThkU58jL+G25eEP5KuVqadmrf3aQ+5wZMEs+i1xsieLcMES273cvpOxC04gR
         sUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqs1fkBQs8nw1jpdBWvEsWXPgVAImtCVIZ35WMtgf4Y=;
        b=bL+IhCs2D2ihW1p7kQKDtjBsAYrxUMPRESwOv8M0OMxIh21lkd5eEAsmcMsuUFt3aT
         fHyYFzSyVnVMkT/09irpbA4SGhbjnI7TGtqI7AB7Ag+EFtIFId7U46WPTppG/HyXUlaM
         MLJZ6SUuYV4PIftBKxc6W2oW2XeIfBS2AkgbDC9bt3VJApabG9QUJOI6zv/BoNDKIMQl
         UuY0pfnrQYrdDhGEegOdwB8oBDnH07fTJB5Uw7DtKe92X1OIpDlDlLDiVP2P/y06CzGG
         Kh8stvmmh44Osub751ZvrAVhA2Wf0wKV0NSoogewjYPpjKZ69gSPH2OkQBAAhTwJsJ6S
         f0vw==
X-Gm-Message-State: AO0yUKWq/w8gcLeswn7zKWjebG46i5cNtMC5yc3+c6dxBRptRXoO4YSx
        nH3vGiO36S0wEKavUyJGqlpGzQ==
X-Google-Smtp-Source: AK7set+GJrq9WCTESgejHy8VIVpRUZcxemrJkaUssAb5F3qglJLgqnINejfzEiRq88QQN8o+OMpJrQ==
X-Received: by 2002:a05:600c:d5:b0:3ed:bc83:3745 with SMTP id u21-20020a05600c00d500b003edbc833745mr8730794wmm.25.1679921603468;
        Mon, 27 Mar 2023 05:53:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 04/18] arm64: dts: qcom: sa8775p: add the pdc node
Date:   Mon, 27 Mar 2023 14:53:02 +0200
Message-Id: <20230327125316.210812-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the Power Domain Controller node for SA8775p.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 296ba69b81ab..6bb1db1839cc 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -591,6 +591,53 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
+			reg = <0x0 0x0b220000 0x0 0x30000>,
+			      <0x0 0x17c000f0 0x0 0x64>;
+			qcom,pdc-ranges = <0 480 40>,
+					  <40 140 14>,
+					  <54 263 1>,
+					  <55 306 4>,
+					  <59 312 3>,
+					  <62 374 2>,
+					  <64 434 2>,
+					  <66 438 2>,
+					  <70 520 1>,
+					  <73 523 1>,
+					  <118 568 6>,
+					  <124 609 3>,
+					  <159 638 1>,
+					  <160 720 3>,
+					  <169 728 30>,
+					  <199 416 2>,
+					  <201 449 1>,
+					  <202 89 1>,
+					  <203 451 1>,
+					  <204 462 1>,
+					  <205 264 1>,
+					  <206 579 1>,
+					  <207 653 1>,
+					  <208 656 1>,
+					  <209 659 1>,
+					  <210 122 1>,
+					  <211 699 1>,
+					  <212 705 1>,
+					  <213 450 1>,
+					  <214 643 2>,
+					  <216 646 5>,
+					  <221 390 5>,
+					  <226 700 2>,
+					  <228 440 1>,
+					  <229 663 1>,
+					  <230 524 2>,
+					  <232 612 3>,
+					  <235 723 5>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		tlmm: pinctrl@f000000 {
 			compatible = "qcom,sa8775p-tlmm";
 			reg = <0x0 0x0f000000 0x0 0x1000000>;
-- 
2.37.2

