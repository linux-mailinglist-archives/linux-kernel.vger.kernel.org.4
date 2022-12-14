Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF364D153
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLNUgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiLNUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627226C1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so450617pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXo7ON+W+HqSzfMLSf0nu5/9om0aVHW6nmyC6DVkBmI=;
        b=XMacLbFeRR4Jifz4+Q63pAto3sNGhGFs7D/C1Jtc9QQeGCWJRFI9tvaxikbQ2t/Dco
         G4gssaES0KuTv0xIEbouEsR5nQPUN12ph2mTl7f99Uj+lsVkI/5E7vYiBMxy95HKhXdC
         4g20V7tkXglVZZRAL3X4miN88lXYqVjsHqTp+83qH2J4i0oVpcJR6jXyE4gclz3NfinW
         LQn4wBQ5M4Uj63PvZevVA5hRSggTsXftzAenddpZxNwfgW7p+Hez6dSAXeTTYDeoXjF/
         PLX0+mxUxBiprC6yxUcGwXSIxO/DapOC27xIn07FyGShU/pveYYzB+vvAaN1qsUhHqhK
         VZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXo7ON+W+HqSzfMLSf0nu5/9om0aVHW6nmyC6DVkBmI=;
        b=vX1g4K8l/CXrqB/ZGQ/yUjLNgPii+J8GS1q/wBUHFddOp3u2/OF7EljfNrMqSvU2/z
         dDrWK4N72SI+FYb+dEfgbRdbybS/7igRBnIoRL/q4p1KUgk+dqwc6A8nzI3AS0fkf40q
         +I2Tu5Fk8Ds2apfe/gcLBNOODIS/dWB/eaWXOWJIxnaqd9QNApzmzm0pVsRtqqF9uQQ5
         HLZEU7mWSROwMxz7Uj2uqfaXc7bgi3wl9yEvu2hAOmICbS/IphYcIjaUrzLf8z6NTgU2
         82nOa7c6AvbXJ0W1fnuW6FI8VT71nVeAfXov0JtL3bmM853bqb7Z9GXtaMuRKXGyPB5u
         +RBA==
X-Gm-Message-State: ANoB5plMRAlKYbpv18JLbCoIBNjBKbiZskuuxq3TABwMITUg1C4raR4/
        RwbiF0f8TToDhsc3iTgRMSSNQQ==
X-Google-Smtp-Source: AA0mqf7gbCnQyLrxJw4M6FcVDByhc7Y4y2bkdQGassD9WGwBwZ9ttLkWeVbsTZim+PqXUoslZyKT+w==
X-Received: by 2002:a17:90b:378c:b0:21e:1282:af42 with SMTP id mz12-20020a17090b378c00b0021e1282af42mr23121685pjb.40.1671049912274;
        Wed, 14 Dec 2022 12:31:52 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b00219e38b42f5sm1812238pjb.26.2022.12.14.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:31:51 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and 'dr_mode' properties to dts
Date:   Thu, 15 Dec 2022 02:01:23 +0530
Message-Id: <20221214203124.564537-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
References: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
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

Normally the 'maximum-speed' and 'dr_mode' properties
of a USB controller + port is dependent on the type of
the ports, regulators and mode change interrupt routing
available on the board(s).

So, move the same from the sm6115 dtsi file to respective
board file(s).

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

