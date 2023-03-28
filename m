Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BB6CC502
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjC1PLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC1PLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:11:38 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2EEEC4E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:10:41 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 3D8A9162E7F;
        Tue, 28 Mar 2023 17:07:40 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680016060; bh=+/3nvo1yYXim8zKDDEGS5Ln3cTmFtDCEk+Ab9n7rpdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJdGEF4sm5cpMC96PhA7CJdP7X4/E2TDIlbCRhbxzRSrN7aeY+0D6JFo5YseQbKMc
         c9QmAA7jyYGyo7QK+uvFpNH4J4xnuDt+KEOkTjiPwoJuqkeKreOK+27iV1dd9w2ydF
         /A0DgOf70+M6yhkIDp3jEHqw/1UelXANFOwpsRxQ/DDe440of55Dy/NrzDvtGIMNYL
         PzIDxwkAA6sidCbdxDDTMfdH+PfVAnh5xuyT0NkkqsuukcblNvHP1TxCK/AUh+OqPm
         Z9uk4pFt3dYEvHsVbvCFwxY/wKq+Ohbk9Ga7toFWjHOXWTizA9EallH57bdHWszCaz
         U7fbsGkU79MSQ==
Date:   Tue, 28 Mar 2023 17:07:39 +0200
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
Message-ID: <20230328170739.10e33345@meshulam.tesarici.cz>
In-Reply-To: <BYAPR21MB1688983A72B114BBC3AA1DE2D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
        <ZCJEAx/G0x6zokPF@infradead.org>
        <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
        <20230328155017.5636393b@meshulam.tesarici.cz>
        <BYAPR21MB1688983A72B114BBC3AA1DE2D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Tue, 28 Mar 2023 14:29:03 +0000
"Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Tuesday, March 28, =
2023 6:50 AM
> >=20
> > On Tue, 28 Mar 2023 13:12:13 +0000
> > "Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
> >  =20
> > > From: Christoph Hellwig <hch@infradead.org> Sent: Monday, March 27, 2=
023 6:34 =20
> > PM =20
> > > >
> > > > On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote: =20
> > > > > @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct devi=
ce *dev, int =20
> > > > area_index, =20
> > > > >   area->index =3D wrap_area_index(mem, index + nslots);
> > > > >   area->used +=3D nslots;
> > > > >   spin_unlock_irqrestore(&area->lock, flags);
> > > > > +
> > > > > + new_used =3D atomic_long_add_return(nslots, &total_used);
> > > > > + old_hiwater =3D atomic_long_read(&used_hiwater);
> > > > > + do {
> > > > > +         if (new_used <=3D old_hiwater)
> > > > > +                 break;
> > > > > + } while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, =
new_used));
> > > > > +
> > > > >   return slot_index; =20
> > > >
> > > > Hmm, so we're right in the swiotlb hot path here and add two new gl=
obal
> > > > atomics? =20
>[...]
> > For my purposes, it does not have to be 100% accurate. I don't really
> > mind if it is off by a few slots because of a race window, so we could
> > (for instance):
> >=20
> > - update a local variable and set the atomic after the loop,
> > - or make it a per-cpu to reduce CPU cache bouncing,
> > - or just about anything that is less heavy-weight than an atomic
> >   CMPXCHG in the inner loop of a slot search.
> >  =20
>=20
> Perhaps I'm missing your point, but there's no loop here.  The atomic
> add is done once per successful slot allocation.  If swiotlb_do_find_slot=
s()
> doesn't find any slots for the current area, it exits at the "not_found" =
label
> and the atomic add isn't done.

My bad. I read the patch too quickly and thought that the update was
done for each searched area. I stay corrected here.

>[...]
> I thought about tracking the high water mark on a per-CPU basis or
> per-area basis, but I don't think the resulting data is useful.  Adding up
> the individual high water marks likely significantly over-estimates the
> true high water mark.   Is there a clever way to make this useful that I'm
> not thinking about?

No, not that I'm aware of. Min/max cannot be easily split.

>[...]
> Regarding your other email about non-default io_tlb_mem instances,
> my patch just extends what is already reported in debugfs, which
> is only for the default io_tlb_mem.   The non-default instances seemed
> to me to be fairly niche cases that weren't worth the additional
> complexity, but maybe I'm wrong about that.

What I mean is that the values currently reported in debugfs only refer
to io_tlb_default_mem. Since restricted DMA pools also use
swiotlb_find_slots() and swiotlb_release_slots(), the global counters
now get updated both for io_tlb_default_mem and all restricted DMA
pools.

In short, this hunk is a change in behaviour:

 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val =3D mem_used(&io_tlb_default_mem);
+	*val =3D (u64)atomic_long_read(&total_used);
 	return 0;
 }

Before the change, it shows the number of used slots in the default
SWIOTLB, after the change it shows the total number of used slots in
the SWIOTLB and all restricted DMA pools.

Petr T
