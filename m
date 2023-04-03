Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27206D3DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDCHNf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 03:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDCHNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:13:20 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2586BD;
        Mon,  3 Apr 2023 00:13:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g17so36736275lfv.4;
        Mon, 03 Apr 2023 00:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680505991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7capAJy/014BXDXeBkJl6CUwcFU7SprHWGZwxKTcxg=;
        b=hLC49TBVWt1rjTqVVu0oLVhQmINJAE+p50np2C5JgQH2EdUQZs7qWQUjUjMm3liQod
         heCKJFnd+UrIeyNNdo7ZIiX1OJIdk+zmA69KfrV2M0kR9qpM89djt4GwbegN01g+qkd/
         Y7FmTpAE8PTfwcXJ8hDw3HbAVgDr/9Br+yPjkYiNVhReICaB2WcJO+nlXI+u8ezhehf2
         Z+DeRZGI6o+K8bYWDANAkGyswcR19zvUimw+Ve0l0+Z9VJSyGSFRYSUVc1izMCzrr/DW
         R5IiVrNeBLTriHD0c1OPz7LElaugfoRBvHFY+oYJdYsU8CEMB27olQkMtsskwfMOyBMg
         fvWA==
X-Gm-Message-State: AAQBX9fdhIj3iIIpKHRqKunroxWdHykRWTa2tBM5gBdtA8EohIcUX8RG
        Vhv3CzSW65Z0HxwHySo4LSNPE6mYwowQ8Q==
X-Google-Smtp-Source: AKy350ZH5qiDzPPdBSxA7mZm9eLPaIx2SXQvoX9Sg/nuFG9FzH8Luy1nAtXDHVK0IV9XG9gEW90OEA==
X-Received: by 2002:ac2:5291:0:b0:4b9:a91c:b0c9 with SMTP id q17-20020ac25291000000b004b9a91cb0c9mr9376528lfm.7.1680505991373;
        Mon, 03 Apr 2023 00:13:11 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b5-20020ac25e85000000b004e80141709fsm1647026lfq.109.2023.04.03.00.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:13:10 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 20so29274990lju.0;
        Mon, 03 Apr 2023 00:13:10 -0700 (PDT)
X-Received: by 2002:a2e:86d2:0:b0:2a1:d819:f0ae with SMTP id
 n18-20020a2e86d2000000b002a1d819f0aemr10668463ljj.9.1680505990149; Mon, 03
 Apr 2023 00:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230331095545.31823-1-lidaxian@hust.edu.cn> <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
 <d2688eb2-d7b6-4e80-a13e-55ed541ac9b8@kili.mountain>
In-Reply-To: <d2688eb2-d7b6-4e80-a13e-55ed541ac9b8@kili.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Apr 2023 09:12:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2b+GV4+Ee0yQ2hfNCvHaU_jAsnmF28=4ffCmdVy58xg@mail.gmail.com>
Message-ID: <CAMuHMdX2b+GV4+Ee0yQ2hfNCvHaU_jAsnmF28=4ffCmdVy58xg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: renesas-soc: release 'chipid' from ioremap()
To:     Dan Carpenter <error27@gmail.com>
Cc:     Li Yang <lidaxian@hust.edu.cn>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Apr 3, 2023 at 6:29 AM Dan Carpenter <error27@gmail.com> wrote:
> On Fri, Mar 31, 2023 at 02:13:10PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Mar 31, 2023 at 12:14 PM Li Yang <lidaxian@hust.edu.cn> wrote:
> > > Smatch reports:
> > >
> > > drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
> > > 'chipid' from ioremap() not released on lines: 475.
> > >
> > > If soc_dev_atrr allocation is failed, function renesas_soc_init()
> > > will return without releasing 'chipid' from ioremap().
> > >
> > > Fix this by adding function iounmap().
> > >
> > > Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
> > > Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
> > > Reviewed-by: Dan Carpenter <error27@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/soc/renesas/renesas-soc.c
> > > +++ b/drivers/soc/renesas/renesas-soc.c
> > > @@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
> > >         }
> > >
> > >         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > -       if (!soc_dev_attr)
> > > +       if (!soc_dev_attr) {
> > > +               if (chipid)
> > > +                       iounmap(chipid);
> >
> > We don't really care, as the system is dead at this point anyway.
>
> Why even have the check for NULL then?  The kzalloc() is small enough

Because else someone will submit a patch to add that check? ;-)

> to the point where it litterally cannot fail.

I still don't understand how it can be guaranteed that small allocations
never fail... "while (1) kmalloc(16, GFP_KERNEL);"

> This patch is already written, it's way less effort for us to apply it
> than it is to debate its worth.  I kind of feel like it's better to just
> fix the bugs even when they don't affect real life.  Otherwise it's a
> constant debate with bugs if they're worth fixing.
>
> This is a university group and they're looking for bugs to fix.  I'm
> like, "I'm drowning in resource leak warnings and I don't even look at
> them any more because they're basically all trash that no one cares
> about."  So I was hoping to maybe clean up the trash a bit to the point
> where we can start caring about the leaks.

Fair enough.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Perhaps we need a different mechanism to annotate error handling code
that cannot ever happen in a real product, so it can be thrown away by
the compiler, while still pleasing the static checkers?  All these
checks and error handling code do affect kernel size.  There are
Linux products running on SoCs with 8 MiB of internal SRAM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
