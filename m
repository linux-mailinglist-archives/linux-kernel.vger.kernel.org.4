Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF835665F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAKPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjAKPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:40:27 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614CF19C3F;
        Wed, 11 Jan 2023 07:40:25 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B16AFE0004;
        Wed, 11 Jan 2023 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673451624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJ80tI+n7E12DAvDikBDbLVrg9IXgTxZ252Cq+neEbQ=;
        b=Q+o9216wXpyzH4Fmo4XE+A/19Rhli449oB8gxh74cMuVSBe7TmgTWv0NVMgETjHj7ICimI
        2lEldE8luCvEuRzv4wncGEOGkp8+YWnj/gHNVwVIcANGc/i9KFCarw2xI7Zy7ii4mw01BP
        3yh4Y2Qf6FLQR/pCfsBovsMC1nhClDVRgsfz9BsqGrMm8sPNTEXSy366YeN1nX8+aedw2l
        5dU2xzoQw9jeYIRqNq8AjlA436V/DgDKdEL+uikobI8yvJhFeEtymQvw2NPhOwbDD2+MwT
        mU28pFltJe6k53uG/R2oCKCPp6dR2f20BtbgaXKCRweyOUiSP64AKbrgZhfqEA==
Date:   Wed, 11 Jan 2023 16:40:18 +0100
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
Subject: Re: [PATCH v2 06/10] soc: fsl: qe: Add support for QMC
Message-ID: <20230111164018.676a8ca1@bootlin.com>
In-Reply-To: <f46eb64d-ad4c-7531-60b0-68961f171ed8@csgroup.eu>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
        <20230106163746.439717-7-herve.codina@bootlin.com>
        <f46eb64d-ad4c-7531-60b0-68961f171ed8@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,
On Wed, 11 Jan 2023 13:58:03 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 06/01/2023 =C3=A0 17:37, Herve Codina a =C3=A9crit=C2=A0:
> > The QMC (QUICC Multichannel Controller) is available on some
> > PowerQUICC SoC such as the MPC885 or MPC866. =20
>=20
> Same, that's QMC for CPM for the time being, should that be made clear=20
> in the subject ?

Also same answer:
Will changing the subject be enough or do I need to move it to new
created drivers/soc/fsl/cpm/ directory ?

>=20
> QE also has QMC and this driver might be used for QE QMC as well with=20
> some enhancement, maybe that could be explained here ?

Yes and we plan to have it working on QE too.

What do you think if I add the following:
  The QMC is also available on some Quicc Engine SoC.
  This current version support CPM1 SoC only. Some
  enhancement are needed to support Quicc Engine SoC.

>=20
> I see you are using in_be16(), out_be16() etc ....
> That's specific to powerpc arch, maybe it is better to use ioread16be,=20
> iowrite16be() etc ....
> See commit 3f39f38ea91d ("soc: fsl: qe: replace qe_io{read,write}*=20
> wrappers by generic io{read,write}*") and commit 6ac9b61786cc ("soc:=20
> fsl: qe: introduce qe_io{read,write}* wrappers") for information.

You're right.
I will switch to io{read,write}{16,32}be.

I prefer avoid the use of qe_* wrappers as the driver is not
(yet) compatible with QE.

>=20
> >=20
> > It emulates up to 64 channels within one serial controller
> > using the same TDM physical interface routed from the TSA.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> In some places, you comments use the network style, not the generic style.

I will fix them.

>=20
> Christophe

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
