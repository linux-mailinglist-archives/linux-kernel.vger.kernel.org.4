Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F4649888
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 05:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiLLE4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 23:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiLLE4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:56:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4ACCE2A;
        Sun, 11 Dec 2022 20:56:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jl24so10873875plb.8;
        Sun, 11 Dec 2022 20:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AGiY0wnB/1m3iy30ZrryEDinMyDvzaxsJSLhD9hQaE=;
        b=eGlrN+5mGhSHe4z0TumOiU7a2hqc/W8jiUNb4JeI2W71jcBOa6mrUByAOYpLJ5WzWP
         TrljNq1vYokJhDHji7ASzrCw5OBPqx3j9Vrwa9xPsuWJYidRIEQzwu7GUGkm1Ho5+AIE
         UnEvZt2Rl8+nlOY6sTD34rlutbeM5Bk92huMbv8lVtzuaHHFxvCFGL0wV3kVAorIfORB
         eQ7I1kXOvfDCTmOEq8bi4XLUK3jkEakkmY1XHZClzX8xQtav218bozI6fWlxDTLba/hx
         ewjxmhR/BlLJefQF7zXemxyu284VEFdFcYedoAIxaeC2osg+eBXSo8lbPyPPYFedgLQ8
         5qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AGiY0wnB/1m3iy30ZrryEDinMyDvzaxsJSLhD9hQaE=;
        b=EJMwrVJ2Z0VzjyECiCInq140SeBcbuOgJX9y+Yell5U+v24ekqcoOLPgRTXIgTORJu
         yqdmgOdCn9gv6WLFaOvbKBru5Fs0TVlV74QhCDxM0eGadqeCOk0Wv9fOvM9AgBi9Ulpf
         DKrnQpn3ZZB6nO5leqPytPTbbkEayo6nGObK353EbAqckNQIxWWLdlCSf/7Jz31SOyDB
         ZVeMAEYaaRxp8kSWQCGHDSmr703dD5/vp39CyTD5LD8rZCltHcQ013S7n2YIrmBmDFr1
         Fu5O/zUnW6N30vP8MGv/w4icGshr/1oP1Smi7lvo3QexZ0a/95B9ZwOdHdiKJCkfV5fW
         3zqw==
X-Gm-Message-State: ANoB5plXRHlSAi7Lw1IUCwcTp3xijATAJPu4ZkYDHKpLv0zqpazuMlx3
        JiAGSyPLeyB3Qmy/7NKzFLMYIDCRbks=
X-Google-Smtp-Source: AA0mqf7eAaCS7xBtsp3I9OgZv8nzvoFI1o8ru+D0Frfm88ywYRttXsdEE+bg7sbwNt35treA1Y8LKg==
X-Received: by 2002:a17:90a:12c2:b0:219:2f17:f956 with SMTP id b2-20020a17090a12c200b002192f17f956mr15007957pjg.40.1670820971677;
        Sun, 11 Dec 2022 20:56:11 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id s20-20020a639254000000b00478eb777d18sm4217674pgn.72.2022.12.11.20.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:56:11 -0800 (PST)
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
Subject: [PATCH v4 0/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Mon, 12 Dec 2022 12:55:55 +0800
Message-Id: <20221212045558.69602-1-gch981213@gmail.com>
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

Changes since v1:
various dt binding fixes
add support for default-brightness

Changes since v2:
more dt binding fixes
drop default-brightness and default-intensity

Changes since v3:
1. add more comments
2. rename reg to cascade
3. redo some line breaking
4. move duplicated pointer calculation into ws2812b_set_byte
5. reword error message
6. get ws2812b_priv from led cdev->dev->parent

Chuanhong Guo (3):
  dt-bindings: vendor-prefixes: add an entry for WorldSemi
  dt-bindings: leds: add worldsemi,ws2812b
  leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs

 .../bindings/leds/worldsemi,ws2812b.yaml      | 116 +++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-ws2812b.c               | 231 ++++++++++++++++++
 5 files changed, 361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
 create mode 100644 drivers/leds/rgb/leds-ws2812b.c

-- 
2.38.1

