Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A007139A3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjE1N1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1N1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:27:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD84B1;
        Sun, 28 May 2023 06:27:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7749357e71cso70938739f.3;
        Sun, 28 May 2023 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685280454; x=1687872454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEM2GqZ8OMei7ENhUmT/X40pgKCW19D6Zd4VJ4P8qcU=;
        b=R8luGRAIhXl4kxrGq9klpfmLL7HVLRAa/SX6uXo7qUjSDp7ljH+HmXvDrigp26fNNM
         Y1aTHI+PZx2p2Y6myKaWvQRpZcrF2mGS4i4/bb4OmmnpOnSY3Rftf+wSgzXYhru/szBg
         WvZzyyrNjl3vPc0MtvSM5T4SFZP1r/c5DmrXaf8TdKbEbVZViNXrhHovdRLvewa8UJru
         LbnHdaF1hxw9yFfg8R/uvFGhiSJD12OEvb3TRpjCO870OWsEA8TuSmZU2yOjd9OVKvjc
         hl68D8s0r5CMmMqZt2m+xUJbwMuhiq05UkyozbAaTmCldXLdExAGThSaDnRRSAcRnfny
         HLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685280454; x=1687872454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEM2GqZ8OMei7ENhUmT/X40pgKCW19D6Zd4VJ4P8qcU=;
        b=DobPtub9NarIzKNapWIUrDqcAHcMK4e9zOB0EcuL5TqbljCD38vsfrY6qY8ii9zf1E
         6AhgOg9V/I3gbhH+QTyy4wfjC2+sVBqpgW1oNpH56PC5vwDDPxz9JSZ8K6g5lABkv5qF
         GakCZYVjrzg3l7Vi8CxBuYqVYGJ8idWnH2t4JPU37dOfmZBfR1Jbtjtbo8Dwx9dzxs4A
         JeCsXBCuraFotIPti7JLGGb+7r3ObL2IetW2HRWqbbxz9PmWLxdWhS0x54Tddnh2nwVU
         U/iTLQ0rEaAUr4Bgy+3oiLrdkChpDGreewrE/lbgexeB0zJ24N5I6ksTLbM2TUU9sIXS
         x0QQ==
X-Gm-Message-State: AC+VfDwmGGCk/cnJnAvuRb4SF1LZr7z5HLrBjVy7YBpV9M/mEz07b0D0
        po5zpnX+qQpAB2K04UC01hTOuvM64j6O1A==
X-Google-Smtp-Source: ACHHUZ6GtMr4xqSpqmFvjtAU90VfNw84Yg1PZzFC6bTY+R7QA/BmfifhSOuJ0y13BfpDPWumnufYdQ==
X-Received: by 2002:a6b:dd02:0:b0:76c:4ca6:34d7 with SMTP id f2-20020a6bdd02000000b0076c4ca634d7mr5679747ioc.19.1685280454476;
        Sun, 28 May 2023 06:27:34 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:afd6:bf52:6c04:831a])
        by smtp.gmail.com with ESMTPSA id p11-20020a02290b000000b004161fafff97sm2276330jap.136.2023.05.28.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:27:34 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] dt-bindings: bridge: samsung-dsim: Make some flags optional
Date:   Sun, 28 May 2023 08:27:27 -0500
Message-Id: <20230528132727.3933-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event a device is connected to the samsung-dsim
controller that doesn't support the burst-clock, the
driver is able to get the requested pixel clock from the
attached device or bridge.  In these instances, the
samsung,burst-clock-frequency isn't needed, so remove
it from the required list.

The pll-clock frequency can be set by the device tree entry
for samsung,pll-clock-frequency, but in some cases, the
pll-clock may have the same clock rate as sclk_mipi clock.
If they are equal, this flag is not needed since the driver
will use the sclk_mipi rate as a fallback.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
V2:  Split from driver series.  Re-word updates for burst
and pll-clock frequency.

diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
index 9f61ebdfefa8..06b6c44d4641 100644
--- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
@@ -70,7 +70,9 @@ properties:
   samsung,burst-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM high speed burst mode frequency.
+      DSIM high speed burst mode frequency.  If absent,
+      the pixel clock from the attached device or bridge
+      will be used instead.
 
   samsung,esc-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -80,7 +82,8 @@ properties:
   samsung,pll-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM oscillator clock frequency.
+      DSIM oscillator clock frequency. If absent, the clock frequency
+      of sclk_mipi will be used instead.
 
   phys:
     maxItems: 1
@@ -134,9 +137,7 @@ required:
   - compatible
   - interrupts
   - reg
-  - samsung,burst-clock-frequency
   - samsung,esc-clock-frequency
-  - samsung,pll-clock-frequency
 
 allOf:
   - $ref: ../dsi-controller.yaml#
-- 
2.39.2

