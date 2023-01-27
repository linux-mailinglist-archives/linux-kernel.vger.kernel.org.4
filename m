Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA767E694
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjA0N0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjA0N0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:26:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55481B20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:26:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so4976612wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZd+JWIjDaKYpzBxZXlaUPrja5cm3GEdrEIrnzSxg1A=;
        b=bvD1H6lI5hOPKvzUhnX/f1mraAjS5TO2SBRO11Nqdd1onSn+pVzM2tBBmSFEjLBp8x
         20nHqzRNWlmWjVSit2glAPGgnq1LvEb9pLDEqMJ9bGCGQgPLDDZ0w/tdIOpejPm2xuCK
         Q6uV2SkgWwH90irqtOpsLTSgzD2VmafIQnZnug7rny4BULDppVXicqhnb/XxBx2XazXQ
         lr6CMRaI+2iOiQM345L/8yVH6Er7j/bQXUycDZCWDWfnuiOJ4DCBRxPAPGkcd+e6b0nw
         361M47k8NIkKFwJzgVA9400bTyQa381ANuprfXCmUTCDYligJXZ2EsaaJW9OdIWvSzqF
         HV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZd+JWIjDaKYpzBxZXlaUPrja5cm3GEdrEIrnzSxg1A=;
        b=DXBBC11JVO0rTyBYlFVYrexncgbMLp6egsoT58WAt5f4UcNJadJ8sYogpklRO/cKCS
         hs4x3+8tVpqNpn/DAGkC+PvBOKyn40eG1oTy2nKxZQA/ZatGxrAoxwef2KkdgDw9bjxA
         6XQ5AnjAAOpk+KcNVJyu+QS7A6sXhJjm10i6uu8Ob+wqgCpFwK3qCBKMFZbJjinWTOx4
         18NVgullaaxv3WuGjaese6zxb60llVEeTws5h44uvDotfHX3FSjLuzUic+TVulrFTSxg
         NXFjzAfeIYAb4p1Dor9xMOpOC/uHHw+Jl2ThSNfo8XDT0i0yKOsG2iuXFswO4tfah9Pd
         ueWw==
X-Gm-Message-State: AO0yUKU/fb5/D3MbQR7vBy7ImACmB8WXQsbvu91MmMhPghSg9s6T55sW
        F2840nWmXZvEZRUYiJ2wkcSQtiNTTgdeyALj
X-Google-Smtp-Source: AK7set+jTjYlToxLv7HWQHoOXBqVASbP6hK8bv/7nOmcOahZ6nnLj42BD8VTI1PqExDUkUHpsgpU0w==
X-Received: by 2002:a5d:4283:0:b0:2bf:d428:a768 with SMTP id k3-20020a5d4283000000b002bfd428a768mr1958419wrq.49.1674825966132;
        Fri, 27 Jan 2023 05:26:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm4021515wrs.47.2023.01.27.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:26:05 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: qcom,pdc: Add compatible for SM8550
Date:   Fri, 27 Jan 2023 15:25:58 +0200
Message-Id: <20230127132558.1176730-1-abel.vesa@linaro.org>
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

Document the compatible for SM8550 PDC.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

The v1 is here:
https://lore.kernel.org/all/20221116114210.2673902-1-abel.vesa@linaro.org/

Changes since v1:
 * rebased on next-20230125
 * added Krzysztof's R-b tag

 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 94791e261c42..5a733bd76b57 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
           - qcom,sm8450-pdc
+          - qcom,sm8550-pdc
       - const: qcom,pdc
 
   reg:
-- 
2.34.1

