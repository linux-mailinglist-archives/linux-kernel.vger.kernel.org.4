Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD74656CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiL0Qce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiL0QcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:32:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544EBC21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:32:03 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g13so20251694lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj3odR24R3zltoZ8J0vvuKsCnJFZ1r/NGOBMtXzcGls=;
        b=BJqrcT6WZus5i8s+2oU+P2gJAgp1c8WWSeXt36RLawrbLJzLL/xxIq5obXGVMDaADo
         ZFs8cG+V45I5V4ife5KLrUA/j9Gt5er/wznTBA9EXCNWIj03SFlshD7DAb7MZmpfa29w
         IWr6It9bF7HX5hrefh4QDvx58nJLgdLZXfNuHDylWr+9jMvD+gOyuVcxq8V8lO/Jqa6i
         k5DBCO2gwWhQcXT1GL2iaFu4EmIoJXgvul2/zDp04KHRZfSQkFaQo1s1UDDjnrPOxb4Y
         XqIqihPzCBfArf18vd8VpGu95Aw5Wv5C3NTLliM2AbNf9My3TuuHdkoLYdJz/JW5fBKv
         n1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj3odR24R3zltoZ8J0vvuKsCnJFZ1r/NGOBMtXzcGls=;
        b=k6mcQStmRfseCNLZLf1eTXEIXj9VlUIzOX2bkXGTSYSWk25aHWxs9shGBzZxb0SQRn
         63GGpJWOPl0AguoEh8i9O75HRiSrZorZpwalEqW84ljtptjTJ/mMO4B7xsJEPSsHP8OI
         0lzO0IDYgTh6ukDzQ1f281zanajmKEMBP+UuvYEYvzjKU+1RArjwAqy79dVjhZq8UEd0
         E6TtYdilh3C8KPoSK1JCPfsFugd5FD0Qg/IwvRYiH3IkIRL8CYpbl1PdCOVtKm2msDTA
         D+YzAzDHKJgMjWdYuTnyD5nlqT7NFLU8UTw7SBYEWxIl8zvxBvgjdDQe25TQcrq4pxQb
         muVg==
X-Gm-Message-State: AFqh2kp8WBLnkJIYNAUEBb6lcO1KZxb37mvii1GPqMeUZm258Sxcty1x
        /i+zMueFZHXyGcwTOY/L81QaEg==
X-Google-Smtp-Source: AMrXdXsR/f5ChOpOBVEToYJox+k43YLCl7w7oekaq//lCeatIW6bPIGiR8kmybCiHw3OC6WqAs1bcg==
X-Received: by 2002:a05:6512:3ca0:b0:4b5:b7c3:8053 with SMTP id h32-20020a0565123ca000b004b5b7c38053mr6901004lfv.42.1672158722840;
        Tue, 27 Dec 2022 08:32:02 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm2319853lfb.29.2022.12.27.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 08:32:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc7180-trogdor: align DAI children names with DT schema
Date:   Tue, 27 Dec 2022 17:31:58 +0100
Message-Id: <20221227163158.102737-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227163158.102737-1-krzysztof.kozlowski@linaro.org>
References: <20221227163158.102737-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect DAI children to be named "dai-link":

  sc7180-trogdor-coachz-r1.dtb: lpass@62d87000: Unevaluated properties are not allowed ('hdmi@5', 'mi2s@0', 'mi2s@1' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d134d172a3c5..64e85cfb36d3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -788,18 +788,18 @@ &lpass_cpu {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	mi2s@0 {
+	dai-link@0 {
 		reg = <MI2S_PRIMARY>;
 		qcom,playback-sd-lines = <1>;
 		qcom,capture-sd-lines = <0>;
 	};
 
-	secondary_mi2s: mi2s@1 {
+	secondary_mi2s: dai-link@1 {
 		reg = <MI2S_SECONDARY>;
 		qcom,playback-sd-lines = <0>;
 	};
 
-	hdmi@5 {
+	dai-link@5 {
 		reg = <LPASS_DP_RX>;
 	};
 };
-- 
2.34.1

