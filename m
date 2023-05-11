Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C486FFD08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbjEKXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbjEKXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:14:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87D65BA5;
        Thu, 11 May 2023 16:14:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1649526966b.3;
        Thu, 11 May 2023 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846857; x=1686438857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1YaV1mLf8ta46NqCsJ+gUT1ajmBoG4/m5hmiu17DFk=;
        b=JW7oR2OyYZ62rFL5P9pzdR5DWFAgrbpzmJmlxoUBxtWRZOwPmOahMp5o43VaHDUlC4
         pv2mkhlpxKEz7e0vvrVa5PICdu0vXUQVH4KIGVX/R10DkUsGhjESdrSlH4USgc2TADYZ
         9SKUEboWvCPdVXNIsUzgiP8/Ks8xAvdEJLJGcXqpF2OYsNNwcPNWhdEFrpOQ9n8dtq8+
         JE7sUgrjFL4lTvfjuWGtP8DGIOv1vO3GdXUl+qdOaUbcKJzPQkKieF4ub8t6tv8TP61Y
         dmpg5Uq6l3Il/z6HPcMxu3R4R0lGRY8s6X9Qm2ZTAOiuSn3I/ta9ZMuR2y9gcmBUmuVY
         Pitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846857; x=1686438857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1YaV1mLf8ta46NqCsJ+gUT1ajmBoG4/m5hmiu17DFk=;
        b=XDH7+pCLGDjjacJv20rR7rCyI/H3RJvKF1hNsXZDzkd8E9wb0clJK9v3u0kMlpkOvb
         /pgxbjQzkQoCDy0Jm1Uv3FmOKbIMPH43EyvGd4TzVkzaDOx1vQKre9pEnqeGYGM1XjV2
         xmQmXO904efQjRWqGqs4cQuTspetSTCGVBC7G/q2aeKE1voarCfabQ1mfhUOja36091Z
         GWJ7SiM5r6gr831XPctibl3cED6RKJRqzqsoDRiQzPABilWUtLkS8AerT9RU22tC1WHM
         2oFWT/U+bPKa2eiDWKfGBXzUrmHSkg18C+SYGn+Lgpy6haEtLPu32trCizd6gataoq/v
         2tsw==
X-Gm-Message-State: AC+VfDzb2hAiAHwcRmh/Bv1W3q6pp6Likf24V9J1n0X48BtQNW9LaoEH
        fr53agzCeBeB+mSBvAVjSuw=
X-Google-Smtp-Source: ACHHUZ4zTQ5dUIsmJG0DHK5HLv1IgcRBZF+6ZtK7r+B79fL4gxSiCG5zBaSBtGGy5N4YjlOXhR8GzQ==
X-Received: by 2002:a17:907:a407:b0:96a:928c:d382 with SMTP id sg7-20020a170907a40700b0096a928cd382mr986215ejc.48.1683846856728;
        Thu, 11 May 2023 16:14:16 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c7874f2f0049cdad3080524d03.dip0.t-ipconnect.de. [2003:c7:874f:2f00:49cd:ad30:8052:4d03])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm4543023ejc.182.2023.05.11.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:14:16 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
X-Google-Original-From: Boerge Struempfel <bstruempfel@ultratronik.de>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
Date:   Fri, 12 May 2023 01:13:14 +0200
Message-Id: <20230511231317.158214-2-bstruempfel@ultratronik.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511231317.158214-1-bstruempfel@ultratronik.de>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 782a014b63a76..46d5acc1fc232 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -34,6 +34,12 @@ properties:
     description:
       The device requires the chip select active high.
 
+  spi-mosi-idle-low:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires the mosi line to be low when idle and the
+      chip select is asserted.
+
   spi-lsb-first:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.25.1

