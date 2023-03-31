Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1C6D188D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCaH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCaH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:26:35 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE383ED;
        Fri, 31 Mar 2023 00:26:32 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1680247588; x=1680506788;
        bh=uVwhpYDZIIdj+265twvljuSYRqJy0izgHprDWPhFAdk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hw6VZAVNB4YexoRNxps4VHNqNH/PrhjbJFt6BrwyKOapdfq698yksDCDKevKNSRpB
         yUNI98DJav/sC2Oqw1nb9rpJqKiL0gZHNDUevqGD6eAJuZEjbqmIteuVn0KW2pW5u0
         Za1bxHpkPNek/QDWs95QZO0nEp/9l1T568xgiiWdT4wEdXtXWDnwJcUgGnPNtXkprZ
         lhhMzJTj9Eq8FAq5jahb3oUc8nhnbZYLAwSbYoVfVYTDb97ad6o+IQuYXa989ueAlz
         dwHtt2ndeX67oFAy/KkJPHDVejIM9Ui28A/rvlu5mP586ro49OANNWPxlh99C+6oUc
         xMuUCzefuj0hA==
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
From:   Juerg Haefliger <juergh@proton.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Message-ID: <20230331092553.677e9649@smeagol>
In-Reply-To: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
References: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_RX1JEplCPdOoZLmijgm2vZMNZS7zoj4VjnqCNmqCo"
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_RX1JEplCPdOoZLmijgm2vZMNZS7zoj4VjnqCNmqCo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2023 09:54:35 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> On 3/28/2023 6:07 AM, Christoph Hellwig wrote:
> > [adding Alex as he has been interested in this in the past]
> >
> > On Mon, Mar 20, 2023 at 01:28:15PM +0100, Petr Tesarik wrote:
> >> Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
> >> moved from the rendering GPU (v3d driver), which can access all
> >> memory, to the display output (vc4 driver), which is connected to a
> >> bus with an address limit of 1 GiB and no IOMMU. These buffers can
> >> be large (several megabytes) and cannot be handled by SWIOTLB,
> >> because they exceed maximum segment size of 256 KiB. Such mapping
> >> failures can be easily reproduced on a Raspberry Pi4: Starting
> >> GNOME remote desktop results in a flood of kernel messages like
> >> these:
> >
> > Shouldn't we make sure dma-buf allocates the buffers for the most
> > restricted devices, and more importantly does something like a dma
> > coherent allocation instead of a dynamic mapping of random memory?
> >
> > While a larger swiotlb works around this I don't think this fixes the r=
oot
> > cause.
>
> I tend to agree here. However, it's the DMABUF design itself that causes
> some trouble. The buffer is allocated by the v3d driver, which does not
> have the restriction, so the DMA API typically allocates an address
> somewhere near the 4G boundary. Userspace then exports the buffer, sends
> it to another process as a file descriptor and imports it into the vc4
> driver, which requires DMA below 1G. In the beginning, v3d had no idea
> that the buffer would be exported to userspace, much less that it would
> be later imported into vc4.
>
> Anyway, I suspected that the buffers need not be imported into the vc4
> driver (also hinted by Eric Anholt in a 2018 blog post [1]), and it
> seems I was right. I encountered the issue with Ubuntu 22.10; I
> installed latest openSUSE Tumbleweed yesterday, and I was not able to
> reproduce the issue there, most likely because the Mesa drivers have
> been fixed meanwhile. This makes the specific case of the Raspberry Pi 4
> drivers moot. The issue may still affect other combinations of drivers,
> but I don't have any other real-world example ATM.

I'm only seeing this problem with Wayland, no issue when switching Ubuntu t=
o
X. It seems Tumbleweed is using X by default.

...Juerg


> [1] https://anholt.github.io/twivc4/2018/02/12/twiv/
>
> >> 1. The value is limited to ULONG_MAX, which is too little both for
> >>    physical addresses (e.g. x86 PAE or 32-bit ARM LPAE) and DMA
> >>    addresses (e.g. Xen guests on 32-bit ARM).
> >>
> >> 2. Since buffers are currently allocated with page granularity, a
> >>    PFN can be used instead. However, some values are reserved by
> >>    the maple tree implementation. Liam suggests to use
> >>    xa_mk_value() in that case, but that reduces the usable range by
> >>    half. Luckily, 31 bits are still enough to hold a PFN on all
> >>    32-bit platforms.
> >>
> >> 3. Software IO TLB is used from interrupt context. The maple tree
> >>    implementation is not IRQ-safe (MT_FLAGS_LOCK_IRQ does nothing
> >>    AFAICS). Instead, I use an external lock, spin_lock_irqsave() and
> >>    spin_unlock_irqrestore().
> >>
> >> Note that bounce buffers are never allocated dynamically if the
> >> software IO TLB is in fact a DMA restricted pool, which is intended
> >> to be stay in its designated location in physical memory.
> >
> > I'm a little worried about all that because it causes quite a bit
> > of overhead even for callers that don't end up going into the
> > dynamic range or do not use swiotlb at all.  I don't really have a
> > good answer here except for the usual avoid bounce buffering whenever
> > you can that might not always be easy to do.
>
> I'm also worried about all this overhead. OTOH I was not able to confirm
> it, because the difference between two successive fio test runs on an
> unmodified kernel was bigger than the difference between a vanilla and a
> patched kernel, except the maximum completion latency, which OTOH
> affected less than 0.01% of all requests.
>
> BTW my testing also suggests that the streaming DMA API is quite
> inefficient, because UAS performance _improved_ with swiotlb=3Dforce.
> Sure, this should probably be addressed in the UAS and/or xHCI driver,
> but what I mean is that moving away from swiotlb may even cause
> performance regressions, which is counter-intuitive. At least I would
> _not_ have expected it.
>
> >> +=09gfp =3D (attrs & DMA_ATTR_MAY_SLEEP) ? GFP_KERNEL : GFP_NOWAIT;
> >> +=09slot =3D kmalloc(sizeof(*slot), gfp | __GFP_NOWARN);
> >> +=09if (!slot)
> >> +=09=09goto err;
> >> +
> >> +=09slot->orig_addr =3D orig_addr;
> >> +=09slot->alloc_size =3D alloc_size;
> >> +=09slot->page =3D dma_direct_alloc_pages(dev, PAGE_ALIGN(alloc_size),
> >> +=09=09=09=09=09    &slot->dma_addr, dir,
> >> +=09=09=09=09=09    gfp | __GFP_NOWARN);
> >> +=09if (!slot->page)
> >> +=09=09goto err_free_slot;
> >
> > Without GFP_NOIO allocations this will deadlock eventually.
>
> Ah, that would affect the non-sleeping case (GFP_KERNEL), right?
>
> Petr T
>


--b1_RX1JEplCPdOoZLmijgm2vZMNZS7zoj4VjnqCNmqCo
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbVFtaXdFQUNna1FEOU9MQ1F1bQ0KUXJkR2dBLy9icjU5YUxH
S3hSSC9vOC9nUzdnMlVQb1NkVVdZUHg1MjdMTWJ5NkorQnZXY2I4aEo0dTJZNTJrTQ0KcUlBQkRJ
RHpZaU13K1FkZExBUjlWMzY1WGNBYWtxU2JoZi9iUThDS1FKOG90OHBJWDNqd2laY3p3akloMVJC
Rw0Kc2hmdW1FWFRNTVJsQkZUSGxubFRrd1dtdnNrS2xkVHlPeWNML1c5aERITW0zSm92U0VBQzB6
YlVrZ0YyekIxOA0KZ1gwT0dGd0x1MEZ4VGlJcCtEeE9BREFORXpyeGtTeEwzRU9jUndrWHZzbkJw
Tzl1T0U2bVdZQmZQdWY0aGQ0Zw0KN3dKL0VvR2hTdVNRNzBON29MS1NDK1g4K1NCS1R5WURYeE03
RTNENnRUaUY4RkQ5K3RkQ3UxMVBjbmV4SGdPWA0KaVhSazNZcGtQMUFnQ0gxWnJ1ZmVJaXRpMEJD
Y3gzUlhPNU5JQTFlVU55Sjc4eldzaVpPakxaZnBlRWJiTzg1Wg0KNURsWDNIdFN1M2RMVXFOQURW
SUJzY3BZeWNKazBuWHZXcVlRM3AySDlPbmN5TmszdEdZK0ZBOGNhNUhlU0hyTg0KVWpnSklXTGpR
SGprZWg1ekE2a2VQOC9uSDUvYlRTQmtYQVFFT2F4anlUa2pnZnBvQXlaZXFsdEc4ZGVwSkkybg0K
VDh3YlBBTHczMzNCVy8xUGtCeUJJMTRCWGxpWlUrQkxNU2labVpKek9CUUlGeE92ZWZmSG5pc2sx
akVOcUlGeQ0KMXo5a2NLc1gvYUx1WWhSeVhyQmc1QllIa0szOVJFdW5rSVJTd1hIN2JvZ0pnZ2xx
KzMycTEvaXUwMWFxQ0pWbA0KMXpLa1BuUjBETStneTVpMHZMZ00yM29vM0sxQ21sb1h3UkhPOUpw
dGRTMFoyMDByMW5FPQ0KPTlMNlgNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_RX1JEplCPdOoZLmijgm2vZMNZS7zoj4VjnqCNmqCo--

