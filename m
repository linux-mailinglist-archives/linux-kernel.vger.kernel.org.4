Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8828A6AC35E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCFOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCFOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:34:05 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D82A15F;
        Mon,  6 Mar 2023 06:33:18 -0800 (PST)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 08DD1C9079;
        Mon,  6 Mar 2023 14:20:33 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 72F3140007;
        Mon,  6 Mar 2023 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678112311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQMPVgcFTy/Q4j9fnpHklSpnWa3lhC60q1SMkTSain8=;
        b=OM/O1gwxOk+2qmvXGeInvI30SlgTahnGgFQA/ABfG7tFB438IKBji0LkO2N0Nip6LE708Z
        sYJeC6ZF+A+zmqCvZE4bEUZrdFryPaAPDS+Dyr/Aiu35Lhe/2+W1BU7kYDDmEfb7ne8ML7
        ywft1Guav3tZ34DG1zqMHH2ntqFaRmXRlM4oj7ExoAN8C2GxI497qI9abRksJf+MQzgqtR
        HpoXKqGal62A5qJs3EO7X8/MZNmmlBFmxmXOn/kyF0s4fAG4T+oNmE4cP8f502r/+QzBNZ
        FuxMQ+Il9dz3EDgEUyixGc+hRLfCobJ2xO6jpKbf+fvprml8InG+w4YakExiwg==
Date:   Mon, 6 Mar 2023 15:18:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
Message-ID: <20230306151829.57c689b4@xps-13>
In-Reply-To: <73a04afaf658292c05ef27117c60b21d@milecki.pl>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
        <ee7923a8b5fa8358e6805d20df7d8049@walle.cc>
        <20230306143528.7407fda5@xps-13>
        <73a04afaf658292c05ef27117c60b21d@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Mon, 06 Mar 2023 14:57:03 +0100:

> On 2023-03-06 14:35, Miquel Raynal wrote:
> > Hi Michael,
> >=20
> > michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
> >  =20
> >> > Miquel Raynal (8):
> >> >   of: Fix modalias string generation
> >> >   of: Change of_device_get_modalias() main argument
> >> >   of: Create an of_device_request_module() receiving an OF node
> >> >   nvmem: core: Fix error path ordering
> >> >   nvmem: core: Handle the absence of expected layouts
> >> >   nvmem: core: Request layout modules loading
> >> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
> >> >   nvmem: layouts: onie-tlv: Convert layout driver into a module =20
> >> >> With the fixes series [1] applied: =20
> >=20
> > Thanks for the series! Looks good to me. I believe both series can live
> > in separate tress, any reason why we would like to avoid this? I am > k=
een
> > to apply [1] into the mtd tree rather soon. =20
>=20
> Given past events with nvmem patches I'm against that.
>=20
> Let's wait for Srinivas to collect pending patches, let them spend a
> moment in linux-next maybe, ask Srinivas to send them to Greg early if
> he can. That way maybe you can merge Greg's branch (assuming he doesn't
> rebase).

Just to be on the same page, we're talking about the mtd core fixups to
handle correctly probe deferrals in the nvmem side.

Applying mtd patches then nvmem patches is totally fine in this order.
Applying nvmem patches and then mtd patches creates a range of commits
where some otp devices might have troubles probing if:
- a layout driver is used
- the driver is compiled as a module
- the driver is also not installed in an initramfs

I was actually asking out loud whether we should care about this
commit range given the unlikelihood that someone would have troubles
with this while bisecting a linux-next kernel.

So getting an immutable tag from Greg would not help. The opposite
might make sense though, and involves that I apply [1] to mtd/next
rather soon anyway, I guess?

Thanks,
Miqu=C3=A8l
