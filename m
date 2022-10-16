Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615C600147
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJPQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJPQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:25:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270D17A9D;
        Sun, 16 Oct 2022 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52D23B80D0F;
        Sun, 16 Oct 2022 16:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B61C433C1;
        Sun, 16 Oct 2022 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665937470;
        bh=eRghN2lZHqfpOgRLupDxS556SB1xyrwitdm1QMOWL08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r5IQBskBZgdRbPpks4rWPq69dRt6D0V1SahdsL0D2tjU8vXInppctABKlUP0f7o0t
         3G6NH9Dy/UrzGk8bNTsEjGRGhf6ik52e5a5IZAJ5TgDcThv8qmVNwZkln2C9LorfrR
         jz82uKgacoYniiE8iBIBsPz7w6l473Nyjkh9Qb61Skc/Eln+OGy3ZjWnP9RkXbJlAD
         4esp0VasIFYkJ+Sy9l3V4dsQxXAp1kj4KneV/rcuAJ6xPrBGTPpyjAnFa1iBxpSmgI
         x0tn85sCcJ3/2Wc6KGlY4oQT7eC45Pb6CWkmbVYxywPRg9rq78B6DStM+3/Opf1xno
         ezy0vxA5AhqTQ==
Date:   Sun, 16 Oct 2022 17:24:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Message-ID: <20221016172457.6637c888@jic23-huawei>
In-Reply-To: <20221016171520.07506844@jic23-huawei>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
        <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
        <0aaeb018-94ba-eaaa-4000-7ad082a09850@gmail.com>
        <20221016171520.07506844@jic23-huawei>
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

On Sun, 16 Oct 2022 17:15:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 30 Aug 2022 15:54:07 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>=20
> > Thanks for the review(s) Nuno!
> >=20
> > On 8/30/22 14:46, Sa, Nuno wrote: =20
> > >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> > >> Sent: Friday, August 19, 2022 9:20 PM
> > >> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> > >> <matti.vaittinen@fi.rohmeurope.com>
> > >> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > >> <Michael.Hennerich@analog.com>; Jonathan Cameron
> > >> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> > >> kernel@vger.kernel.org
> > >> Subject: [PATCH v3 11/14] iio: ad7606: simplify using
> > >> devm_regulator_get_enable()
> > >>
> > >> [External]
> > >>
> > >> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> > >> add_action_or_reset(regulator_disable)' and use the
> > >> devm_regulator_get_enable() and drop the pointer to the regulator.
> > >> This simplifies code and makes it less tempting to add manual control
> > >> for the regulator which is also controlled by devm.
> > >>
> > >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >>
> > >> ---   =20
> > >=20
> > > The commit message could state that while doing the change, dev_err_p=
robe()
> > > was also introduced. Bah, anyways:
> > >=20
> > > Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>   =20
> >=20
> > Good point. I have few other changes to the series pending - and I=20
> > probably need to rebase/respin when -rc1 is out (and dependency patches=
=20
> > are merged from Mark's tree) =3D> I may as well alter the commit messag=
e.
> >  =20
> I tweaked it and applied.
>=20
> Not I'm grabbing these early because I forgot you'd sent them and
> found myself writing the same patches.  Memory of a goldfish :)

Tweaked a little more - you missed that the struct in the header had
kernel-doc for the struct regulator *.  Dropped that.

>=20
> Jonathan
>=20
> > Yours,
> > 	-- Matti
> >  =20
>=20

