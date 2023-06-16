Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5C7337DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjFPSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbjFPSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768E2D50;
        Fri, 16 Jun 2023 11:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46CF62D96;
        Fri, 16 Jun 2023 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A54C433C8;
        Fri, 16 Jun 2023 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686938617;
        bh=Qu9Did7YoZUbw3V6+L0iVuxfDFQlXJHOf/rLjbEKwWY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IxjSPmyUCNW+2U6R33zMEibauaaygA9ixcvyQU1APxF6pyU//K9UuxAXkzZ/C7L9B
         7NIw3oicPKpalSbWBsB/LH5aTDx8A8blb4vUTd3sPgpJh+efxMgZ0aYnVCS1V7mzZ3
         DnRpTGW0RZ9GcRXsPhJm9ccN3u9GzeTRSShoZq82Pp8ZvnkgF22Q6+9tzaVZPTaskH
         ea3yAxAM1UCb34W+gPqyGrS/zR7HWb+JSyRxEMoN7rN5qSG7HXVPtn4A34dKufsmh6
         NwS3OCbDvhKV1NAXH5AbY00eiE+dJDSTEwEsmq6xeIpJ2b/pTmdj7W7GNTOqozNUct
         /DvJIcNaT6wwA==
Message-ID: <86c4012d945a5a1594c5e191ee6186e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230418090312.2818879-3-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com> <20230418090312.2818879-3-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 16 Jun 2023 11:03:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-04-18 02:03:05)
> Until now, clock related code for old ralink SoCs was based in fixed cloc=
ks
> using 'clk_register_fixed_rate' and 'clkdev_create' directly doing in code
> and not using device tree at all for their definition. Including this dri=
ver
> is an effort to be able to define proper clocks using device tree and also
> cleaning all the clock and reset related code from 'arch/mips/ralink' dir.
> This clock and reset driver covers all the ralink SoCs but MT7621 which is
> the newest and provides gating and some differences that make it different
> from its predecesors. It has its own driver since some time ago. The rali=
nk
> SoCs we are taking about are RT2880, RT3050, RT3052, RT3350, RT3352, RT38=
83,
> RT5350, MT7620, MT7628 and MT7688. Mostly the code in this new driver has
> been extracted from 'arch/mips/ralink' and cleanly put using kernel clock
> driver APIs. The clock plans for this SoCs only talks about relation betw=
een
> CPU frequency and BUS frequency. This relation is different depending on =
the
> particular SoC. CPU clock is derived from XTAL frequencies.
>=20
> Depending on the SoC we have the following frequencies:
> * RT2880 SoC:
>     - XTAL: 40 MHz.
>     - CPU: 250, 266, 280 or 300 MHz.
>     - BUS: CPU / 2 MHz.
> * RT3050, RT3052, RT3350:
>     - XTAL: 40 MHz.
>     - CPU: 320 or 384 MHz.
>     - BUS: CPU / 3 MHz.
> * RT3352:
>     - XTAL: 40 MHz.
>     - CPU: 384 or 400 MHz.
>     - BUS: CPU / 3 MHz.
>     - PERIPH: 40 MHz.
> * RT3383:
>     - XTAL: 40 MHz.
>     - CPU: 250, 384, 480 or 500 MHz.
>     - BUS: Depends on RAM Type and CPU:
>         + RAM DDR2: 125. ELSE 83 MHz.
>         + RAM DDR2: 128. ELSE 96 MHz.
>         + RAM DDR2: 160. ELSE 120 MHz.
>         + RAM DDR2: 166. ELSE 125 MHz.
> * RT5350:
>     - XTAL: 40 MHz.
>     - CPU: 300, 320 or 360 MHz.
>     - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
>     - PERIPH: 40 MHz.
> * MT7628 and MT7688:
>     - XTAL: 20 MHz or 40 MHz.
>     - CPU: 575 or 580 MHz.
>     - BUS: CPU / 3.
>     - PCMI2S: 480 MHz.
>     - PERIPH: 40 MHz.
> * MT7620:
>     - XTAL: 20 MHz or 40 MHz.
>     - PLL: XTAL, 480, 600 MHz.
>     - CPU: depends on PLL and some mult and dividers.
>     - BUS: depends on PLL and some mult and dividers.
>     - PERIPH: 40 or XTAL MHz.
>=20
> MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
> register reads and predividers. To derive CPU and BUS frequencies in the
> MT7620 SoC 'mt7620_calc_rate()' helper is used.
>=20
> In the case XTAL can have different frequencies and we need a different
> clock frequency for peripherals 'periph' clock in introduced.
>=20
> The rest of the peripherals present in the SoC just follow their parent
> frequencies.
>=20
> With this information the clk driver will provide all the clock and reset
> functionality from a set of hardcoded clocks allowing to define a nice
> device tree without fixed clocks.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
