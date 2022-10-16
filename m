Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DB60011D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJPQPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJPQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:15:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B13B15A33;
        Sun, 16 Oct 2022 09:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C0C4CE0B75;
        Sun, 16 Oct 2022 16:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF06C433C1;
        Sun, 16 Oct 2022 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665936900;
        bh=x3CwrcunJNuG98FQOYXz8XlmpGAm0KMCZ85BHWC6tE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nEJaXWhhd2AbXxqTB/M3bbJkH+pMZqcec9yhNtf8IaI6Zn1gGTE/tK20yBFZWBHqb
         GOITFK2LHrHlOwmtkhIzIioUzZNViQvXaOK88LFvZLU2SqGZElO2e6GwNKwLJCvbJS
         pqT+gyW+R3UqcYSutZand2saPmIBsWe3yNAnjm3ND1dvAE1osvSAqNiwxX2aPahYU2
         LuxRP4hR7GkHEalI62xPxkzqmECdRy/HLgPI93Ld3WcKoq7bG0QC/c9i1KTRn78AHA
         DqMik2H4GbUi6MPDi/Ql0Pj47+KILZjKfarosKN8PuP2vGnIogauCpMZNZz57/wAGG
         n0rWeBRoALFRQ==
Date:   Sun, 16 Oct 2022 17:15:29 +0100
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
Message-ID: <20221016171520.07506844@jic23-huawei>
In-Reply-To: <0aaeb018-94ba-eaaa-4000-7ad082a09850@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
        <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
        <0aaeb018-94ba-eaaa-4000-7ad082a09850@gmail.com>
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

On Tue, 30 Aug 2022 15:54:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks for the review(s) Nuno!
>=20
> On 8/30/22 14:46, Sa, Nuno wrote:
> >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Sent: Friday, August 19, 2022 9:20 PM
> >> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> >> <matti.vaittinen@fi.rohmeurope.com>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> >> <Michael.Hennerich@analog.com>; Jonathan Cameron
> >> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> >> kernel@vger.kernel.org
> >> Subject: [PATCH v3 11/14] iio: ad7606: simplify using
> >> devm_regulator_get_enable()
> >>
> >> [External]
> >>
> >> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> >> add_action_or_reset(regulator_disable)' and use the
> >> devm_regulator_get_enable() and drop the pointer to the regulator.
> >> This simplifies code and makes it less tempting to add manual control
> >> for the regulator which is also controlled by devm.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> --- =20
> >=20
> > The commit message could state that while doing the change, dev_err_pro=
be()
> > was also introduced. Bah, anyways:
> >=20
> > Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Good point. I have few other changes to the series pending - and I=20
> probably need to rebase/respin when -rc1 is out (and dependency patches=20
> are merged from Mark's tree) =3D> I may as well alter the commit message.
>=20
I tweaked it and applied.

Not I'm grabbing these early because I forgot you'd sent them and
found myself writing the same patches.  Memory of a goldfish :)

Jonathan

> Yours,
> 	-- Matti
>=20

