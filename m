Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2565A388
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiLaKr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLaKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:47:53 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BC6146
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:51 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gh17so56429965ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEyhDLjUotgmC3JtXt/RMPu+Hko7HSi75jUhaPS/Wts=;
        b=Q7ihk4LOj4p8w+nLZjeNXShVWZ67NNNje/AuDd5IQufoP47QxJgIuldn+X+o46xQ8i
         AhWSy7tf636P11d11KqtmI5tCp4Iwo99zJefOwSN+8AcHLwzpvhESQL23dUDvLQDZflj
         xm9+6T7RR3Wy4n9WKFoit7oXGUDhNvjZO2OnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEyhDLjUotgmC3JtXt/RMPu+Hko7HSi75jUhaPS/Wts=;
        b=HROO++vgp9zTDJvAiEmgLvGqIKs8SiiOh4dROzZHuKyy6ILp/pTKHM8JIT681YBZNz
         doa7G2kLpaxjY1sLvQWqLcddK6rszVIX19zdwLjz3YTV2HoY0TTRJEQxJtFN4JDDDTP2
         Mdmrsp2fQgRndX0Ypl05djlvDGaor6q2ScKpnSWA4T3vYROenoB6P91fmc6WAaIBIVYi
         wKi5109IKSOeOIjpFguBMLK0j9qTaReoLBOHEBSPIRJXhHvahT45Fnv12H4iOzZpstqI
         3SSilpEsR0SjEftHSoN7BW4ggx6XqqmJ7kaPoH/lSeYVa9CK6kytKL7R5kH+gdmRvuQq
         stEw==
X-Gm-Message-State: AFqh2kox8R5JTCzCsOFwFYJVzQT5ds3mpFY5g8bUFcV+buJesooHadRZ
        RjyM487IIRjcA7cJSW5SQ20I6uyHDI6bGwhHnD8=
X-Google-Smtp-Source: AMrXdXu1x8liAPz491BtUIf6hj5bm8qPI+F9cy8Jl1JSxQW5vdTGZNokloNsBS4HQ5CBnhvuMsfdxQ==
X-Received: by 2002:a17:907:2918:b0:818:3f54:8db6 with SMTP id eq24-20020a170907291800b008183f548db6mr27872605ejc.6.1672483669569;
        Sat, 31 Dec 2022 02:47:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:47:49 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com,
        angelo@amarulasolutions.com, anthony@amarulasolutions.com,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 00/11] clk: imx8mn: setup clocks from the device tree
Date:   Sat, 31 Dec 2022 11:47:25 +0100
Message-Id: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
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

The idea for this series was born back from Dublin (ELCE 2022) after
having attended the talk entitled "Updating and Modernizing Clock
Drivers" held by Chen-Yu Tsai and the availability of a board with
imx8mn SOC.

This series aims to setup all imx8mn's clocks from the device tree and
remove the legacy setup code with hardwired parameters.

I am well aware that the series lacks patches for the DT bindings. The
effort up to this point has been important and so I thought I'd ask for
feedback from the community before proceeding to implement them. If it
is positive I will add the DT binding patches starting from version 2.

The series has been tested on the BSH SystemMaster (SMM) S2 board:
https://www.apertis.org/reference_hardware/imx8mn_bsh_smm_s2pro_setup



Dario Binacchi (11):
  clk: imx: add structure to extend register accesses
  clk: imx: add clk_hw based API imx_get_clk_hw_from_dt()
  clk: imx8mn: add gate driver
  clk: imx8mn: add mux driver
  clk: imx8mn: add divider driver
  clk: imx: pll14xx: add device tree support
  clk: imx: composite-8m: add device tree support
  clk: imx: gate2: add device tree support
  clk: imx: cpu: add device tree support
  arm64: dts: imx8mn: add dumy clock
  arm64: dts: imx8mn: add clocks description

 .../boot/dts/freescale/imx8mn-clocks.dtsi     | 1885 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   51 +-
 drivers/clk/imx/Makefile                      |    3 +
 drivers/clk/imx/clk-composite-8m.c            |   83 +
 drivers/clk/imx/clk-cpu.c                     |   54 +
 drivers/clk/imx/clk-divider.c                 |  235 ++
 drivers/clk/imx/clk-gate.c                    |  156 ++
 drivers/clk/imx/clk-gate2.c                   |   86 +
 drivers/clk/imx/clk-imx8mn.c                  |  716 ++-----
 drivers/clk/imx/clk-mux.c                     |  258 +++
 drivers/clk/imx/clk-pll14xx.c                 |  220 +-
 drivers/clk/imx/clk.c                         |   21 +
 drivers/clk/imx/clk.h                         |   15 +
 13 files changed, 3176 insertions(+), 607 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
 create mode 100644 drivers/clk/imx/clk-divider.c
 create mode 100644 drivers/clk/imx/clk-gate.c
 create mode 100644 drivers/clk/imx/clk-mux.c

-- 
2.32.0

