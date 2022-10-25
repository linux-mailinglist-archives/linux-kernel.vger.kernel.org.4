Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6E60C5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiJYHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiJYHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:49:35 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3A26AE5;
        Tue, 25 Oct 2022 00:49:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B9A0A20005;
        Tue, 25 Oct 2022 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666684172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuSwOgZY8sHme8bFpEr2PZ8MbxLNuNWPW+Z3pPtGyEk=;
        b=PUEdnLAPCSLhuoDaQISlHsB6738xXC0Wj/kHDXu2JGyYtg9rbHDE5pkj45sfbtsjHjxDz5
        ZpyHpFWTjRGOs0Mf5/w3D5hD/8a6EGUqhq8pkQSJlLvDdD02ZgXv5tqC+cWg6a645RGW0B
        7O/xuvUnUomJp+HpFiao61DM6lz7WmAddX9u0awkbiaTg66UuTWRdPVujgWI2y70UXY4Qt
        aRySmhTRIrAvQ6i7LTFynGvzi9GxdUWE7jq0M/FaF52n1hBpbnW5y1YUQ4O3C4e9yY2Sri
        8nJJ25B+xIsPl1LmSPmTvMqz8jyvhfFBBFrPPXK78FcO1WTLbMOO+2i/jIG9jw==
Date:   Tue, 25 Oct 2022 09:49:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: arm,pl353-smc: Extend
 to support 'arm,pl354' SMC
Message-ID: <20221025094930.492548e1@xps-13>
In-Reply-To: <CAL_Jsq+C903Syo-buYvC5=jtvhtvhwerEbz9wkd6nRFs7aB8LQ@mail.gmail.com>
References: <20221021203928.286169-1-robh@kernel.org>
        <20221024101405.3c2e163a@xps-13>
        <CAL_Jsq+C903Syo-buYvC5=jtvhtvhwerEbz9wkd6nRFs7aB8LQ@mail.gmail.com>
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

Hi Rob,

robh@kernel.org wrote on Mon, 24 Oct 2022 09:31:41 -0500:

> On Mon, Oct 24, 2022 at 3:14 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Rob,
> >
> > robh@kernel.org wrote on Fri, 21 Oct 2022 15:39:28 -0500:
> > =20
> > > Add support for the Arm PL354 static memory controller to the existing
> > > Arm PL353 binding. Both are different configurations of the same IP w=
ith
> > > support for different types of memory interfaces.
> > >
> > > The 'arm,pl354' binding has already been in use upstream for a long t=
ime
> > > in Arm development boards. The existing users have only the controller
> > > without any child devices, so drop the required address properties
> > > (ranges, #address-cells, #size-cells). The schema for 'ranges' is too
> > > constrained as the order is not important and the PL354 has 8
> > > chipselects (And the PL353 actually has up to 8 too). =20
> >
> > I'm not convinced the ranges constraint should be soften. For me
> > the order was important (and the description in the yaml useful, but
> > that's a personal opinion). What makes you think the ranges order is
> > not relevant on PL353? =20
>=20
> Address translation looks for a matching entry, so order doesn't
> matter. However, we have seen cases in PCI hosts where the driver
> populates registers based on the order of ranges. That's a driver
> problem IMO. For PCI, it was multiple entries of the same type. For
> this, we have the chip select number in the entry, so we shouldn't
> have the same sort of problem. Except there is another issue that the
> SRAM interface chipselects are numbered 1 and 2. The PL353 can have 4
> NAND chipselects, I don't think the host addresses are necessarily in
> order or contiguous either, so you could need 4 entries for NAND. The
> existing description doesn't handle that, and the chipselects for the
> SRAM interface should have been numbered 4-7. I don't mind saying the
> entries should be in order by chipselect, but we can't define indices
> of the entries as was done. It's all kind of academic because we don't
> have any h/w needing anything else though the Arm boards would if the
> child nodes actually got defined (not likely at this point).

Alright, thanks for the feedback.

Cheers,
Miqu=C3=A8l
