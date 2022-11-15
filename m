Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C286299E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiKONRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiKONRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:17:24 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185832A96C;
        Tue, 15 Nov 2022 05:17:22 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id i9so9386007qki.10;
        Tue, 15 Nov 2022 05:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl8NQgIvIe7TyMtrjFXQ+PIFZ5WFuLSc0VcNaYyRH9Y=;
        b=AFCyWCGixDBbJkosdsXgD2VFfMDjQnLFW10e8tC2Zvb1hS0nAhWcsdFT35Fg+lzKdr
         L/U8BYi9YR+ym3D3aJ6SEM0lEZ4h/HWt1nu4DcxFiYJubFQQhP2K0eHr8fRKUWax/QKP
         B1adi/swRtDULOVXNYFA5lRKG0DcoldZ7+quG8cjk9bUB0ie8QqDP+IWmMofhVYq3i5g
         2rsURmIsIseiqwgaEUExcTCj3peT2vKZwaT1ljjrCofIPdJmlsy4sgyBVG7jBy/8xbuV
         iWqtwEBgUCGgOCmUKHheq2akWay/8Q8yEAcMSZ91UqOTBkYvTIXR0zwsjxYSXhRo8JTS
         VIog==
X-Gm-Message-State: ANoB5plXn45R9Dg0B4uDrl7iKKh4Oi5lOSZBgJ6h0w6bmTggCaR9db75
        3NB4iZba0JuUn0mGZlyH2ArWV6/3eLZqKw==
X-Google-Smtp-Source: AA0mqf50fWe5mqrQLfQzkN6m2q3kWy4RtQbJ5wRalJz9kV9DwmPDsZh6xTGYIg1nxWM274Q7e0mS5g==
X-Received: by 2002:a05:620a:1d51:b0:6fa:57a4:6526 with SMTP id dm17-20020a05620a1d5100b006fa57a46526mr15174683qkb.671.1668518241054;
        Tue, 15 Nov 2022 05:17:21 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id c8-20020ac853c8000000b00359961365f1sm7073961qtq.68.2022.11.15.05.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:17:20 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-370547b8ca0so137087617b3.0;
        Tue, 15 Nov 2022 05:17:20 -0800 (PST)
X-Received: by 2002:a81:4ed2:0:b0:370:202b:f085 with SMTP id
 c201-20020a814ed2000000b00370202bf085mr17176976ywb.502.1668518240254; Tue, 15
 Nov 2022 05:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20221022182828.give.717-kees@kernel.org> <20221022182949.2684794-2-keescook@chromium.org>
In-Reply-To: <20221022182949.2684794-2-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 14:17:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2k2CXB2qfPeAN8LDGsqN-koLSLgp5azEB1HHHiqhQRQ@mail.gmail.com>
Message-ID: <CAMuHMdV2k2CXB2qfPeAN8LDGsqN-koLSLgp5azEB1HHHiqhQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Sat, Oct 22, 2022 at 9:14 PM Kees Cook <keescook@chromium.org> wrote:
> TIOCSTI continues its long history of being used in privilege escalation
> attacks[1]. Prior attempts to provide a mechanism to disable this have
> devolved into discussions around creating full-blown LSMs to provide
> arbitrary ioctl filtering, which is hugely over-engineered -- only
> TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
> TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
> had historically used TIOCSTI either do not need it, are not commonly
> built with it, or have had its use removed.
>
> Provide a simple CONFIG and global sysctl to disable this for the system
> builders who have wanted this functionality for literally decades now,
> much like the ldisc_autoload CONFIG and sysctl.
>
> [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
> [2] https://undeadly.org/cgi?action=article;sid=20170701132619
> [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Simon Brand <simon.brand@postadigitale.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch, which is now commit 83efeeeb3d04b22a ("tty:
Allow TIOCSTI to be disabled") in tty/tty-next.

> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -149,6 +149,25 @@ config LEGACY_PTY_COUNT
>           When not in use, each legacy PTY occupies 12 bytes on 32-bit
>           architectures and 24 bytes on 64-bit architectures.
>
> +config LEGACY_TIOCSTI
> +       bool "Allow legacy TIOCSTI usage"
> +       default y

Obviously this should either default to n, ...

> +       help
> +         Historically the kernel has allowed TIOCSTI, which will push
> +         characters into a controlling TTY. This continues to be used
> +         as a malicious privilege escalation mechanism, and provides no
> +         meaningful real-world utility any more. Its use is considered
> +         a dangerous legacy operation, and can be disabled on most
> +         systems.
> +
> +         Say 'Y here only if you have confirmed that your system's
> +         userspace depends on this functionality to continue operating
> +         normally.

... or the help text should be made less scary.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
