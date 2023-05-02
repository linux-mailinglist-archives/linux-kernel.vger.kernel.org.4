Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB56F4339
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEBMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjEBMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:01:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620D5244
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:00:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f4b911570so617750666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683028857; x=1685620857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WYS2uNNoOkm3orqvZxxy/U4Nr8xICG5Dwp3aoTlmM4=;
        b=KrNvgqnlCJ62jTv5QKIFn8l1MPz6NrKoUB/fs6ZiByAZQRfT32HlFohiu4KLlAKKv9
         kLbaauMkSbT16Z6VAl1JcxnOE1qoMmLssiN+TlUwhoPWdLeVCdEVtWHaeUTklz1sr8Hy
         FJjnyNlSUMs921zOgeC1Xf8RA6pCLNiYTAvj85ZV4Icmq2tHIgkDIj17EsDgmnt6484+
         o5xo9O+atBqVzX14QE/WT32YhMBTEt+oFygM7LFwoy28EU+DU9dqXQm9clbOD7S3boUi
         CsGfQ/xWDWdD3c/zo9kKqCsbOMV29Fh0qbFzDFKUv8VWsx6FN3IHSSLwabUYPSxQXyAV
         qnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028857; x=1685620857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WYS2uNNoOkm3orqvZxxy/U4Nr8xICG5Dwp3aoTlmM4=;
        b=EqCnOwrZyjFqM92+cUio+3YHBbMg6h0/ucyz6REmJ63OlTl+Gz+LfRh5YfN5eMu5ZM
         CG2Kg9tfpPdt9/SCtoYpjQ0rjXAire29j0TEgSAgr59adR6SnAsW49xxmssWF+ExrqpD
         HJQmrBeXvJ1GxOJJy2ZrU5T92i2tU9A/iFbLKdXNOgsX3nofGhlM4FvLcK5KFn+2mRza
         6q8YwGnLEUaccmTAlz3/WxAG3hKeq7i41G1Fwt+aNfYPWoHPdW7nDXuwGTAVnOF34Q9J
         FCz8bAMKWY/ame+glJOx1rpOnlepAEhqnLC1qq0SuAmsRazpUeoukcCIZMguW9NyTwNM
         tnKQ==
X-Gm-Message-State: AC+VfDzP8/bOHJAVmnhyp8eg4rcbccXC+7gBZOmoF7jTSG1yFOnft9GS
        bFFHca/aqNfupsL86/0LmkY7DA==
X-Google-Smtp-Source: ACHHUZ7UP4zneqUqBTSrVE1dz3gYWQRhrswBtXkRlQD/zyv1FGBW6b28N3mfaqsf3b5HIL1999Ir6g==
X-Received: by 2002:a17:907:6e89:b0:94a:62e7:70e1 with SMTP id sh9-20020a1709076e8900b0094a62e770e1mr15086566ejc.68.1683028857540;
        Tue, 02 May 2023 05:00:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b0094ee3e4c934sm16063403ejf.221.2023.05.02.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:00:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: display: novatek,nt36523: define ports
Date:   Tue,  2 May 2023 14:00:36 +0200
Message-Id: <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
References: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
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

The panel-common schema does not define what "ports" property is, so
bring the definition to enforce the type.  All panels described by
binding are dual-link, thus require both ports.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework to add ports to device schema, not to panel-common.
https://lore.kernel.org/all/20230420160905.GA2952736-robh@kernel.org/
---
 .../bindings/display/panel/novatek,nt36523.yaml           | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index 0039561ef04c..a2a8c4e39573 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -32,8 +32,14 @@ properties:
   vddio-supply:
     description: regulator that supplies the I/O voltage
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    required:
+      - port@0
+      - port@1
+
   reg: true
-  ports: true
   backlight: true
 
 required:
-- 
2.34.1

