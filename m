Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A406FAC20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjEHLVC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjEHLVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:21:01 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E038F17;
        Mon,  8 May 2023 04:20:59 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b983027d0faso5837421276.0;
        Mon, 08 May 2023 04:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683544858; x=1686136858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqPuvzTIAAJR3gQFU7iaBnW2r3ZRs4kyF5A1wshu+4w=;
        b=RE3CaHLAz1GjslzY5aVdF4nG1AleGR+aGRbssgdyqIFm55tSWE5iP26KlpQLkB9o4P
         uDoeyOWFEZI00m7ndO5F5mMC0zeVU48FdRdq5fK86KVur13eigN6WgfqAhoAO8BczjYl
         dCRjyWxpEcQBBEZVo9WOvP2DwPR+FwLuOmIVxc4gIZnp/SkQ1jms0jvUACHix+AT5NJV
         mkCzZhwcHx67xZWmiVcmzR7gTxH8Vf0pcgkmOhOJf3xdGfJJiUWPIfBpu5jRFshuG/+j
         YhP23OQgpK+70SqLlIcepQp5r3886XG+GXrPpbe5MoSHHKj6BHc/8rgUlQBmxcsY3ojS
         NLEQ==
X-Gm-Message-State: AC+VfDxkZg9QQ6jVwO+DgbBG/IZsdJ9gT53u1TFN3YEACEpVut+wsfps
        +Ve1HGoMqUT71e0jeW9cohNej07pX/kMGA==
X-Google-Smtp-Source: ACHHUZ5EZaPJvLwmge7dGQfRYmrzG90X+ko+Gln9tCbbU/0dIooUSZNDhGjMsKYW+e1XW4Sja6NCUQ==
X-Received: by 2002:a0d:d695:0:b0:55a:da:8d1a with SMTP id y143-20020a0dd695000000b0055a00da8d1amr11252349ywd.36.1683544857933;
        Mon, 08 May 2023 04:20:57 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i135-20020a0ddf8d000000b00555c30ec361sm2392514ywe.143.2023.05.08.04.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:20:57 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so5831821276.3;
        Mon, 08 May 2023 04:20:57 -0700 (PDT)
X-Received: by 2002:a25:4284:0:b0:b8f:490c:a0db with SMTP id
 p126-20020a254284000000b00b8f490ca0dbmr11119868yba.59.1683544857295; Mon, 08
 May 2023 04:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-2-contact@artur-rojek.eu> <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
 <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
In-Reply-To: <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 13:20:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
Message-ID: <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg` macros
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

On Sun, May 7, 2023 at 11:43 AM Artur Rojek <contact@artur-rojek.eu> wrote:
> On 2023-05-07 10:39, John Paul Adrian Glaubitz wrote:
> > On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> >> Squash two bugs introduced into said macros in 7f47c7189b3e,
> >> preventing
> >> them from proper operation:
> >> 1) Add DMAOR register offset into the address of the hw reg access,
> >> 2) Correct a nasty typo in the DMAOR base calculation for
> >>    `dmaor_write_reg`.
> >>
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>\

Thanks for your patch!

> >> --- a/arch/sh/drivers/dma/dma-sh.c
> >> +++ b/arch/sh/drivers/dma/dma-sh.c
> >> @@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct
> >> dma_channel *chan)
> >>   * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
> >>   * channels 0 - 5, DMAOR1 6 - 11 (optional).
> >>   */
> >> -#define dmaor_read_reg(n)           __raw_readw(dma_find_base((n)*6))
> >> -#define dmaor_write_reg(n, data)    __raw_writew(data,
> >> dma_find_base(n)*6)
> >> +#define dmaor_read_reg(n)           __raw_readw(dma_find_base((n) * 6) + \
> >> +                                                DMAOR)
> >> +#define dmaor_write_reg(n, data)    __raw_writew(data, \
> >> +                                                 dma_find_base((n) * 6) + \
> >> +                                                 DMAOR)

Fixes: 7f47c7189b3e8f19 ("sh: dma: More legacy cpu dma chainsawing.")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> >>  static inline int dmaor_reset(int no)
> >>  {
> >
> > I have looked through the changes and the code and I agree that there
> > is a typo
> > in dmaor_write_regn() that needs to be fixed and that the DMAOR offset
> > is missing
> > although I don't understand why that didn't break the kernel on other
> > SuperH systems
> > such as my SH-7785LCR evaluation board or the LANDISK board which Geert
> > uses.
>
> I also wondered that. On SH7709 it's a hard panic, it should be the same
> elsewhere.

Landisk does not seem to use DMA.
I did have CONFIG_SH_DMA=n, but enabling it does not make any difference.

> > What I also don't understand is the factor 6 the DMA channel number is
> > multiplied
> > with. When looking at the definition of dma_find_base(), it seems that
> > every channel
> > equal to 6 or higher will return SH_DMAC_BASE1 as DMA base address.
> > But if we multiply
> > the parameter with 6, this will apply to every n > 0. Is that correct?
>
> As confusing as they look, those macros take dmaor index (a number in
> range 0 <= n < NR_DMAOR) as parameter, then multiply it by 6 to convert
> it to a format compatible with `dma_find_base` (which expects a channel
> index). In practice `n` will be either 0 or 1, so dma_find_base(0 * 6)
> will return SH_DMAC_BASE0, while dma_find_base(1 * 6) SH_DMAC_BASE1.

Looks like this is still broken on e.g. SH7751R, which has 8 channels,
both handled by a single DMAOR register at offset 0x40...

While e.g. dma_base_addr() seems to have some provision for this
(cfr. the "chan >= 9" (not "8") check), dma_find_base() will fail, as
arch/sh/include/cpu-sh4/cpu/dma.h defines SH_DMAC_BASE1.
Anyway, that's not new, so I have no objection to your patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
