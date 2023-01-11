Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D5665EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAKPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbjAKPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:06:59 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763BC64;
        Wed, 11 Jan 2023 07:06:58 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7925C1C000B;
        Wed, 11 Jan 2023 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673449616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96p48KGQVOszGpiIUB1uMQHTSrU1mw+PEt8uGhIXaOc=;
        b=J2zebCAM0gphMWejuOqgoceHr5MqD34OCvw5uIQ+F8xbwSyORqkjh5JN2WScz1Txu5rTA2
        oWG0oqjsC4TfW2W6iI9azZabaMlxD4UwGsCtIMgaxUsBAVf+S4BhZxNsfF++6qyd88P51j
        jTN0lxAM9hMeQ2T1yXZ3dCMevMQX/c69W2vPSEc81hUm2hBKXfojWt/aKd1iw4OGl0mv14
        6jyJY34VcHSqHG5PWqLJhCiaVS7KwdXzjRRNsRc7oZvowk1q7ZqmkvjRCtumbZwDyt60IY
        gVVVVQjYQyaYgKeiyyyZhzYFLYpjrQTPE5pNH2V3X3c+rY/pgSOvtO7fye2REA==
Date:   Wed, 11 Jan 2023 16:06:51 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 02/10] soc: fsl: qe: Add support for TSA
Message-ID: <20230111160651.24538b35@bootlin.com>
In-Reply-To: <7a36f02b-1ba1-b509-4aa0-c5c37a3cb3ef@csgroup.eu>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
        <20230106163746.439717-3-herve.codina@bootlin.com>
        <7a36f02b-1ba1-b509-4aa0-c5c37a3cb3ef@csgroup.eu>
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

Hi Christophe,

On Wed, 11 Jan 2023 13:47:23 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 06/01/2023 =C3=A0 17:37, Herve Codina a =C3=A9crit=C2=A0:
> > The TSA (Time Slot Assigner) is available in some
> > PowerQUICC SoC such as the MPC885 or MPC866.
> >=20
> > Its purpose is to route some TDM time-slots to other
> > internal serial controllers. =20
>=20
> Is the subject correct ? As far as I understand this patch adds support=20
> for the TSA on the CPM (exactly on CPM1), not on the QE.

Yes exactly, it is a CPM1 support (kind of previous version of QE).

Do you think that fixing the subject is enough or do I need also
to create a new directory drivers/soc/fsl/cpm/ and move these drivers
(TSA and QMC) in this new directory.

The alternative could be to leave this driver in drivers/soc/qe/ and
rename it to cpm-tsa.c.

For information, we have some plan to have this driver working
with QE (not done yet).

>=20
> By the way, there are already some embryo for handling TSA on QE in=20
> drivers/soc/fsl/qe/qe-tdm.c

Yes but this can be seen as an extension only used by=20
drivers/net/wan/fsl_ucc_hdlc.c and it supports QE only.

Not sure that qe-tdm.c will fit well if several other
drivers instances use it.

>=20
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Christophe

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
