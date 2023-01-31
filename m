Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1E682EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjAaOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAaOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:08:53 -0500
X-Greylist: delayed 6003 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 06:08:49 PST
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150010260;
        Tue, 31 Jan 2023 06:08:49 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E2A5B100065; Tue, 31 Jan 2023 14:08:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1675174127; bh=Rl8n5CW2uLVcOyxok/8JKlboB2g6hTd8IuCPIf9Ab2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1nISWmtnNt9RYQv7Fl9V77dCX5J0wJeooTl7tGpfd+UK3omGvHiVER9+1ZToGtkG
         eBRFVuDyuTohEfXAFdpxHavGCpWcWfo2I4AKIz1QxGJc6ri5KE/nQ558KUq4EM/X8G
         51zCEG1a6t7Nykq2yo3nKJCarFdoTEiHdwqmduxxkis/hpxqp8UeQhdzx3Xn8KMDZB
         lglmhK6cFgNxE+VIarXRKF1Wc2YTOzMen1hCncxEw8z3V1OJ13yrbxVJz0BVwqd7fI
         z7EEgs3ddvN4IV1eHK10ZFKT70yo32YkEXbPqV9HO4osobNVRiaBS7wNBH+4Khan2O
         5IMC+m1YswZPg==
Date:   Tue, 31 Jan 2023 14:08:47 +0000
From:   Sean Young <sean@mess.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: Re: [PATCH] media: rc: add common keymap for Dreambox RC10 and
 RC20/RC-BT remotes
Message-ID: <Y9kg75CGbMKiYVoR@gofer.mess.org>
References: <20230128033616.3982911-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128033616.3982911-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 03:36:16AM +0000, Christian Hewitt wrote:
> From: Emanuel Strobel <emanuel.strobel@yahoo.com>
> 
> Add a common keymap and bindings for the RC10 and RC20/RC-BT remotes
> used with the Dreambox One and Dreambox Two DVB-S/T boxes. The maps
> are combined since the IR codes do not conflict and both boxes have
> shipped with both remote designs.
> 
> Signed-off-by: Emanuel Strobel <emanuel.strobel@yahoo.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../devicetree/bindings/media/rc.yaml         |   1 +
>  drivers/media/rc/keymaps/Makefile             |   1 +
>  drivers/media/rc/keymaps/rc-dreambox.c        | 147 ++++++++++++++++++
>  include/media/rc-map.h                        |   1 +
>  4 files changed, 150 insertions(+)
>  create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c
> 
> diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> index d4ef523cb3d5..f390a5d2c82d 100644
> --- a/Documentation/devicetree/bindings/media/rc.yaml
> +++ b/Documentation/devicetree/bindings/media/rc.yaml
> @@ -56,6 +56,7 @@ properties:
>        - rc-dm1105-nec
>        - rc-dntv-live-dvb-t
>        - rc-dntv-live-dvbt-pro
> +      - rc-dreambox
>        - rc-dtt200u
>        - rc-dvbsky
>        - rc-dvico-mce
> diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
> index 77d8b5a69815..03bc9a8d355e 100644
> --- a/drivers/media/rc/keymaps/Makefile
> +++ b/drivers/media/rc/keymaps/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_RC_MAP) += \
>  			rc-dm1105-nec.o \
>  			rc-dntv-live-dvb-t.o \
>  			rc-dntv-live-dvbt-pro.o \
> +			rc-dreambox.o \
>  			rc-dtt200u.o \
>  			rc-dvbsky.o \
>  			rc-dvico-mce.o \
> diff --git a/drivers/media/rc/keymaps/rc-dreambox.c b/drivers/media/rc/keymaps/rc-dreambox.c
> new file mode 100644
> index 000000000000..0ccbed367ea3
> --- /dev/null
> +++ b/drivers/media/rc/keymaps/rc-dreambox.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (c) 2021 Emanuel Strobel <emanuel.strobel@yahoo.com>
> +
> +#include <media/rc-map.h>
> +#include <linux/module.h>
> +
> +//
> +// Keytable for the Dreabox RC10 and RC20/RC-BT remote controls

Dreambox

> +//
> +
> +static struct rc_map_table dreambox[] = {
> +

checkpatch.pl --strict says:

Blank lines aren't necessary after an open brace '{'

> +	/* Dreambox RC10 remote */
> +
> +	{ 0x3401, KEY_POWER },
> +
> +	// DREAM
KEY_MEDIA?

> +	{ 0x3426, KEY_HELP },
> +	// TV

How about KEY_TV for this button?

> +
> +	{ 0x3404, KEY_1 },
> +	{ 0x3405, KEY_2 },
> +	{ 0x3406, KEY_3 },
> +	{ 0x3408, KEY_4 },
> +	{ 0x3409, KEY_5 },
> +	{ 0x340a, KEY_6 },
> +	{ 0x340c, KEY_7 },
> +	{ 0x340d, KEY_8 },
> +	{ 0x340e, KEY_9 },
> +	{ 0x340b, KEY_PREVIOUS },
> +	{ 0x3410, KEY_0 },
> +	{ 0x340f, KEY_NEXT },
> +
> +	{ 0x341f, KEY_RED },
> +	{ 0x3420, KEY_GREEN },
> +	{ 0x3421, KEY_YELLOW },
> +	{ 0x3422, KEY_BLUE },
> +
> +	{ 0x341b, KEY_INFO },
> +	{ 0x341c, KEY_MENU },
> +	{ 0x3430, KEY_AUDIO },
> +	{ 0x3431, KEY_PVR },
> +
> +	{ 0x3414, KEY_LEFT },
> +	{ 0x3411, KEY_UP },
> +	{ 0x3416, KEY_RIGHT },
> +	{ 0x3419, KEY_DOWN },
> +	{ 0x3415, KEY_OK },
> +
> +	{ 0x3413, KEY_VOLUMEUP },
> +	{ 0x3418, KEY_VOLUMEDOWN },
> +
> +	{ 0x3412, KEY_ESC }, // EXIT

KEY_EXIT?

> +	{ 0x3407, KEY_MUTE },
> +
> +	{ 0x3417, KEY_PAGEUP },
> +	{ 0x341a, KEY_PAGEDOWN },
> +
> +	{ 0x3432, KEY_PREVIOUSSONG },
> +	{ 0x3433, KEY_PLAYPAUSE },
> +	{ 0x3434, KEY_STOP },
> +	{ 0x3435, KEY_NEXTSONG },
> +
> +	// TV
KEY_TV?

> +	// RADIO
KEY_RADIO?

> +	{ 0x3425, KEY_TEXT },
> +	{ 0x3436, KEY_RECORD },
> +
> +	/* Dreambox RC20/RC-BT */
> +
> +	{ 0x321a, KEY_MUTE },
> +	// MODE
KEY_MODE?
> +	{ 0x3200, KEY_POWER },
> +
> +	{ 0x3223, KEY_PREVIOUSSONG },
> +	{ 0x3224, KEY_PLAYPAUSE },
> +	{ 0x3226, KEY_NEXTSONG },
> +
> +	{ 0x322a, KEY_RECORD },
> +	{ 0x3225, KEY_STOP },
> +	{ 0x3229, KEY_TEXT },
> +
> +	{ 0x321f, KEY_RED },
> +	{ 0x3220, KEY_GREEN },
> +	{ 0x3221, KEY_YELLOW },
> +	{ 0x3222, KEY_BLUE },
> +
> +	{ 0x3210, KEY_INFO },
> +	{ 0x3212, KEY_MENU },
> +	{ 0x320e, KEY_AUDIO },
> +	{ 0x3218, KEY_PVR },
> +
> +	{ 0x3213, KEY_LEFT },
> +	{ 0x3211, KEY_UP },
> +	{ 0x3215, KEY_RIGHT },
> +	{ 0x3217, KEY_DOWN },
> +	{ 0x3214, KEY_OK },
> +
> +	{ 0x3219, KEY_VOLUMEUP },
> +	{ 0x321c, KEY_VOLUMEDOWN },
> +
> +	{ 0x321d, KEY_ESC }, // EXIT
KEY_EXIT?
> +	{ 0x3290, KEY_HELP },
> +
> +	{ 0x321b, KEY_PAGEUP },
> +	{ 0x321e, KEY_PAGEDOWN },
> +
> +	{ 0x3201, KEY_1 },
> +	{ 0x3202, KEY_2 },
> +	{ 0x3203, KEY_3 },
> +	{ 0x3204, KEY_4 },
> +	{ 0x3205, KEY_5 },
> +	{ 0x3206, KEY_6 },
> +	{ 0x3207, KEY_7 },
> +	{ 0x3208, KEY_8 },
> +	{ 0x3209, KEY_9 },
> +	{ 0x320a, KEY_PREVIOUS },
> +	{ 0x320b, KEY_0 },
> +	{ 0x320c, KEY_NEXT },
> +

Unnecessary blank line.

Thanks
Sean

> +};
> +
> +static struct rc_map_list dreambox_map = {
> +	.map = {
> +		.scan     = dreambox,
> +		.size     = ARRAY_SIZE(dreambox),
> +		.rc_proto = RC_PROTO_NEC,
> +		.name     = RC_MAP_DREAMBOX,
> +	}
> +};
> +
> +static int __init init_rc_map_dreambox(void)
> +{
> +	return rc_map_register(&dreambox_map);
> +}
> +
> +static void __exit exit_rc_map_dreambox(void)
> +{
> +	rc_map_unregister(&dreambox_map);
> +}
> +
> +module_init(init_rc_map_dreambox)
> +module_exit(exit_rc_map_dreambox)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Emanuel Strobel <emanuel.strobel@yahoo.com>");
> diff --git a/include/media/rc-map.h b/include/media/rc-map.h
> index 43d254930daa..dadd4d27a760 100644
> --- a/include/media/rc-map.h
> +++ b/include/media/rc-map.h
> @@ -242,6 +242,7 @@ struct rc_map *rc_map_get(const char *name);
>  #define RC_MAP_DM1105_NEC                "rc-dm1105-nec"
>  #define RC_MAP_DNTV_LIVE_DVB_T           "rc-dntv-live-dvb-t"
>  #define RC_MAP_DNTV_LIVE_DVBT_PRO        "rc-dntv-live-dvbt-pro"
> +#define RC_MAP_DREAMBOX                  "rc-dreambox"
>  #define RC_MAP_DTT200U                   "rc-dtt200u"
>  #define RC_MAP_DVBSKY                    "rc-dvbsky"
>  #define RC_MAP_DVICO_MCE		 "rc-dvico-mce"
> -- 
> 2.34.1
