Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79E6CC87F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjC1Quk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjC1Qug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:50:36 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539328A49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:50:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 459EBE0003;
        Tue, 28 Mar 2023 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680022205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lHjQqz2bvwIGLCUjlFOvqonsd4AdNqo2rm07pQiMA8=;
        b=emu/aTREplUYi19S5EGm8XKbz3GPz+d1zNFOUlGxHZKKsmHqfjSKxkSfntMCFy3G9k2nJ9
        +aPkpUlsl7W6O7lLUMQibPVkV2YtOjJsWhpPS+ZxmJSDr82SHQU/zx6IUis2pD7KWBhEQ1
        oGhnJoCRen3yih668hv1cKBQkom6UxBhwpyFZQ8iWZ+0Igtnqtqn9i2luhum0Si0OBZBLL
        yx6zs8+mK72ue65SBHTqgd4alxk5u7LQ0pq5lxIbYoO3xS1G3JA/vclPMcJoyOYwEZdh/T
        ApK5aGSilBv3p3tEL1oWSBOzIkItKlOL14M9w9ak+Dt26FzbJZU4MNEnnxxT/Q==
Date:   Tue, 28 Mar 2023 18:50:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in
 command word
Message-ID: <20230328185001.5661132b@xps-13>
In-Reply-To: <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
        <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
        <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
        <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 28 Mar 2023 18:56:19 +0300:

> Hello!
>=20
> @Miquel Raynal, what is the status of this patch?

Please, it's been 6 days, there is also a maintainer (Liang) in
between, I'm fine with the patch but it was too late to take it as
part of my previous fixes PR. As said earlier today on the mailing list
to Christophe I will make another fixes PR next week (I'll wait for the
current one to be part of the next -rc tag).

By the way any reason not to have Cc'ed stable?

>=20
> Thanks, Arseniy
>=20
> On 23.03.2023 10:57, Arseniy Krasnov wrote:
> >=20
> >=20
> > On 22.03.2023 23:10, Martin Blumenstingl wrote: =20
> >> Hello Arseniy,
> >>
> >> thank you for submitting this fix! =20
> > Thanks! =20
> >>
> >> On Wed, Mar 22, 2023 at 7:45=E2=80=AFPM Arseniy Krasnov
> >> <avkrasnov@sberdevices.ru> wrote: =20
> >>>
> >>> Valid mask is 0x3FFF, without this patch the following problems were
> >>> found:
> >>>
> >>> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
> >>>                   bit-wise majority to recover it
> >>>    [    0.947384] ONFI parameter recovery failed, aborting
> >>>
> >>> 2) Read with disabled ECC mode was broken.
> >>>
> >>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NA=
ND flash controller")
> >>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru> =20
> >> This matches what I can see in the old vendor driver, so: =20
> > Moreover it was clear that mask of 0x3f is too small for length of data=
 in
> > bytes, for example for 2048 + OOB size. =20
> >> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>
> >> [...] =20
> >>> -               cmd =3D (len & GENMASK(5, 0)) | scrambler | DMA_DIR(d=
ir);
> >>> +               cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(=
dir); =20
> >> My understanding of the vendor driver is that this "len" is only used
> >> for "raw" access (my own words: any access that doesn't use the HW ECC
> >> engine). =20
> > Exactly, 'len' is only for raw access. =20
> >> As a future improvement (no need to update re-send this patch) it
> >> would be great to have a #define with a meaningful name for
> >> "GENMASK(13, 0)" (maybe something like NFC_CMD_RAW_LENGTH) as it's
> >> used in multiple places now =20
> > Ack
> >=20
> > Thanks, Arseniy =20
> >>
> >>
> >> Best regards,
> >> Martin =20


Thanks,
Miqu=C3=A8l
