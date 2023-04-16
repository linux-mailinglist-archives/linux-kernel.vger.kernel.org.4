Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14366E37D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDPMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDPMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:02:22 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E572691;
        Sun, 16 Apr 2023 05:02:21 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id l16so739981vst.2;
        Sun, 16 Apr 2023 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681646541; x=1684238541;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHFyNrT1VfxBGxS1NMERI8Qt8lLflFfoWypKZafbriw=;
        b=Gr2CwbikwHB7A59r50sarUS2CH/dcuZbg4pEeTnK59LgL4W7cobcQfIca5jvAormlP
         h6gTpxoetqb3fawVvKobCLEzru3gi5FuEkzkSC9uVFdrsUOk5QAkYltNOkyvqpEt1ke+
         uGpUhG3L8gWRiUUZUR6ooDa0dr8FsdXvHxUVH+zUBY4/tp0NDNW4dxxgvuVmkPi6MOjZ
         tqrqlMKQVzErFtbzkNwmjKPRnlLDmrqfK/H9qjDVk1ZUjHDvM4WMoKQjPNL0ummH2raU
         vE7Osg1VB8voInyqCVHKG74Ih+C4eSAeVCXPdM42sMLQudrqo9yCJdiGq40ArW1TCGdm
         eGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681646541; x=1684238541;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHFyNrT1VfxBGxS1NMERI8Qt8lLflFfoWypKZafbriw=;
        b=O5VJQsRdGYBVOTKUgJIx6txaRo8MfnnKcDBQJ2cJblJyCBYs1YUBIVQYmngPHu4LpX
         pwR/fXujSW5G3GS87i92zwzluO9+vu8ImDMmGE2dCSCO/uNNzfTrBMt/TB74zQtF2OZN
         Y8Pmx0NkB+bx82eIWL32MVZl0efecuZnIFQQR2BKpjFNzWRjdnpNNvZWxTl2lttC1oQ7
         93VNN+vvgWMn/on7YTX+1SDLGONWqObM40lEUFH7shDXeGaBn/BXZdw/FwqcEDPNQQzh
         THdf0p35Et2m8KCzEtQsSwWjdzP/Elup7gQYHS87zZwlwlZ558CNkrgZfcstBSSLll/v
         c5iQ==
X-Gm-Message-State: AAQBX9ePOBp4XqAVIlhbzRbk8s3Uhzv+eBW86jSXYq25X45lcjC7pPCt
        dG9kz+N9Ygodbkd1VRZB3aCAoqu7LtjUCMwcgyk=
X-Google-Smtp-Source: AKy350Zmj6n67b5JoT7QDdrHXZ0P69Lsbok+9BzxR0RWe5YRsQ3pdDepaoDW9z26tcvAPd3ulKZrXU63nEHFr9rD+ds=
X-Received: by 2002:a67:d715:0:b0:42c:3bcf:f927 with SMTP id
 p21-20020a67d715000000b0042c3bcff927mr6800346vsj.4.1681646540836; Sun, 16 Apr
 2023 05:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230305212519.499-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20230305212519.499-1-yongsuyoo0215@gmail.com>
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
Date:   Sun, 16 Apr 2023 21:02:09 +0900
Message-ID: <CANXPkT4QS1OO_BW5xWguNxa3jXVjwfFTxPmHYAYT=+MRc-FZOg@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_demux: Fix a bug for the continuity counter
To:     0215yys@hanmail.net, yongsu.yoo@lge.com, mchehab@kernel.org,
        tommaso.merciai@amarulasolutions.com, yongsuyoo0215@gmail.com,
        hverkuil-cisco@xs4all.nl, colin.i.king@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ~ Everyone
Can you share how this patch is going ?

2023=EB=85=84 3=EC=9B=94 6=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:25, <y=
ongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: YongSu Yoo <yongsuyoo0215@gmail.com>
>
> Signed-off-by: Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> In dvb_demux.c, some logics exist which compare the expected
> continuity counter and the real continuity counter. If they
> are not matched each other, both of the expected continuity
> counter and the real continuity counter should be printed.
> But there exists a bug that the expected continuity counter
> is not correctly printed. The expected continuity counter is
> replaced with the real countinuity counter + 1 so that
> the epected continuity counter is not correclty printed.
> This is wrong. This bug is fixed.
> ---
>  drivers/media/dvb-core/dvb_demux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/=
dvb_demux.c
> index 398c86279b5b..7c4d86bfdd6c 100644
> --- a/drivers/media/dvb-core/dvb_demux.c
> +++ b/drivers/media/dvb-core/dvb_demux.c
> @@ -115,12 +115,12 @@ static inline int dvb_dmx_swfilter_payload(struct d=
vb_demux_feed *feed,
>
>         cc =3D buf[3] & 0x0f;
>         ccok =3D ((feed->cc + 1) & 0x0f) =3D=3D cc;
> -       feed->cc =3D cc;
>         if (!ccok) {
>                 set_buf_flags(feed, DMX_BUFFER_FLAG_DISCONTINUITY_DETECTE=
D);
>                 dprintk_sect_loss("missed packet: %d instead of %d!\n",
>                                   cc, (feed->cc + 1) & 0x0f);
>         }
> +       feed->cc =3D cc;
>
>         if (buf[1] & 0x40)      // PUSI ?
>                 feed->peslen =3D 0xfffa;
> @@ -300,7 +300,6 @@ static int dvb_dmx_swfilter_section_packet(struct dvb=
_demux_feed *feed,
>
>         cc =3D buf[3] & 0x0f;
>         ccok =3D ((feed->cc + 1) & 0x0f) =3D=3D cc;
> -       feed->cc =3D cc;
>
>         if (buf[3] & 0x20) {
>                 /* adaption field present, check for discontinuity_indica=
tor */
> @@ -336,6 +335,7 @@ static int dvb_dmx_swfilter_section_packet(struct dvb=
_demux_feed *feed,
>                 feed->pusi_seen =3D false;
>                 dvb_dmx_swfilter_section_new(feed);
>         }
> +       feed->cc =3D cc;
>
>         if (buf[1] & 0x40) {
>                 /* PUSI=3D1 (is set), section boundary is here */
> --
> 2.17.1
>
