Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0365AAD5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAAR5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjAAR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:57:50 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2826FE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:48 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id vm8so55333182ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALuH1lvp2knJtHcYW+i1s8ZvzexDo4P1ZGTmQCOOx0Q=;
        b=gHsBdSknCJsKckxDmgjNLhkIjW0BxoYHD+AxZTIb+PS2dNuIJEZd4QJm8tJIyMCBJU
         XEwkcyZsEk5WCx+RKUZPFU5911LKl++VPqkPCh19NouOSUBwJkSYCCYfCvAa21cuLqDO
         oGo46nKNjTTqMNb169uhDu7J5qhO7AHEKeQkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALuH1lvp2knJtHcYW+i1s8ZvzexDo4P1ZGTmQCOOx0Q=;
        b=aZwackx3zybDsQyzehxSuWzGFDpFNBo5Alkbu9x8Ovv7P5fIafe6Vjm5GbNf4ioex7
         enwPidvFtKdSDR2jE06oBVOF+KxYKdaXACis6vL/4l6U4sywE2N3TrR36TWiT88RseKa
         6viGsYkLN9FstCRmCYeGjm3RXCm5p0SgtQeugLm33FeFV4US2umGki9YQPA9COt8dds5
         7LhVPwhJJZno6ShjXuI8AlqguSQrMlhHnfoYAnSrwfaij5xnbAzlsB/El8CNtZmEXxg+
         eVtvkM+OQKUE+cTcqtNFuXI3E2QXyKt8JwWKeJa1liErT5fPAKn406NnkCo4mM5fDI66
         25Ag==
X-Gm-Message-State: AFqh2kpfsQQXq+VDHS17vFN7RIN5vNj6vblw5TX1ZacAnsSL+XzIzgoz
        qcZRfdVEJxjTwO9EfktSWfmoFGPq++j+2JU5oZM=
X-Google-Smtp-Source: AMrXdXtH/xODB+NwyqHz8wDEhZ9XJ4jQWEMdW5ab3YH90LKN2zFnY89AaK56+GQ0jAgFvwBdZvArxw==
X-Received: by 2002:a17:907:d602:b0:7c1:286a:d87c with SMTP id wd2-20020a170907d60200b007c1286ad87cmr32679732ejc.65.1672595866417;
        Sun, 01 Jan 2023 09:57:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:46 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
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
Subject: [RFC PATCH v2 00/11] clk: imx8mn: setup clocks from the device tree
Date:   Sun,  1 Jan 2023 18:57:29 +0100
Message-Id: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
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


Changes in v2:
- Fix compiler warnings reported by kernel test robot.

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
 drivers/clk/imx/clk-composite-8m.c            |   84 +
 drivers/clk/imx/clk-cpu.c                     |   54 +
 drivers/clk/imx/clk-divider.c                 |  235 ++
 drivers/clk/imx/clk-gate.c                    |  156 ++
 drivers/clk/imx/clk-gate2.c                   |   86 +
 drivers/clk/imx/clk-imx8mn.c                  |  716 ++-----
 drivers/clk/imx/clk-mux.c                     |  258 +++
 drivers/clk/imx/clk-pll14xx.c                 |  220 +-
 drivers/clk/imx/clk.c                         |   21 +
 drivers/clk/imx/clk.h                         |   15 +
 13 files changed, 3177 insertions(+), 607 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
 create mode 100644 drivers/clk/imx/clk-divider.c
 create mode 100644 drivers/clk/imx/clk-gate.c
 create mode 100644 drivers/clk/imx/clk-mux.c

-- 
2.32.0

