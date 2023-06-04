Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1912D721656
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFDLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B2D2;
        Sun,  4 Jun 2023 04:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0144860C22;
        Sun,  4 Jun 2023 11:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40EFC433EF;
        Sun,  4 Jun 2023 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685877619;
        bh=OsT04YCHMN5MqW4NW2NAHo0FOaoVoBBMNab3Jjr9zlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KYq6RQ//h7A8/skmKmA3ol1phPbS39NKta5uWZH1E7E390eihXtXR0CX5p2XjLtaz
         W6/DwZOWtj6B6OmeFecr2hpB9YEUoeT6ThSSW7G/VL2uXqOXzVrZDDTKheASH2/mIT
         L3CVS0gOKJtI8lLJplLJ6aY2d4m7vNxKmOy5DS70k/feykKPYANTmmeuEBooUPXtiO
         IL5WlO2/P2xL8wmfDpDZBiYpnbADydbbc16AkrjuafYKjV1oPJx/PVvHQ9roVcQyYe
         BCGFgJiIgGIGGu5irpg0bE/upDylVNXsuDasnrHB4L5zJ73vLBP5qWZLYE5Ewvgnr/
         3ewTjkf8pGUcA==
Date:   Sun, 4 Jun 2023 12:20:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 0/7] iio: light: vcnl4000: Add features for
 vncl4040/4200
Message-ID: <20230604122015.38e7b8a5@jic23-huawei>
In-Reply-To: <ZHtGAn8ZF_fhgNQn@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
        <ZHtGAn8ZF_fhgNQn@surfacebook>
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

On Sat, 3 Jun 2023 16:54:10 +0300
andy.shevchenko@gmail.com wrote:

> Tue, May 30, 2023 at 04:23:58PM +0200, Astrid Rost kirjoitti:
> > Add a more complete support for vncl4040 and vcnl4200, which allows to
> > change the distance of proximity detection and interrupt support for the
> > illuminance sensor.
> >=20
> > Proximity functionality:
> >   - Interrupt support (new on vcnl4200).
> >=20
> > Proximity reduce the amount of interrupts:
> >   - Adaptable integration time (new on vcnl4200) - the sampling rate
> >     changes according to this value.
> >   - Period - interrupt is asserted if the value is above or
> >     below a certain threshold.
> >=20
> > Proximity change the activity distance:
> >   - Oversampling ratio - Amount of LED pulses per measured raw value.
> >   - Calibration bias - LED current calibration of the sensor.
> >=20
> > Illuminance functionality:
> >   - Interrupt support.
> >=20
> > Illuminance reduce the amount of interrupts:
> >   - Adaptable integration time - the sampling rate and scale changes
> >     according to this value.
> >   - Period =E2=80=93 interrupt is asserted if the value is above or
> >     below a certain threshold. =20
>=20
> It's a good work, thank you for doing it!
>=20
> But it has a lot of small style and inconsistent issues. They are not maj=
or
> per se, but since there is more than 3, it makes sense to address. Also c=
heck
> if you can split your patches to two or three where it makes sense.
>=20

FWIW nothing to add from me.  Agree with Andy that we are down to style
things that would be good to tidy up before applying these.

Adding levels to switch nests always makes for ugly diffs so I fully agree
with Andy that, though trivial, it is probably better to do those in two st=
eps
for ease of review.  If there is just one in a patch then meh, we can proba=
bly
cope with the extra thinking required to review them , but where it happens
several times it's worth making reviewer's lives that little bit easier!

Jonathan

