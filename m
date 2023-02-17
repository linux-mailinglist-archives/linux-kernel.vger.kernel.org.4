Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7969B3B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQUSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:18:28 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFD25961;
        Fri, 17 Feb 2023 12:18:26 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 337FE100005;
        Fri, 17 Feb 2023 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676665105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8lIhLyYZrWOGH9acO3c8AQgJcBFOpPFrurmuqfB/DU=;
        b=obYLelZ0JpWaeHM6XQnuEUxoArkn0+207v2TingL+S5XYm+6rwdff8zRrzHgkYLJWrd+Ph
        fMP9ByQfat3MpOUROCd8ZI/xIlRtYV5geFdbGDqh8MtLoxR46yJPFJ9uL72EsEIp7vwUdD
        WHJe2q4dgHghfDTa3rnFerrXAS50zXfIbxGXy9LCO3avlzWJuZ0F8UvmqBdYOoJWcI1HJC
        3jF6uf4FB6X7h8dR1SQehYPUnMlCli6LiksbHXvRNgMuKPji4vkMkQk93+nZfPPeENfMxE
        8YknYacLfbmAreQ6q91HJ/heB2kN7gRA7RO29JggH1vCkXQdg1Pe5pEZAjz3wg==
Date:   Fri, 17 Feb 2023 21:18:20 +0100
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
Message-ID: <20230217211820.39fb47a7@bootlin.com>
In-Reply-To: <Y+/SStm9ifszrYA1@sirena.org.uk>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
        <87mt5dyxph.fsf@mpe.ellerman.id.au>
        <0606f44f-bdbb-055c-6fff-440007222ce3@csgroup.eu>
        <Y+/SStm9ifszrYA1@sirena.org.uk>
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

On Fri, 17 Feb 2023 19:15:22 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Feb 17, 2023 at 06:32:03AM +0000, Christophe Leroy wrote:
>=20
> > Mark, is that ok for you or do you expect this series to go via soc tre=
e ?
>=20
> Sure, that sounds good to me.  I'll give it another check and
> then assuming everything is fine apply for -rc1.

Thanks a lot,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
