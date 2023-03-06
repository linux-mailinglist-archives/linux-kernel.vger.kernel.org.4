Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A206AC3AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCFOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCFOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:45:35 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33662128A;
        Mon,  6 Mar 2023 06:45:08 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 47E1C240007;
        Mon,  6 Mar 2023 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678113886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LoFqhbO/xUacwzIgCqmbuhv2WRCNpVEYFLg9uP16XAg=;
        b=EHhq1V0zi75YS3/W4TPdk2huuhFFxzt9wqI8Ud6AmWIgCXEK5fj9i/E2me4QwqBCpms9/s
        6ZxMztl82GnlQuns7Ag51dg1niTsTwgiYI7xUzLR3heogYXuw9jGqAftzQ3bUmJEY++ZfN
        B6CCZpCLtTWkc3FJRUNPsP4Qbzp7xfZsAUsO7iaOjXH4rRMviwPYOTIPZhg7oYa6ckj61K
        NIM72mVUEKOfpAbMYpQUmFO5Q3fLZuJC3TNbLpkucSn3VFe9WJ2BYQfySDEEYnacaemNCW
        dlAY0xjxDo+gFPdAI3x9iEGB1RfJV+j1BzK8mAPXraVUvLtR+TfXeUinE1lLoA==
Date:   Mon, 6 Mar 2023 15:44:44 +0100
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
Message-ID: <20230306154444.5bd59b5f@xps-13>
In-Reply-To: <55aec068346e75008d84587ac2dad40b@milecki.pl>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
        <ee7923a8b5fa8358e6805d20df7d8049@walle.cc>
        <20230306143528.7407fda5@xps-13>
        <73a04afaf658292c05ef27117c60b21d@milecki.pl>
        <20230306151829.57c689b4@xps-13>
        <0b94d38a25f5d8ea70f228213ba14fa4@milecki.pl>
        <20230306152954.5b72154f@xps-13>
        <55aec068346e75008d84587ac2dad40b@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Mon, 06 Mar 2023 15:34:50 +0100:

> On 2023-03-06 15:29, Miquel Raynal wrote:
> > Hi Rafa=C5=82,
> >=20
> > rafal@milecki.pl wrote on Mon, 06 Mar 2023 15:23:50 +0100:
> >  =20
> >> On 2023-03-06 15:18, Miquel Raynal wrote: =20
> >> > Hi Rafa=C5=82,
> >> >
> >> > rafal@milecki.pl wrote on Mon, 06 Mar 2023 14:57:03 +0100:
> >> > =20
> >> >> On 2023-03-06 14:35, Miquel Raynal wrote: =20
> >> >> > Hi Michael,
> >> >> >
> >> >> > michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
> >> >> > =20
> >> >> >> > Miquel Raynal (8):
> >> >> >> >   of: Fix modalias string generation
> >> >> >> >   of: Change of_device_get_modalias() main argument
> >> >> >> >   of: Create an of_device_request_module() receiving an OF node
> >> >> >> >   nvmem: core: Fix error path ordering
> >> >> >> >   nvmem: core: Handle the absence of expected layouts
> >> >> >> >   nvmem: core: Request layout modules loading
> >> >> >> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
> >> >> >> >   nvmem: layouts: onie-tlv: Convert layout driver into a modul=
e =20
> >> >> >> >> With the fixes series [1] applied: =20
> >> >> >
> >> >> > Thanks for the series! Looks good to me. I believe both series ca=
n live
> >> >> > in separate tress, any reason why we would like to avoid this? I =
am > keen
> >> >> > to apply [1] into the mtd tree rather soon. =20
> >> >> >> Given past events with nvmem patches I'm against that.
> >> >> >> Let's wait for Srinivas to collect pending patches, let them spe=
nd a =20
> >> >> moment in linux-next maybe, ask Srinivas to send them to Greg early=
 if
> >> >> he can. That way maybe you can merge Greg's branch (assuming he >> =
doesn't
> >> >> rebase). =20
> >> >
> >> > Just to be on the same page, we're talking about the mtd core fixups=
 to
> >> > handle correctly probe deferrals in the nvmem side.
> >> >
> >> > Applying mtd patches then nvmem patches is totally fine in this orde=
r.
> >> > Applying nvmem patches and then mtd patches creates a range of commi=
ts
> >> > where some otp devices might have troubles probing if:
> >> > - a layout driver is used
> >> > - the driver is compiled as a module
> >> > - the driver is also not installed in an initramfs
> >> >
> >> > I was actually asking out loud whether we should care about this
> >> > commit range given the unlikelihood that someone would have troubles
> >> > with this while bisecting a linux-next kernel.
> >> >
> >> > So getting an immutable tag from Greg would not help. The opposite
> >> > might make sense though, and involves that I apply [1] to mtd/next
> >> > rather soon anyway, I guess? =20
> >> >> The problem IIUC is nvmem.git / for-next containing broken code aft=
er =20
> >> adding nvmem stuff. That is unless Srinivas takes your patches in some
> >> way. Hopefully not by waiting for 6.4-rc1. =20
> >=20
> > I don't follow. There will be nothing broken after applying the nvmem
> > patches, at least nothing more than today. I will apply the patches
> > provided by Michael, they fix existing issues, nothing related to the
> > nvmem changes. Just, it is easier to trigger these issues with the
> > nvmem series thanks to the probe deferral situations.
> >=20
> > Both series can live on their own. If required I will produce an
> > immutable tag to Greg. =20
>=20
> OK, it's me how didn't follow then.
>=20
> I thought your mtd fixes are needed before applying nvmem stuff.

Yes, that would be ideal. I will produce an immutable branch.

Thanks,
Miqu=C3=A8l
