Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1F64B554
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiLMMlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiLMMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:40:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555141FF96
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:38:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3369506pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RVsCHc65/n25Apk0UMd5OFnRvCxYzOfIak3gevXkuc=;
        b=fst2QKHMJERtQiH16RRC3rKQIEuuNljc0CVfv+0XMUPYg9KlibsyhsD0p59YFXX8XM
         /L4skjMsfkhD0BfpCHlLCU8h/TwgevUNKj6rY+Lcejee8/YadDX/GruHfgP0NOPCh7eE
         0IlvUWP0rMiR1gyh0K9Boejq6J2inl9i1eYiLa9PK3J4W17Cs5mk5E3BDtzwgkBW5/lA
         x65/s26oLhjrglThUidAB2P8cHLdR7H6CNiPDvGCxjh9FQrg+OXkCzxU5sF8ob0+pTmP
         GcH9FrknynLa9D6d7Jj4rgWwdBGpm5KSpbKk82HsXCogzDuf5BTdlLjzz1Q07A8n7RJL
         RKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RVsCHc65/n25Apk0UMd5OFnRvCxYzOfIak3gevXkuc=;
        b=hCP7IWur35YDYRBAlFst93iTr+pDP8OiYfgXUfW3v2GqO4OMNZyiXLqyPnb2I6/rU0
         uODoVyvprqJcUivEh/uxuAWhp7IuBnAF3ngtYWO1vZkJInpqY+G3kSEokILJIsYSKPTz
         /KthqixGQB3wVaiqyxCjLG9WYpCP+3ncRIEGFYs+JTGa37oH5J9mKkcBb11pFeCMPxFB
         ImjeJNhOnM8b/CbEI04MkOvUYM19vfWqXPy08HJZv7FpZDsNQeTL7Acz+Y1NWqMw0pTH
         tkQDN2Z9S5Pxd/pvyNYXf24o3ha2YnmRtJUQOaco7vZUiAzXwY811a49IouqMo2gaVTS
         N90Q==
X-Gm-Message-State: ANoB5pkI2NLqLx/lrw/I9fhFP9EmLUIxd8dS8WiHXf0PV7Pd6I6kCgGI
        nyCcFjipVtdNH8ygms5pGklwYA==
X-Google-Smtp-Source: AA0mqf4yhWgLXFEtHPOzR+dKB3bwqHUul+V7vZkVUZ8+EhHWweTcRbp2fdEAgwBcm2hyVJuYZo8gDA==
X-Received: by 2002:a17:902:7890:b0:188:fc0c:cdb1 with SMTP id q16-20020a170902789000b00188fc0ccdb1mr20388196pll.16.1670935121723;
        Tue, 13 Dec 2022 04:38:41 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902c44c00b001889e58d520sm8297011plm.184.2022.12.13.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:38:41 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and 'dr_mode' properties to dts
Date:   Tue, 13 Dec 2022 18:08:22 +0530
Message-Id: <20221213123823.455731-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
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

Normally the 'maximum-speed' and 'dr_mode' properties
of a USB controller + port is dependent on the type of
the ports, regulators and mode change interrupt routing
available on the board(s).

So, move the same from the sm6115 dtsi file to respective
board file(s).

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 5 +++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index fa57f4bf58256..3f39f25e0721e 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -229,6 +229,11 @@ &usb {
 	status = "okay";
 };
 
+&usb_dwc3 {
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
 &usb_hsphy {
 	vdd-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l12a>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b5f7480c2e713..e4ce135264f3d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1031,8 +1031,6 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
-				maximum-speed = "high-speed";
-				dr_mode = "peripheral";
 			};
 		};
 
-- 
2.38.1

