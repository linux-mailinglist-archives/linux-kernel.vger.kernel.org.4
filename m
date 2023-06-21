Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1229738016
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjFUKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFUKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0E19B4;
        Wed, 21 Jun 2023 03:02:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54fac329a71so3016625a12.1;
        Wed, 21 Jun 2023 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341770; x=1689933770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbgYhzuy9T4qbd91L6MqO3N2cluCsCr/3CGw0bX5giM=;
        b=bM5JEEK4NPKMkM6W1IwcEojJlILIMMIDhB+SvMF6sZZAyXv4bBmqCd4fGSfoOaDxr2
         L8QBmZdyXpz5iue9RolaZGEJmyFsQrgZmoC2vNY9Z5ZWNV+ibzetkhmIr4n+zLza7j/J
         vUzIvFFpKMoqSL/WrD5Sw7h4KLTNyFsb79CPDee02Aa5wKcpaaXo0ao9m/87jnwtuFmR
         9IstcF8zKhoxZw7rYXhszdRGtRltN8vVNlamlQcgj9I2Z4Mb2QbRH7gGkyV73DoyJ95R
         gRUslLyMpx4u2Fm+wettrXmwlUPnsLSs8H5MzeElJ0yRari2Klk8nXmdwsW7VQSNsM35
         GHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341770; x=1689933770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbgYhzuy9T4qbd91L6MqO3N2cluCsCr/3CGw0bX5giM=;
        b=NcLpf+imHwgqXCyOELz8C2LDiQ8yMx7tzlqmRfOUEOh8VCtOka3CTgNuu6o+0mgE1N
         QizHM/anvoHzJWxMkPRPRTwvmf9qxhU3Jsn7Pi+/UhIubx43+I6wkIZeAUBCGK/afBs9
         /iuoMFIl6nhkUG/EMJUC2fXzqdPWt/J28Td0k/OjceCagPnef9Eg9dJikvoKEXUohE4P
         GdV9Tvs9zk21+SYcuVom4ryYqsJQPtMFJ2TnF/vWZLMR/FpEAwdxjZ05yT02yIITXzSH
         9lBf+X3O7dIPI8BTeX/hC1Fln79MvBsFMCvcBR3xHkh9psNCN7PvSCxQm2YHNenCnsXd
         WO6w==
X-Gm-Message-State: AC+VfDyjOxhjFLP/HKmxMicfL/p9w04aPMsZEbeedBFixcOANpFSjsp5
        yBjNLLiEuvxJptu9b/uXokbiVWkiv5u4qw==
X-Google-Smtp-Source: ACHHUZ7Iv6KmOrh1v1bjsJiVlUBhn/NNiK8EONZ8ffxFbrchIc7x+gMjwFAPM8hxQx5BrKuFsou6CQ==
X-Received: by 2002:a17:90a:c905:b0:258:818a:fd65 with SMTP id v5-20020a17090ac90500b00258818afd65mr8490381pjt.30.1687341769913;
        Wed, 21 Jun 2023 03:02:49 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id e4-20020a17090a280400b0025c09577ce1sm9402937pjd.7.2023.06.21.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:49 -0700 (PDT)
From:   Dongjin Kim <tobetter@gmail.com>
To:     tobetter@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: ili9881c: add compatible string for Elida hj080be31ia1
Date:   Wed, 21 Jun 2023 19:02:43 +0900
Message-Id: <20230621100244.1325638-1-tobetter@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elida hj080be31ia1 is a 8" MIPI display panel. It utilizes an ILI9881C
controller chip, so its compatible string should be added to
ilitek,ili9881c file.

Add the compatible string for it.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index c5d1df680858..0f47414e3375 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - bananapi,lhr050h41
+          - elida,hj080be31ia1
           - feixin,k101-im2byl02
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
-- 
2.34.1

