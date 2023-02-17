Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B769B3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBQU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:28:03 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBC34F62;
        Fri, 17 Feb 2023 12:28:00 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 060A3240007;
        Fri, 17 Feb 2023 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676665678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvDZ7Ve+5FFvR/CqSfvy5MV7TZP0j51A/S+5V2+9/OI=;
        b=Qy+krOUJ44tvEiFjWe9YQkjR8tcp8Y98DemShkj0+2SlPQOzy5NE0xuVLPS61xJTSIdP/7
        iw6n/SwXTgLhW+RSZE3Tt6+2g1bnqECHxbwmXJ+ySh35qcuowJTP+LrvtUVWUNBZh/YVMt
        nf+0XG9cifw3v0NDHbgNuy5w8DycFBSOz5GuNu/ukZM7G86Wzz+0EX6XkzRQsJOnmWXCE4
        T/cT4XK2iP6mL4UzaOVGQ7ZN2TI3sANGJ1HlxGa9pSBiktAzZDmpw4MYkt5/7ef5vn6ehC
        6s5n98W01n0UVjigYqwCmFnQAnxpjis5ScbOK6w7dqwf6OParTyU9GbzWsHeRQ==
Date:   Fri, 17 Feb 2023 21:27:54 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Li Yang <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/10] Add the PowerQUICC audio support using the QMC
Message-ID: <20230217212754.4fba0b78@bootlin.com>
In-Reply-To: <20230217211820.39fb47a7@bootlin.com>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
        <87mt5dyxph.fsf@mpe.ellerman.id.au>
        <0606f44f-bdbb-055c-6fff-440007222ce3@csgroup.eu>
        <Y+/SStm9ifszrYA1@sirena.org.uk>
        <20230217211820.39fb47a7@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
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

On Fri, 17 Feb 2023 21:18:20 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> On Fri, 17 Feb 2023 19:15:22 +0000
> Mark Brown <broonie@kernel.org> wrote:
>=20
> > On Fri, Feb 17, 2023 at 06:32:03AM +0000, Christophe Leroy wrote:
> >=20
> > > Mark, is that ok for you or do you expect this series to go via soc t=
ree ?
> >=20
> > Sure, that sounds good to me.  I'll give it another check and
> > then assuming everything is fine apply for -rc1.
>=20
> Thanks a lot,
> Herv=C3=A9
>=20

And note that the v6 series is available.
  https://lore.kernel.org/linux-kernel/20230217145645.1768659-1-herve.codin=
a@bootlin.com/
with the v5 feedbacks from Krzysztof taken into account.

Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
