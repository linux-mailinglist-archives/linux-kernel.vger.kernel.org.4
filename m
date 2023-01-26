Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03EA67C803
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbjAZKHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjAZKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:07:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB49756
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:07:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2909180wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/C64VDfxrfMZ/1uEiB9zDHpUFLh7m1+xnmbS1pFOyk=;
        b=V8GT72wwmpsgfPbJCh3bZau3EqF2A4BmUXRINxha+xoOrYdxcwh7sGQJkDcYSMVt7d
         OEWhNIynscbTDMOde6Scdc3iOpLWjwbl0fDFquAtRZ2lvtpmDtFi4FGJLQLpx9+mmbAz
         WMCA5HMP7sCJQbCqtw1DXcsWpiwaSU6vwzCpxsdHeutZ1zotQeDyf/i7FbDxsmwAjcBf
         SC0ksg3nz1JTQ+jWQ4yGHPgt4wQlbaLLxcrcFydXqIEbTGqFeSGS/ubVFCT/vW4Kw65L
         2EFVzCsmXCMCB0wxJQTzW+Yn36mK8A50GcTo4kFXIEF4+CRyPfw8obfnqRd6wdCOVCs5
         ThRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/C64VDfxrfMZ/1uEiB9zDHpUFLh7m1+xnmbS1pFOyk=;
        b=uAl1b2drqARvJVZfqKH5f3JdCtX4vid9mGBajoSBv0XEJkofjkTPpgVT20gR6qsLcb
         mOS58fiE5MS2P7R0RhQsXBTOZ1kItckg2oc8zZGg3//09r/NO2wSyJ2f44wGi1D7Bz3X
         yiuFWLTN0nhf7aulpmCaPDLtvdB3cPnYUaXWmwLTottxtTL62tQBnspYjn1E1BYhJZGO
         QVLNx4ihosU1zijWfTmYw21TUweNCjBJXBHO3cgrIfUzZlfQDj1MyLQjwNfHcvdQrW0w
         TVb8nWS7Q/03nSTfehybVzS6muXC9kF6+4GHwECGqxk5HFtXBxXx+QgDmid32Z8tgT4P
         d6oQ==
X-Gm-Message-State: AFqh2kodQEWdnexUO1i7RtmrgZq8FOVqF2nV7SM/8/0WPLyDSdx0PzK5
        94IhUj0u1NmX504EdBl8AjC72w==
X-Google-Smtp-Source: AMrXdXuJjP3gif07dsS93YMwa0ud5oEd8szdXezHlD3wXohWvaPMrwT/AMVBSYVQSnEovOilt2svNQ==
X-Received: by 2002:a05:600c:3d16:b0:3d0:6a57:66a5 with SMTP id bh22-20020a05600c3d1600b003d06a5766a5mr35013737wmb.0.1674727648285;
        Thu, 26 Jan 2023 02:07:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm5198839wmj.0.2023.01.26.02.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:07:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: renesas,rsnd: simplify list of compatibles
Date:   Thu, 26 Jan 2023 11:07:22 +0100
Message-Id: <20230126100722.9473-1-krzysztof.kozlowski@linaro.org>
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

The fallback compatible in a list (the last one) cannot be enum, because
it is always fixed.  Also if such fallback is used alone ("Generic"
case), it's not a list anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/sound/renesas,rsnd.yaml           | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index cb90463c7297..b1f08d6af38d 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -18,8 +18,7 @@ properties:
           - enum:
               - renesas,rcar_sound-r8a7778   # R-Car M1A
               - renesas,rcar_sound-r8a7779   # R-Car H1
-          - enum:
-              - renesas,rcar_sound-gen1
+          - const: renesas,rcar_sound-gen1
       # for Gen2 SoC
       - items:
           - enum:
@@ -32,8 +31,7 @@ properties:
               - renesas,rcar_sound-r8a7791   # R-Car M2-W
               - renesas,rcar_sound-r8a7793   # R-Car M2-N
               - renesas,rcar_sound-r8a7794   # R-Car E2
-          - enum:
-              - renesas,rcar_sound-gen2
+          - const: renesas,rcar_sound-gen2
       # for Gen3 SoC
       - items:
           - enum:
@@ -47,14 +45,12 @@ properties:
               - renesas,rcar_sound-r8a77965  # R-Car M3-N
               - renesas,rcar_sound-r8a77990  # R-Car E3
               - renesas,rcar_sound-r8a77995  # R-Car D3
-          - enum:
-              - renesas,rcar_sound-gen3
+          - const: renesas,rcar_sound-gen3
       # for Generic
-      - items:
-          - enum:
-              - renesas,rcar_sound-gen1
-              - renesas,rcar_sound-gen2
-              - renesas,rcar_sound-gen3
+      - enum:
+          - renesas,rcar_sound-gen1
+          - renesas,rcar_sound-gen2
+          - renesas,rcar_sound-gen3
 
   reg:
     minItems: 1
-- 
2.34.1

