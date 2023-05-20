Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D961B70A8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjETPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjETPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A17103;
        Sat, 20 May 2023 08:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A253360DEF;
        Sat, 20 May 2023 15:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482FC433D2;
        Sat, 20 May 2023 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596610;
        bh=I0/PYCkSOLHKSNHXu0txjdVY6Bmb7+j9J1Y+CWmldhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aDoEEmHZpAqFLAowx9ND3W5CE9XrVubLboXGte0hddEMGEcF3hCFdNREo5UzQ289k
         5Rg1ZQ/HdJZe2YK5XD5+3tk6SoOzbkGWwhOSbgIHrbnHPSQ979IVy9Qe3O7Qjmv13S
         m3Kdc/kBOu87bYqO3WUNkexGhMgxGPyMEbq3BlyeuIcgNO30lV2Wynrlc78quhQwz2
         ruAnC0ZAvwc4+qHeCTWWK0touTiXNcxDMJUqrTQ5BDs/1Jl3OhE8xPTjSwuEmAcCE9
         XCwIuokDpzPFCwMCuQCPtMl9+pkthh0ehCi5kDKnA5LB+ubH3uS8lSEqeLzxcMGWMk
         8ivitMZ9wdr6Q==
Date:   Sat, 20 May 2023 16:46:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0Lg=?=
         =?UTF-8?B?0Yc=?= <GNStark@sberdevices.ru>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Message-ID: <20230520164618.08f26fd9@jic23-huawei>
In-Reply-To: <f0966e95-43c7-e6f6-8aeb-05f27691cec3@sberdevices.ru>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
        <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
        <f0966e95-43c7-e6f6-8aeb-05f27691cec3@sberdevices.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 16:47:59 +0000
=D0=A1=D1=82=D0=B0=D1=80=D0=BA =D0=93=D0=B5=D0=BE=D1=80=D0=B3=D0=B8=D0=B9 =
=D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B5=D0=B2=D0=B8=D1=87 <GNStark@sberd=
evices.ru> wrote:

> On 5/16/23 22:08, Martin Blumenstingl wrote:
> > Hi George,
> >
> > thank you for this patch!
> >
> > On Mon, May 15, 2023 at 11:06=E2=80=AFPM George Stark <gnstark@sberdevi=
ces.ru> wrote: =20
> >> From: George Stark <GNStark@sberdevices.ru>
> >>
> >> According to datasheets of supported meson SOCs
> >> length of ADC_CLK_DIV field is 6 bits long =20
> > I have a question about this sentence which doesn't affect this patch
> > - it's only about managing expectations:
> > Which SoC are you referring to?
> > This divider is only relevant on older SoCs that predate GXBB (S905).
> > To my knowledge all SoCs from GXBB onwards place the divider in the
> > main or AO clock controller, so this bitmask is irrelevant there. =20
>=20
> Hello Martin
>=20
> I've checked datasheets of all chips listed in meson_sar_adc_of_match arr=
ay in meson_saradc.c and everywhere this field is 6 bits long. According to=
 driver code and existing dts files this patch affects all supported chips =
except meson8.

On that note, do we want to add any clarifying text on the scope to the
commit message?

Jonathan

>=20
> Best regards
> George
>=20
>=20
> >> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in =
Amlogic Meson SoCs")
> >> Signed-off-by: George Stark <GNStark@sberdevices.ru> =20
> > Since my question above doesn't affect this patch:
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > =20
>=20

