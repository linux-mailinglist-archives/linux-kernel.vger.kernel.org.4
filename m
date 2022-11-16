Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CDE62B2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKPFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiKPFil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:41 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD395AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f3so9277541pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MEFKtk2jr+pIrd01Y8QsB7lxnOrOB6iK6YPYP1nPMA=;
        b=ZRenwPioW9g8p00PEamyGH8jzVZok76Ys2CSw60kjNNdSavkAdfHlfoLivu3CxFHJs
         A8oJU7Cd0PUGcEYCpbZmnuUfoF+/2mJE7q9IFfVdJEOkIx9H/rrf3tWqnxpFy+ibOpw+
         hKAHZZh68owi/D985vbBZkzUYBsNW5EySLu9t/fW/TPXI/KRtNoqfdugUHrGqOy2A5cz
         X296GIv47gk0p29rBQ8rsjNbe9Iuq0DF69sugsWyXAiO+WWAZhQw/nT/MawRF4yfiofC
         xZpEb0ZxygrvpdDQBmMFf/d4gC/1eoW1GW5/X8+uNFS31b7DdyxDChWAIrvnn+D/SR5+
         LXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MEFKtk2jr+pIrd01Y8QsB7lxnOrOB6iK6YPYP1nPMA=;
        b=WffjFnbr/4M4G2JQT4coB9Ou6Nr6YT35L2VhmciRyVdyVBEewAg//kUHwtgpgx/9t/
         LbQGIuvqaUvsmxh7vfTkf1nhqz81eFZXyz7/1z4NYTNZd2MHkgiCnGFPajJ64z6DRMpX
         zb+IJzRWGJNV6OKsXNNCOMTnDwOVjS89wXesb+pThbLtzYhjHXvWxmjMVMspcMn4TWUS
         vwu2Ueo5RNSzbDCt1p7GA0anNaIOtrtBjz3fZ9rbhv04hUUth8enY72RN2qhwf/BOVGt
         SdtzMsmdBPylmilBNiijI+CH/bpTLTgS/w/O1ed2/73yw4aI8Q+F9Kt3NDrAuTMpcEVK
         0UuA==
X-Gm-Message-State: ANoB5plrrbEGL58O9kGqvPWAR6c+O1TUq8w2Pf9OBby75DxOn9yDla3/
        XoznDeH77805l1vkdgAyX44=
X-Google-Smtp-Source: AA0mqf6ex8aOz3bvEsY002H/DOqXJxnAt++xm328WBIajR1/qG4sKD8ytPpIYYxQvfoosCQyWL52YQ==
X-Received: by 2002:a62:6001:0:b0:52f:db84:81cf with SMTP id u1-20020a626001000000b0052fdb8481cfmr22052595pfb.26.1668577119040;
        Tue, 15 Nov 2022 21:38:39 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:38 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/11] ASoC: dt-bindings: wcd938x: fix codec reset line polarity in example
Date:   Tue, 15 Nov 2022 21:38:16 -0800
Message-Id: <20221116053817.2929810-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the codec, when resetting the chip, first drives the line
low, and then high. This means that the line is active low. Change the
annotation in the example DTS accordingly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This was sent out previously as part of other series. Collected
Krzysztof's ack and added missing include per Rob's feedback.

 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 51547190f709..3cb542d559c6 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -110,9 +110,10 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     codec {
         compatible = "qcom,wcd9380-codec";
-        reset-gpios = <&tlmm 32 0>;
+        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd938x_tx>;
         qcom,rx-device = <&wcd938x_rx>;
-- 
2.38.1.431.g37b22c650d-goog

