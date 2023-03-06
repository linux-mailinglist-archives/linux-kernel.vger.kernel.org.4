Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0F6AB857
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCFIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCFIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:31:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258491EBD4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:31:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso4649254wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091499;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ9dX1yqOkVplS53pDQk6TsdKFFTae1EpPWYpLAyuC0=;
        b=xP1KgTFueGNTV5O5U+ke5w6mZZsav01et//f23TjsbOHjALthUinL2P0srbq5n28eh
         JE1r6R8PeQYpWA28KwdSPtgdPp2804A3WPXFPMy/hleMlaUyhIn1S/Y3l98smI9hqdsq
         ri6fxLbx/HALxCr6tAVLqAsaDR9zJo48z0+Ur4tSudnTLEuRne9RDNMb+6EQYR4oeYGy
         z9o/n6vdzjxOwRli6PmOzNhSboEMod1mvvRctxwT9OYEiZ4yg4wlaAms/ByXGXu9nq9r
         JG/q213yZ/JHpdkczBMF1IHVxg57iGKgOBw/DIGSpO8biVuaPymdXefpqYnFVo6rM6dh
         G0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091499;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZ9dX1yqOkVplS53pDQk6TsdKFFTae1EpPWYpLAyuC0=;
        b=hJ6t33B4zK5mNyETkoI4CarsMunW3sLtqF9fmPwC0FgOloq8rNe2/Zuc9KrW3osKLE
         2lsfLE0pJov0F7arctLd+OAySNVvmqMsxht01nFf7Z6U1oqQogu/UmUO+Vdf2gpBDwYR
         DMB8LnCRbfrRk9+D+3aDiDsm+T6sCE4ZCOI6wwSCHfROkzerufw+DtpX6CiCKHAdaEJt
         usDtQ6o9BNx/2609xp+6cXW5s6doG4lRV9l/J4HwPvYf95VnsJpIcUDosirAhkIn7su9
         ANkGR1aFvblOEgFMlKxMTuTML3rrIHBvAZ0p4DE80o+qmZQn/HUjhcEp0VBwI6vvb+f9
         ZQSA==
X-Gm-Message-State: AO0yUKV+WDrxHZ7+9Kho6acmEsnAEouKdYqifGOoftewYjLSds1DS8kV
        eYs1Xg/Lh/rMndy0F/zJUEjoZw==
X-Google-Smtp-Source: AK7set8qd06ahF3AiQWFs3rx1lzdgIlBEjQNS4dmqXxiohg8IZu2OWkrAET24Ivd8FaKR/G6PTb2OA==
X-Received: by 2002:a05:600c:3505:b0:3ea:f883:53ea with SMTP id h5-20020a05600c350500b003eaf88353eamr7840614wmq.7.1678091499543;
        Mon, 06 Mar 2023 00:31:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003daf7721bb3sm13529724wmb.12.2023.03.06.00.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:31:39 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] arm64: amlogic: Add initial support for BPI-CM4
 module with BPI-CM4IO baseboard
Date:   Mon, 06 Mar 2023 09:31:37 +0100
Message-Id: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmkBWQC/42OQQqDMBREryJZ95cYq9Sueo/i4id+9UNMQqLSI
 t69qScosxjeLGZmF4kiUxKPYheRNk7sXQZ1KYSZ0I0E3GcWSqpKZsHiAxvA2fox+xrSEgln0IH
 BzDdoFcm6UcO9raXIJRoTgY7ozJRr3GptDkOkgd/n6qvLPHFafPycJ7byl/69t5UgoUZVYYk9N
 bp/WnYY/dXHUXTHcXwBuVN0feIAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for both the BananaPi BPI-CM4 module and the BananaPi
baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.
                                                                                            
The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
but with a single HDMI port and a since DSI output.

The current CM4IO baseboard DT should work fine on the Raspberry CM4
baseboard and other derivatives baseboards, but proper DT should
be written for other baseboards.

The split is done so it's easy to describe a new CM4 baseboard, enabling
only the necessary HW used on the baseboard.

[1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- rebased on v6.3-rc1
- Added Tested-by, Acked-by tags
- Fixed audio routing
- Fixed position in makefile
- Fixed emmc 1v8 regulator node name
- Link to v1: https://lore.kernel.org/r/20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org

---
Neil Armstrong (2):
      dt-bindings: arm: amlogic: Document the boards with the BPI-CM4 connected
      arm64: dts: amlogic: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard

 Documentation/devicetree/bindings/arm/amlogic.yaml |   8 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  | 165 +++++++++
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  | 388 +++++++++++++++++++++
 4 files changed, 562 insertions(+)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230303-topic-amlogic-upstream-bpi-cm4-92e0562f8950

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

