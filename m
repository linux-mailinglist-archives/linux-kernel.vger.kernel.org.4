Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E876F9AB6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGRqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEGRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:46:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3C14369
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 10:45:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96622bca286so233094566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683481546; x=1686073546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBqbH1+Z/yG5/u58VKF5l00D91rsZqi2F+V+kyJbRdc=;
        b=RpDW5Vi3uTdoyCjyi53VzpkqVQaNrS40tYTDxbxN9kUakAZNq4qVOJTSuh3RHz/ggm
         KU3J2EdpqTqZD+IOwwMKe2M6gpQKXQKMBnJ1Y47q/bVip9GCzTMtKAaaGyyuvF7MQOT3
         YjK/D+sSTPW/vNKoSlrbrCxS7ZQ4WVmki1Xheqok/VhjyNk4hmdRYYUogfHOU8vKzh8f
         MV/ULu7RRUnxrspXFf/YirAreJJVzhUpmOZnyAaxVr+4JxUxYJPDsbqSEnKxk7J2nWA/
         yAwu2DhwRn0XC+XNC+a1kx5nHBJIen7vznQiujaiFyhqq54uJMDmDyRbKLduUk+KWjgI
         e4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683481546; x=1686073546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBqbH1+Z/yG5/u58VKF5l00D91rsZqi2F+V+kyJbRdc=;
        b=Sb3hFCJd1wOCI83cSjqg+L8Wx3Ji/TkZmkQRjvOOcR3wz0BvPnYvgn+OaiYaHkPIH7
         nvUJPm6rIRHFhZrVA+U7ifY/4zStd/D0/V+qiqsWN/QQYEamPy3+RfhDrLK0j/Rqbaqu
         tscAA9WkIffwLr3aQEkLShUMb0T8mkeXY39i1K7tNFumBf5UAJnbNEVFsD94kQzt7zvx
         cZ+nV+lZOIqsoqsBI50tDdbRJm2rLKEf8zIB+9EtPXRNqloZOBHUrhiBBulNnKnJZK3V
         izw0DTJMqGDxgAiECPtdvFwTAzzhrdwLl0fzASnvhC4fQRIqNyco2Ib3ZWUpGE7zmST6
         glgw==
X-Gm-Message-State: AC+VfDzetOmUzRjQm76RKF2KtD/iUgBu/rlx4i5qeKY096W7eP1Ozkum
        9ZCofweAlbZNgKnM3lzY2ZJ4Ag==
X-Google-Smtp-Source: ACHHUZ5nFUVIAjPvidnpQiyRlIFWqFXgGzJU+QS95ur+bwGnLQ0VHfJA9T3y/aUGsZ06MePHXwR8gg==
X-Received: by 2002:a17:907:2d0b:b0:94a:6953:602d with SMTP id gs11-20020a1709072d0b00b0094a6953602dmr8408613ejc.37.1683481545978;
        Sun, 07 May 2023 10:45:45 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id d7-20020a1709067a0700b009662d0e637esm1828849ejo.155.2023.05.07.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:45:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: google,sc7180-trogdor: allow up to four codec DAIs
Date:   Sun,  7 May 2023 19:45:43 +0200
Message-Id: <20230507174543.264987-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7180 Trogdor sound cards come with multiple audio amplifiers, so allow
up to four of them to fix dtbs_check warnings like:

  sc7180-trogdor-homestar-r3.dtb: sound: dai-link@1:codec:sound-dai: [[275], [276], [277], [278]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/google,sc7180-trogdor.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
index 67ccddd44489..666a95ac22c8 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
@@ -74,7 +74,8 @@ patternProperties:
 
         properties:
           sound-dai:
-            maxItems: 1
+            minItems: 1
+            maxItems: 4
 
     required:
       - link-name
-- 
2.34.1

