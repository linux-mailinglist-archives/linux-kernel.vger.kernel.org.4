Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4BD7263C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjFGPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjFGPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:11:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC201734;
        Wed,  7 Jun 2023 08:11:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9745baf7c13so962736266b.1;
        Wed, 07 Jun 2023 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150696; x=1688742696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lCkOH0dTMYfmftYr+XeGrSRIetqwhmrVfou0QqoIt0=;
        b=dEqCcXpPH8BLEA/DLJGh7f/Myx/bEaYYzRYdg6HVEr+xE4WqmI3mlfa62Hiz+9MHNF
         Um6HfObp78Gnj2T8bdRoL7JdpFwHNPO88pM2tDOCsc4eclIblLprM1aKoJCnLeOdGLGu
         r4OYJUTD7/v80dhZAg3K3HRmovh8L7i8NPKVCXANpODtQSwweAYbUfXM2L1+vad/K59j
         sU/eJwnn7Wq57OSE8013AhmvFMgYpOu1DI69dKSF7HqQ9wUKXH9VK+KEBO+spKJmceOq
         4hk4SFPKgpPkPlM/By6FN5/feDPrDiJUs/S7pok3l75dGEVHVIQOwKEBmb10E2kvlwri
         hGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150696; x=1688742696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lCkOH0dTMYfmftYr+XeGrSRIetqwhmrVfou0QqoIt0=;
        b=NzW84Zvd4dSQcWcIA7e2tNzZZNq42DEQdvIIsf24+nL32pOSq/apXg+/+w060luhSn
         ABYKFBe2TZEgV4OPlpj1M7o2SQKiNmjC2zBk5KSN7raxR7EoMh7SxnEis6deyFb6V+BD
         ZzN9AzdfL02ETA98MK1cGBckyjNSpox7JBXpJ0NvLc6vSlHGmEuLBeK/o0JpFjuwWst0
         q56vrs7u/DzbOAfIFu0vXx2es8iQXq+t6x/BFS/6hqxVirVI4G9m8jd7qKIpR8SpFEGJ
         duN6eTb+QZj4ZVeRUHyDbYYYLnRCjDtyorqcek4QwJJInJe1tXVHx0D3yCVuW6fjcmbk
         C6qQ==
X-Gm-Message-State: AC+VfDznEmafSSXadPvxgB9Q6Z25jQzALJSk3HJZYBpygqWIjm1XigFV
        nFGLfodFX6cFV+YBEPd+s1c=
X-Google-Smtp-Source: ACHHUZ6+uoPvY6CEbwnL5CZV4ptGTfNw5hBhUF2HPpxpP1fPUX4S3bd1OtYraPjOc3SBz3D7b5LTwA==
X-Received: by 2002:a17:907:3f1f:b0:965:6075:d0e1 with SMTP id hq31-20020a1709073f1f00b009656075d0e1mr6312083ejc.72.1686150695556;
        Wed, 07 Jun 2023 08:11:35 -0700 (PDT)
Received: from fedora.. ([46.188.160.176])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906235300b00967a18df1easm7006222eja.117.2023.06.07.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:11:35 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: add fannal vendor prefix
Date:   Wed,  7 Jun 2023 17:11:25 +0200
Message-Id: <20230607151127.1542024-2-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607151127.1542024-1-pavacic.p@gmail.com>
References: <20230607151127.1542024-1-pavacic.p@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fannal is a one-stop-solution provider for touch displays in industrial
application, committed to delivering a variety of professional high-quality
products and technical services globally.

Website: www.fannal.com

Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..f962750f630a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -462,6 +462,8 @@ patternProperties:
     description: Facebook
   "^fairphone,.*":
     description: Fairphone B.V.
+  "^fannal,.*":
+    description: Fannal Electronics Co., Ltd
   "^faraday,.*":
     description: Faraday Technology Corporation
   "^fastrax,.*":
-- 
2.40.1

