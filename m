Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E867232C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjARQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjARQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:27:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB558961
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:25:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1947061wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5Exmqod7rYxyDVLS9FkOBJX2qhHGgIWItdN+1JD6iM=;
        b=Kp8CojqRPzwg0gnuCcldt7j8PZf5BgsV6fhJwA0cZqV8qIH2kb/BwSJENcOce8fjuX
         Ov7cQPWFmZSkezEWMQksWgVVrGWG2RpOpqOPrlXuRT69savpHxiyQoN3rZmxYe95x7v/
         yBM8SVkjtZ2aE3jN4SjuIJt5s4wp7c47PdJf63tlYWlabGfWIOQmzDWBo9OXBjcDbaEO
         v9+NBIHoyDR/wyIZlv2jz4Df2zCMkJ1tQK/l2fWXtTdnBZ/O6EbAMfZ7y1pa4zB7P89e
         enRHzWA1PPEnjKHJiBBHhlEkFU+F1QoMYxjPsHZjU4fa95xaOeHbpwtrZb5+UVmRCpb1
         L5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5Exmqod7rYxyDVLS9FkOBJX2qhHGgIWItdN+1JD6iM=;
        b=1V1mM4rrKhFyHHKxwjEAWZ9M8Zz+hrazbcWdIQlTJcVeCzZwPK7WdIVvLOxvFSlhIv
         KEyENdpUkGB/7gHSFEVw3kyU7ecvgHgGsPSJ8xV+84/it0ZZD9FD6Iwkq5eQjIyeOxEo
         k9QPVDQjwOq5gfKgT1CPUjY6ZrcD8XLAFakWElwJX2eIOtlHAbVLImYEuALpyhoZx7l8
         r4+ZlFGDDGOAMA/Isac22Uhafr1IkhlOpnHbDMmuUYeubRDEKncKLEtMbc1LpZyawYIx
         QDRr7PERoUAp5JNIQgwxtIzUHaXyeD1CIr/dYb/f4phllX759fmOiUAtrX71c9ix2JKd
         XWiw==
X-Gm-Message-State: AFqh2ko5bB3NzxXyISFaG/mURJdm4tiyW4ft5OpZiJ1oskpSlH0P6jif
        4pohpA4TODxyz7E6EZcgpItJ7Koz6TZQS0JEkRM=
X-Google-Smtp-Source: AMrXdXvHWkM36NiunCT6BBtkq9CAC8LU8Z2tJV77q2X+zY1W79XPygYWyTlJlqifEepodX8f5NwvhQ==
X-Received: by 2002:a05:600c:1ca4:b0:3da:f5b5:1401 with SMTP id k36-20020a05600c1ca400b003daf5b51401mr7529549wms.31.1674059115623;
        Wed, 18 Jan 2023 08:25:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm3670695wms.2.2023.01.18.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:25:15 -0800 (PST)
From:   neil.armstrong@linaro.org
Date:   Wed, 18 Jan 2023 17:25:11 +0100
Subject: [PATCH v3 1/3] arm64: dts: qcom: sm8550: Add interconnect path to SCM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-1-815a1753de34@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-0-815a1753de34@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-0-815a1753de34@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add the interconnect path to SCM dts node.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 3d47281a276b..ee3e5150a976 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -298,6 +298,7 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8550", "qcom,scm";
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 		};
 	};
 

-- 
2.34.1
