Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3A6CC1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjC1OHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1OHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:07:16 -0400
X-Greylist: delayed 935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 07:06:01 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7A19BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:06:00 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id D9432164B37;
        Tue, 28 Mar 2023 16:04:30 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680012271; bh=dLhHv/WzPGJpZ6GUidyDbJHkEOMAUN6OwnftRnlmPa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxokpOgzIdS3rZkEtLatMm7RHGP1IN6GS5a/cZD6tpboCaE2gnDkxguu2AD4LLCd2
         1UvcWl6Lw3jlx8176Y5MNYU75Zxo/LCeXqJfP5TJgmZ3klar4sIl70wUG3C6BKjfc6
         hXAGiurLDmR8FGD9XvcAwkNMD+zYSz3rzLOsvS+cG0kP48WIzmBUm/Ga8UTemlDzcV
         kmGYDXPW5Kr/6KLhq21wu5VfCyEiVd1k/u+mUkGvgrVQZ/il6689eRtVKk4k0l27Gx
         gHcffZHwPlg7MG2h5VWjxdZvc4cz+ZdIoLBc5BGDIzr4Q77R5FSr3Tav+wQQvvUPaU
         xzR0BG75E3vZw==
Date:   Tue, 28 Mar 2023 16:04:29 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Message-ID: <20230328160429.38f58623@meshulam.tesarici.cz>
In-Reply-To: <20230328155017.5636393b@meshulam.tesarici.cz>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
        <ZCJEAx/G0x6zokPF@infradead.org>
        <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
        <20230328155017.5636393b@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 15:50:17 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Tue, 28 Mar 2023 13:12:13 +0000
> "Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
>=20
> > From: Christoph Hellwig <hch@infradead.org> Sent: Monday, March 27, 202=
3 6:34 PM =20
> > >=20
> > > On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote:   =20
> > > > @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device=
 *dev, int   =20
> > > area_index,   =20
> > > >  	area->index =3D wrap_area_index(mem, index + nslots);
> > > >  	area->used +=3D nslots;
> > > >  	spin_unlock_irqrestore(&area->lock, flags);
> > > > +
> > > > +	new_used =3D atomic_long_add_return(nslots, &total_used);
> > > > +	old_hiwater =3D atomic_long_read(&used_hiwater);
> > > > +	do {
> > > > +		if (new_used <=3D old_hiwater)
> > > > +			break;
> > > > +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, ne=
w_used));
> > > > +
> > > >  	return slot_index;   =20
> > >=20
> > > Hmm, so we're right in the swiotlb hot path here and add two new glob=
al
> > > atomics?   =20
> >=20
> > It's only one global atomic, except when the high water mark needs to be
> > bumped.  That results in an initial transient of doing the second global
> > atomic, but then it won't be done unless there's a spike in usage or the
> > high water mark is manually reset to zero.  Of course, there's a similar
> > global atomic subtract when the slots are released.
> >=20
> > Perhaps this accounting should go under #ifdef CONFIG_DEBUGFS?  Or
> > even add a swiotlb-specific debugfs config option to cover all the swio=
tlb
> > debugfs code.  From Petr Tesarik's earlier comments, it sounds like the=
re
> > is interest in additional accounting, such as for fragmentation. =20
>=20
> For my purposes, it does not have to be 100% accurate.

Actually, why are these variables global? There can be multiple
io_tlb_mem instances in the system (one SWIOTLB and multiple restricted
DMA pools). Tracking the usage of restricted DMA pools might be useful,
but summing them up with the SWIOTLB not so much. AFAICS the watermark
should be added to struct io_tlb_mem.

Petr T
