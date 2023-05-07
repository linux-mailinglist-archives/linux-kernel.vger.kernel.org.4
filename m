Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3ED6F98F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjEGOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A611D89;
        Sun,  7 May 2023 07:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5151760FF9;
        Sun,  7 May 2023 14:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5BC433EF;
        Sun,  7 May 2023 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683470710;
        bh=f3AxfwqEtAr5VZd9yHfGJdkHrsRn7CJ/CJ1thpUvEUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Od2gsyxzXbSQBBRpPLRVAiujAEjY/fkZGyHrC+o2g1bK2ZrxBCI7+By+b7y4r3PU6
         fdWMl6QYhI8CUytNTl+AQGblExCMj1v0+5D7ZlzyEitLGUFCak6TlrrUi5qQ/1U1WJ
         P9+Z6rx00FpS8ojUjvzv6CTitQUzqPndbZ3sOxivw+iYkKQeWyEO6nW1HRDW78D2oW
         lUJDA6EvG1gC3q53C9kkyK5ejsV5Hhvku97cym7N4/5eupfkfllYrtitijlwAj5nbJ
         ZbNeXYAYNJn1vkjhtBNvUQF+QOJWtFJ66oqBc1WExFGWkwz1c03WSU1/da2VPLrcV9
         PB1GXJ85b1aPA==
Date:   Sun, 7 May 2023 16:01:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Message-ID: <20230507160104.1d6e8bb8@jic23-huawei>
In-Reply-To: <f83adfd4df5cd23176721087a4fcd9a0225c3483.camel@gmail.com>
References: <20230502102930.773-1-honda@mechatrax.com>
        <f83adfd4df5cd23176721087a4fcd9a0225c3483.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Wed, 03 May 2023 10:09:28 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

Patch title should be something like the following so it's easy to see what
is affected when looking at a long list of patches.

iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag.


> On Tue, 2023-05-02 at 19:29 +0900, Masahiro Honda wrote:
> > The Sigma-Delta ADCs supported by this driver can use SDO as an interru=
pt
> > line to indicate the completion of a conversion. However, some devices
> > cannot properly detect the completion of a conversion by an interrupt.
> > This is for the reason mentioned in the following commit.
> >=20
> > commit e9849777d0e2 ("genirq: Add flag to force mask in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq[_nosy=
nc]()")
> >=20
> > A read operation is performed by an extra interrupt before the completi=
on
> > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLA=
ZY
> > flag.
> >=20
> > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Fixes tag?  We'll want to know how far to backport this.  I assume it's
limited by the above commit as these drivers are older than that.=20

I'm also not totally sure what this 'looks like' for a user.  What happens?
Fail to read, wrong value, lock up or something else?  It would be helpful
to include that information in case anyone else runs into this.

Actual change looks right to me.

Thanks,

Jonathan


>=20
> > v4:
> > =C2=A0- Remove the callback.
> > v3:
> > https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatrax.=
com/
> > =C2=A0- Remove the Kconfig option.
> > v2:
> > https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.=
com/
> > =C2=A0- Rework commit message.
> > =C2=A0- Add a new entry in the Kconfig.
> > =C2=A0- Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freei=
ng the IRQ.
> > v1:
> > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.=
com/
> >=20
> > =C2=A0drivers/iio/adc/ad_sigma_delta.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > b/drivers/iio/adc/ad_sigma_delta.c
> > index d8570f6207..7e21928707 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device =
*dev,
> > struct iio_dev *indio_de
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_completion(&sigma_=
delta->completion);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sigma_delta->irq_dis =
=3D true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* the IRQ core clears IRQ_D=
ISABLE_UNLAZY flag when freeing an IRQ */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_set_status_flags(sigma_d=
elta->spi->irq, IRQ_DISABLE_UNLAZY);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_request_ir=
q(dev, sigma_delta->spi->irq,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad_sd_data_rdy_trig_poll,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigma_delta->info->irq_flags | IRQF_NO=
_AUTOEN, =20
>=20

