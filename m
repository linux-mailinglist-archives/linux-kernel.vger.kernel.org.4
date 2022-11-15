Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8626292FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiKOILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKOILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:11:19 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138386306;
        Tue, 15 Nov 2022 00:11:19 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id l2so8287608qtq.11;
        Tue, 15 Nov 2022 00:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5FBxs387xMLJ6FEoMsoqjFKDtcBxbziSzdRL5iwuys=;
        b=TfNVDH++H/2O4XnnGN57gJqrIm33Sk/yze7NMVJbmDiu0iN+C2YWM+0bqVqtyKSNGU
         mrPaCtmz5quYCawZv3vF4JaRQLPX7uIV8iEgyETuXFZzmiKUUNPbD0LQzwgIIJPV07cj
         Lq2NHzWaS7rDsPvrFnUz5b51sYOpRT5oSmWHF/zPLNwUeZj85OsIe7RoXMt15295B5pU
         /ZmF35Ykl3e/+k8LLfgfn2RpqMp+IEOYBNYuv9sLcg55bxnFdy1iaKCCCJqYoa3N6MNw
         FZsG0xXgMczov+HYgqTsC7RAac3m248Kq8VwFkGBbS9+eZ2e0mp/QZtiVyUR8f7Havib
         YGTA==
X-Gm-Message-State: ANoB5pmnVoWZedjeEIsyaoBcBtMLDCUzzmP0L2Vi1D1xrxWN7mu2MdMs
        1rMfFz3hlNxZ/70XuhaiCMVqUERfyYArTw==
X-Google-Smtp-Source: AA0mqf4Uw/UUM/BSeIkiWx9y2o+mCGPKTEulqbd96UUlNLMpOGoYsFgpWSxpVxi51Mcpk36VyKwEmA==
X-Received: by 2002:a05:622a:1982:b0:3a5:7de1:9708 with SMTP id u2-20020a05622a198200b003a57de19708mr15676723qtc.616.1668499878064;
        Tue, 15 Nov 2022 00:11:18 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id b13-20020ac86bcd000000b003a57a317c17sm6840125qtt.74.2022.11.15.00.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:11:17 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-381662c78a9so49120897b3.7;
        Tue, 15 Nov 2022 00:11:17 -0800 (PST)
X-Received: by 2002:a81:4ed2:0:b0:370:202b:f085 with SMTP id
 c201-20020a814ed2000000b00370202bf085mr16147843ywb.502.1668499877212; Tue, 15
 Nov 2022 00:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
 <OS0PR01MB59224DF03590185EFD5AF91386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592239F10E9C768888F41D1786049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592239F10E9C768888F41D1786049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 09:11:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzNA7CP1zGHSEMK9Jo+76fzEkZ+RXa7ecL0HD4y2gfMg@mail.gmail.com>
Message-ID: <CAMuHMdUzNA7CP1zGHSEMK9Jo+76fzEkZ+RXa7ecL0HD4y2gfMg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Tue, Nov 15, 2022 at 8:48 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > -----Original Message-----
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Mon, Nov 14, 2022 at 7:42 PM Biju Das
> > <biju.das.jz@bp.renesas.com> wrote:
> > > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > > On RZ/Five SoC it was observed that setting timeout (to say 1
> > sec)
> > > > > wouldn't reset the system. To fix this we make sure we issue a
> > > > > reset before putting the PM clocks to make sure the registers
> > have
> > > > > been
> > > cleared.
> > > > >
> > > > > While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout()
> > as
> > > > > we were calling the same functions here.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > > Note,
> > > > > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > > > > - My initial investigation showed adding the delay after
> > > > > pm_runtime_get_sync()
> > > > >   also fixed this issue.
> > > > > - Do I need add the fixes tag ? what should be the operation
> > PUT-
> > > > > >RESET/RESET->PUT?
> > > >
> > > > It looks like timing issue, None of the previous devices are
> > > > affected by
> > > this.
> > >
> > > To me it looks like the device must be clocked for the reset signal
> > to
> > > be propagated?
> >
> > Yep, provide clk supply for a device, then apply reset.
>
> Maybe we need to make it consistent by taking care of  [1]
>
> Current patch: CLK ON -> apply Reset for V2M.
> [1]:  Apply Reset -> CLK ON for V2M.

Yes, that would also simplify that patch: just add the call to reset?

> [1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUWbT6VArm9B56VE0yUYWCTm=3vMGrrONSv9cdsQQnhpg@mail.gmail.com/T/#mdb78503524a8f4207f59a40f7ff573e210656988

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
