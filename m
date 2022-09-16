Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD255BAD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiIPMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiIPMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51EB14FB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso15742642wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zo8kVKLKtNbL7LV3ucP5GI+hqu0rYi1ISG3c79jI6bk=;
        b=H4iAzZYZ+xk0hTaVbutPPEiHQr70DA4fV99XQry0LkYqrdXQC2nm2atc0SE/c/H8mW
         MSeEeTUZAvOZ39KCibaha5kVLEIE+ysdd58pG9znjZTQ3iV/eDN9nL51AF0uqsK5LYLj
         apCf8G8+9dsCn6xhMoYKUjsR/6t9V1l7MuueXj8wAn84gfHgO2aaJuAYOA/O6mnGNCnS
         joIvajR77qkCaVohOQgpPNXoQyR2j7eGqOmXLMQxsPVRTMZbakByEM20gVA0SoK1iWwP
         5lDQ9GHA+d126VYwVlTht+vvAhtiBakEB0zaqOshJf7LwNHxr337uJcxHaM47hjLSsYK
         ulCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zo8kVKLKtNbL7LV3ucP5GI+hqu0rYi1ISG3c79jI6bk=;
        b=GIQF+9Pr4banzHr1UEuGM+I0i5mucHziYGuLULFVFQR8szLERzD3jI1hIkeIRNK70T
         mPpwMmdzSxYZUhVsFNapgkx/cGcCF7096B7sGn+Uyn6rsJTdopQh0ddeYNhoBvkKexI4
         kQOZ6jy+i0bn0KkWQtltRh5mCuMnh7N93vGYrIt79SQFGaTBzWLoRgmUHcSZbXVmYrCJ
         LpY7ExVqQklVwjG4aA1Pc3pcCC/MmaUbh2tOLnNAm9oSdub56Mn4/hK+K1FANX2nl8Lw
         lD+grX/HJ23GKJ5GfmPT9bt5BAi4Wd6I4DsWaVfmSKzxx/pMzysOB9NvDANDdoVszXpC
         XMoA==
X-Gm-Message-State: ACgBeo2vuUbmT2OQA9gvAlsv1FeOkQl43F8emQX9DKJe0Rh26SKNs9Ve
        b4GSgaiCBdXBv+A2+Nxq/+eJ9/Fp3FSi9A==
X-Google-Smtp-Source: AA6agR4ZvYxD4ZAQKOL7+MxGdvwiOOZ8f2ZfEziEvmtGZkPLTxBDZ0IBIBXOImfaZivaePnAhca23g==
X-Received: by 2002:a1c:6a0b:0:b0:3b3:3ed4:9bef with SMTP id f11-20020a1c6a0b000000b003b33ed49befmr10549468wmc.84.1663330870991;
        Fri, 16 Sep 2022 05:21:10 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Johnson Wang <johnson.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/13] dt-bindings: nvmem: mediatek: efuse: Add support for MT8188
Date:   Fri, 16 Sep 2022 13:20:51 +0100
Message-Id: <20220916122100.170016-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
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

From: Johnson Wang <johnson.wang@mediatek.com>

Add compatible for MT8188 SoC.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index b5a1109f2ee1..75e0a516e59a 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
               - mediatek,mt8186-efuse
+              - mediatek,mt8188-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
-- 
2.25.1

