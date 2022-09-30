Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9EA5F14D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiI3V1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiI3V1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:27:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CC3142E22;
        Fri, 30 Sep 2022 14:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A95B82A30;
        Fri, 30 Sep 2022 21:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628D2C433C1;
        Fri, 30 Sep 2022 21:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573257;
        bh=qMvmm8i8soEiwwWmYGUfp26xau2BuSrpG99vQ9WlVl8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Q3lQCOwvc3hWU0g/onrUcSCxW3RLnXJYq/80OTzWfJgrAYlMv7SWamZ48QlylwOzg
         eBg08AlXx33GQkjqPD7LfcRceIqJHFZ3QCqvPNGZ1Qo37IP4aLqI0HxWngNUPAeyTN
         lotuRHlAGluDVpykOanOf7gISX4Rn9uLF0VhZbiEmxYC3lYujlOiS5pDbcJidJxFCr
         gsUI2ftrU8rmfQwY3fRXh8nkPL3K9zvrsPexYGVgd/XDxAjbBtgZJBUfhgiQI4IWUT
         VdgU4yQbhdV2jwxn4O+FHF73wKUuqz7mv1OKWoLEkV5WlwJ2Wc38raChTKeTtdxXTo
         dRyW1agQmQWUQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929225402.9696-9-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru> <20220929225402.9696-9-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v12 8/8] clk: baikal-t1: Convert to platform device driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Fri, 30 Sep 2022 14:27:34 -0700
User-Agent: alot/0.10
Message-Id: <20220930212737.628D2C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2022-09-29 15:54:02)
> In accordance with the way the MIPS platform is normally design there are
> only six clock sources which need to be available on the kernel start in
> order to one end up booting correctly:
> + CPU PLL: needed by the r4k and MIPS GIC timer drivers. The former one is
>   initialized by the arch code, while the later one is implemented in the
>   mips-gic-timer.c driver as the OF-declared timer.
> + PCIe PLL: required as a parental clock source for the APB/timer domains.
> + APB clock: needed in order to access all the SoC CSRs at least for the
>   timer OF-declared drivers.
> + APB Timer{0-2} clocks: these are the DW APB timers which drivers
>   dw_apb_timer_of.c are implemented as the OF-declared timers.
>=20
> So as long as the clocks above are available early the kernel will
> normally work. Let's convert the Baikal-T1 CCU drivers to the platform
> device drivers keeping that in mind.
>=20
> Generally speaking the conversion isn't that complicated since the driver
> infrastructure has been designed as flexible enough for that. First we
> need to add a new PLL/Divider clock features flag which indicates the
> corresponding clock source as a basic one and that clock sources will be
> available on the kernel early boot stages. Second the internal PLL/Divider
> descriptors need to be initialized with -EPROBE_DEFER value as the
> corresponding clock source is unavailable at the early stages. They will
> be allocated and initialized on the Baikal-T1 clock platform driver probe
> procedure. Finally the already available PLL/Divider init functions need
> to be split up into two ones: init procedure performed in the framework of
> the OF-declared clock initialization (of_clk_init()), and the probe
> procedure called by the platform devices bus driver. Note the later method
> will just continue the system clocks initialization started in the former
> one.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> ---

Applied to clk-next
