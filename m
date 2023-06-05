Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96B722E20
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjFESBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjFESBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167910EA;
        Mon,  5 Jun 2023 11:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83077628E4;
        Mon,  5 Jun 2023 18:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BDEC433D2;
        Mon,  5 Jun 2023 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685988053;
        bh=QzKDnromzr6o+llFm1S5csDJlNa3xNImFeFTlYoWklo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtxHaSMp2YWFbafHhlGHF6pUV1Teos2yRuiFqv24KtoTfse5mHSTqXapqsataBVNB
         rs71h69BOcTVNBToYl/GzbVc+CPg/Bg3dQ8vKAQZ/j5i9LEjTnYv3a6ruotKUezESl
         2jnGYAdBMM/6fCOI2nrqp+BTog8im4jQ3ycbXo7PFxLIj2qXFeGRa4M/L7cl0TGZ14
         f9BoeHIxyqZ6D028ddeP1BQl24X4KjPy9mbHVf9p8tW3kK/WD0TNjSN9+UOxKaatdX
         0xDs64jeFi+FJjzCZbZADUjVfX3P9r5jWZxukaHSobod+ZRNjHxQHFL+/TfgcU9iEw
         obnEhASd/LxFw==
Date:   Mon, 5 Jun 2023 19:00:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <20230605190046.63c98b3e@sal.lan>
In-Reply-To: <88d8a7c3-0018-cc9a-13aa-e3262e20e4aa@leemhuis.info>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
        <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
        <20230605113727.69e7f309@sal.lan>
        <88d8a7c3-0018-cc9a-13aa-e3262e20e4aa@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 5 Jun 2023 12:44:43 +0200
Thorsten Leemhuis <regressions@leemhuis.info> escreveu:

> On 05.06.23 12:37, Mauro Carvalho Chehab wrote:
> > Em Mon, 5 Jun 2023 11:38:49 +0200
> > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.i=
nfo> escreveu:
> >  =20
> >> Hi, Thorsten here, the Linux kernel's regression tracker.
> >>
> >> On 30.05.23 13:12, Thomas Voegtle wrote: =20
> >>>
> >>> I have the problem that sometimes my DVB card does not initialize
> >>> properly booting Linux 6.4-rc4.
> >>> This is not always, maybe in 3 out of 4 attempts.
> >>> When this happens somehow you don't see anything special in dmesg, but
> >>> the card just doesn't work.
> >>>
> >>> Reverting this helps:
> >>> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
> >>> Author: Hyunwoo Kim <imv4bel@gmail.com>
> >>> Date:=C2=A0=C2=A0 Thu Nov 17 04:59:22 2022 +0000
> >>>
> >>> =C2=A0=C2=A0=C2=A0 media: dvb-core: Fix use-after-free on race condit=
ion at dvb_frontend
> >>>
> >>>
> >>> I have:
> >>> 03:00.0 Multimedia video controller [0400]: Conexant Systems, Inc.
> >>> CX23887/8
> >>> PCIe Broadcast Audio and Video Decoder with 3D Comb [14f1:8880] (rev =
04)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Hauppauge compu=
ter works Inc. Device [0070:c138]
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: cx23=
885   =20
> >>
> >> Hmmm, that was posted last Tuesday and received not a single reply. :-/
> >>
> >> Hyunwoo Kim: could you please look at it, as it's a regression caused =
by
> >> a commit of yours (one that would be good to solve before 6.4 is
> >> finalized!)? And in case you are unable to do so let us know?
> >>
> >> But FWIW:
> >>
> >> Mauro: I wonder if this is something you or someone else has to look
> >> into, as Hyunwoo Kim posted a few times per months to Linux lists, but
> >> according  to a quick search on lore hasn't posted anything since ~two
> >> months now. :-/ =20
> >=20
> > Yeah, I was slow applying this one, as I was afraid of it to cause
> > troubles. The DVB frontend state machine is complex, and uses a
> > semaphore to update its state. There was some past attempts of
> > addressing some lifetime issues there that we ended needing to revert
> > or not being applied, as the fix caused more harm than good.
> > [...] =20
>=20
> Thx for the update. That's unfortunate, but how it is sometimes. Which
> leads to a follow-up question: is reverting the culprit temporarily an
> option? Or did those old use-after-free problems became known to be a
> problem we can't live with anymore for another few months?

Reverting the patch seems to be the way to proceed. Then, work on another
way to address UAF.=20

I'm not aware of dvb users complaining about troubles due to UAF, although=
=20
it seems that there's now a CVE for it. So, maybe someone complained against
a distro Kernel, which caused the CVE to be opened.

So, while it is nice to have the lifetime issues fixed, last time I checked,
the USB dvb-usb/dvb-usb-v2 have some logic that usually prevents it to caus=
e=20
real issues during device removal, and unbinding DVB PCIe devices is=20
something that users don't do in practice.

Regards,
Mauro
