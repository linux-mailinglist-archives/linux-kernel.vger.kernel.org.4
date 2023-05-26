Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A79711E50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbjEZDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:06:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27918D;
        Thu, 25 May 2023 20:06:22 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77491a28035so36039339f.2;
        Thu, 25 May 2023 20:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685070381; x=1687662381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRTsj12b6O33FC+cr8c7BPZ01uR7I3K/mmxNkVF4jws=;
        b=WmIQ59Di4v3M/mXQbgwi2pQoRYZielG4kZCCoqzPisHE+8DjvztO76vbRaQG41IpE/
         95lE0AlZ3kQ+DZ03BU2On7Il7WUetoWIgnXteDV7hCia8s4+hZ/U/lRjylif0+1OhpbU
         5zVh0qb6kiwihMfRl36/KV8/loJcBiqqNBhwUSf/509WIfn7wmcbl0/ghiMHvEAE1KMj
         FE9JvYu75N8ewqC6Y2m8ynZ8eSAVKw/tzQ7JOKFn5l8EBHCduhYVk/s06zw03b/pKn4W
         VU9ruuT8LlTE7rRxUVzaGWaOLSrc50RqgmJUK6RQpgR9dH9Y/8oFIvuta8ITbhNyDZ/J
         X05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685070381; x=1687662381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRTsj12b6O33FC+cr8c7BPZ01uR7I3K/mmxNkVF4jws=;
        b=EixwN7lY5lL5wbzBxn8EaX/5UreJlDcC2rPAufy5fC7E0JEWZzFSVW4F4fIs8ZUUXm
         CYyn8aK744UBQuK164+soc9FLO6nsYf2j7Ja5UeGl7pp9PNIp6XIN9eALsqKlR1xVh19
         ufS4AyLVlg9j9LdBIzMzM/au09tdh4lZAaZJMkA18NGfDdQRpsrgWMNIgLZOkkTdoYwW
         dCpjHb4z2/VWTpr1vQmMjQWHUJP0yg+1SFYQcU8N+BxBxKfSOqsWUdTNDg/2NYkNPwmO
         syF79mw7+fNosJD6z+zkpUwAFwUynxOnPD/r0gTVrntudRghUAJFNf6sLMHlO61cmkxg
         hACg==
X-Gm-Message-State: AC+VfDyjzjX+9/NSTQ9nvnqG/ugygKaH8VqR/9knKyf/tHgeQ8HjTzvj
        rv9DV8jaqa4YxJMKId8xct0=
X-Google-Smtp-Source: ACHHUZ46ETqqCYSYeOAgsdP4uUnjzzJzPtujOlWTViqpEcR6iNPvd45x0tYH4YmDMzJqwsndOmzppg==
X-Received: by 2002:a6b:da0e:0:b0:774:8a30:a928 with SMTP id x14-20020a6bda0e000000b007748a30a928mr162926iob.5.1685070381381;
        Thu, 25 May 2023 20:06:21 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:3dd9:3f6c:9922:6420])
        by smtp.gmail.com with ESMTPSA id i2-20020a5e8502000000b007702f55116fsm363189ioj.38.2023.05.25.20.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 20:06:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
Date:   Thu, 25 May 2023 22:05:59 -0500
Message-Id: <20230526030559.326566-8-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526030559.326566-1-aford173@gmail.com>
References: <20230526030559.326566-1-aford173@gmail.com>
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
---
 .../bindings/display/bridge/samsung,mipi-dsim.yaml       | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
index 9f61ebdfefa8..360fea81f4b6 100644
--- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
@@ -70,7 +70,9 @@ properties:
   samsung,burst-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM high speed burst mode frequency.
+      DSIM high speed burst mode frequency when connected to devices
+      that support burst mode. If absent, the driver will use the pixel
+      clock from the attached device or bridge.
 
   samsung,esc-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -80,7 +82,8 @@ properties:
   samsung,pll-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM oscillator clock frequency.
+      DSIM oscillator clock frequency. If absent, the driver will
+      use the clock frequency of sclk_mipi.
 
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

