Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B960F15D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiJ0HrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:46:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208C168E68;
        Thu, 27 Oct 2022 00:46:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 130so708459pfu.8;
        Thu, 27 Oct 2022 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6Hvc44I/ESMlqa43mGR1Qp3cCc/2vV67IQonLZ5Kj4=;
        b=XMZJXb2aMniO3wi3vct3lmCMu1sgd0TZS9mPPFUv3uGyO5BbE5Vv2eA13j3ZzfIrXn
         6jbK7dsBJ4YJSk7BJUNfc6P1Ca0Ln/HlhrzBd6OEEgtM2rxGwUE+6iaFgK9tLf5K0Icc
         bDZLqc8OIuhiZE8jkI9pXQfqg4Au9OrWeQIYnvYhKbO23XlImrZmoxRZsyz+1Tp7CwFd
         8FUBnvxFarrfsb8wMGegH6xyUoxYQn/fKDIpKXeG6yGgf6jaUFGo1kwtrmdPeQmTMKuy
         TlorfTpS+AJLKmlIiaqfcWxE7x7Omp+AjPh/rPEnQIGoxjQX1y0oZCTlItdFrknEaNPs
         NwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6Hvc44I/ESMlqa43mGR1Qp3cCc/2vV67IQonLZ5Kj4=;
        b=beQcFAlkpYRBqMlo54EzrrrFW9IK0WiXNRLOrDRzv7MXf4sBM/PhQiXh7FD5FFkB1b
         AATaEG6r0w9y5n4gWhuA3EDlwRXpl4ZTd09fgrJDzk2Oj/kBpEx6A0pi/vXVTOAxivdm
         MeBfe1Z8eiqiSJW/vvmAek4Xw6yiaq7TNcn19NPigoH4/MKXaB3uOcK3mxaNZjr6T9Yl
         ThCUUZheb6911go1kkQs9G0YvA+BZbuPok7xwQbGyWdvwtw2nz2uKVM4EpUZLDgJ0ZWH
         y9hwxA4sceLjLuKRftQwNgOU+4WTZidvEAml1ZQC4Fxg6IpK6Ajzo/e08Cv7rVEMJrMW
         /PpQ==
X-Gm-Message-State: ACrzQf15cy1GI6c+z+1A3NFavMEXqa2yzxRvWLmPt6g2S2JPjXQH7CWn
        uE/DzXnqvWc1M6W03m3Zk2o=
X-Google-Smtp-Source: AMsMyM4SAdo0yIHCUNKVJcMdSQZ6/10dChczVTXApEI92NIcT0SnRLaHek+Q1nUaGqS5ytY5EY39Vw==
X-Received: by 2002:a05:6a00:4504:b0:56b:3ed4:1fac with SMTP id cw4-20020a056a00450400b0056b3ed41facmr29774692pfb.73.1666856817535;
        Thu, 27 Oct 2022 00:46:57 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:46:56 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ASoC: dt-bindings: wcd9335: fix reset line polarity in example
Date:   Thu, 27 Oct 2022 00:46:48 -0700
Message-Id: <20221027074652.1044235-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting the block, the reset line is being driven low and then
high, which means that the line in DTS should be annotated as "active
low".

Fixes: 1877c9fda1b7 ("ASoC: dt-bindings: add dt bindings for wcd9335 audio codec")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 5d6ea66a863f..1f75feec3dec 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -109,7 +109,7 @@ audio-codec@1{
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpios = <&msmgpio 64 0>;
+	reset-gpios = <&msmgpio 64 GPIO_ACTIVE_LOW>;
 	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
-- 
2.38.0.135.g90850a2211-goog

