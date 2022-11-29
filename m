Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7963C1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiK2OKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiK2OKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:10:15 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8FF5E9C6;
        Tue, 29 Nov 2022 06:10:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so13075906pgb.13;
        Tue, 29 Nov 2022 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVP9j+3BhVTLvWLIbS8NQw4iMFG9wd3z53JwQ0Tttrw=;
        b=RmvYdYu3p4xuFYAItsLk/YIMiEvOYMDpKR0GkFlfhSCRGxMjST/G+rY0nEXgrZuh2i
         6C91j3KEv26zEj6/wAg9y5NEdKVtXAnKs9gvu0Lc6PMrTvfKHzQCAeW0zpc+AUzYacL6
         xGRp8/pC5g8sOgIvT11sFgkcrQn4b7HMjU88nnK6cr1ogdHHZP3LcTeKINgTyqsXmeqi
         NwyaRQz3vF2bvi/ZJyJHbAJDiwYL+ERKZUNHGdQCFcN/7pWtn2VJk2DbcSeF9yqqNwhK
         3h1Q0an+RFVybhGr0MW21w3u3JrEx3UWytWT0I3NhdiRHxMkrXFQDZ4xRZQfdTH2fmh/
         Qmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVP9j+3BhVTLvWLIbS8NQw4iMFG9wd3z53JwQ0Tttrw=;
        b=TP9a0XAivOAM4WLnrj/qwtR5lY/1u+9s/N5CS7kndGci+H0s1OXb9938C8ZJdh0vAg
         imNZ2mTEhdjVjpr7qBSKbTbP3vpv2wdEUAYJAMD/sEPQ5GuHZ0zyh6kbfVpyhH8j6OIr
         yLZIoE3j+CMLp8L+DJQdfsMBC3DQ1KZiwU6YYy43OqsHDruj3G85opYRZaiQzVU2SoYW
         W3Iuk5Ob3b4pNmcWevusjqqsHloGdcWE220VKaIAihq/qipTrb4zFLuJ4BsYh6Hn9EBN
         6M6M6XWyXpnwB+/UA4GWKyyBPtojM/J9HQ9rWHjt61auU8/IyYfUjP01QdUw+6egS5ix
         mxpg==
X-Gm-Message-State: ANoB5pkx5YR6BmoqavjBs7xYlnqjp/ws3pUwh3YPO00Ginmk/YHtTBTT
        4jNThGoUJsNUIgSgDJ16DpbWbIyCbZA=
X-Google-Smtp-Source: AA0mqf7NiOKYXunJCGeM4irmRCqv9IIOpYiaf+seCAXF3GXRd0Oje0hRtTf0ZWFcm7FQGLRP09ZEnw==
X-Received: by 2002:a62:2fc1:0:b0:562:fcae:5f10 with SMTP id v184-20020a622fc1000000b00562fcae5f10mr36698094pfv.28.1669731004646;
        Tue, 29 Nov 2022 06:10:04 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0017854cee6ebsm10932342pll.72.2022.11.29.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:10:04 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Tue, 29 Nov 2022 22:09:52 +0800
Message-Id: <20221129140955.137361-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for driving a chain of WS2812B LED chips
using SPI bus.

WorldSemi WS2812B is a individually addressable LED chip that
can be chained together and controlled individually using a
single wire. The chip recognize a long pulse as a bit of 1 and
a short pulse as a bit of 0. Host sends a continuous stream
of 24-bits color values, each LED chip takes the first 3 byte
it receives as its color value and passes the leftover bytes to
the next LED on the chain.

This driver simulates this protocol using SPI bus by sending
a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
frequency needs to be 2.105MHz~2.85MHz for the timing to be
correct and the controller needs to transfer all the bytes
continuously.

Chuanhong Guo (3):
  dt-bindings: vendor-prefixes: add an entry for WorldSemi
  dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
  leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs

 .../bindings/leds/worldsemi,ws2812b-spi.yaml  | 131 +++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-ws2812b-spi.c           | 222 ++++++++++++++++++
 5 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
 create mode 100644 drivers/leds/rgb/leds-ws2812b-spi.c

-- 
2.38.1

