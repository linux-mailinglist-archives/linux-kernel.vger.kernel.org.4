Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708B707FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjERLkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjERLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:40:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35C1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30781184e78so767921f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409994; x=1687001994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG4Vbyr7PlG0lpY1RSxwlZMOHt+XOR7/ovgh8gARZlM=;
        b=kbczseXt+Cf+wUhPfg3lOvHXPHqqYE7Mh28Vz0DG3Tus2Fb0O+v8jSSfk+sOsXfJej
         yFsMiR9F7FxX/XYGxM4urkPI0/lSKkx1ogJoX/ZhscTnCYQue3lPgolwI0KZ20oL5QUX
         XWn4zTIG5bKgqf67r94YkjPGJmgiyOlu4LYYiGUjSoTCUICGLzyxRRi9tHT4E2Gu8MWC
         gLEW6MZFNeeusp28Fca11GDy+1QJC2RvJ4JmpebUHRoXeILJscP8flYNw/+i4Ne/kFAZ
         y7aMlICfq5PLz8ul8AnbZst/iPbLSy7wAID9g1T00xAXXWI4OssILrA0Fjl2YQg7GJXi
         PUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409994; x=1687001994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG4Vbyr7PlG0lpY1RSxwlZMOHt+XOR7/ovgh8gARZlM=;
        b=kuiUjj4gjfdHsM+qim+sD/4Kp+3UbOg51Tkf6bMjmxqzJUI6uWwFM5QMEKFSMLOorf
         oY/dU8034NszsjojbGjjY1GJBMNxvaKo1+kQLnRQ8hnrZYUBxDkTYJd5xp2KJ5hQySxY
         sa2vzf7W5bIcZA2wacTYJovo7qMqz1sTxUKRU6YtJwbaO3Uts0QZii4noDUNQJJOAB3k
         jg03xyo6h2r6ViuOPLW8IeJGtlMRW+qbmKn02bXKkbq42X7eP1Ibo5+fQ8q5KNqpuBHc
         7pDxOAekGC87WlEKzV2ZjhCsX6koIa0zbZK80uoyq9iYJZLGJfCUSfIHOMWu58Yk5Jcm
         W05g==
X-Gm-Message-State: AC+VfDzieGtZNQtTu+Z34i9cCCd/ymMCwxKdTqy6BNqgdW4AV+cbCIEy
        jEnrM+rNvZmjML+CfnmYAEqBNg==
X-Google-Smtp-Source: ACHHUZ45vjuEaH9D5GBYXWDkM1nucUH5ctXYjl87CMZOxDISAypwtYW5WXGFDuw5yYrlwsiHTzA7Eg==
X-Received: by 2002:adf:f484:0:b0:306:3ec9:99c5 with SMTP id l4-20020adff484000000b003063ec999c5mr1398646wro.9.1684409994340;
        Thu, 18 May 2023 04:39:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b003047d5b8817sm1897135wrv.80.2023.05.18.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:39:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] dt-bindings: clock: Add YAML schemas for LPASS AUDIOCC and reset on SC8280XP
Date:   Thu, 18 May 2023 12:37:57 +0100
Message-Id: <20230518113800.339158-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASS(Low Power Audio Subsystem) Audio clock provider provides reset
controller support when is driven by the Q6DSP.
This patch adds support for those resets and adds IDs for clients
to request the reset.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml         | 11 +++++++++++
 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h     |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
index 7c30614a0af9..394833819ba3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - qcom,sc8280xp-lpasscc
+      - qcom,sc8280xp-lpassaudiocc
 
   '#reset-cells':
     const: 1
@@ -45,6 +46,16 @@ required:
 additionalProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
+    lpass_audiocc: clock-controller@3300000 {
+      compatible = "qcom,sc8280xp-lpassaudiocc";
+      reg = <0x32a9000 0x1000>;
+      #reset-cells = <1>;
+      #clock-cells = <1>;
+      qcom,adsp-pil-mode;
+    };
+
   - |
     #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
     lpasscc: clock-controller@3900000 {
diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
index df800ea2741c..d190d57fc81a 100644
--- a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
+++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
@@ -6,6 +6,11 @@
 #ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
 #define _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
 
+/* LPASS AUDIO CC CSR */
+#define LPASS_AUDIO_SWR_RX_CGCR				0
+#define LPASS_AUDIO_SWR_WSA_CGCR			1
+#define LPASS_AUDIO_SWR_WSA2_CGCR			2
+
 /* LPASS TCSR */
 #define LPASS_AUDIO_SWR_TX_CGCR				0
 
-- 
2.25.1

