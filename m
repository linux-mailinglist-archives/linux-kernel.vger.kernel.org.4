Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1140669A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjAMO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAMO3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:29:03 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D10FF;
        Fri, 13 Jan 2023 06:19:28 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3A5AA60013;
        Fri, 13 Jan 2023 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673619566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48ADDpQM9z/BZ40yXTCecgBCKKneMYXS0AEi6nY1rNY=;
        b=pxDShVxpca+jED54OGgdBg2dQ/oLPtWL3k1XprzkQgOZNVmQB2J8anIbjl9TH5ndSi8EtM
        CVDwgeA/F1Rwz2aJFbe2d0uZMU8kwHdAq/sC33IEJYKedCQX6NkyE/Xhs6hNj1eFiczDsg
        MxGIigt6L9diQdCvI0t2FH80R9ieFCEml7Orp6TKOR/G0i2wQngnIXJH/3cpcfc6nQpN5s
        WO84G9SQyVaYOhrqgcXTjW5qRR9J30DCDtuvGO/9n2yWGs4irpkQLh+jnRHudKr2MV6S35
        T8m1yxS6wMWcU80yb9BPjOkelGxc9ooexqQI/4QwIZIxZRKqpr6PujFTFg8Q1Q==
Date:   Fri, 13 Jan 2023 15:19:23 +0100
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
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034
 codec
Message-ID: <20230113151923.086a0495@bootlin.com>
In-Reply-To: <Y8FVz/Mp5xSdI34a@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
        <20230111134905.248305-3-herve.codina@bootlin.com>
        <Y77DKSdZf27qE+xl@sirena.org.uk>
        <20230111174022.077f6a8c@bootlin.com>
        <Y774bY4icD8RuMnX@sirena.org.uk>
        <20230113090431.7f84c93a@bootlin.com>
        <Y8FVz/Mp5xSdI34a@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 13 Jan 2023 12:59:59 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jan 13, 2023 at 09:04:31AM +0100, Herve Codina wrote:
>=20
> > For DAPM (struct snd_soc_dapm_widget), no kind of .put() and .get()
> > are available. I will use some Ids for the 'reg' value and use the
> > .write() and .read() hooks available in struct snd_soc_component_driver
> > in order to handle these Ids and so perform the accesses. =20
>=20
> That's what the event hooks are for - there's plenty of widgets using
> SND_SOC_NOPM as the register, look at those for examples.

Indeed, got it.
Thanks for pointing it.

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
