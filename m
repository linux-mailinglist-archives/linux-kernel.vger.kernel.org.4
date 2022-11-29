Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273663C143
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiK2Nkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2Nkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:40:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2B5ADDD;
        Tue, 29 Nov 2022 05:40:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF45521BDB;
        Tue, 29 Nov 2022 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669729234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFsalh8bL4seyyKkE319sRhzziNPYV9UGJT999sCXDo=;
        b=m9WbLzPVNWEkBg6MGv11dvKu7IToHgZmiCDgZkWECgG0NB/Owh8Q9BgC1zcvM/JmMGkbTb
        jd569w58ZKyKPrcZzZwB1Li9s51hGEFvPUyOwTqmh9HHzvsRLa5CstbFKWmDSAQxPQqLbj
        TpmF/9TAknfbBDV5rCzVrzgLluCTKv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669729234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFsalh8bL4seyyKkE319sRhzziNPYV9UGJT999sCXDo=;
        b=RTQVPYO1oq66qprUyOmWT/IRpN3Axbu+HHCH9tolKTPwz6c4HXabaecB4DLAlb+jqH94oA
        iAJO1eYntazK8bAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CFBB13AF6;
        Tue, 29 Nov 2022 13:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eWoTItILhmOsNgAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 29 Nov 2022 13:40:34 +0000
Message-ID: <3276c36e-7dfe-ce2d-14d3-20dab732bd76@suse.de>
Date:   Tue, 29 Nov 2022 14:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
Content-Language: en-US
To:     Chester Lin <clin@suse.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-3-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
In-Reply-To: <20221128054820.1771-3-clin@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

Am 28.11.22 um 06:48 schrieb Chester Lin:
> Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> on NXP's downstream implementation on CodeAurora[1].
> 
> [1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt
> 
> Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> 
> Changes in v2:
> - Create a s32_pin_range matrix in the driver for replacing the "nxp,pins"
>    property in DT.
> - Refine the compatible name to "nxp,s32g2-siul2-pinctrl".

Thanks.

> - Fix the copyright requested by NXP.
> - Remove a few recipients from the Cc list since these email addresses are no
>    longer available.
> 
>   drivers/pinctrl/freescale/Kconfig         |   16 +
>   drivers/pinctrl/freescale/Makefile        |    2 +
>   drivers/pinctrl/freescale/pinctrl-s32.h   |   77 ++
>   drivers/pinctrl/freescale/pinctrl-s32cc.c | 1003 +++++++++++++++++++++
>   drivers/pinctrl/freescale/pinctrl-s32g.c  |  773 ++++++++++++++++
>   5 files changed, 1871 insertions(+)
>   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
>   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
>   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g.c
> 
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> index 7a32f77792d9..fdd8f5492830 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -217,3 +217,19 @@ config PINCTRL_IMXRT1170
>   	select PINCTRL_IMX
>   	help
>   	  Say Y here to enable the imxrt1170 pinctrl driver
> +
> +config PINCTRL_S32CC
> +	bool "NXP S32 Common Chassis pinctrl driver core"
> +	depends on ARCH_S32 && OF
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GENERIC_PINCONF
> +	help
> +	  Say Y here to enable the NXP S32CC pinctrl driver core

Does this driver core make any sense without a specific driver?

I.e., could this just be a menu-invisible internal option if S32G is the 
one the user needs to select anyway?
The alternative would be to leave it and have S32G depend on it, 
creating a submenu structure, but that would then still allow to build 
the driver core without any users.

> +
> +config PINCTRL_S32G
> +	depends on ARCH_S32 && OF
> +	bool "NXP S32G pinctrl driver"
> +	select PINCTRL_S32CC
> +	help
> +	  Say Y here to enable the pinctrl driver for NXP 32G family SoCs

s/32G/S32G/

> diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
> index 647dff060477..ceb0f61c6215 100644
> --- a/drivers/pinctrl/freescale/Makefile
> +++ b/drivers/pinctrl/freescale/Makefile
> @@ -33,3 +33,5 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
>   obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
>   obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
>   obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
> +obj-$(CONFIG_PINCTRL_S32CC)	+= pinctrl-s32cc.o
> +obj-$(CONFIG_PINCTRL_S32G)	+= pinctrl-s32g.o
[snip]

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Frankenstraße 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nürnberg)
