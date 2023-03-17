Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DC6BEFB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCQR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCQR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:29:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9622B2B3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:29:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so23149909edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679074142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AHQcv/bratJAdxK3ULpQpAGRa2qj1qoNnym4PAT7wg=;
        b=P3qYQwjqIxftAhCvTvD0PfzVuZbAnV1KT502bmSIGNe7xa2LYBVdAIZ2haJaEvTuKu
         TP7UNBCiUOTRJ5jtoG301JmImBSIt2E+IeheEhfAwxu61iX0juRxDtyTtjGAIL+9cfyI
         udICmfus/NO8ciGqdnS884e4V6ptcSDPtNvZ3QaonEchkgpiZIrsBNAukzKlYfuQAmUn
         ahc+OwR4F0mydiL01ZKE5z+O88DLpC9WK+yyLuA5ve1QnGamLhuoelO8RVm07oQbmPyq
         fUuoBuQ/g0Co5qulVsmPJfWvPsIFADwxL39qClHUqtBDNrqD8nu2Ct+fGzAb2m0KEfZy
         hytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AHQcv/bratJAdxK3ULpQpAGRa2qj1qoNnym4PAT7wg=;
        b=7v8FrYS81lQ56wCrF7ylTIH1VsiSn9xZPsKnTjeYdurs3FPfcXqOyrkL9ZrQxRQmT9
         vqfqDrn+3RcAleQcLAK6hfhOxLL7H1+5obYKS+SFIm4WADIsfQ621oZNx3FY0W2OaHmW
         JTmIexHCILnUjMHXoOS3EDwhJhKhoYcoUXNooIUUISKBFw5loEBxATWdrE1LnMhwEyeP
         zAj1NsWnkRGZ+eKWABGexjr1xwNvvLTLIEt6QE4Q/v1U3YmGg8UVDIZigYmqLvzW+3Kr
         MORJeXI+O/D9DcnjKuFbPDp1U31m0JHbMzx4HcJ7n2ECE9gHeeW0hpBxkQamrxHxewpW
         2RNg==
X-Gm-Message-State: AO0yUKWa9+m+80UBLw2b6WeRa6N6NO32PVVbWgMQYCYBwNIxS6nM4n2Q
        B0xjSvsdRAysENvgK5GTlkPWzhknFrdSdmOgUwg=
X-Google-Smtp-Source: AK7set8rYAf/N7W3S+Kh3wYLQRtXPI+EzgUp0w2Y+WNXFn1+Wqw/rcS95U4yKnUMukiQ5vzVl0/Mzw==
X-Received: by 2002:a17:906:17d3:b0:931:ed:e379 with SMTP id u19-20020a17090617d300b0093100ede379mr84845eje.67.1679074142534;
        Fri, 17 Mar 2023 10:29:02 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:10af:6120:4312:7f15:6b35:a247])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm1200089ejc.86.2023.03.17.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:29:02 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: optee driver interrupt can be a per-cpu interrupt
Date:   Fri, 17 Mar 2023 18:28:58 +0100
Message-Id: <20230317172859.989650-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit in optee firmware device tree bindings that the interrupt
used by optee driver for async notification can be a peripheral
interrupt or a per-cpu interrupt.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v4

Changes since v3:
- Patch added in this v4 to address review comments.
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index d4dc0749f9fd..5d033570b57b 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -28,7 +28,8 @@ properties:
     maxItems: 1
     description: |
       This interrupt which is used to signal an event by the secure world
-      software is expected to be edge-triggered.
+      software is expected to be either a per-cpu interrupt or an
+      edge-triggered peripheral interrupt.
 
   method:
     enum: [smc, hvc]
-- 
2.25.1

