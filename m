Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CA6452DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLGEJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:09:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B84E6B6;
        Tue,  6 Dec 2022 20:09:17 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so15201022pga.1;
        Tue, 06 Dec 2022 20:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGWGdognDWHGX+nqNjk4QQWgeIg0knIT7CWaIudXUak=;
        b=bEDz2XPQ3VK5ctm+F+fbQk1+9swy2xH+SZCZgAdUXM+40sq0wMW1UkOgkbbMx/mXJq
         c0oOmjLNRKUJkhrUUqZxueiSNk5gQadboumoeW1BD9AOTAQ3yJit/QQKlEalj/VwDJNW
         2dAUWnQMmmIn0bwpyXr4rY1+gE2x0rQESta2Bj7p56CJdwa/qDNVv8Ms9l6QVrGbPGbv
         qL47sJrawPL/5lcMr4Dm/IlV5DvG3+oo9AwjNIoDKslyWH0Gk3lIb83QFyewczi8EIYO
         B5ji5W+pQGrMsGXRLE6AH74M7SEHd1ZHGX6tL2vbZWrCGwSExBntD0ruE3TpeP8wj4Mc
         3XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGWGdognDWHGX+nqNjk4QQWgeIg0knIT7CWaIudXUak=;
        b=v70UsbUNX6FbRNY9HmlWxQID/oMlI+lfxU25Xn4sff64j5VdRFmDGyXY9qWF7WFHO+
         Ot6WgZX9H28Qr8or4MXc3tvhgKp8I0oYXXm+ClwpRWqC/pmICXzFdAl3WKlRg622WQzw
         T0XbVpovOZdYLUBiFoS8Lbirnn8xCMwvwoja7HHoD+7JRuCQ5a0NcqPM3NBoYaOqG45v
         PDvascWpY8LX29d8oLkHQjRGyXJmDWDoIpHThflCPjvPfHor0Y7MxLwb9YQRajnFDX/V
         ZRMLN9yMW5W66WS5IYJOOb1o/CRbasrFD0R1zsLIv9ddTKqADOybOMZ9pTA4NVNoWk2w
         6hIg==
X-Gm-Message-State: ANoB5pkxOk0hrLN8ooD69vymS99jVLFJwIHehLXXwUxMIxq+7sYJOISP
        JMgI3vzNZD3B6W9Sgz7eGVxDPpd7lzY=
X-Google-Smtp-Source: AA0mqf5vKCDnEMlI7100pEVBCccG4nNqyYLLcsa372D65Da2CHm31WY4CIQ/fQ5Np3vqEJMmiamxPQ==
X-Received: by 2002:a63:60a:0:b0:478:80ac:566c with SMTP id 10-20020a63060a000000b0047880ac566cmr22609717pgg.320.1670386156506;
        Tue, 06 Dec 2022 20:09:16 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b00478eb777d18sm587822pgl.72.2022.12.06.20.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:09:16 -0800 (PST)
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
Subject: [PATCH v3 0/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Wed,  7 Dec 2022 12:09:01 +0800
Message-Id: <20221207040904.582585-1-gch981213@gmail.com>
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

Chuanhong Guo (3):
  dt-bindings: vendor-prefixes: add an entry for WorldSemi
  dt-bindings: leds: add dt schema for worldsemi,ws2812b
  leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs

 .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-ws2812b.c               | 219 ++++++++++++++++++
 5 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
 create mode 100644 drivers/leds/rgb/leds-ws2812b.c

-- 
2.38.1

