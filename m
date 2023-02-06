Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B868BA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBFK2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBFK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B037193E8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso8357814wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=q7b8YklXP68I6TrEL2BynmvKOen6PVDc5E2pUk0eOw2KzrdQxEte0WayCrGTRSEBpH
         lNd48JFye1DOdpH3PcfpsX3mf4XXeL1hR+byILYP+UL8sSBOj/nypX6gAoNjByeLkBSF
         uBQmEt7RpFvbIFBMSM3VKxcZhIh6M9j4jgp9bD/1u6okypohKT/U1MuSUKiKUij7W8Vl
         3CO5w4z/pSTxEfuP42lVepOGFtftzoFlERt3s+3CGD82sSq0b1YpXOYnWwCiloOzbpU5
         xkXuVuutHMx+Ud+jANgw8SYyOGlGKIwBbx7w2lOi8lfrb+HFXzs/N5bvZe8THIRWDxns
         4HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=BfBSFoZYALFKi1Rf3viXENxoeZBv8eQnDE/tQswzIa4W1JS97DFoFWPDEvRR0CHCwO
         5wFdnVZQ/ngo0qzJqWXV8yqdgKA7N4BS2qL4DbuzDDReMiDysvpDBMLsrB1zmwLeoP4L
         qRVaR8e/Xup84z01xb0jA7JSMudC8TfcVg6eeRCmuraWWNsOFWvhOEfNXeIiP5qnY2uC
         nHjMRV+84llqoqajw+VfrlCH5RR1U+F3dUGO8WJEp25jb/55Myv8e6fmkNSb4E+MudYc
         vUYl5qJlSabRX546Xcn0YQrYQr4Y873IibZ8jSpNtvV3GIkWlpW1+YAI1sBrTvbzgaBE
         fqHA==
X-Gm-Message-State: AO0yUKVq6c6idasAah71l8aVTiUUIhRVcw9f0VpSqurGEZEHVTT6Kn+L
        ZmccO2YFyuiISj0PWutt1bolAg==
X-Google-Smtp-Source: AK7set+jtSbBTiTK0xgtT0Hi5Z9S8Y8FLCxeMWMEZU3I3Jp0lQFes2eOhGEN6SIXt34pUeO6Y+0WVw==
X-Received: by 2002:a05:600c:1ca2:b0:3dc:440f:8e9d with SMTP id k34-20020a05600c1ca200b003dc440f8e9dmr18797961wms.0.1675679299737;
        Mon, 06 Feb 2023 02:28:19 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 05/37] dt-bindings: nvmem: Add compatible for SM8150
Date:   Mon,  6 Feb 2023 10:27:27 +0000
Message-Id: <20230206102759.669838-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8150.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index b7811bbb0e71..a248033026b1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
+          - qcom,sm8150-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

