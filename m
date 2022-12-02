Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220263FF28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLBDnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiLBDnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:43:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3212935A;
        Thu,  1 Dec 2022 19:43:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h193so3362492pgc.10;
        Thu, 01 Dec 2022 19:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOx0w0mnQfQWQTws79m+7TjAlJJBi7acjo8aETWPYBM=;
        b=ow4Erc3dpaVkQ6cQZa4+ljGr9mDSI4TE/QVw3SftvZryhBd2/e+y4EIjmGnFwEn+Kr
         FGVDEvxlUS2zqsEob5M4eBVXIBC0I2niqf/wBu8kxRoK8HFGfZ0RGQCGQ622/B1hHv4q
         HCCYXCtXpk1NVIMCstSS7ICu+nu1Crre/cqo72Fn0LArW7TO/AwyJ56EnknpX9xdhchV
         sOPYG3kwapdySIFB1ybkwx9WkBPZTp4OWMvDHLrgbTq3r90OrpxD2shZEpAFzmNuR/0z
         oLqnVHvqJpdOblzm5grbTC2BiE5p5fn3VRnwEprC94epaI25LwlECDsetYaGumatW+ya
         5W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOx0w0mnQfQWQTws79m+7TjAlJJBi7acjo8aETWPYBM=;
        b=ELRcoBDKLFadzU2zSYldWZhEyztglEThMyFGz6KGkgHkJiaLslBH7ND4sqE3pQprVT
         HTVQu+l3wdUqqxqtHAqbfQQPgH0ow7mSzlecLzUEVVc+ROQG8mw0YzrsPETdDaRiU45Q
         IwWUy6SA/ka+lEkYJFNZNl0ck7yTC9qbRtVDGBRUI4KWFQMaZ1gjKAxzarb6jAlom0Qw
         mTqDKPI7ou8e+qu4RTyNdqjBr7uLb4J4sbd2rJCw36WdfiWIHKZj7AI0dtpnLUBDB0TC
         PE30MilJNV+VeBEg/rQpwzksa1+bw3eOeO016yay3/V5gn1+VbKwwyrdMAUc4QHpFEpX
         RHJw==
X-Gm-Message-State: ANoB5pmo7O0+Ey5OCX+lgMuBaiePAbnpX3HR8rTcfk12IQvLUXRWZCp2
        rg4zSnhKztaEiL5tuabpnaUb1OX6nag=
X-Google-Smtp-Source: AA0mqf5lejTM9Tko+7AruYXuNLKeWQS9a65+g6HuExEGSjO56XWuhlJnlKzA0ohiGY3d+kA6r9Cg8A==
X-Received: by 2002:a63:220c:0:b0:46a:e819:216c with SMTP id i12-20020a63220c000000b0046ae819216cmr49893931pgi.155.1669952586681;
        Thu, 01 Dec 2022 19:43:06 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0017f59ebafe7sm4370636plg.212.2022.12.01.19.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:43:06 -0800 (PST)
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
Subject: [PATCH v2 0/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Fri,  2 Dec 2022 11:42:37 +0800
Message-Id: <20221202034240.455831-1-gch981213@gmail.com>
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

Chuanhong Guo (3):
  dt-bindings: vendor-prefixes: add an entry for WorldSemi
  dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
  leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs

 .../bindings/leds/worldsemi,ws2812b.yaml      | 138 ++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-ws2812b.c               | 235 ++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
 create mode 100644 drivers/leds/rgb/leds-ws2812b.c

-- 
2.38.1

