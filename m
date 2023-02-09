Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BD690AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBINzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBINy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:54:57 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CF1ADF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:54:55 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id ch10so759707qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CcV9wL3Ec1xOc4Cg0ZtCdpfu4ss4O9wCq9W1zoWAsE=;
        b=IcQaxIZYhB6FFBdB6Pimc7UII7a1NCLQAIvtYwEVzZhfGtz4dA4rP9uL/8Wla5PrXB
         ygCc+bFFoVmB8H090To5LD5DeiXF/HvzenbfxFSS36eOsNK7jcOV+sTXlHqa1BwsiNFg
         2+snEnYMp6s0/1QvjN26Uek98kEWrgDqXE6KBSiSYG7gez2A4zwz7dkkWVAJQnEDOmQP
         xXhzQHoxO1hOOEGJR5+DpgIT9lwpa021zlnZOswWIB83Q24VjDu2BB0l9S923hPkHlpL
         xE6QUcZO9li9PpLWNWfn3cLjfc2huebBqN8r7DxrLU/eYkwW5CV9h8J/WIDEHMedITOp
         GN4g==
X-Gm-Message-State: AO0yUKX6gVq4t+GbgA/3dG9xqorrTsC26+jhtyav/ui5mk56hfP6WIwE
        JwkvMPjsdL9iI7nKhHoZbYh4EH2Y970Sxg==
X-Google-Smtp-Source: AK7set/yRW6Vn0JeEhpX7ZTzQkTqt/csq228I40JpCFWFxr9L54Riv0FjtchHDz8bn1F0ZxBeKvYfw==
X-Received: by 2002:ac8:5c50:0:b0:3b9:ec46:bf95 with SMTP id j16-20020ac85c50000000b003b9ec46bf95mr18643337qtj.49.1675950894687;
        Thu, 09 Feb 2023 05:54:54 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b003b9a4a497a1sm1231299qtp.86.2023.02.09.05.54.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:54:54 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4c24993965eso25438537b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:54:53 -0800 (PST)
X-Received: by 2002:a0d:e004:0:b0:52a:7505:84bc with SMTP id
 j4-20020a0de004000000b0052a750584bcmr1196453ywe.383.1675950893766; Thu, 09
 Feb 2023 05:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20230209010825.24136-1-rdunlap@infradead.org>
In-Reply-To: <20230209010825.24136-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Feb 2023 14:54:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVi8YQbf3HiCXkcvcttoqQdDJ+Zn5fdTanvwR3Hi9g+MA@mail.gmail.com>
Message-ID: <CAMuHMdVi8YQbf3HiCXkcvcttoqQdDJ+Zn5fdTanvwR3Hi9g+MA@mail.gmail.com>
Subject: Re: [PATCH] m68k: /proc/hardware depends on PROC_FS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
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

Hi Randy,

On Thu, Feb 9, 2023 at 2:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When CONFIG_PROC_FS is not set, there is a build error for an unused
> function. Make PROC_HARDWARE depend on PROC_FS to prevent this error.
>
> In file included from ../arch/m68k/kernel/setup.c:3:
> ../arch/m68k/kernel/setup_mm.c:477:12: error: 'hardware_proc_show' defined but not used [-Werror=unused-function]
>   477 | static int hardware_proc_show(struct seq_file *m, void *v)
>       |            ^~~~~~~~~~~~~~~~~~
>
> Fixes: 66d857b08b8c ("m68k: merge m68k and m68knommu arch directories") # v3.0
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.3 branch.

> --- a/arch/m68k/Kconfig.devices
> +++ b/arch/m68k/Kconfig.devices
> @@ -18,6 +18,7 @@ config HEARTBEAT
>
>  # We have a dedicated heartbeat LED. :-)
>  config PROC_HARDWARE
> +       depends on PROC_FS

I'll move the "depends ..." line below the "bool ..." line while applying,
as that's where the dependencies are usually listed.

>         bool "/proc/hardware support"
>         help
>           Say Y here to support the /proc/hardware file, which gives you

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
