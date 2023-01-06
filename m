Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610976602E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjAFPSb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Jan 2023 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjAFPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:18:02 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189E6F958;
        Fri,  6 Jan 2023 07:18:01 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id d13so1149831qvj.8;
        Fri, 06 Jan 2023 07:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alz05ZcNgoaQdFl2lti3Hdp2W/onZPDBRRL7a7nm+Vw=;
        b=RpqvAfwP6nAFnDP7wiCIz3ssZJymjiGAd7K/Lq76upoN17Q9EI9qlisR9++gfAnq2r
         Wo67ZcCJPPzH1Rjsxk7r3QNBYNjFowlCRwEVVUs2fQWPMGOQA2KDyCxRSXfzmwjmeb8x
         EYLS2/IbrkQgONbBYoktQHQcQdwfm6QhdP6LUsA8XTcGRPci5RitRWIk1r2EqwDsP3Eu
         zmRyaY+P3VrjZV8nWy2EC3jC16vSSxjbQ9znI4hbANcc+V5+hHj+9F6Px9qV5EMwHiIK
         Tuo6LGturyN15G69h1LLk7OwuLZ8rucI51+gDuVDGwyNb/L21w0CssmonW+OYc2W0NAD
         Arzg==
X-Gm-Message-State: AFqh2krvevVg4mXQS8/OE3pt0D21OP9jlQCnZdhewp4r6lJtB6vMUsfc
        zD/Cq90rNK5tn2+bSiYTSo92tMU8CUQJMg==
X-Google-Smtp-Source: AMrXdXu7EFaDUulAfhQDoU3292fdoUd6O2mj7gAhOkwk7Fb1Uy+zD//ToW2C7UKXUqzf+qduGSn60g==
X-Received: by 2002:a05:6214:5e90:b0:531:cb37:aa95 with SMTP id mm16-20020a0562145e9000b00531cb37aa95mr24801261qvb.10.1673018280362;
        Fri, 06 Jan 2023 07:18:00 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id a22-20020a05620a103600b006fbaf9c1b70sm621226qkk.133.2023.01.06.07.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 07:17:59 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id t15so2191218ybq.4;
        Fri, 06 Jan 2023 07:17:59 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr557375ybg.543.1673018279290; Fri, 06
 Jan 2023 07:17:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
In-Reply-To: <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jan 2023 16:17:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
Message-ID: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 6, 2023 at 4:10 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 12/27/22 09:35, Geert Uytterhoeven wrote:
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_262' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().:  => 358:45
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().:  => 358:45
> >
> > In function 'follow_pmd_mask',
> >      inlined from 'follow_pud_mask' at /kisskb/src/mm/gup.c:735:9,
> >      inlined from 'follow_p4d_mask' at /kisskb/src/mm/gup.c:752:9,
> >      inlined from 'follow_page_mask' at /kisskb/src/mm/gup.c:809:9:
> >
> > sh4-gcc11/sh-defconfig (Günter wondered if pmd_t should use union)
>
> I'm seeing this, too. Also for sh7785lcr_defconfig.
>
> > sh4-gcc11/sh-allmodconfig (ICE = internal compiler error)
>
> I'm not seeing this one, but I am getting this one instead:
>
> In file included from ./arch/sh/include/asm/hw_irq.h:6,
>                   from ./include/linux/irq.h:596,
>                   from ./include/asm-generic/hardirq.h:17,
>                   from ./arch/sh/include/asm/hardirq.h:9,
>                   from ./include/linux/hardirq.h:11,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/serial_core.h:13,
>                   from ./include/linux/serial_sci.h:6,
>                   from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
> ./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]
>    100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>        |                                                               ^
> ./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRAY'
>    105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
>        |                               ^~~~~~~~~~~

The easiest fix for the latter is to disable CONFIG_WERROR.
Unfortunately I don't know a simple solution to get rid of the warning.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
