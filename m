Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A674F23E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGKO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjGKO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11238268B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729FE61524
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD125C433CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689085596;
        bh=1DUmkViYN9fziKjeAd6oVmwpVEWCXPxOx4+pyFAeKxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TdIigh6aoOUoBfEHn4QQjPOBTwc76XklxNbPqlnAlB/ewytV0ukNSBouqXnHbFFYo
         ITPfmIipH8IXOHWwJ558xYbhCrhsUapGVpilWXq4g9X5dYxGYtlkcKO0TzIAYUWDxy
         0GuKHZi6w5iqqTFpKYUEuWIhjLIFR1YDBn7/HLUW+sFc0CABYTYmJsJpuS2hbRF4IX
         huwv0tKvb9xZrSpcHz735st9Ewqsff82Z/DeTNhl9Sa/P15Ygr2qaCwV5B4iph7Ki4
         oXHE7//azKsKndqpuuCWK/A1o/ew2QRCZ02hmSmzZhZQVIycvs/Gl9QVgAab9/e9he
         4XRRdF6JdvI3g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so11119415a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:26:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLarTsRD9rZzOwA+b/YLlPGnKbqInMidMYvREw1mnQ4RqEkL+sPg
        HjFdKRbbCA/ExsdHKvDV+SnPOplLceUz0awON+I=
X-Google-Smtp-Source: APBJJlHVx40sDPXN/Hbq4fvZ4xkbiL2eh15EzqC3z5T5ZPEzdGkWXTiFfTkytTHWitDksNMwx8oyyOaxwXLI+tA7EP0=
X-Received: by 2002:a05:6402:5113:b0:51e:5e93:6c38 with SMTP id
 m19-20020a056402511300b0051e5e936c38mr5769826edd.21.1689085594946; Tue, 11
 Jul 2023 07:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 11 Jul 2023 22:26:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com>
Message-ID: <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
To:     Dong Zhihong <donmor3000@hotmail.com>
Cc:     kernel@xen0n.name, ardb@kernel.org, tangyouling@loongson.cn,
        zhoubinbin@loongson.cn, yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 9:47=E2=80=AFPM Dong Zhihong <donmor3000@hotmail.co=
m> wrote:
>
> Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and
> CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
> There's already code handling CONFIG_CMDLINE_FORCE, which replaces
> `boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd b=
e
> similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER=
,
> so some code is added after OF_FLATTREE part to handle them.
>
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>
> v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao=
)
> v2 -> v1: Reworded the commit message so it's more imperative (Markus);
>         Added `goto out` to FDT part (Huacai)
>
>  arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 78a00359bde3..3cafda1a409e 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -332,7 +332,24 @@ static void __init bootcmdline_init(char **cmdline_p=
)
>                         strlcat(boot_command_line, " ", COMMAND_LINE_SIZE=
);
>
>                 strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
> +               goto out;
> +       }
> +#endif
> +
> +#ifdef CONFIG_CMDLINE
> +       /*
> +        * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built=
-in
> +        * command line if no command line given, or we append given comm=
and
> +        * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
> +        */
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
You can simply the logic:
               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
               strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE=
);
And then modify the comments because you are appending built-in parts
to bootloader parts.

>         }
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0=
])
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
This should be removed if you want to keep the exact meaning of
CONFIG_CMDLINE_BOOTLOADER.

Huacai

>  #endif
>
>  out:
> --
> 2.25.1
>
