Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBC6B24FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCINKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCINKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:10:48 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54401D5153;
        Thu,  9 Mar 2023 05:10:43 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EC0AAFF803;
        Thu,  9 Mar 2023 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678367441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAtQ/zm36r/xZZG8gCGP5DOMaREHcbOXCuBhiJyl+SQ=;
        b=jDAFHsci28br950/rzGOMVaYQ/eA3m7hA4/4KbJxApBCilyu2kVn6RXevK9MO/7Il3RfT8
        +Uxx/4YfL4DL8C1OmDXhqJwWAtqOlQKI3eWqmN8gzPTJRjtAyOM4LpF1pYR26gmrSLVbT5
        lWUgXpE06Qxob4VW5btgzmTaQ91qryMqfG2SJFOZ8LmkBwehb7qwaUXMRRmiK/nxdMmtTT
        zkZh8d5dfq/0n1EA36+gQUOTIJu7gyDccAkoqwLrRKJHeCVsdLjCfIcIzux0/ceVxIvHQi
        viANWa/IQ5TMqURjSegBZXL3gQsjKyizPHEiIX+XiGwA1oGMxa2jH0XhCUcmDw==
Date:   Thu, 9 Mar 2023 14:10:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
Message-ID: <20230309141038.4399af1f@xps-13>
In-Reply-To: <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
References: <20230222172245.6313-1-zajec5@gmail.com>
        <20230222172245.6313-3-zajec5@gmail.com>
        <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
        <20230309113211.6321ce3d@xps-13>
        <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
        <20230309122324.4b012a58@xps-13>
        <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
        <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
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

Hello,

rafal@milecki.pl wrote on Thu, 09 Mar 2023 12:52:37 +0100:

> On 2023-03-09 12:44, Srinivas Kandagatla wrote:
> > On 09/03/2023 11:23, Miquel Raynal wrote: =20
> >> Hi Srinivas, =20
> >> >> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:53:07 >>=
 +0000: =20
> >> >>> On 09/03/2023 10:32, Miquel Raynal wrote: =20
> >>>> Hi Srinivas, =20
> >>>> >>>> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:2=
4 >>>> +0000: =20
> >>>> >>>>> On 22/02/2023 17:22, Rafa=C5=82 Mi=C5=82ecki wrote: =20
> >>>>>> @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct >>>>=
>> nvmem_device *nvmem,
> >>>>>>     	if (!nvmem)
> >>>>>>     		return -EINVAL; =20
> >>>>>>     > +	/* Cells with read_post_process hook may realloc buffer we=
 >>>>>> can't allow here */ =20
> >>>>>> +	if (info->read_post_process)
> >>>>>> +		return -EINVAL; =20
> >>>>> This should probably go in 1/4 patch. Other than that series looks =
>>>>> good to me. =20
> >>>> >>>> FYI patch 1/4 is also carried by the nvmem-layouts series, so i=
t's =20
> >>>> probably best to keep these 2 patches separated to simplify the >>>>=
 merging. =20
> >>> that is intermediate thing, but Ideally this change belongs to 1/4 >>=
> patch, so once I apply these patches then we can always rebase layout >>>=
 series on top of nvmem-next =20
> >> >> Well, I still don't see the need for this patch because we have no =
use =20
> >> for it *after* the introduction of layouts. Yes in some cases changing
> >> the size of a cell might maybe be needed, but right now the use case >=
> is
> >> to provide a MAC address, we know beforehand the size of the cell, so
> >> there is no need, currently, for this hack. =20
> >> > Am confused, should I ignore this series ? =20

I think this series makes sense and addresses a need. But this issue
can also be solved with the layouts. Rafa=C5=82 does not want (I still
don't get the reason) to use that solution. Whatever. But if you apply
this series, it requires to modify the layouts series, thus postponing
it even more. I would prefer to merge that big series first and then
merge an update of this patch (which changes in the two layout drivers
the cell size argument type).

> I'm confused no less.
>=20
> I think we have 3 different opinions and no agreement on how to proceed.
>=20
>=20
> Rafa=C5=82 (me):
> NVMEM cells should be registered as they are in the raw format. No size
> adjustments should happen while registering them. If NVMEM cell requires
> some read post-processing then its size should be adjusted *while*
> reading.

This implementation only works if you reduce the size of the cell.

While writing this, I am realizing that we would actually expect
a check on the nvmem side if the size was enlarged because this would
be a bug.

> Michael:
> .read_post_process() should be realloc the buffer

This would be more robust. But if we start with 1, we can improve it
later, I don't mind as long as an error is returned in case of misuse.

> Miquel:
> While registering NVMEM cell its size should be already adjusted to
> match what .read_post_process() is about to return.

Sounds like the simplest solution to me and covers all the uses we
have to day, but honestly, I won't fight for it.

> I'm really sorry if I got anyone's view wrong.

LGTM.

> > Whatever. If you want it, just merge it. But *please*, I would like =20
>
> :-)
>
> > to see these layouts in, so what's the plan? =20
>
> Am on it, you sent v3 just 24hrs ago :-)

Yes, sorry for being pushy. I just wanted to highlight that the two
series conflict together, but my answer was clumsy. Take the time you
need, that's how it's supposed to work anyway.

Thanks,
Miqu=C3=A8l
