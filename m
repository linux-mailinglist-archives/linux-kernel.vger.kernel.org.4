Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965946DE50F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDKTlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:41:39 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3181BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:41:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id u13so9563371ybu.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681242097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0/nKGfHRXrrmiQ4m9sfooa+yv8qI/GDqXMogqLNUhU=;
        b=uasZ0TzAUF47dFaCNSEUylbZBL0w4E9FiQRLljItM/yetIkaHKkDVwzOJ0hT++4aMa
         4mxFHfNtwpFJ4lZ0NPndPHrUkEDITdIxkX+LK61VoLUUyg+aimSZy1ngjVOVo/PFLkAu
         jHEjp+tZDIbo+Oq6m2a/Pfv2c8GLTbaDvZXnPPfsN4/5t1pYH2FlcBjU7Upo9RiMcTZI
         ncJ6T8eYNl6Gt/W8+LKA+8X7SxmYOLK9odrFlln6a/44oDgVxqvnvkMqE3pHNVmKAM1s
         fESeKjSF3uAse8JwEaiNdqg7GpeY3gklIzY/f+KrFdP7A1fDAMtncV0w1P8Lioh4a6ok
         tDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0/nKGfHRXrrmiQ4m9sfooa+yv8qI/GDqXMogqLNUhU=;
        b=aarBGcIEaXqFimPbXJl2QhH1A17HSwEFrBRjE4QpslJ1tO6IchilxSQk8Qv7WQeaHL
         LMvpIAvU44I9YEgRBzRP98BFQd+A9GjYTVbKZWf7/Y+C3cb1H60k94giFsWqm7q7fu2z
         m/MYMCY9ELTp0VEsZzthwwLtJC8LxeXf0OA8af+TCZV/bIJ+GrJu545mHpJQqnYBOUfm
         Gt8YDVsh/aw2edYRPXSTh8nPFiCidDenONiZTV9dkWzuRLQvWvj0wS25HvXh1f6l0MZs
         +NM6GD9BitGaJFVXKNHUBQBapsDUlJ1bXM/ZEx1FMsFJrrgVXQnRiyHjuVC+JNyRNHhj
         VcJg==
X-Gm-Message-State: AAQBX9eqVUlK68JPkyO556BZ002KkiZta8PeyYLX2ikWtmC4kmhPVkJj
        pyOa6TyVPdMxzN9jcYBlS6LCVkLFp9Wo8TZc8w7aM+RFl00uingX4LJFng==
X-Google-Smtp-Source: AKy350ZCxLrwLdbIRMaiN+D+H/Z4jUhovrtlxvEbFVwv6ZHSQ/CF2XFz7SZG2BHt7UN8YukL82Q95FFwLFmziVlPU14=
X-Received: by 2002:a25:3354:0:b0:b8e:f726:d198 with SMTP id
 z81-20020a253354000000b00b8ef726d198mr3848780ybz.8.1681242096534; Tue, 11 Apr
 2023 12:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com> <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com> <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com> <20230411150916.24vagjzbhshaujse@mobilestation>
 <ZDV6FKd/TupHEPMf@smile.fi.intel.com> <CAOSNQF3JQKVgvp5M17SzeyF5LB85_ZvkRpp3PZkCYcGcqm8V2g@mail.gmail.com>
 <ZDWJJaYauhOl0Iue@smile.fi.intel.com>
In-Reply-To: <ZDWJJaYauhOl0Iue@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Wed, 12 Apr 2023 01:11:23 +0530
Message-ID: <CAOSNQF2dxwbCa7_MrN-qd5mrK9jfpaakeExuMBwctXbsQGmiJQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 11, 2023 at 08:48:52PM +0530, Joy Chakraborty wrote:
> > On Tue, Apr 11, 2023 at 8:47=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote:
> > > > On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> > > > > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote=
:
> > > > > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wro=
te:
>
> ...
>
> > > > > > > > -     if (n_bytes =3D=3D 1)
> > > > > > > > +     switch (n_bytes) {
> > > > > > > > +     case 1:
> > > > > > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > > > > -     else if (n_bytes =3D=3D 2)
> > > > > > > > +     case 2:
> > > > > > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > > > > -
> > > > > > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > >
> > > > > > > > +     case 3:
> > > > > > >
> > > > > > > I'm not sure about this.
> > > > > >
> > > > > > This actually makes sense seeing the function argument can have=
 values
> > > > > > 1, 2, _3_ and 4:
> > > > > > dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER=
_BYTE);
> > > > > > transfer->bits_per_word =3D __F__(master->bits_per_word_mask =
=3D SPI_BPW_RANGE_MASK(4, 32));
> > > > > > ...
> > > > > > dw_spi_dma_convert_width(dws->n_bytes)
> > > > > >
> > > > > > The spi_transfer.bits_per_word field value depends on the
> > > > > > SPI peripheral device communication protocol requirements which=
 may
> > > > > > imply the 3-bytes word xfers (even though it's indeed unluckily=
).
> > > > > >
> > > > > > This semantic will also match to what we currently have in the
> > > > > > IRQ-based SPI-transfer implementation (see dw_writer() and
> > > > > > dw_reader()).
> > > >
> > > > > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that.=
 Why we don't
> > > > > use it?
> > > >
> > > > We could but there are two more-or-less firm reasons not to do
> > > > that:
> > > > 1. There aren't that much DMA-engines with the
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SSI just
> > > > ignores the upper bits if CTRLR0.DFS is less than the value actual
> > > > written to the DR registers. Note DW DMAC engine isn't one of such
> > > > controllers. So if we get to meet a peripheral SPI-device with 3-by=
tes
> > > > word protocol transfers and the DMA-engine doesn't support it the
> > > > DMA-based transfers may fail (depending on the DMA-engine driver
> > > > implementation).
> > > > 2. The DW APB SSIs (3.x and 4.x) can be synthesized with the APB Da=
ta
> > > > Bus Width of 8, 16 and 32. So no matter whether DMA-engine supports
> > > > the 3-bytes bus width the system bus most likely will either conver=
t
> > > > the transfers to the proper sized bus-transactions or fail.
> > > >
> > > > So taking all of the above into account not using the
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using it wi=
th
> > > > a risk to fail some of the platform setups especially seeing the DW
> > > > APB SSI ignores the upper bits anyway.
> > >
> > > But this is not about SPI host hardware, it's about the consumers.
> > > They should know about supported sizes. Either we add the correspondi=
ng support
> > > to the driver or remove 3 case as I suggested. I don't think it's cor=
rect to
> > > use 3 as 4.
> >
> > Another thing to add is that as per spi.h even if bits per word is a
> > not a power of 2 the buffer should be formatted in memory as a power
> > of 2
> > ...
> >  * @bits_per_word: Data transfers involve one or more words; word sizes
> >  * like eight or 12 bits are common.  In-memory wordsizes are
> >  * powers of two bytes (e.g. 20 bit samples use 32 bits).
> >  * This may be changed by the device's driver, or left at the
> >  * default (0) indicating protocol words are eight bit bytes.
> >  * The spi_transfer.bits_per_word can override this for each transfer.
> > ...
> > Hence for n_bytes =3D 3 or 24 bits/per word we expect the client SW to
> > format it to 4 byte buffers hence the transaction generated should
> > also be of size 4 from the DMA.
>
> You didn't get my point. The consumer wants to know if the 3 bytes is sup=
ported
> or not, that's should be part of the DMA related thing, right?
>
> It's incorrectly to say 4 for 3 if the backend DMA controller behaves dif=
ferently
> on this. How do you know that (any) DMA controller integrated with this h=
ardware
> has no side effects for this change.
>
> So, I don't think the case 3 is correct in this patch.

I see, I am of the opposite opinion in this case.

Other then Serge(y)'s points,
I was trying to say that irrespective of what the underlying DMA
controller supports we should use DMA_SLAVE_BUSWIDTH_4_BYTES when
n_bytes =3D 3 from SPI perspective as we get n_bytes from bits per word
passed by the client / spi framework " dws->n_bytes =3D
DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) ".
Based on the spi header what I perceive is that for bits/word between
17 and 32 the data has to be stored in 32bit words in memory as per
the example in the header " (e.g. 20 bit samples use 32 bits) ".

Hence, taking an example to transfer 6 bytes (say 0xAA 0xBB 0xCC 0xDD
0xEE 0xFF) with bits per word as 24 (n_bytes =3D 3) i.e. a total of 2
words I expect the buffer to look as follows which is coming from the
client:
_ _____address|__________0________4________8________C
    SD:00000000|>00CCBBAA 00FFEEDD 00000000 00000000
Hence to transfer this successfully the DMA controller would need to
copy 4 bytes per word .

Please correct me if my understanding of this is incorrect.

>
> > > > > > > > +     case 4:
> > > > > > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > > > > +     default:
> > > > > > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Thanks
Joy
