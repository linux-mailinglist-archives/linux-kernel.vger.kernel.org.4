Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3406BED7E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCQP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCQP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:57:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84998E274A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:57:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z21so22280230edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679068634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uy2ES2r2yaQEcdoZfhDVthoS5kcRZ5J4S2pvE5uM7rI=;
        b=zNbMt5WWt7D75H1iFIKYBO0yJgcmitPlnPTpXPjM7phEqmeLtWC2xq8ZELhPbKT79H
         fsgMDkqfaIVnzqVA0MXGv1IWFABiPzZDxrGlIHI3erRVnCvUEAj7VPmFV26SLelSUo3w
         NbeR4PwSP7tz3iF9gizt2A2IIZnemreSH+acwprMWrVwV9pmK5g8SB8YLlYcal1euHh1
         s3gAJ9jejgmv9MTLAjFbH7duQrMLiEpGx4LIUEioZfwPRmrVcD5j23UBXV+157jruGQR
         13HbKn0mMW/uTugbHSOdoqW6AWjaUoyOE4LJRBfI1zG8AgI2ybvIoB4TG/FWIVmr4OhJ
         Nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679068634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy2ES2r2yaQEcdoZfhDVthoS5kcRZ5J4S2pvE5uM7rI=;
        b=EZrXZnwX+v5m6K/HjQw4PFQzTyp2gHJrxVplZgtNXOu0Ur1ml+/mSYPluPMMDx/IeZ
         SvjHY6rJ4HKq7pZI9tqXv0jwkOFYl+LiREpHYSRgJH8yafGUh2pqzwjcB6MZBRIRYZM4
         DMvt/qOUrz2voa6SwiGVpl/ZcxiqXE+b/2fORsvsO+sthmyQoPeVMxbQGRrDDGxpAmaO
         7VdreXopS1Juxmj86M5neFy+h3IxnugTV7gldox71qyuv7L4o6rEUL3IOOw5UeoeIbvp
         OETs9GlhZ048K6S9s7xkPi68024e2RBFCZsnlAzjKJVCbn2gKlYF0MKey/3E6oFO3MCO
         MCRA==
X-Gm-Message-State: AO0yUKW32GCJtsWS3p+HNKUaZpUOzX2qmf/V9hKFVerhfXIJGLYN18fj
        Iab1xNCn5Zi85RkJc/pdMVQ8Uw==
X-Google-Smtp-Source: AK7set8d+ZBui09OfExOiwhJupDe51E5rlM1UNGoW1HDC8JPz8szDwdnpl8u7sd50Kds9vwa8djpCA==
X-Received: by 2002:a17:906:612:b0:8b1:3483:e3d5 with SMTP id s18-20020a170906061200b008b13483e3d5mr13758017ejb.48.1679068634078;
        Fri, 17 Mar 2023 08:57:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906a09500b009226f644a07sm1105318ejy.139.2023.03.17.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:57:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: correct number of DMAs
Date:   Fri, 17 Mar 2023 16:57:12 +0100
Message-Id: <20230317155712.99654-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The "minItems" alone does not impose any upper limit of DMAs, so switch
it to "maxItems" which also implies same value for minItems.

Fixes: 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma & dma-names properties")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 2becdfab4f15..8212a9f483b5 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -68,7 +68,7 @@ properties:
       - const: apb_pclk
 
   dmas:
-    minItems: 2
+    maxItems: 2
 
   dma-names:
     items:
-- 
2.34.1

