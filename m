Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F656AB004
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCENqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCENqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:46:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F1CA04;
        Sun,  5 Mar 2023 05:45:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h11so6354417wrm.5;
        Sun, 05 Mar 2023 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3lfSrbd4QG8pApbR/SCATb+t3wLQomrPBsssXD+brM=;
        b=lRu8tiCiBCSJ0FkKW4I2QJ0maefa4Rsck5BBpAD7C8nyPs5GyUvxGH2+zVgybJuJvj
         yznYU6tyGj14agJHJ5mJ1b5gO2wPleUobpq8KaJjGnAkzybLvHMwJmcEJnkSQ3czWoQr
         GC8vLJ9AHr8iGYUxqMl/WekrZQpH+lEsCgXa9Sf2B0/GkiOBAm80dwlulo524+kfM+cL
         BxAEuyFlezic4W+0EbA+CS8c2LXRFAItT5GWcaGIG5L+phwh/bzuoUsSoFL09iAc61aQ
         sYloYT4NW+1dX4RQvrUTQzdRO9AM2BqWehyNGWVohdWDlDUUKzRu/W5jn9MR63TCedS0
         Hdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3lfSrbd4QG8pApbR/SCATb+t3wLQomrPBsssXD+brM=;
        b=FFWhx1J/25Z2w+2Y7XXn3dYHJQ5UIoVGfXtguguVq2PlKewkknlf25eH2gRLPuxI0Z
         kNZKNieaeiF+uTD8jFh+4Z74Ay8xe1zqqr8idHDazdioB1rJ3l4ScdWmXYp9/H2PBoNk
         icLuyarjJ1b9u8x2yKyv9KvcmbKsqSx708L/xr/w+Hejtqtmd9FJzV1dTilasiJKZY+4
         6cgoBzVxZ2eOnRhCqQRDKZaOxeu8NzSjhOQZ05JXvHMPWbcFlRaJg04zjiSFGIYBiwiX
         9v/K3pyf3NlUArz73sLtZ08p4EMQH4XwVvrDoruBlTTroX6g8IQR6MuwnLb780V2wAue
         mjoQ==
X-Gm-Message-State: AO0yUKUqFgug6YyxR8OxIoe/swhWXJ2jto+hkijJQueMV3fnosigd/RP
        JtvftH2Hay3LtdiiGaBRiqA=
X-Google-Smtp-Source: AK7set/J1KAoZpvFBzDy6E/mVM5T+GeQDY3QdIQXn8Cr88+Bb4rbmJg2AHQphHxF5zWBNJtBO2H/5Q==
X-Received: by 2002:adf:ec47:0:b0:2c7:e48:8ca3 with SMTP id w7-20020adfec47000000b002c70e488ca3mr5119278wrn.0.1678023916627;
        Sun, 05 Mar 2023 05:45:16 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d4f81000000b002c54e26bca5sm7421507wru.49.2023.03.05.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:45:16 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] arm64: amlogic: Add initial support for BPI-M2S variants
Date:   Sun,  5 Mar 2023 13:45:10 +0000
Message-Id: <20230305134512.1596572-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BananaPi M2S which ships in two board variants with
the Amlogic S922X or A311D chipset. Schematics for the board are not
currently available from Sinovoip so the device-tree is largely derived
from the Khadas VIM3 (also S922X/A311D) and other recent BPI boards that
have public documentation. The device-tree also supports the RTL8822CS
WiFi/BT module. This is optional so the nodes must be enabled though an
overlay or fdtput.

Patches are based on current (v6.3) for-next branch.

Changes from v1:
- Fix LED node names to follow schema
- Add Krzysztof's ack to bindings patch

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for BananaPi M2S variants
  arm64: dts: meson: add support for BananaPi M2S variants

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-bananapi-m2s.dts |  37 ++
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi | 521 ++++++++++++++++++
 .../amlogic/meson-g12b-s922x-bananapi-m2s.dts |  14 +
 5 files changed, 576 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts

-- 
2.34.1

