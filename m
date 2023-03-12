Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DAC6B685F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCLQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCLQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676E22028;
        Sun, 12 Mar 2023 09:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C1E60F72;
        Sun, 12 Mar 2023 16:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EFDC433EF;
        Sun, 12 Mar 2023 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678639528;
        bh=v3YW+tOhU6NvghcU8ePtg4xxv5KLn6KJH5+dYosdrs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YxEhMVNmplQlUkDoURJ6/oWUfonRqx5KpBJu10rV0eLrnqHaorOkAVV7huoxYSFtb
         Iien4gP05Tai+KoNRCuVIdfRbQcUoNZ3wow2CeDyGCOP7cfMEsn+JRMHeffimZwAyO
         H3CRhVgMix5GRB2ngsV3TJV0rlk+PByrpf/h+7woM9fD4TSLdo/HqZyPZMrmOC3TeI
         Fi9h502KnJo0Sf3TihbtghihzvSONAyxnCnZ6B/pV8OeIYWjpSE37gLmQ7I6dR+Kdv
         srW0OxuoI6Ro9R6HR6Lz66p/n6iEowymBrc5id8fEBGAWMdZti8mm4I6kO6EH59o0C
         YUKytdNb4YOrg==
Date:   Sun, 12 Mar 2023 16:45:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] adding support for Microchip PAC193X Power
 Monitor
Message-ID: <20230312164533.491a7402@jic23-huawei>
In-Reply-To: <178ee962c5fc7ee7806475cb38527b8bdbfa8d09.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230225171139.65238b62@jic23-huawei>
        <178ee962c5fc7ee7806475cb38527b8bdbfa8d09.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 14:03:52 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
>=20
>   Please, see my comments below...
>=20
>=20
> On Sat, 2023-02-25 at 17:11 +0000, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Mon, 20 Feb 2023 14:32:30 +0200
> > <marius.cristea@microchip.com> wrote:
> >  =20
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > Adding support for Microchip PAC193X series of Power Monitor with
> > > Accumulator chip family. =20
> >=20
> > This device is at the messy boundary between IIO and HWMON. Perhaps
> > call out
> > the reasons you think IIO is more appropriate in this cover letter.
> > + Often a good idea for these borderline parts to cc both mailing
> > lists and
> > maintainers.
> >=20
> > Often the conclusion is that it is fine to have these in IIO because
> > we can
> > bridge to hwmon anyway with the iio-hwmon driver.
> >  =20
>=20
> Indeed the driver (the device) is at the boundary between IIO and
> HWMON. I was thinking to start with a simple driver (this one that is
> more apropiate to be a HWMON) and add more functionality later (like
> data buffering that is quite important for example if someone wants to
> profile power consumtion of the procesor itself, or a pheriperic, or a
> battery)
>=20

OK. List out some of the things you want to do later as the reasoning
+CC hmwon maintainers just to be sure.  They are usually fine with this
sort of reasoning, but it is best to check anyway.

Thanks,

Jonathan


>=20
> > >=20
> > > Differences related to previous patch:
> > >=20
> > > v1:
> > > - first version comitted to review
> > >=20
> > >=20
> > > Marius Cristea (2):
> > > =C2=A0 dt-bindings: iio: adc: adding dt-bindings for PAC193X
> > > =C2=A0 iio: adc: adding support for pac193x
> > >=20
> > > =C2=A0.../bindings/iio/adc/microchip,pac193x.yaml=C2=A0=C2=A0 |=C2=A0=
 122 +
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 7 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +
> > > =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/pac193x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 2072
> > > +++++++++++++++++
> > > =C2=A05 files changed, 2214 insertions(+)
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> > > =C2=A0create mode 100644 drivers/iio/adc/pac193x.c
> > >  =20
> >  =20
>=20
> Thanks,
> Marius
>=20

