Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFA6F3263
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjEAPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjEAPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75619109;
        Mon,  1 May 2023 08:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 045CB6155E;
        Mon,  1 May 2023 15:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D549AC433EF;
        Mon,  1 May 2023 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682953199;
        bh=oIbyg+1zc4Iqoh6xK0LuuT7HCKaLEf4UWG79FvxayeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pkGDLrAcRV9sDcO5GOXP2vrd+LtOwI/heSpxXQG2IPdgtRphRxGWnnDETxMZ6xDzX
         A+MKACYd7KEMZ0sV6dWeZQc5xtTrxa9MPr0hTyWQP3aZ7xM+p+NS9VQyADYNdWE38Q
         lEVffXGX+b5QFpNUjJFY6LGF0G5FKVW7mb1fDtX/Y7ET8XtXqMODb4q8tCh3mNccA6
         5u0xw4S2Xx7J+ZWZeMqpxgeMvd0eqHUamxzHIrnQ4K5KHO6ocKxRwN6gyrIXTPcU80
         olHs1znUrkFHCjADFjkQ9ppDhznYSh7PLuJ2O5+fAbDN3w/TZj7qIFLvLUdbpvBqcW
         uKHgunwQTpX7A==
Date:   Mon, 1 May 2023 16:15:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <20230501161543.25156692@jic23-huawei>
In-Reply-To: <20230424095041.540be943@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-3-herve.codina@bootlin.com>
        <20230422174916.74ccfe00@jic23-huawei>
        <20230424095041.540be943@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consume=
r.h
> > > index 6802596b017c..956120d8b5a3 100644
> > > --- a/include/linux/iio/consumer.h
> > > +++ b/include/linux/iio/consumer.h
> > > @@ -297,6 +297,17 @@ int iio_write_channel_raw(struct iio_channel *ch=
an, int val);
> > >   */
> > >  int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
> > > =20
> > > +/**
> > > + * iio_read_min_channel_raw() - read minimum available raw value fro=
m a given
> > > + *				channel, i.e. the minimum possible value.
> > > + * @chan:		The channel being queried.
> > > + * @val:		Value read back.
> > > + *
> > > + * Note raw reads from iio channels are in adc counts and hence
> > > + * scale will need to be applied if standard units are required.   =
=20
> >=20
> > Hmm. That comment is almost always true, but not quite.  Not related to
> > your patch but some cleanup of this documentation and pushing it down n=
ext
> > to implementations should be done at some point.  If anyone is really
> > bored and wants to take this on that's fine. If not, another one for the
> > todo list ;) =20
>=20
> If you are ok, I can change every where in consumer.h the following:
>   * Note raw reads from iio channels are in adc counts and hence
>   * scale will need to be applied if standard units required.
> by
>   * Note raw reads from iio channels are not in standards units and
>   * hence scale will need to be applied if standard units required.

If going to the effort, we should include offset and make it clear how
they are applied.

    * Note, if standard units are required, raw reads from iio channels
    * need the offset (default 0) and scale (default 1) to be applied
    * as (raw + offset) * scale.
=20

>=20
> Also the same for raw writes:
>   * Note raw writes to iio channels are in dac counts and hence
>   * scale will need to be applied if standard units required.
> by
>   * Note raw writes to iio channels are not in standards units and
>   * hence scale will need to be applied if standard units required.
This one is more interesting because you kind of need to apply the opposite
logic. Perhaps text such as.

    * Note that for raw writes to iio channels, if the value provided is
    * in standard units, the affect of the scale and offset must be removed
    * as (value / scale) - offset.

My slight concern is that we'll spend longer arguing about these comments
than we spend on the rest of the patch set.  Might be worth delaying
fixing the others for a separate series after this one.

Jonathan

>=20
> >  =20
> > > + */
> > > +int iio_read_min_channel_raw(struct iio_channel *chan, int *val);
> > > +
> > >  /**
> > >   * iio_read_avail_channel_raw() - read available raw values from a g=
iven channel
> > >   * @chan:		The channel being queried.   =20
> >  =20
>=20
> Thanks for the review,
> Herv=C3=A9
>=20

