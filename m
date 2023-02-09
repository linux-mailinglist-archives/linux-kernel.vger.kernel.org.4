Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1668FE76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBIEVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBIEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:21:41 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F82E826;
        Wed,  8 Feb 2023 20:20:43 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id j6so647993qvm.1;
        Wed, 08 Feb 2023 20:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXrJfmmxAWbUYgAc1YpWoSrR/fYIQQeJz6qUnhOIgis=;
        b=Ch6Y7TL+qOk2jmuJ6zMwxFor9pwjdnSaek2wjmN1wJIXSDFV97uHXGMaC4oi4sKEQJ
         geVd4cIfy61j3KZdgwb0ndi81+lFXULSNmIwciJGxUNLDYItEteu9eZQIVQfcDA1rP9r
         zww32Ak0YuTliaCrL21263hJzbNorMolPH4AcGxIthw9GOSULeSHPKXb463NhpznbeZ+
         fGyoh8rRvEzcfvqH5KQmusARQqUAbbQPg9tx+tkCszU7gNykc7Lu+Gq0pUTI2Wi+EFZQ
         kKXI0rLgtttC+Ob7p0Vufi+5EDPplfzKgG9Ym4b8x7pB2Uxs68kPe5tJDmvCDUeFrEBy
         PFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXrJfmmxAWbUYgAc1YpWoSrR/fYIQQeJz6qUnhOIgis=;
        b=dCc4Gm2ZSZEBfgcc0VEPnnu3IPwEfafMT0LFRT+bzT+o8MULTD/S9k0U+Uc+uUZzSi
         sDf815+6LpLKc3alI+fmZ4eNi00iaE5GmyHVs8+CRTuS32XYtEenJjr26RAdfNA7Ugpc
         8XDklkHENHekpm9GE8M1hCjmOyY6SLfKHUkaxrP9g1ed+6/aSsd2+dd1vBG3ydLDJDD8
         TdkyxsB/RUYHM76rdYXJ7xLn5pMfOlLtgXQcJ39te7WOn2id0ZqItz9z2NIm8UZVCbuq
         4oYPN3hPbMCnbXqRGkDvDZwDQqY0+godlj/cDY1Dx1Dc8r7THXUC6wp6ZaLgcYG8i2WV
         AOUw==
X-Gm-Message-State: AO0yUKUBX4UJCWC0/lsdThUrmvsU/StR7ZIjMj9l1n7GQZ5lCBnou5OD
        ZlWmYVq5SQjbj6VfPjhjDjUB4anmI74=
X-Google-Smtp-Source: AK7set8pjigW6Tf6vzq4YNFcEDFChLpPO+v+o1sP7rPXWFA7t2qYnt3JtyP/p6A3CCC9C0opTntvHA==
X-Received: by 2002:a05:6214:b67:b0:56c:2118:bea with SMTP id ey7-20020a0562140b6700b0056c21180beamr8326993qvb.37.1675916292191;
        Wed, 08 Feb 2023 20:18:12 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id p125-20020a378d83000000b00706a452c074sm543825qkd.104.2023.02.08.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 20:18:11 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: gpio: nxp,pcf8575: add gpio-line-names
Date:   Wed,  8 Feb 2023 23:17:52 -0500
Message-Id: <20230209041752.35380-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The family of PCF857x-compatible chips describe 8-bit i2c i/o expanders.
Allow the user to specify names for the 8 gpio lines.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
index f0ff66c4c74e..81b825a4353c 100644
--- a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
+++ b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
@@ -39,6 +39,10 @@ properties:
   reg:
     maxItems: 1
 
+  gpio-line-names:
+    minItems: 1
+    maxItems: 8
+
   gpio-controller: true
 
   '#gpio-cells':
-- 
2.36.0.rc2.17.g4027e30c53

