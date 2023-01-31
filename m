Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D2682EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjAaOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjAaOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:08:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002836FFC;
        Tue, 31 Jan 2023 06:08:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 69D8F22B05;
        Tue, 31 Jan 2023 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675174129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T49m4aNneycdJRUox2NnWvbDHKOK5LQ0u6zBagVR6NY=;
        b=19R4zxNGaLGs0/BdyhligmSWKz7ncKw4I9vEaCeJbqvAajD+uc6ET5AkprNHNtGxxTaWE3
        0ufCmT501ll9cnG5BVbwJ1I5evVot1UbC9ZFNvj1AJTanWK7on2pM1aV2ql50USH5b+oyu
        uIt7lKO+GN8nQQdrYzdqRIm2OEVTxNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675174129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T49m4aNneycdJRUox2NnWvbDHKOK5LQ0u6zBagVR6NY=;
        b=z2/uq1WlpP3hZGyMEyL9G0pYl2Vz7xEmuiuYkEuS7QEeRHzP5SU+PqQxN8+KvFbFYWng4I
        1U0pLFoHuEecFyCg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id E15DE2C141;
        Tue, 31 Jan 2023 14:08:48 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 9D17F440D4E; Tue, 31 Jan 2023 15:08:48 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] pinctrl: starfive: Add StarFive JH7110 sys
 controller driver
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
        <20221220005529.34744-5-hal.feng@starfivetech.com>
X-Yow:  My polyvinyl cowboy wallet was made in Hong Kong by Montgomery Clift!
Date:   Tue, 31 Jan 2023 15:08:48 +0100
In-Reply-To: <20221220005529.34744-5-hal.feng@starfivetech.com> (Hal Feng's
        message of "Tue, 20 Dec 2022 08:55:28 +0800")
Message-ID: <mvm4js6zthr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 20 2022, Hal Feng wrote:

> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> new file mode 100644
> index 000000000000..85df9d0ae1de
> --- /dev/null
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> @@ -0,0 +1,979 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pinctrl / GPIO driver for StarFive JH7110 SoC
> + *
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> +
> +#include "../core.h"
> +#include "../pinctrl-utils.h"
> +#include "../pinmux.h"
> +#include "../pinconf.h"
> +#include "pinctrl-starfive-jh7110.h"

This misses a couple of headers, see commit 042b93c9b666.

../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_pin_dbg_show':
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:100:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
  100 |         seq_printf(s, "%s", dev_name(pctldev->dev));
      |         ^~~~~~~~~~
      |         bstr_printf
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: At top level:
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:538:21: error: variable 'jh7110_pinconf_ops' has initializer but incomplete type
  538 | static const struct pinconf_ops jh7110_pinconf_ops = {
      |                     ^~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:10: error: 'const struct pinconf_ops' has no member named 'pin_config_get'
  539 |         .pin_config_get         = jh7110_pinconf_get,
      |          ^~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:35: warning: excess elements in struct initializer
  539 |         .pin_config_get         = jh7110_pinconf_get,
      |                                   ^~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:35: note: (near initialization for 'jh7110_pinconf_ops')
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:10: error: 'const struct pinconf_ops' has no member named 'pin_config_group_get'
  540 |         .pin_config_group_get   = jh7110_pinconf_group_get,
      |          ^~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:35: warning: excess elements in struct initializer
  540 |         .pin_config_group_get   = jh7110_pinconf_group_get,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:35: note: (near initialization for 'jh7110_pinconf_ops')
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:10: error: 'const struct pinconf_ops' has no member named 'pin_config_group_set'
  541 |         .pin_config_group_set   = jh7110_pinconf_group_set,
      |          ^~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:35: warning: excess elements in struct initializer
  541 |         .pin_config_group_set   = jh7110_pinconf_group_set,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:35: note: (near initialization for 'jh7110_pinconf_ops')
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:10: error: 'const struct pinconf_ops' has no member named 'pin_config_dbg_show'
  542 |         .pin_config_dbg_show    = jh7110_pinconf_dbg_show,
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:35: warning: excess elements in struct initializer
  542 |         .pin_config_dbg_show    = jh7110_pinconf_dbg_show,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:35: note: (near initialization for 'jh7110_pinconf_ops')
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:10: error: 'const struct pinconf_ops' has no member named 'is_generic'
  543 |         .is_generic             = true,
      |          ^~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:35: warning: excess elements in struct initializer
  543 |         .is_generic             = true,
      |                                   ^~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:35: note: (near initialization for 'jh7110_pinconf_ops')
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_gpio_request':
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:548:16: error: implicit declaration of function 'pinctrl_gpio_request' [-Werror=implicit-function-declaration]
  548 |         return pinctrl_gpio_request(gc->base + gpio);
      |                ^~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_gpio_free':
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:553:9: error: implicit declaration of function 'pinctrl_gpio_free' [-Werror=implicit-function-declaration]
  553 |         pinctrl_gpio_free(gc->base + gpio);
      |         ^~~~~~~~~~~~~~~~~
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: At top level:
../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:538:33: error: storage size of 'jh7110_pinconf_ops' isn't known
  538 | static const struct pinconf_ops jh7110_pinconf_ops = {
      |                                 ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [../scripts/Makefile.build:253: drivers/pinctrl/starfive/pinctrl-starfive-jh7110.o] Error 1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
