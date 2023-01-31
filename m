Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC98F682EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjAaOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjAaOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:09:55 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B536FFC;
        Tue, 31 Jan 2023 06:09:53 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7CB1F100065; Tue, 31 Jan 2023 14:09:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1675174191; bh=u8e6LXMsNPzh5ZqtqgH5Yc+rEXl9xlAI+kpXOjIAup4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEPNeCjRWhraAb3BFwJwdvZaP0eL2Vz14ol1XVMCPh4B/SgFX6v0b4yvR6NYnhGfi
         34uBBLz2Sac8o1axGwXOetYDi2zozxc6PD9P/Xw8f4SlfGAVgpHkCsY61xjZ32ye+P
         UgV827HI8rYs7REbF6pkZRtcwlzjxze/YNhzGszTxjGq13cjxmUHOSdfavlK1/LJCo
         m9rw8ChitndNVdju1VTw040VYWAqJwsNFybbYEc2EYY7F5LXgPdRJ+sfdmzzKn62IE
         xTlYZ1JzWmoBUyzRZErsg5oLzUCH1mqiGGyma4b9bhhbwF0rXiz3aL+MsOivGF5gz6
         TV22tR50PPRrQ==
Date:   Tue, 31 Jan 2023 14:09:51 +0000
From:   Sean Young <sean@mess.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
Message-ID: <Y9khL5lKbSG61pWI@gofer.mess.org>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128034117.3983105-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 03:41:17AM +0000, Christian Hewitt wrote:
> Add a keymap and bindings for the simple IR (NEC) remote used with
> the Beelink Mini MXIII Android STB device.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../devicetree/bindings/media/rc.yaml         |  1 +
>  drivers/media/rc/keymaps/Makefile             |  1 +
>  drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 +++++++++++++++++++
>  include/media/rc-map.h                        |  1 +
>  4 files changed, 57 insertions(+)
>  create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
> 
> diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> index 266f1d5cae51..f390a5d2c82d 100644
> --- a/Documentation/devicetree/bindings/media/rc.yaml
> +++ b/Documentation/devicetree/bindings/media/rc.yaml
> @@ -39,6 +39,7 @@ properties:
>        - rc-avertv-303
>        - rc-azurewave-ad-tu700
>        - rc-beelink-gs1
> +      - rc-beelink-mxiii
>        - rc-behold
>        - rc-behold-columbus
>        - rc-budget-ci-old
> diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
> index ec0361b0b758..03bc9a8d355e 100644
> --- a/drivers/media/rc/keymaps/Makefile
> +++ b/drivers/media/rc/keymaps/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_RC_MAP) += \
>  			rc-avertv-303.o \
>  			rc-azurewave-ad-tu700.o \
>  			rc-beelink-gs1.o \
> +			rc-beelink-mxiii.o \
>  			rc-behold-columbus.o \
>  			rc-behold.o \
>  			rc-budget-ci-old.o \
> diff --git a/drivers/media/rc/keymaps/rc-beelink-mxiii.c b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
> new file mode 100644
> index 000000000000..09b77295e0a3
> --- /dev/null
> +++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (C) 2019 Christian Hewitt <christianshewitt@gmail.com>
> +
> +#include <media/rc-map.h>
> +#include <linux/module.h>
> +
> +//
> +// Keytable for the Beelink Mini MXIII remote control
> +//
> +
> +static struct rc_map_table beelink_mxiii[] = {
> +	{ 0xb2dc, KEY_POWER },
> +
> +	{ 0xb288, KEY_MUTE },

I'm guessing this is the mouse button. It should say so in a comment, if it
is.

Thanks,
Sean

> +	{ 0xb282, KEY_HOME },
> +
> +	{ 0xb2ca, KEY_UP },
> +	{ 0xb299, KEY_LEFT },
> +	{ 0xb2ce, KEY_OK },
> +	{ 0xb2c1, KEY_RIGHT },
> +	{ 0xb2d2, KEY_DOWN },
> +
> +	{ 0xb2c5, KEY_MENU },
> +	{ 0xb29a, KEY_BACK },
> +
> +	{ 0xb281, KEY_VOLUMEDOWN },
> +	{ 0xb280, KEY_VOLUMEUP },
> +};
> +
> +static struct rc_map_list beelink_mxiii_map = {
> +	.map = {
> +		.scan     = beelink_mxiii,
> +		.size     = ARRAY_SIZE(beelink_mxiii),
> +		.rc_proto = RC_PROTO_NEC,
> +		.name     = RC_MAP_BEELINK_MXIII,
> +	}
> +};
> +
> +static int __init init_rc_map_beelink_mxiii(void)
> +{
> +	return rc_map_register(&beelink_mxiii_map);
> +}
> +
> +static void __exit exit_rc_map_beelink_mxiii(void)
> +{
> +	rc_map_unregister(&beelink_mxiii_map);
> +}
> +
> +module_init(init_rc_map_beelink_mxiii)
> +module_exit(exit_rc_map_beelink_mxiii)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
> diff --git a/include/media/rc-map.h b/include/media/rc-map.h
> index 5178dcae5ff7..dadd4d27a760 100644
> --- a/include/media/rc-map.h
> +++ b/include/media/rc-map.h
> @@ -225,6 +225,7 @@ struct rc_map *rc_map_get(const char *name);
>  #define RC_MAP_AVERTV_303                "rc-avertv-303"
>  #define RC_MAP_AZUREWAVE_AD_TU700        "rc-azurewave-ad-tu700"
>  #define RC_MAP_BEELINK_GS1               "rc-beelink-gs1"
> +#define RC_MAP_BEELINK_MXIII             "rc-beelink-mxiii"
>  #define RC_MAP_BEHOLD                    "rc-behold"
>  #define RC_MAP_BEHOLD_COLUMBUS           "rc-behold-columbus"
>  #define RC_MAP_BUDGET_CI_OLD             "rc-budget-ci-old"
> -- 
> 2.34.1
