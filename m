Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461C6CBBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC1KDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC1KDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:03:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59996184
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h25so15048830lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PzeyQrd2Tc1EuOfrldCPoi2vXLAKnhW3XMPQDwN2ac=;
        b=f4c1QRz0gcjGtyirFi0ANq0c/1qKueB5uUwVlvypcnBvwqg8GWZIngXHoI6g7W0VLr
         wnxQLYQKSK7Rv98k1xeV8aZcCTY+0CjQXvB20yPQRAVl3fyfNyOe79jUZwUAZ//jaKb1
         CUyzsYWFFLKBFB7dGe+8j+2J42ODchwmo3TQ6Y2ZsJ6piJDYP2+XrLpXaUKB3fiaHSRX
         kxR/ctPJG+JSHkgVgOYRcDH0GqB4+O9z109PcrwBDy7m+LojQVe+m2dXgkUMwOpTkmys
         rljRgZZgXJkGLfDF3uFg8r64xK1tqd/YcfFwLhz/xy+Dg2QsTN/g17dAypWNJwPOU4oF
         VMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PzeyQrd2Tc1EuOfrldCPoi2vXLAKnhW3XMPQDwN2ac=;
        b=K2xVzhAK5ZfBp9ff4yfwFQhxllgYjR1qvC7XuSTvA9efI6QHXFS8YyDSC7EZFYqzSA
         WupRmiiEAR66t6bRmyCFkEhK/9lRPelYnu4J9V5KnHGWDGSrpig3rY9ymahOl8+tLQI3
         pIy/R/jVKcsPGppOdZ7xOr0ZmYuTnL8b1Aqe7CU049YRS3An7Ft82NmRaYxezDJQFsyJ
         JJSi+7vJZCWT4oBv+AZzt2m74H/youq7gbMENcQfFwtbtoHuC77I5Z3S+XHUGUsR9vcA
         xJNqYnLVh9fGlVdwGmmEPuy/fVdbSuZ0sspPkqZdXnvbNQjyjYAkSVBB0M9/VkmsYU01
         ymig==
X-Gm-Message-State: AAQBX9eR3RK4hoHmLG+WcjHOuPYvHp+Y/BosWOjSCyXuTwJXKv7DVThy
        o5uaGDFf3KP0iVxFSHIepk+Sgdf9mfvcStvqudo=
X-Google-Smtp-Source: AKy350YnpvWToCO4K7eYa+DJcOXfV40TWaRERpWOJp08TxYhyxkD4JFWIHPyeB5j8KhWgHtikVVfaA==
X-Received: by 2002:ac2:5963:0:b0:4d5:ae35:b221 with SMTP id h3-20020ac25963000000b004d5ae35b221mr4284717lfp.34.1679997782048;
        Tue, 28 Mar 2023 03:03:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f10-20020ac24e4a000000b004db3e330dcesm5008471lfr.178.2023.03.28.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:03:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Mar 2023 12:02:52 +0200
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: mpm: Allow passing
 reg through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v1-1-1b788a5f5a33@linaro.org>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679997779; l=1381;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=C4N0Ev8VKX3zoI5LrzMOtOGVDcPvF0sVmEyLrmGffDM=;
 b=5VTz0TXYou6dESAd20JbdSqHQfvEqtSex/DVC7nsLbDDDFk1MRXmIhegfP3UUOj0Hwa28Li2VIg9
 7jVFDEIBCvVhPHyP1gldQPvO0g3ZxbeD9i8Zi4xH2OVWQZcnicj1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
use 'reg' to point to the MPM's slice of Message RAM without cutting into
an already-defined RPM MSG RAM node used for GLINK and SMEM.

Document passing the register space as a slice of SRAM through the
qcom,rpm-msg-ram property. This also makes 'reg' no longer required.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
index 509d20c091af..77fe5e0b378f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -30,6 +30,11 @@ properties:
     description:
       Specifies the base address and size of vMPM registers in RPM MSG RAM.
 
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the APSS MPM slice of the RPM Message RAM
+
   interrupts:
     maxItems: 1
     description:
@@ -64,7 +69,6 @@ properties:
 
 required:
   - compatible
-  - reg
   - interrupts
   - mboxes
   - interrupt-controller

-- 
2.40.0

