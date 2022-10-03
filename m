Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5315F2B72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJCILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJCILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:11:25 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8094072ECD;
        Mon,  3 Oct 2022 00:46:53 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id f26so5909055qto.11;
        Mon, 03 Oct 2022 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=1yjpMK1krEeeplmSYTL0u1hWiSdjZeop0evvtlI1i1w=;
        b=gKphT3q8aKZ1CBoas430JaQonZxkPt1UOXVtN8ECftFOjn7sIDhP7pp1//boL3LNHI
         FHBuUDISphV4WOaBBOpuoDNrVt2Z5YN8V4PZEBFTZmuotQXFm+pu1AdtqISY39YgkMwb
         u+ifaJcDC8wFRoKOkf/dkEwhJLJw0dRiL5KnrtaBXK6lGxZgEISWhCQrMZnFWIxO5DzQ
         906T57oWreM6ex9aF+J/kul9BD4v9E1rLNUp/Pr+9kS4DS+QMtctHicVm5Vrf3MYSIKD
         PufmkPWZADzYdSlcoRrjZDchX0A1M7YUkGBHIAdDR5hGHzutkF2jGDUGaLPeuqEgQNsx
         MKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1yjpMK1krEeeplmSYTL0u1hWiSdjZeop0evvtlI1i1w=;
        b=uiXgTzEFNKROzuEk7uUIEzzgZQcTU0CWuK8km5UdkM9ASi2jfJttvbdI2X+pFke57v
         lEfJuk3wKbZNIey8as1qE/gaFrocZS84M7l865PaB+NiP1tK6w4cXjZyAJHHn5NvUrxe
         U+HjMPqSZmC0RwjxTqWe3G6Tv3icY2AQxWBygBRdLp6XWKeAt3hn5n8FZKzgIQrNpvaT
         Kg9AHaFIDQlKECuDBLEWBob7VOCkfheMtrKZGMTB+TotqQmKBQSnzeAvrg/dkl01RGXT
         +UT1zdxYYWRtPdzmy5G/bM+IZRmxYNZc602HAvglkuZdh+/qTboCxZVn3VdPiCKD8zZL
         wdMg==
X-Gm-Message-State: ACrzQf0BcLF50UGxMNV0yGzL6YG42FCfAX565lqft0mbNXO+uk3nObbV
        29WFzEt8O4oKi1IoCnx2qJJWmL1WykFyLjn8fx4=
X-Google-Smtp-Source: AMsMyM6LlK6ZB7rljg0Mj5bp/ehF6MfiYRFKZ2FmW8R5HOnHagjs+fpqrJi6VpkJvKuLO/RaY082lgiQAqbFVcJsipc=
X-Received: by 2002:ac8:5b95:0:b0:35c:e579:1feb with SMTP id
 a21-20020ac85b95000000b0035ce5791febmr15103919qta.481.1664783034172; Mon, 03
 Oct 2022 00:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663834141.git.cmo@melexis.com> <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
 <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr> <e039d9bd-d2e7-a215-4ec2-7f760e1f83b1@wanadoo.fr>
In-Reply-To: <e039d9bd-d2e7-a215-4ec2-7f760e1f83b1@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Oct 2022 10:43:18 +0300
Message-ID: <CAHp75VcbsE2Smwvpih--7OiMbw3DJeNYAma-prmDLwxqVodwrw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cmo@melexis.com, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 7:11 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 02/10/2022 =C3=A0 18:09, Christophe JAILLET a =C3=A9crit :

...

> >>   static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >>                    struct iio_chan_spec const *channel, int *val,
> >>                    int *val2, long mask)
> >>   {
> >>       struct mlx90632_data *data =3D iio_priv(indio_dev);
> >>       int ret;
> >> +    int cr;
> >
> > This 'cr' seems to be unused.
>
> Ok, used in patch 2/3.
> Sorry for the noise.

But it should be used in this patch if it was introduced by it.

--=20
With Best Regards,
Andy Shevchenko
