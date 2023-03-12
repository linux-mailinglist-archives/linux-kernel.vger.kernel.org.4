Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B316B6595
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCLLjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Mar 2023 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCLLjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:39:08 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37AA34F71;
        Sun, 12 Mar 2023 04:39:05 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id l13so10553960qtv.3;
        Sun, 12 Mar 2023 04:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678621144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHsU4w7j+rX05CyivyZKDHXiX4NthxonKHXgo0Q46rs=;
        b=emKqODnYwHnKOUD57RO7QmcTm14N8aZwEcfM+0hVGVYoe7oa+WHI7rDjRYIH88Yykr
         8rOuplXFi6ZOU3mc0X5Cet7Ql8bxEQBubyzHB6bSucedqsAjOXmsnyzluUJ5TmRUyBMe
         KUg7jColsmzjZfnLYNwfsaZ2b4hR3QDGjxcS1x5ipam+I+tykmKD7D9nAvqgoEFIucgf
         /tL2i80ad+q9FHEynljmCSOF/u08L0PvPKvNgfsDbtB12dkQVJIqYMf69V2YgtEWw0/H
         eeZze+03xeXMuWybyogQ+18ZmwXeNk/hTZgVRgKoBD0o+2QGHBZzqSVBUMSmKlI9WhEQ
         5NwA==
X-Gm-Message-State: AO0yUKWAHC/kpp+Egs6kB+vMW6/3r5zDBLMls3+fvLRvVTPFORvXLR3e
        NnTTStaSZYk9ptsPiaUmzccR+n+mZfVjfw==
X-Google-Smtp-Source: AK7set/7L5UWtAcVWDLnA+IIS93zN0FRvyY6JkoHizMSE1SbH6T6E0vX+4/NjW5o7v8VTIX7DaaKLw==
X-Received: by 2002:a05:622a:1a9f:b0:3bd:16cf:2f33 with SMTP id s31-20020a05622a1a9f00b003bd16cf2f33mr50537165qtc.63.1678621144612;
        Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 74-20020a37054d000000b007456c75edbbsm1833698qkf.129.2023.03.12.04.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5419d4c340aso5436507b3.11;
        Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
X-Received: by 2002:a81:ad50:0:b0:541:8a9a:5445 with SMTP id
 l16-20020a81ad50000000b005418a9a5445mr1295851ywk.5.1678621143951; Sun, 12 Mar
 2023 04:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230312052624.8402-1-rdunlap@infradead.org>
In-Reply-To: <20230312052624.8402-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Mar 2023 12:38:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXia3d8dV1EyNcmgA=k_osEAkHZkA4ya9xjzyEVO4YjGQ@mail.gmail.com>
Message-ID: <CAMuHMdXia3d8dV1EyNcmgA=k_osEAkHZkA4ya9xjzyEVO4YjGQ@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_cs5536: don't build on UML
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

On Sun, Mar 12, 2023 at 6:26 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Similar to 22eebaa631c4 ("ata: pata_cs5535: Don't build on UML"),
> prevent pata_cs5536 from building on UML since it references
> symbols that are not present when building X86_32/i386 allmodconfig.
>
> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -650,6 +650,7 @@ config PATA_CS5535
>  config PATA_CS5536
>         tristate "CS5536 PATA support"
>         depends on PCI && (X86_32 || MIPS || COMPILE_TEST)

How does this work on MIPS?
Oh, the MSR functionality inside the driver depends on CONFIG_X86_32.
Perhaps this can be fixed better for all users inside
arch/x86/include/asm/msr.h?

> +       depends on !UML
>         help
>           This option enables support for the AMD CS5536
>           companion chip used with the Geode LX processor family.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
