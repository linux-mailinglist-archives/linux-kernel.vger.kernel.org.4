Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA536BD590
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCPQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCPQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:29:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277276B0;
        Thu, 16 Mar 2023 09:29:04 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CF611FF811;
        Thu, 16 Mar 2023 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678984143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeRzDs4ihJbeI7tp32i3vf2hG703FkbCNPgA50D/FNA=;
        b=mXFzboS07wKLrh31pNwHjrVSBN14J/n9oejyp51jQ/bRh1ex0pQ7a21J4KKzxljg005gqX
        pp45HUxC6IHCfX+F8PGrmOOe/FB8XqVLKHmpyjW1yXy3R2vmaaqTe+RfLiqjIa572fiwh1
        RiXLGu+b5LQW2DT+RLrmq9+oiqzS89YrL38unneeJIJ+7SpG81P2m+vSnxwz88EdkoB1sF
        VyzyCQSwkEHO3RqJ+C/o/N3qLhutNpOSA87VuQciRtJpa83iHr0vAJYZb7YRZTLMvqUb8f
        K4JbNS/lXslxJ//oyVuBGcG7p/c1fqW0TZPO/CAIRgW7v1iHsyAMjBZ955oItA==
Date:   Thu, 16 Mar 2023 17:29:00 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] drivers: misc: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20230316172900.2bb49a13@bootlin.com>
In-Reply-To: <ZBMQTxFsrKQesd4v@kroah.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
        <20230316122741.577663-3-herve.codina@bootlin.com>
        <ZBMQTxFsrKQesd4v@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
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

Hi Greg,

On Thu, 16 Mar 2023 13:49:19 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 16, 2023 at 01:27:36PM +0100, Herve Codina wrote:
> > +EXPORT_SYMBOL(pef2256_get_byphandle); =20
>=20
> You have a mixture of EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() in the
> same file here.  As this one:
>=20
> > +
> > +void pef2256_put(struct pef2256 *pef2256)
> > +{
> > +	put_device(pef2256->dev);
> > +}
> > +EXPORT_SYMBOL(pef2256_put); =20
>=20
> Is just a wrapper around a EXPORT_SYMBOL_GPL() function, please revisit
> and perhaps make them all EXPORT_SYMBOL_GPL() calls?
>=20

Indeed.
I will make them consistent in the v3 series.

Thanks for pointing that out.
Herv=C3=A9
--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
