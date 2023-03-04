Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B36AA9C2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCDNDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:03:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF4F975
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:03:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so20564949edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4G0qf8dTLAf7njJtTk+v5kvGa3NoxWfF7xQsqRpSsI=;
        b=m/klVkfAgSPv+uTNFsJ8A5ctXJYY/KiwphuQlOBDbOEL/vy3ff2SXXQitiydbvMvyN
         Kuhl2fhYwCAF5stVkO2EXDIDMMSIGG7LdUC44TgiW0yCy8OOQUm0peClCvzsT/NXkBVs
         rLEZYKmN0OOU1bt5MbGUCwuDjEHP7yFg0upOQ6lwV2qg7pspr281EdIcsUU2oPn7/XUX
         kzhSbdD94eAKv7XZWpeF4WNPepNUb6qmnZqnUV9p4xAygf3vZzcgTl2Iwu4haO8qQUVF
         gH7md4CSkL8KyCHZuA9fL7czFJhQljx0yv+0u75BOZiTWZ1O6b1rbjpJAoqBmBiu33jX
         2GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4G0qf8dTLAf7njJtTk+v5kvGa3NoxWfF7xQsqRpSsI=;
        b=jJd+9atEkcMOsyXyDAidi4dqTGJEIybK8TA+Qsc56ei/Aaf4e5u1FPJFJ2CHjWfEi8
         0xXfBKtY604D+plFCmCRNt+FQhkemgWZxuCS6JMh4scwXup94eedzFnrzDy9q2jYpJ3s
         NBn2rW1tPk+O+/sAkUjijEgkAtOe+I9OgFgahxuhg+ItbloV+7eijLKbKvSlXyc3cn48
         Qwz7bkoea7qFloiWSfyZ04kl81KWHpo+I+GaDUNO6q6aAzsL3Yb4bGpEtM/5kO7QGILa
         ojEms+LcpCC3gYsv5tbE+AfMb9JXS1IOIUCyGUt5jGkVC8FLcP+zYcvsHaUJN3+Z922g
         d0mg==
X-Gm-Message-State: AO0yUKWdo27z3VK9+h4D/YAqFDC8JHNn4k9q4+21Wz8rVG1+hCoOdqSb
        6yF+kAMa2FY9zGpDU8iMVfIDGw==
X-Google-Smtp-Source: AK7set/2/4SvFV+0OjnWkKgPftA7+FeQxNKdBT7hxrYftfHnpyHOQycxdNqNjHQOHBoKz7fazax2NA==
X-Received: by 2002:a17:906:4882:b0:8af:3739:bdd7 with SMTP id v2-20020a170906488200b008af3739bdd7mr8098256ejq.27.1677934999664;
        Sat, 04 Mar 2023 05:03:19 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b004c19f1891fasm2423220edd.59.2023.03.04.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:03:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Katherine Perez <kaperez@linux.microsoft.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8350-microsoft-surface: fix USB dual-role mode property
Date:   Sat,  4 Mar 2023 14:03:15 +0100
Message-Id: <20230304130315.51595-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
References: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
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

The "dr_mode" is a property of USB DWC3 node, not the Qualcomm wrapper
one:
  sm8350-microsoft-surface-duo2.dtb: usb@a6f8800: 'dr_mode' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Fixes: c16160cfa565 ("arm64: dts: qcom: add minimal DTS for Microsoft Surface Duo 2")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index b536ae36ae6d..3bd5e57cbcda 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -341,6 +341,9 @@ &ufs_mem_phy {
 
 &usb_1 {
 	status = "okay";
+};
+
+&usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
-- 
2.34.1

