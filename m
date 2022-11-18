Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBA62F3F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiKRLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:46:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C512182A;
        Fri, 18 Nov 2022 03:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D4D6246E;
        Fri, 18 Nov 2022 11:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73120C433C1;
        Fri, 18 Nov 2022 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668771963;
        bh=BHxtre8/LYcerFh38ah/n8Jv/xVfQGTrqxctZy8lgjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNk0o4T0JG0y212MaXGP1b+vZnD5q1YJKiExPzGooj8ENWtUiNlVDp6gN6ksbUTzf
         fseC+bR7chE9+7j+ts+6XH3mQj+kqe9cfK/YFzYOwDRc7gcYe/vf4/VdffBytaqIy8
         a73kq03VjgrH78vNs15S8PpySmwsoed8H3FxpcElhMGB3XtyCO8U73iKW6JWJuFps1
         xGlb8MTObWDrQaB9l4KtD4wNPpi8R2ah38QBdyr7knN81W5ChEP+rx7gqBmq3WioQ8
         kK9LDRkfnY6rXyJU4btW3RHpbmwFB8/r60em9hVEB0XGsEjJ8mOHkIrbhB2PlviSR2
         1MndekKJuTZVQ==
Date:   Fri, 18 Nov 2022 11:45:57 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] soc: sifive: ccache: Add StarFive JH7110 support
Message-ID: <Y3dwdXExRRltyp8A@spud>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-6-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118011714.70877-6-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Emil/Hal,

On Fri, Nov 18, 2022 at 09:17:11AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This adds support for the StarFive JH7110 SoC which also
> features this SiFive cache controller.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/Kconfig.socs            | 1 +
>  drivers/soc/Makefile               | 2 +-
>  drivers/soc/sifive/Kconfig         | 2 +-
>  drivers/soc/sifive/sifive_ccache.c | 1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..5a40e05f8cab 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,7 @@ config SOC_STARFIVE
>  	bool "StarFive SoCs"
>  	select PINCTRL
>  	select RESET_CONTROLLER
> +	select SIFIVE_CCACHE

Please no. I am trying to get rid of these selects + I cannot figure out
why this driver is so important that you *need* to select it. Surely the
SoC is useable without it?

Is this a hang over from your vendor tree that uses the driver to do
non-coherent stuff for the jh7100?

>  	select SIFIVE_PLIC
>  	help
>  	  This enables support for StarFive SoC platform hardware.
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 69ba6508cf2c..534669840858 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -26,7 +26,7 @@ obj-y				+= qcom/
>  obj-y				+= renesas/
>  obj-y				+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> -obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
> +obj-y				+= sifive/

This bit is fine.

>  obj-y				+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-y				+= ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index ed4c571f8771..e86870be34c9 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -if SOC_SIFIVE
> +if SOC_SIFIVE || SOC_STARFIVE

As I suppose is this - but hardly scalable. I suppose it doesn't really
matter.

>  config SIFIVE_CCACHE
>  	bool "Sifive Composable Cache controller"
> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> index 1c171150e878..9489d1a90fbc 100644
> --- a/drivers/soc/sifive/sifive_ccache.c
> +++ b/drivers/soc/sifive/sifive_ccache.c
> @@ -107,6 +107,7 @@ static const struct of_device_id sifive_ccache_ids[] = {
>  	{ .compatible = "sifive,fu540-c000-ccache" },
>  	{ .compatible = "sifive,fu740-c000-ccache" },
>  	{ .compatible = "sifive,ccache0" },
> +	{ .compatible = "starfive,jh7110-ccache" },

Per my second reply to the previous patch, I am not sure why you do not
just have a fallback compatible in the binding/dt for the fu740 ccache
since you appear to have identical configuration?

Thanks,
Conor.

