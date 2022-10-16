Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2137600130
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJPQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJPQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FD33A3F;
        Sun, 16 Oct 2022 09:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1CF60C09;
        Sun, 16 Oct 2022 16:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85038C433C1;
        Sun, 16 Oct 2022 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665937213;
        bh=AgVSNbatKbAkQGmFAvT/IFaVkqfFzNcZFfDPKtG6bw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iX9aoEMqfOqbMhl7M4M6YWClK64w6MB8/oG4wdpNNqsmwjgVZCZ8MAqw2+7H8ircl
         /Z6r+Bb1icIImi/e0bqXGJRBZ1HUkRWqoZIM/s7dlWy6XUrF79SBoytLQSndOjkbpq
         dGXRHeA5LlSao5Tj3IVrKujyo+3WoGfW2kojeLkCzKnRHEpZR+TlfHDsE4yE+o6MWz
         y1lCiu5q3VZeRuhddL+HESWGskkb+nymPiZb8cedGoJ5KR0bcxetvojhFNzvIrwQvC
         aFla9vRXwW3CzsTBD1kAn+ay5HbCKt7AK/y3ayVS6SjV26HgOn7x9/YBWGgaYQP28g
         ABdv/c40cwFCQ==
Date:   Sun, 16 Oct 2022 17:20:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Message-ID: <20221016172041.2c7fa721@jic23-huawei>
In-Reply-To: <SN4PR03MB678490A2B25A8B2E38EA99B399799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
        <SN4PR03MB678420C67AA8988CF706198399799@SN4PR03MB6784.namprd03.prod.outlook.com>
        <44f05a0b-01a7-775d-606c-d2f0ab94ae6e@gmail.com>
        <SN4PR03MB678490A2B25A8B2E38EA99B399799@SN4PR03MB6784.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 13:55:38 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > Sent: Tuesday, August 30, 2022 3:00 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>; Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 14/14] iio: hmc425a: simplify using
> > devm_regulator_get_enable()
> >=20
> > [External]
> >=20
> > On 8/30/22 14:49, Sa, Nuno wrote: =20
> > > =20
> > >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> > >> Sent: Friday, August 19, 2022 9:21 PM
> > >> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> > >> <matti.vaittinen@fi.rohmeurope.com>
> > >> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > >> <Michael.Hennerich@analog.com>; Jonathan Cameron
> > >> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> > >> kernel@vger.kernel.org
> > >> Subject: [PATCH v3 14/14] iio: hmc425a: simplify using
> > >> devm_regulator_get_enable()
> > >>
> > >> [External]
> > >>
> > >> Drop open-coded pattern: 'devm_regulator_get(), =20
> > regulator_enable(), =20
> > >> add_action_or_reset(regulator_disable)' and use the
> > >> devm_regulator_get_enable() and drop the pointer to the =20
> > regulator. =20
> > >> This simplifies code and makes it less tempting to add manual =20
> > control =20
> > >> for the regulator which is also controlled by devm.
> > >>
> > >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >>
> > >> --- =20
> > >
> > > Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >
> > > (I see that in this patch you are not using dev_err_probe(). Maybe =20
> > some =20
> > > consistency in the series and where applicable would be appropriate =
=20
> > :))
> >=20
> > I don't think the driver did originally print an error if regulator get
> > or enable failed. I didn't want to add any new prints - just converted
> > the existing ones to use dev_err_probe(). I believe adding new prints
> > would've been somewhat unrelated change :)
> >  =20
>=20
> Ahh that makes sense. I failed to see the print that you were replacing
> in the ad7606 patch...
>=20
Applied to the togreg branch of iio.git though for now that's just pushed
out as testing.

As I mentioned on an earlier patch I forgot these existed and was about
to duplicate some of the work..  Anyhow, we only overlapped on a few
patches so I'll send the rest of my set out shortly.

There are probably other cases still in IIO but they are fiddly to grep
for!

Jonathan
> - Nuno S=C3=A1

