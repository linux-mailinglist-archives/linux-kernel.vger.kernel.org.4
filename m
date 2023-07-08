Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2974BDCA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGHOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGHOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA3191;
        Sat,  8 Jul 2023 07:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0212A60CF7;
        Sat,  8 Jul 2023 14:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CF9C433C7;
        Sat,  8 Jul 2023 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826199;
        bh=6C+lcSfpmHU4jzuKfuAovBVJKC42+vBxh4SD5v68bX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5EW3qY9s1W77cvdq8D4mOEW23lzhuJGXiRuFWW4JK3LstckUiMgZ1RbggwsyyHIr
         S4UvsrrhbW+HAJDSqQvVlLrEXItOKGf06y+VQW7hkrFJFuXeFrpgFWnYwn1Ni5MvHk
         ee3VzUcrwK1O6QMxuUbhiEDtoiohFIO/i5eblIjenI3uaajxC45q7kpfkX8eRSuCck
         6uYQsWvrlRCGKTOcH3Y6wgjXEpj3ZndQQu06lNPlSfMQXRkrCynW71spy6lZpEjPCf
         Elpx2895pHYVle8SsY9JnAPoaI7Bm63vtljrSQ6nHHw9zAfFu6MdS7R547MqSjzlb5
         odkG1cfEyWN1g==
Date:   Sat, 8 Jul 2023 15:23:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Alisa Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: Use sysfs_emit_at
Message-ID: <20230708152313.620328bd@jic23-huawei>
In-Reply-To: <9167ba56f8afafa81efb2d5acd84cab0843505e4.camel@gmail.com>
References: <20230620163135.93780-1-alisa.roman@analog.com>
        <9167ba56f8afafa81efb2d5acd84cab0843505e4.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 13:19:49 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-06-20 at 19:31 +0300, Alisa Roman wrote:
> > Replace scnprintf with sysfs_emit_at which is the preferred alternative.
> >=20
> > Also make sure each fractional digit is in its place by padding with
> > zeros up to 3 digits: "...%03d...".
> >=20
> > Signed-off-by: Alisa Roman <alisa.roman@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git. Not that as we are mid merge window
I'll wait to rebase on rc1 before pushing out as togreg. In meantime 0-day =
gets
to see what it can find on this branch as testing.

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7192.c | 5 ++---
> > =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index e23d9a7dcc9e..c980bc871412 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -561,9 +561,8 @@ static ssize_t ad7192_show_filter_avail(struct devi=
ce *dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad7192_get_available_fi=
lter_freq(st, freq_avail);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < ARRAY=
_SIZE(freq_avail); i++)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len +=3D scnprintf(buf + len, PAGE_SIZE - len,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%d.%d ", freq_avail[i] / 1000,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq_avail[i] % 1000);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len +=3D sysfs_emit_at(buf, len, "%d.%03d ", freq_avai=
l[i] / 1000,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq_ava=
il[i] % 1000);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf[len - 1] =3D '\n';
> > =C2=A0 =20
>=20

