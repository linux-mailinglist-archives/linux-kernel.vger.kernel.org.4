Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5621A710DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjEYOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjEYOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:06:29 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09716E41;
        Thu, 25 May 2023 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SVC7JU89Ibvqe/MRZpOcFxuHYUrMm1k3g+sVe4L8ZBU=; b=gv2pVZjzfU8lmN8kiDmrxA2FPp
        Hs8GB7EJ+p8Y4szzuK/Wwq75bBCn7htDFUqKAB95csz8QWQxojoyjozXu0jb7ow/pky/Xc5f0bKId
        cJbR7oAgsXVTDTtUYlJEMkVEdWhczVA5Rvn1eKpfCeoq8bun/XH+rMEzqaKFz1DCS6OI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48210 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Bb2-00084I-0S; Thu, 25 May 2023 10:05:40 -0400
Date:   Thu, 25 May 2023 10:05:39 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525100539.b2c0720f35563150334e4bf9@hugovil.com>
In-Reply-To: <1ae6fb11-6aa8-66e-86a-a9b5a6403f5e@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-5-hugo@hugovil.com>
        <1ae6fb11-6aa8-66e-86a-a9b5a6403f5e@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 04/11] serial: sc16is7xx: add post reset delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 14:05:35 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 25 May 2023, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Make sure we wait at least 3us before initiating communication with
> > the device after reset.
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index a7c4da3cfd2b..af7e66db54b4 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1428,6 +1428,12 @@ static int sc16is7xx_probe(struct device *dev,
> >  	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIF=
T,
> >  			SC16IS7XX_IOCONTROL_SRESET_BIT);
> > =20
> > +	/*
> > +	 * After reset, the host must wait at least 3us before initializing a
> > +	 * communication with the device.
> > +	 */
> > +	usleep_range(3, 5);
> > +
> >  	for (i =3D 0; i < devtype->nr_uart; ++i) {
> >  		s->p[i].line		=3D i;
> >  		/* Initialize port data */
>=20
> Does this fix a problem? You don't have a Fixes tag nor did you describe
> a problem that arises if the is not there in the changelog.

Not for the moment, that is why I didn't put a Fixes tag.

A potential problem that can arise is that on a much faster processor, ther=
e is a chance that we could reach the first instruction that request a read=
/write before the reset post-delay.

Hugo.
