Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDCE6C96EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCZQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCZQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:47:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6654C15
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:47:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so26601931edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679849223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9We10+aJn7ul+hCgyePSABdIzaHTrq5ihMYDVZioG4=;
        b=BCsjrgqFL9KlSvIHJbDWc+7t9N9t7oUU7WOToekUV2EO0SQFTiQJkmaPhEo+fSPZSj
         YzD6G0Bs8epjf8soLwdWa8IiodufrmYgfC2Y6HJKABANlO5CqqxCn1jRAt1cNqOBGPQr
         w0ieqdPMBSuNYj7BrVImGEqks1o532QUn6V4Rrp/jg52X5FOcictKEqqkIj+Up+Wex3F
         TNeUV9hHK5z8SNJbp9uozti78VVFRY9YXlNUR5Ky/u0EWVkU8rNvXsBbkRjVlOvYaCEi
         IJJGXXGKUSHluZgsnf330T60ddYCUQFKqV+VZISktF+QI9KDub2OX7T4bWEEciHNWlDY
         ziXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9We10+aJn7ul+hCgyePSABdIzaHTrq5ihMYDVZioG4=;
        b=Ttq1OsknbaUZZRDxojYwz0AH5uDrqMyey6SpXj3tWYiEfEDQ9l8VBH+JlDNLDsBeqE
         3ofqly43BmHZfB628P+ByBHMi9ccvn6nAK0d1Myn7OSvdYcBMj7/JWV0g9s2blhrpRIc
         O4L9MNUD2KXVh3eL1JLi3jNM9IDlP9YEA91boRD4oQWbDyV1mMRH56gIixT3viOwQ19/
         3UhK42P+n25LnYad3j0WRra8ShyyYeEyiSy8BlPjRRttpY/mUS+izVKSxdcsbLsU+qoP
         2lvLwBb5HDBvHVZupt7GpQTdJR5zAq+ohkU7MQg6pbUT6AXqlk5KLpRVQnDyhWdA30WK
         xQnw==
X-Gm-Message-State: AAQBX9dojWRnYKHq/C7FF4Ls784pkjGwr5P6jj9oXqw4duY3Azw2d/uf
        +IOV4tyj2hUUI4L/Bin7fczaGw==
X-Google-Smtp-Source: AKy350ZaVi6CbGP1f3BlaM7CAOyL3H/tqpdjSxBn5g9IpqoBK7QlOK2q99MGJbJADsg/UvN5lWgoxQ==
X-Received: by 2002:aa7:c90d:0:b0:4fb:2060:4c20 with SMTP id b13-20020aa7c90d000000b004fb20604c20mr9205267edt.31.1679849222778;
        Sun, 26 Mar 2023 09:47:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id v4-20020a509544000000b004fb402a2a37sm13833982eda.33.2023.03.26.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:47:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: sitronix,st7789v: document dc-gpios
Date:   Sun, 26 Mar 2023 18:47:00 +0200
Message-Id: <20230326164700.104570-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device comes with DCX pin which is already used in
canaan/sipeed_maixduino.dts (although not in Linux driver).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index d984b59daa4a..fa6556363cca 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -26,6 +26,10 @@ properties:
   spi-cpha: true
   spi-cpol: true
 
+  dc-gpios:
+    maxItems: 1
+    description: DCX pin, Display data/command selection pin in parallel interface
+
 required:
   - compatible
   - reg
-- 
2.34.1

