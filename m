Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D16B3CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCJKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCJKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:45:25 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCEF5DCB5;
        Fri, 10 Mar 2023 02:45:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D7D56240013;
        Fri, 10 Mar 2023 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678445113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWY3HesGLrysSju0oFUekcV3H8bb2gpbjs5u2RCuvBk=;
        b=kDWZuTvk2gh2uCI8CNSyJlU9qVOQ2AyCdvYSKsg6uksN1Ec263sZlhQjbqKUllvKxZWO0s
        VW1H+pm0zRwRpoVmYbWlGp52ntKEYk1SgykFON/INLhxeEYknpKgpGtAC7t2NKlBmF9u5J
        iWCMIOwn520B4fDbsaN51I0e/jgrZ3aiRj3uWs1DqVrm2lsmKpb2V+vBktd41zwOPU1DIp
        hTTqos39Wsa25Lzt/qS68EdTF+EyvR0FS2PV6+397RPU7muWelP9OIp6Wwh7i1o1g5rFRF
        vM/x6Hkc96zsP4rFb7VY3ysLKcSzF84l+hxRQnmHkpIK5Ubhd8Q/9+zkWAHhMQ==
Date:   Fri, 10 Mar 2023 11:45:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/21] nvmem: core: handle the absence of expected
 layouts
Message-ID: <20230310114510.0867e0bd@xps-13>
In-Reply-To: <c37d2d5d-4a25-27de-3f80-033984232ed9@linaro.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
        <20230307165359.225361-12-miquel.raynal@bootlin.com>
        <c37d2d5d-4a25-27de-3f80-033984232ed9@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 10:30:14 +0000:

> On 07/03/2023 16:53, Miquel Raynal wrote:
> > Make nvmem_layout_get() return -EPROBE_DEFER while the expected layout
> > is not available. This condition cannot be triggered today as nvmem
> > layout drivers are initialed as part of an early init call, but soon
> > these drivers will be converted into modules and be initialized with a
> > standard priority, so the unavailability of the drivers might become a
> > reality that must be taken care of.
> >=20
> > Let's anticipate this by telling the caller the layout might not yet be
> > available. A probe deferral is requested in this case.
> >=20
> > Please note this does not affect any nvmem device not using layouts,
> > because an early check against the "nvmem-layout" container presence
> > will return NULL in this case.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Tested-by: Michael Walle <michael@walle.cc>
> > ---
> >   drivers/nvmem/core.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index b9be1faeb7be..51fd792b8d70 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
> >   static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvm=
em)
> >   { =20
>=20
> Any reason why this is not part of 10/21?

Yes, I would like to credit everybody for his work, so Michael for the
base implementation and myself for the module sitaution handling,
arguing this is two different features. May we keep these separated?

> kernel doc for nvmem_layout_get needs updating with this behavior.

There is no kdoc for nvmem_layout_get, do you want one ? I thought the
comment where this function is called would be more descriptive (and
read by interested people).

Thanks,
Miqu=C3=A8l
