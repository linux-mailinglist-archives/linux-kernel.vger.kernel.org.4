Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561096A2895
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBYJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBYJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:44:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72701204E;
        Sat, 25 Feb 2023 01:44:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy6so6747980edb.5;
        Sat, 25 Feb 2023 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpSiX+Ch3K3DG82dTWHs1KrCJ7bKDMWnHZOHhDvLqjE=;
        b=L8yNZMz2lUKp55CoI/P5ILvkS07Fd+3ffcxzVOi7k2wQgdjPIbOqMl79YnFcjuLqUb
         2advNios1Y+qXq0iKJL2R2ynHOAc8cL0YlOJreg6FyUCBfLWzL3PiJH4+JccOu2la0ha
         0ItIJ+hjw0a+v0U2X5K3aw32QBmB9+Yh8EuDZCOrpcdkgMXzXCjEhOWKu908Mby5XoGB
         nF1GtsEC+twxPGL4nRBDsam9nIuanLMFdtIx6ddcTXNmapQvbcTOJFsCw5f8Y/v5i+/0
         7HJTUMObiMSDaEtF4MMprseEyvybXfSFE7Srad9474H51uNZmRI3Bo4BA4QyMAHq639z
         jtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpSiX+Ch3K3DG82dTWHs1KrCJ7bKDMWnHZOHhDvLqjE=;
        b=jODD9DsOVuJYvLlmmt+/6pk1ZXTkDPXNs4Li0qCb24MTYochCFnbybNAXcWpn7lNeE
         //vijF67OSEepXK1pUstT6zBPoqI5E1BQ2f4sCL7jtzgb72+s8dHerANes3ZYpr1n2ib
         yjOPmzhFP5i/nX9bBi224oz88iALOxfs5TGH5yjmPJv0IQFf8TKIaVsH3jQBthsBjywH
         WUq4yjOnFuWit8UgQ+pLEGPrCSroLECH7Sj0XmgSDRYNc+JTwPOWymE4kpKApW3zrEbi
         ids8CXaN4IqFYnsOSAVb7eieb7HaSBhlIqtvnt/wdIOOedJ4C53NLXhQHUcSt9kXhq+D
         tA5A==
X-Gm-Message-State: AO0yUKUTQRnVCyCdqaGD633d1HH/5bZxOegsj15CFMibQelOw0WUdcCG
        ZgL7iiEGopQRaj5Qe21vBVE=
X-Google-Smtp-Source: AK7set9+Xgh0cE06K4X3mgz9u24bqVJ4GpTOEj1fhk9LgxQm94r3LHbSBgyuUTyyO09qQbCb4lPHJQ==
X-Received: by 2002:a17:906:1747:b0:8b1:3d15:1e2c with SMTP id d7-20020a170906174700b008b13d151e2cmr24479933eje.9.1677318276056;
        Sat, 25 Feb 2023 01:44:36 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b008b23b22b062sm653649ejb.114.2023.02.25.01.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 01:44:35 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] MediaTek MT6735 main clock and reset drivers
Date:   Sat, 25 Feb 2023 12:42:42 +0300
Message-Id: <20230225094246.261697-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in mainline
Linux. More patches (unsent or sent and pending review or revision) can be found here[1].

This series adds support for the main clock and reset controllers on the
Mediatek MT6735 SoC:
- apmixedsys (global PLLs)
- topckgen (global divisors and muxes)
- infracfg (gates and resets for internal components)
- pericfg (gates and resets for peripherals)

MT6735 has other more specialized clock/reset controllers, support for which is
not included in this series:
- mfgcfg (GPU)
- imgsys (camera)
- mmsys (display)
- vdecsys (video decoder)
- vencsys (video encoder)
- audsys (audio)

Changes since v2:
- Add "CLK_" prefix to infracfg and pericfg clock definitions to avoid possible
  clashes with reset bindings.
- Replace "_RST" suffix with "RST_" prefix to maintain consistency with clock bindings.
- Use macros to define clocks.
- Abandon mtk_clk_simple_probe/mtk_clk_simple_remove in favor of custom functions in apmixedsys
  and topckgen drivers for the time being. 
- Capitalize T in MediaTek in MODULE_DESCRIPTION.
Changes since v1:
- Rebase on some pending patches.
- Move common clock improvements to a separate series.
- Use mtk_clk_simple_probe/remove after making them support several clock types
  in said series.
- Combine all 4 drivers into one patch, and use one Kconfig symbol for all
  following a conversation seen on a different series[2].
- Correct APLL2 registers in apmixedsys driver (were offset backwards by 0x4).
- Make irtx clock name lower case to match the other clocks.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging
[2] https://lore.kernel.org/linux-mediatek/CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com/

Yassine Oudjana (4):
  dt-bindings: clock: Add MediaTek MT6735 clock bindings
  dt-bindings: reset: Add MediaTek MT6735 reset bindings
  dt-bindings: arm: mediatek: Add MT6735 clock controller compatibles
  clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset
    drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |   8 +-
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   4 +-
 .../bindings/clock/mediatek,topckgen.yaml     |   4 +-
 MAINTAINERS                                   |  16 +
 drivers/clk/mediatek/Kconfig                  |   9 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c  | 139 ++++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c    |  78 +++
 drivers/clk/mediatek/clk-mt6735-pericfg.c     |  91 ++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c    | 450 ++++++++++++++++++
 .../clock/mediatek,mt6735-apmixedsys.h        |  16 +
 .../clock/mediatek,mt6735-infracfg.h          |  25 +
 .../clock/mediatek,mt6735-pericfg.h           |  37 ++
 .../clock/mediatek,mt6735-topckgen.h          |  79 +++
 .../reset/mediatek,mt6735-infracfg.h          |  31 ++
 .../reset/mediatek,mt6735-pericfg.h           |  31 ++
 17 files changed, 1015 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

-- 
2.39.2

