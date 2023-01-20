Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF96675548
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjATNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjATNOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:14:05 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D346279EBF;
        Fri, 20 Jan 2023 05:14:03 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B35C240004;
        Fri, 20 Jan 2023 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674220442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttRLjpJX7+bPZySHlgrLI4SdZs2FLcJbSnATZxL8sq4=;
        b=C9bv1YWdcNmayF8fuRXHTOmKZ1v7FdA5eJ9fPnhkC3tciKtXV+cTZ9UNKo7kezA72ewWTf
        Pfiwe0hgRbT3XeqN/23Ki4PMTvndZfCUneutZFCTgqfefGHlNG/AxTkIXu5YUAxLNbknU7
        BiAgZXQ5mRSPxBmFERMTTxKY4lYV7YPo9cCRKafI2vqVgKCVTXC6poqPLkxRmiB5lV5Npe
        R4dGk5SrZu3F/GmIqoXRUz/nM5lAHGRjaaBRQSWJZP4lps8xtxH7fYB60ZoMgYg+Tqp4M+
        ibdsE1vST+qzulQ2riNCGHHyRsiAe04qAXkhD+jzH8DtHR3IPq8owQOmIle1iA==
Date:   Fri, 20 Jan 2023 14:13:59 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/3] ASoC: codecs: Add support for the Renesas
 IDT821034 codec
Message-ID: <20230120141359.4606b617@bootlin.com>
In-Reply-To: <Y8qFPBEYJ1gH/Ycv@sirena.org.uk>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
        <20230120095036.514639-3-herve.codina@bootlin.com>
        <Y8qFPBEYJ1gH/Ycv@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 20 Jan 2023 12:12:44 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jan 20, 2023 at 10:50:35AM +0100, Herve Codina wrote:
>=20
> > +static int idt821034_kctrl_gain_put(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct soc_mixer_control *mc =3D (struct soc_mixer_control *)kcontrol=
->private_value;
> > +	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kc=
ontrol);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	struct idt821034_amp *amp; =20
>=20
> > +
> > +	amp->gain =3D val;
> > +	ret =3D 0;
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret; =20
>=20
> _put() methods should return 1 if the value changed to generate
> events - if you use the mixer-test selftest it'll spot this and
> other issues for you.
>=20

Thanks for pointing this. I will look at mixer-test and fix the _put()
methods return code in v3.

> Otherwise this looks fine.

Thanks for the review.

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
