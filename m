Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8026F633244
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKVBk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKVBk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:40:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C9B9489;
        Mon, 21 Nov 2022 17:40:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d1so10444133wrs.12;
        Mon, 21 Nov 2022 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54RP2IWIIhy2xxrG6c6vLV9h3bx5Ywa0moelQvuO0uI=;
        b=EtFDMxmvIub6AsvD5gUZq2j5iVqjX7b7XEX5dtvzYtqsqABsmsM4uIIZWxNPm9dISL
         fK7m5cnFEK2m/3pm4yVvUsnyMgB7C0F+Z2yN7uo9lmxccGBUlVsGtqskMGcmA/RT2joC
         obhoRSzaSLN2YtWMgaEq9BSTIcc3q02Wiv2Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54RP2IWIIhy2xxrG6c6vLV9h3bx5Ywa0moelQvuO0uI=;
        b=K6QGCXhXDXol8wUNQrcKsPaMN0E5YTcAkh4f5McC+DJaOvcCBrhOJvHtdwUWFHa5sk
         urTFZXX8zpxBRQTRs4864qi+ZuuAZOBvhbGCAqDuYLHCWMaF0BVm6601Q+ioNgnOIblr
         qX5hE7bPeRwom2IQD6yeB21qawQzJ0EELWs7aKbMyM724EOUBwM4ZPMZ6PAkcZFJON05
         gDJceN6ufqLhLs60GEJxmlf+HC5bd0tfVMqAICp0a4RZjzW6FvDmi0iGs4PLvgVd3cme
         2HpJIbPyffhuGLjRtvG9HGQ4WMvJxP4/9/BQ1Oh24CjGL9wg8BDytwx8ZS28NU0Ux9Tz
         fudQ==
X-Gm-Message-State: ANoB5pmCCZ37sRguw12oWrpOJ81WWYSm8Bq25ezNTsxEy4uFZtIfXo+G
        SoChY2ZMtlZWmeQ7seEQ+gxVhmWLvw3QmAUOlEU=
X-Google-Smtp-Source: AA0mqf4wL1IspdUOJeOJ/cWD2vinkqtYh79NadtQHo1Z0VjTDwiPzWDFg7XEJZqop4Z+XKeKlDDYRDYQS7jNsQKKF7w=
X-Received: by 2002:a5d:6642:0:b0:236:6a28:eeda with SMTP id
 f2-20020a5d6642000000b002366a28eedamr12437764wrw.315.1669081253980; Mon, 21
 Nov 2022 17:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
In-Reply-To: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 22 Nov 2022 01:40:42 +0000
Message-ID: <CACPK8XdXrAPMdnn0T6GQiYEK3R4MvwprOZu_Yvmv=WVOfivROg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Nuvoton WPCM450 clock and reset driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Patrick Venture <venture@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 16:21, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.ne=
t> wrote:
>
> This series adds support for the clock and reset controller in the Nuvoto=
n
> WPCM450 SoC. This means that the clock rates for peripherals will be calc=
ulated
> automatically based on the clock tree as it was preconfigured by the boot=
loader.
> The 24 MHz dummy clock, that is currently in the devicetree, is no longer=
 needed.
> Somewhat unfortunately, this also means that there is a breaking change o=
nce
> the devicetree starts relying on the clock driver, but I find it acceptab=
le in
> this case, because WPCM450 is still at a somewhat early stage.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
>
> Upstreaming plan (although other suggestions are welcome):
>
> Once reviewed,
>
> - The ARM/dts changes should go through Joel Stanley's bmc tree

I've picked up the standalone patch ("Add clock controller node").

> - The clocksource/timer changes should probably go via Daniel Lezcano and=
 TIP
> - The clock controller bindings and driver should go through the clk tree

Stephen, do you plan on merging this driver for v6.2?

Alternatively, could we get an ack from you and merge this entire
series through Arnd, where we have precedent for merging these initial
support cross-tree patch sets?



> - It probably makes sense to delay the final ARM/dts patch ("ARM: dts:
>   wpcm450: Switch clocks to clock controller") until next cycle to make
>   sure it is merged after the clock driver.
>
>
> v5:
> - Dropped patch 2 (watchdog: npcm: Enable clock if provided), which
>   was since merged upstream
> - Added patch 2 (clocksource: timer-npcm7xx: Enable timer 1 clock before =
use) again,
>   because I wasn't able to find it in linux-next
> - Switched the driver to using struct clk_parent_data
> - Rebased on 6.1-rc3
>
> v4:
> - https://lore.kernel.org/lkml/20220610072141.347795-1-j.neuschaefer@gmx.=
net/
> - Leave WDT clock running during after restart handler
> - Fix reset controller initialization
> - Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock bef=
ore use),
>   as it was applied by Daniel Lezcano
>
> v3:
> - https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx=
.net/
> - Changed "refclk" string to "ref"
> - Fixed some dead code in the driver
> - Added clk_prepare_enable call to the watchdog restart handler
> - Added a few review tags
>
> v2:
> - https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.=
net/
> - various small improvements
>
> v1:
> - https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.=
net/
>
> Jonathan Neusch=C3=A4fer (6):
>   dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
>   clocksource: timer-npcm7xx: Enable timer 1 clock before use
>   dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
>   ARM: dts: wpcm450: Add clock controller node
>   clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
>   [NOT FOR MERGE] ARM: dts: wpcm450: Switch clocks to clock controller
>
>  .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 +++
>  .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   8 +-
>  arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  29 +-
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/clk-wpcm450.c                     | 375 ++++++++++++++++++
>  drivers/clocksource/timer-npcm7xx.c           |  10 +
>  drivers/reset/Kconfig                         |   2 +-
>  .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
>  8 files changed, 549 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm4=
50-clk.yaml
>  create mode 100644 drivers/clk/clk-wpcm450.c
>  create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h
>
> --
> 2.35.1
>
