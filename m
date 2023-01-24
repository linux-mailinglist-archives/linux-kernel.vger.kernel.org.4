Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EA6793C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjAXJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjAXJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:16:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C3244B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:16:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q8so10882978wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzZ68G+EqUxB4ReB2DFPbvUfCZJuRkKJfwx6QbLkd9s=;
        b=qNLZBMKp8jlCOQ6VKoGcz89327mXO1daazZJmZx/ApU597Tmv2aOx1yJ/P2hFuY+WR
         G8c4X1Ja7OmMvMvuTHgs0ofb3Oz7677dr7zhph17CTZZe8ZmSkN5hUFbp6VMp4D4q+zt
         3dRDBMyhC57ofxBd1bmOI21HP1e/+J5pMLmMg5mvgOvsniS+bb40e+fWYpBw6W8nWpzv
         26xvebR5JbrPN0jFLk/DY2MTnlxQtv7WEqkm2LbpTJwh6kq8CEc6S71SDj6qqyaMUfTl
         NDY30jEE0zySKmWS1q+CjCIpx01C0lAOMzOLu0Dzsdw4GD5oW3vneq44bX0/szF7+Bl9
         WTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzZ68G+EqUxB4ReB2DFPbvUfCZJuRkKJfwx6QbLkd9s=;
        b=PW4s6RFP8hgFJjPQJkQaTzFT2u+oEi295+B+Mmw1Sor9Zew5TeXN8SLP511BEfOmiH
         UyLZzsz7TCn0yWEWCKMDaxxt/gTKZg3UXqnE6Pn2y9yT2vRLASYitjfPBWCi8/s/9vhp
         Zh5+r5b3det/DlIMKKzbKoqwziEgbl0s3x/tgsOaSMYvJBu+4D4561FZqNo7/FTFj3T7
         3dqK41IC5yto0hrot0AJXiTD3GbHjUUsxQBk8pNrtNigDXJYdpaVoTOUMmhVKW8v42Kw
         l6ok5kHI/ZG+kz864oaNEf1b6Ro+DoyDIhWGc+TwsNixh6ul6s+9CuEnH+aqGf3Z0Dzk
         zoFg==
X-Gm-Message-State: AFqh2kofU4W/KzGLdnX5EXvx83Ekz4nGUgh0guBTLXUPBKBN0ahM7uNe
        y0CTaoOaC3PoG1sB061Rn4q1Rg==
X-Google-Smtp-Source: AMrXdXsKFwbW1DrSBlwbOeumT8HcjGuNecHBwhrXcJJzSlSBKZ+BDJR+H1Po1PDNqEw25ivpfYz9PQ==
X-Received: by 2002:a05:600c:198a:b0:3db:114:a6a0 with SMTP id t10-20020a05600c198a00b003db0114a6a0mr27455259wmq.21.1674551768883;
        Tue, 24 Jan 2023 01:16:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003c71358a42dsm17882131wms.18.2023.01.24.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:16:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/12] dt-bindings: serial: cleanup and improvements
Date:   Tue, 24 Jan 2023 10:15:50 +0100
Message-Id: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Drop "dt-bindings: serial: restrict possible child node names"
   patch from this series, because it requires more discussion.
   I don't know yet how to solve the errors.
2. Add tags.
v1: https://lore.kernel.org/linux-devicetree/20230123151302.368277-1-krzysztof.kozlowski@linaro.org/T/#t

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  dt-bindings: serial: amlogic,meson-uart: allow other serial properties
  dt-bindings: serial: 8250: correct Nuvoton NPCM850 compatible
  dt-bindings: serial: pl011: allow ARM Primecell properties
  dt-bindings: serial: correct ref to serial.yaml
  dt-bindings: serial: cdsn,uart: add power-domains
  dt-bindings: serial: 8250_omap: drop rs485 properties
  dt-bindings: serial: fsl-imx-uart: drop common properties
  dt-bindings: serial: fsl-lpuart: drop rs485 properties
  dt-bindings: serial: fsl-lpuart: allow other serial properties
  dt-bindings: serial: st,stm32-uart: drop common properties
  dt-bindings: serial: drop unneeded quotes
  dt-bindings: serial: example cleanup

 .../devicetree/bindings/serial/8250.yaml      |  9 ++++---
 .../devicetree/bindings/serial/8250_omap.yaml | 23 +++++++---------
 .../bindings/serial/amlogic,meson-uart.yaml   | 15 ++++++-----
 .../devicetree/bindings/serial/cdns,uart.yaml | 19 +++++++++++---
 .../bindings/serial/fsl,s32-linflexuart.yaml  |  2 +-
 .../bindings/serial/fsl-imx-uart.yaml         | 11 ++------
 .../bindings/serial/fsl-lpuart.yaml           |  6 ++---
 .../bindings/serial/fsl-mxs-auart.yaml        |  2 +-
 .../devicetree/bindings/serial/pl011.yaml     |  1 +
 .../bindings/serial/renesas,em-uart.yaml      | 10 +++----
 .../bindings/serial/renesas,hscif.yaml        | 26 +++++++++----------
 .../bindings/serial/renesas,sci.yaml          | 24 ++++++++---------
 .../bindings/serial/renesas,scif.yaml         | 24 ++++++++---------
 .../bindings/serial/renesas,scifa.yaml        | 22 ++++++++--------
 .../bindings/serial/renesas,scifb.yaml        | 12 ++++-----
 .../devicetree/bindings/serial/serial.yaml    | 18 ++++++-------
 .../bindings/serial/sifive-serial.yaml        |  6 ++---
 .../bindings/serial/st,stm32-uart.yaml        |  7 -----
 .../bindings/serial/xlnx,opb-uartlite.yaml    |  6 ++---
 19 files changed, 120 insertions(+), 123 deletions(-)

-- 
2.34.1

