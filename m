Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD06A8DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCCA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:29:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6C144A4;
        Thu,  2 Mar 2023 16:29:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id x6so782046ljq.1;
        Thu, 02 Mar 2023 16:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYzYl65lrl4NIak+68JmKnOBYHqlW8O3mwHR68tLLkw=;
        b=JfUrCkNOnBcbDT2s9JlFztH5eY16LbVYb4C4xlE3tDBEaRi1JVwxRjJW6XAU5eouio
         DcX/lkRwKBMgu3gN0nnPo9Z8DHNteKZP9MGznEXoq6tXdWAnWJLlRsLhGnL95kCD1IAQ
         1TcP2EbyNyugC48p2leCDlnW7XQXwdqxvCjyqfYkd/oS5wePLrNAuzolUUSzmbq87BF1
         R73MWB7pdv+kB3gy5HSSQQbHZgqvAMp3bNAyab/HI7s0kMa6ow0VRYv7xgnV9kcuPfbZ
         ZCtm+/UfIQZnX22E1R+AFe/g14uKLHxS7705jZWtq6ZbwzjAnQT3Yis7dmLqFveX7LU2
         bfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYzYl65lrl4NIak+68JmKnOBYHqlW8O3mwHR68tLLkw=;
        b=x0RxDDMkny/p0FdQMXPIdWGMSilVI/vcBzcko9hrPjYbynCL3W5U+SUQYC05hY59EA
         +pb1FJwNIBE61ZF9tLt2+vfL6kEg5ugvsPk5l2ljen+kJuJBHbinzJhTACdMXtH44bRb
         U/vOeKIlUv2YRrlpxsDK/pbDqLFW5Kq5A+MrSTqYaZ+mcevm6PKfkTkbVykVBKuCqSYh
         /0zl8lDTQzGhd7Y1ApA8wAKuDNWcdcYc5+nSXIhrLuzq4Ju7myYlbK2w4w2w10zfevTJ
         bHyVOVny+6H9OPfLe6vQyGEtPwwnMZwJKwjUZJ4gKJpDfDSSRFtRmiOvguEsZxaSjEN2
         8OKw==
X-Gm-Message-State: AO0yUKVwHoIDyXeyocX6jjsLf9OFGJaEK/DThMFJtlkjwYqdBCaqnhg6
        xhRuY+G+5elL5qAxFTpgpsY=
X-Google-Smtp-Source: AK7set+pFQzgv0tmjuSOt+nwG3CWBIaTBdJ79tRgzbqGyFk7pkKXomLzTWSeIdFDPbHTOMiURlC0zQ==
X-Received: by 2002:a2e:9111:0:b0:295:a2d0:57ed with SMTP id m17-20020a2e9111000000b00295a2d057edmr4067558ljg.4.1677803390200;
        Thu, 02 Mar 2023 16:29:50 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:29:49 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
Date:   Fri,  3 Mar 2023 03:28:29 +0300
Message-Id: <20230303002850.51858-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

[PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings

This is an ambitious effort I've been wanting to do for months.

Straight off the bat, I'm fixing the ABI that I broke a while back, by
reintroducing the ralink,rt2880-pinmux compatible string.

If you take a look at the schema for mt7620 and rt305x, some functions got
multiple lists for groups. Like refclk on mt7620. Because mt7620 and
mt7628/mt7688 SoCs use the same compatible string, it's impossible to
differentiate on the binding which SoC a devicetree is actually for.
Therefore, the binding will allow all groups listed for that function. For
example, if the SoC is mt7620, only the refclk function for the mdio group
can be used. If one were to put "spi cs1" as the function there, there
wouldn't be a warning.

I address this by introducing new compatible strings for these SoCs, then
split the schemas. I also separate mt7628/mt7688 from mt7620 pinctrl
subdriver in the process.

I wanted to split the rt305x driver too but too much code would be reused
so I backed down from that.

This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
introduced new SoCs which utilise this platform. We're moving the Ralink
pinctrl driver to MediaTek, and rename the schemas for MediaTek SoCs to
mediatek.

I've renamed the ralink core driver to mtmips. I decided to call the core
mtmips as I've seen folks from MediaTek use the same name when they added
support for MT7621 pinctrl on U-Boot. Feel free to comment on this.

Arınç

RFC to v1:
- Address Rob and Krzysztof's reviews, add Rob's acked-by.
- More cleanups, hooray!
- Keep ralink,rt2880-pinmux deprecated.
- Deprecate ralink,mt7620-pinctrl. Another one bites the dust!
- More slight changes I can't currently remember to mention.

Arınç ÜNAL (20):
  pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string
  pinctrl: ralink: {mt7620,mt7621}: add new mediatek compatible strings
  pinctrl: ralink: rt305x: add new compatible string for every SoC
  pinctrl: ralink: mt7620: split out to mt76x8
  pinctrl: ralink: move to mediatek as mtmips
  pinctrl: mediatek: remove OF_GPIO as reverse dependency
  dt-bindings: pinctrl: ralink: improve bindings
  dt-bindings: pinctrl: ralink: add new compatible strings
  dt-bindings: pinctrl: ralink: {mt7620,mt7621}: rename to mediatek
  dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pinctrl
  dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pinctrl
  dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pinctrl
  dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
  dt-bindings: pinctrl: mediatek: fix naming inconsistency
  dt-bindings: pinctrl: {mediatek,ralink}: fix formatting
  dt-bindings: pinctrl: mediatek: drop quotes from referred schemas
  dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
  dt-bindings: pinctrl: ralink: rt305x: split binding
  dt-bindings: pinctrl: mediatek: mt7620: split binding
  MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl

 .../pinctrl/mediatek,mt65xx-pinctrl.yaml        |  28 +-
 .../pinctrl/mediatek,mt6779-pinctrl.yaml        |  37 +-
 ...mt6795.yaml => mediatek,mt6795-pinctrl.yaml} |  39 +-
 .../pinctrl/mediatek,mt7620-pinctrl.yaml        | 298 ++++++++++++++
 ...inctrl.yaml => mediatek,mt7621-pinctrl.yaml} |  23 +-
 .../pinctrl/mediatek,mt7622-pinctrl.yaml        |  32 +-
 ...inctrl.yaml => mediatek,mt76x8-pinctrl.yaml} | 252 ++----------
 .../pinctrl/mediatek,mt7981-pinctrl.yaml        |  35 +-
 .../pinctrl/mediatek,mt7986-pinctrl.yaml        |  72 ++--
 .../pinctrl/mediatek,mt8183-pinctrl.yaml        |  30 +-
 ...mt8186.yaml => mediatek,mt8186-pinctrl.yaml} |  51 ++-
 .../pinctrl/mediatek,mt8188-pinctrl.yaml        |  76 ++--
 ...mt8192.yaml => mediatek,mt8192-pinctrl.yaml} |  53 +--
 ...mt8195.yaml => mediatek,mt8195-pinctrl.yaml} |  44 +--
 .../pinctrl/mediatek,mt8365-pinctrl.yaml        |  28 +-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml |  11 +-
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml |  89 +----
 .../bindings/pinctrl/ralink,rt3352-pinctrl.yaml | 243 ++++++++++++
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml |  11 +-
 .../bindings/pinctrl/ralink,rt5350-pinctrl.yaml | 206 ++++++++++
 MAINTAINERS                                     |  29 +-
 drivers/pinctrl/Kconfig                         |   1 -
 drivers/pinctrl/Makefile                        |   1 -
 drivers/pinctrl/mediatek/Kconfig                |  54 ++-
 drivers/pinctrl/mediatek/Makefile               |  63 +--
 drivers/pinctrl/mediatek/pinctrl-mt7620.c       | 138 +++++++
 .../{ralink => mediatek}/pinctrl-mt7621.c       |  32 +-
 drivers/pinctrl/mediatek/pinctrl-mt76x8.c       | 283 ++++++++++++++
 .../pinctrl-mtmips.c}                           |  90 ++---
 .../pinctrl-mtmips.h}                           |  16 +-
 .../{ralink => mediatek}/pinctrl-rt2880.c       |  21 +-
 .../{ralink => mediatek}/pinctrl-rt305x.c       |  47 +--
 .../{ralink => mediatek}/pinctrl-rt3883.c       |  29 +-
 drivers/pinctrl/ralink/Kconfig                  |  35 --
 drivers/pinctrl/ralink/Makefile                 |   8 -
 drivers/pinctrl/ralink/pinctrl-mt7620.c         | 391 -------------------
 36 files changed, 1723 insertions(+), 1173 deletions(-)


