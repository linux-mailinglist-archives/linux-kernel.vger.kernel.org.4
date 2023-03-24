Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18896C86BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjCXUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:22:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F21A979
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eg48so12303091edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679689373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/8nQNR94y6t/5VtqhjM0ZF/6A0ua7j5oOvHfSU7/lw=;
        b=dOc9jhY4N8YUGBiv3x4wPxr0n0Ngf+V+/Ic6NC5TVhIqdInrjGYBYDga1mDDCSZwFj
         hSdUfR7+thm6BAERhP/nq/tNpTMWsqJt79ZiC3mpj58YFzAf8AwPn+0Fuyq1YHbBKoHj
         dLVSj5l8fMovmDjp3L73aqAase+rr8xgW81Oq29MJ6EqKVp8TTmw0nZgJ2aHIalgtFLk
         vj9gTsEV9p0GqHfrJ4ZGSznCXnzipkeBuMHMwhKv7NWc2cnAgOfjsUMsRlg+FzNXxbow
         53zGQMBXZ4uVUUg8Hm5LLjGdnq3RWsPWSW+PtRGZ9+lVvZNQfloZehtiRW21i20t61C1
         5r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/8nQNR94y6t/5VtqhjM0ZF/6A0ua7j5oOvHfSU7/lw=;
        b=zivUxE5zIG9IWoZBnI4jl36h6xgfTqhn0ALMY3BSJFN9HacAXGzfUm6dBd/Zc+OV2V
         CGkjr7c9psiv1sGKL2gyuWY+aGyjGt5SY3FQ8ksRWU1ok1Szk53zvUZTrKIu81uiP5P5
         ME15U2YOfp4D3YOx0294/UriQCpemZDXY3C2mQdx2F/0BaKw9SAE8dHfyah8mEMiGp+G
         48JVtUwfxLjAvoFgqAtyWVWq2kPVFEJlH9tv5EqLlf8wdCpGmDsmiwmJFWOE4SI1cfn+
         I+TPXVaXKBlmk3aBDUUY3f7YOiaKthbpakMziuMk+ac/y7nqsPlniTmnDNHxtN3rCIpi
         CyRQ==
X-Gm-Message-State: AAQBX9cgXYyHKvAP2ODf0WPS5cAc52pn/HCxJOOWrBmQmoJBYR8VFZVW
        TUB4ytrd8KTJXO25LyEMhEIegw==
X-Google-Smtp-Source: AKy350YH+zPRg8shFxXaRMmprKSP+i3s/64H9neodx8jC3NYIjHU0yXtyu2ZX+el3QRtfd6e/X9HJA==
X-Received: by 2002:a17:906:5299:b0:933:4dc8:972d with SMTP id c25-20020a170906529900b009334dc8972dmr3907248ejm.20.1679689373313;
        Fri, 24 Mar 2023 13:22:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm10900041ejb.176.2023.03.24.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:22:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] arm64: dts: qcom: msm8916-thwc-ufi001c: add function to pin config
Date:   Fri, 24 Mar 2023 21:22:40 +0100
Message-Id: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings require pin configuration nodes to have the function, even if
it is GPIO:

  msm8916-thwc-ufi001c.dtb: pinctrl@1000000: sim-ctrl-default-state: 'oneOf' conditional failed, one must be fixed:
    'esim-sel-pins', 'sim-en-pins', 'sim-sel-pins' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
index 8433c9710b1c..978f0abcdf8f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
@@ -44,18 +44,21 @@ &msmgpio {
 	sim_ctrl_default: sim-ctrl-default-state {
 		esim-sel-pins {
 			pins = "gpio0", "gpio3";
+			function = "gpio";
 			bias-disable;
 			output-low;
 		};
 
 		sim-en-pins {
 			pins = "gpio1";
+			function = "gpio";
 			bias-disable;
 			output-low;
 		};
 
 		sim-sel-pins {
 			pins = "gpio2";
+			function = "gpio";
 			bias-disable;
 			output-high;
 		};
-- 
2.34.1

