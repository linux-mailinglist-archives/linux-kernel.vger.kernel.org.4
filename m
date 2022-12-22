Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29C4654400
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiLVPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:13:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F6F4E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:13:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so3171048lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBkTlHTCV7DoPL4le/mwbRFxHR8aDtr9pUpYPexGk+s=;
        b=zKD5pFwBrN18kAEJOxOpEZiGnAxtZZRyJZP4Z02dzse7A5bBM6cuPBOHL33RF1lrsp
         Nvzw9ZEYCW6LB0mRHqluqA2HaGP430lbfcPwdMs9zqisP9wpbLHftldIc0HpAJNF4lIm
         HLymmIZLItMAMzzH5UJ5GEGRvlZuVN5wov5Le8ayUC8cDuANvWk4Qf5lcU1IUIOT2+9s
         HlZ4ihzOJhduYkqfVDm95ejYrPE0copTH8NEfoA3D3JQ/StBG9qxhP2uv08YXtQBj9nR
         y5M5H+wvJHUQf/CpHMCJ+a6k1eXpp4jukhEUDJ86PSW4qySMiFkviKUUcAVnEyuLbPI3
         GJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBkTlHTCV7DoPL4le/mwbRFxHR8aDtr9pUpYPexGk+s=;
        b=gAngD0RDJPknVMx3W/pI+8VvfqxQwMqee7fYCq0NOQvB4ufNda/1Lsb4C1mB65QEJ+
         xHkIePD1/3qQ0QqUxFuKZEAFAXemoWEfe2l6KGDJTJcanqzfrgZVHHSGq3XOlSqAu/tt
         LlRkcOF5RzOsku0roq68DSB4gdpGuCFM+vS5CVT+GaZH4E7Fy7eA1Q/+KD8LGtotmso4
         D0ags0C35LOgCc5n1AXM5e1jJapdgWCYp1c2hEnaSx6idei7nRo9PAMx1TERyaIgTDjh
         fICfHxKPqc6Tw27sD2zBlZvkuWwprmfA0EgkHrrrHZHom/7Pbzvg4TxaukQW2V1557no
         cgsw==
X-Gm-Message-State: AFqh2kp7Ta43FM05C0h2r5ZVSCCdJ09VjLF0LJjkjkhnkJ7R9XVMAq6f
        b5a6HEEw1hHdiI8KN+knQQRdwQ==
X-Google-Smtp-Source: AMrXdXvPSg3Ce9ePCSZpKhITo9ZVUUwl+XZWcxQZqS5wNHR/5HJ7vEGSCyjbmdN8Ri1rtr/+1KYC8g==
X-Received: by 2002:ac2:446b:0:b0:4a4:68b9:66cf with SMTP id y11-20020ac2446b000000b004a468b966cfmr1473439lfl.26.1671722003702;
        Thu, 22 Dec 2022 07:13:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b004947a12232bsm91269lfo.275.2022.12.22.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:13:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 1/4] arm64: dts: qcom: sdm845-db845c: fix audio codec interrupt pin name
Date:   Thu, 22 Dec 2022 16:13:16 +0100
Message-Id: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The pin config entry should have a string, not number, for the GPIO used
as WCD9340 audio codec interrupt.

Fixes: 89a32a4e769c ("arm64: dts: qcom: db845c: add analog audio support")
Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Cc: Doug Anderson <dianders@chromium.org>

Changes since v3:
1. Add Fixes and Rb tags.

Changes since v2:
1. New patch.
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f41c6d600ea8..774e4352f299 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -979,7 +979,7 @@ sdc2_card_det_n: sd-card-det-n {
 	};
 
 	wcd_intr_default: wcd_intr_default {
-		pins = <54>;
+		pins = "gpio54";
 		function = "gpio";
 
 		input-enable;
-- 
2.34.1

