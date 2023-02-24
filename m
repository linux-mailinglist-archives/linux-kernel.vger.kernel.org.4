Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527EC6A17FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:32:06 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F61040D;
        Fri, 24 Feb 2023 00:32:05 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id cf14so3626395qtb.10;
        Fri, 24 Feb 2023 00:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqZHmts5IBK+j7Xy9THpbLfBLpEKmxFY3zw26RvkgMY=;
        b=dZsuYjGYQ+HH2WsLmE924QhnOoDhe63rsMlqznTn9eRFIhz6CTT4YwT3uTOZVEqCfz
         4Ed7pNbUydHxesFfifdFyh6cQsuCgcilKCkCFPJQprRYhxBwDFtngchTPmr0uJlbt+Xt
         wZGnqnT+C5PhuSGeMvetljeoSLu/NjkcvxmCH8YorG2L+GzODhhD+isz7kNC+HonHpey
         xrwwVCoLdGyoohBRgZCdFbjfWp/c1pzZtQAEIVGiJqJalCN+ASNZOz/eaqZLbCl6nPDW
         8se/I6Eqi3KZSmiQsNP1lj6xbzGx68rqEp1HrPk4gDAuyom5rCRVvHWuGu1Fw+zKv75l
         8JFg==
X-Gm-Message-State: AO0yUKUChPTV61Krp6NlbeFr4ND+/yiyko9EdthP6bqnz4XE6teQ1+/Y
        MVw3RnNMpGhxH75XbdQ9St8b0c9eGU5NNQ==
X-Google-Smtp-Source: AK7set9GR4dc33GmY0kbyX0V3h8C32+8CqMiqOzMuMiFXvrUHh1eEmmHYzLZqBVp6Pfv0hbVV9Slvg==
X-Received: by 2002:a05:622a:54e:b0:3bf:a061:6cb1 with SMTP id m14-20020a05622a054e00b003bfa0616cb1mr25292085qtx.46.1677227523851;
        Fri, 24 Feb 2023 00:32:03 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id b14-20020ac801ce000000b003ba11bfe4fcsm5293182qtg.28.2023.02.24.00.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 00:32:03 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-53916ab0c6bso11763197b3.7;
        Fri, 24 Feb 2023 00:32:03 -0800 (PST)
X-Received: by 2002:a81:ae0c:0:b0:52e:cacb:d7c4 with SMTP id
 m12-20020a81ae0c000000b0052ecacbd7c4mr4021351ywh.5.1677227523085; Fri, 24 Feb
 2023 00:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20230105005838.GA1772817@paulmck-ThinkPad-P17-Gen-1>
 <20230108002215.c18df95b19acdd3207b379fa@kernel.org> <20230107162202.GA4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230107162202.GA4028633@paulmck-ThinkPad-P17-Gen-1>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Feb 2023 09:31:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com>
Message-ID: <CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com>
Subject: Re: [PATCH RFC bootconfig] Allow forcing unconditional bootconfig processing
To:     paulmck@kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, ndesaulniers@google.com,
        vbabka@suse.cz, hannes@cmpxchg.org, joel@joelfernandes.org,
        quic_neeraju@quicinc.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Jan 7, 2023 at 5:33 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Sun, Jan 08, 2023 at 12:22:15AM +0900, Masami Hiramatsu wrote:
> > BTW, maybe CONFIG_BOOT_CONFIG_EMBED is better to select this.
> > (or at least recommend to enable this)
>
> Like this?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit d09a1505c51a70da38b34ac38062977299aef742
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sat Jan 7 08:09:22 2023 -0800
>
>     bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED
>
>     When a kernel is built with CONFIG_BOOT_CONFIG_EMBED=y, the intention
>     will normally be to unconditionally provide the specified kernel-boot
>     arguments to the kernel, as opposed to requiring a separately provided
>     bootconfig parameter.  Therefore, make the BOOT_CONFIG_FORCE Kconfig
>     option default to y in kernels built with CONFIG_BOOT_CONFIG_EMBED=y.
>
>     The old semantics may be obtained by manually overriding this default.
>
>     Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0fb19fa0edba9..97a0f14d9020d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1379,6 +1379,7 @@ config BOOT_CONFIG
>  config BOOT_CONFIG_FORCE
>         bool "Force unconditional bootconfig processing"
>         depends on BOOT_CONFIG
> +       default y if BOOT_CONFIG_EMBED
>         help
>           With this Kconfig option set, BOOT_CONFIG processing is carried
>           out even when the "bootconfig" kernel-boot parameter is omitted.

Thanks for your patch, which is now commit 6ded8a28ed80e4cc
("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED").

After this change, an all{mod,yes}config kernel has:

    CONFIG_BOOT_CONFIG_FORCE=y
    CONFIG_BOOT_CONFIG_EMBED=y
    CONFIG_BOOT_CONFIG_EMBED_FILE=""

Will this actually work? I haven't tried booting such a kernel yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
