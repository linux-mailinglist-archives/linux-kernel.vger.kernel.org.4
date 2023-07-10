Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2374D1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGJJjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGJJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:39:03 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3619358C;
        Mon, 10 Jul 2023 02:36:46 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id E30F414808A;
        Mon, 10 Jul 2023 11:36:19 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1688981780; bh=cEGhRoXPGRpwdgEcYnOlQCfMzy6z9NfW6eHFlWupbSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XABk4b2xj/95NSII8KdLFD9UXbqReOD/JSMT78/awbRfpUBqfGBkx8UaOP7uLhMBC
         3ilozKe2ETT4f5Fu81wNHDCN07rfMRv27v/9Xz75qERHzeG33+YIPLfvMTvoepShXB
         bp2X4b8fPNU/Y7K2HLpKLrrq+yf2U2JAokof6WBFlaoG05B6pU1H78/xgPW15MdaqE
         BfIGVqnvqysxdQ4LOZdewoT61n6Z6aso0jS/C+m9Ibd4l2WgvIliFFmHeTIN46rnAB
         VG7cMrMlXNhKuXURvWmxWocykbHhVETgX2QSYY2w6dFYQnLEHCYsWEc7f2hvRbUR7/
         o2NH4pbmYxXYQ==
Date:   Mon, 10 Jul 2023 11:36:18 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Message-ID: <20230710113618.2038e033@meshulam.tesarici.cz>
In-Reply-To: <BYAPR21MB1688D3AC0C094420733717C4D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
        <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
        <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070626-boxcar-bubbly-471d@gregkh>
        <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070706-humbling-starfish-c68f@gregkh>
        <20230707122213.3a7378b5@meshulam.tesarici.cz>
        <BYAPR21MB1688D3AC0C094420733717C4D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 15:18:32 +0000
"Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, July 7, 202=
3 3:22 AM
> >=20
> > On Fri, 7 Jul 2023 10:29:00 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Thu, Jul 06, 2023 at 02:22:50PM +0000, Michael Kelley (LINUX) wrot=
e: =20
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursda=
y, July 6, =20
> > 2023 1:07 AM =20
> > > > >
> > > > > On Thu, Jul 06, 2023 at 03:50:55AM +0000, Michael Kelley (LINUX) =
wrote: =20
> > > > > > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday,=
 June 27, 2023 =20
> > > > > 2:54 AM =20
> > > > > > >
> > > > > > > Try to allocate a transient memory pool if no suitable slots =
can be found,
> > > > > > > except when allocating from a restricted pool. The transient =
pool is just
> > > > > > > enough big for this one bounce buffer. It is inserted into a =
per-device
> > > > > > > list of transient memory pools, and it is freed again when th=
e bounce
> > > > > > > buffer is unmapped.
> > > > > > >
> > > > > > > Transient memory pools are kept in an RCU list. A memory barr=
ier is
> > > > > > > required after adding a new entry, because any address within=
 a transient
> > > > > > > buffer must be immediately recognized as belonging to the SWI=
OTLB, even if
> > > > > > > it is passed to another CPU.
> > > > > > >
> > > > > > > Deletion does not require any synchronization beyond RCU orde=
ring
> > > > > > > guarantees. After a buffer is unmapped, its physical addresse=
s may no
> > > > > > > longer be passed to the DMA API, so the memory range of the c=
orresponding
> > > > > > > stale entry in the RCU list never matches. If the memory rang=
e gets
> > > > > > > allocated again, then it happens only after a RCU quiescent s=
tate.
> > > > > > >
> > > > > > > Since bounce buffers can now be allocated from different pool=
s, add a
> > > > > > > parameter to swiotlb_alloc_pool() to let the caller know whic=
h memory pool
> > > > > > > is used. Add swiotlb_find_pool() to find the memory pool corr=
esponding to
> > > > > > > an address. This function is now also used by is_swiotlb_buff=
er(), because
> > > > > > > a simple boundary check is no longer sufficient.
> > > > > > >
> > > > > > > The logic in swiotlb_alloc_tlb() is taken from __dma_direct_a=
lloc_pages(),
> > > > > > > simplified and enhanced to use coherent memory pools if neede=
d.
> > > > > > >
> > > > > > > Note that this is not the most efficient way to provide a bou=
nce buffer,
> > > > > > > but when a DMA buffer can't be mapped, something may (and wil=
l) actually
> > > > > > > break. At that point it is better to make an allocation, even=
 if it may be
> > > > > > > an expensive operation. =20
> > > > > >
> > > > > > I continue to think about swiotlb memory management from the st=
andpoint
> > > > > > of CoCo VMs that may be quite large with high network and stora=
ge loads.
> > > > > > These VMs are often running mission-critical workloads that can=
't tolerate
> > > > > > a bounce buffer allocation failure.  To prevent such failures, =
the swiotlb
> > > > > > memory size must be overly large, which wastes memory. =20
> > > > >
> > > > > If "mission critical workloads" are in a vm that allowes overcomm=
it and
> > > > > no control over other vms in that same system, then you have worse
> > > > > problems, sorry.
> > > > >
> > > > > Just don't do that.
> > > > > =20
> > > >
> > > > No, the cases I'm concerned about don't involve memory overcommit.
> > > >
> > > > CoCo VMs must use swiotlb bounce buffers to do DMA I/O.  Current sw=
iotlb
> > > > code in the Linux guest allocates a configurable, but fixed, amount=
 of guest
> > > > memory at boot time for this purpose.  But it's hard to know how mu=
ch
> > > > swiotlb bounce buffer memory will be needed to handle peak I/O load=
s.
> > > > This patch set does dynamic allocation of swiotlb bounce buffer mem=
ory,
> > > > which can help avoid needing to configure an overly large fixed siz=
e at boot. =20
> > >
> > > But, as you point out, memory allocation can fail at runtime, so how =
can
> > > you "guarantee" that this will work properly anymore if you are going=
 to
> > > make it dynamic? =20
> >=20
> > In general, there is no guarantee, of course, because bounce buffers
> > may be requested from interrupt context. I believe Michael is looking
> > for the SWIOTLB_MAY_SLEEP flag that was introduced in my v2 series, so
> > new pools can be allocated with GFP_KERNEL instead of GFP_NOWAIT if
> > possible, and then there is no need to dip into the coherent pool.
> >=20
> > Well, I have deliberately removed all complexities from my v3 series,
> > but I have more WIP local topic branches in my local repo:
> >=20
> > - allow blocking allocations if possible
> > - allocate a new pool before existing pools are full
> > - free unused memory pools
> >=20
> > I can make a bigger series, or I can send another series as RFC if this
> > is desired. ATM I don't feel confident enough that my v3 series will be
> > accepted without major changes, so I haven't invested time into
> > finalizing the other topic branches.
> >=20
> > @Michael: If you know that my plan is to introduce blocking allocations
> > with a follow-up patch series, is the present approach acceptable?
> >  =20
>=20
> Yes, I think the present approach is acceptable as a first step.  But
> let me elaborate a bit on my thinking.
>=20
> I was originally wondering if it is possible for swiotlb_map() to detect
> whether it is called from a context that allows sleeping, without the use
> of SWIOTLB_MAY_SLEEP.   This would get the benefits without having to
> explicitly update drivers to add the flag.  But maybe that's too risky.

This is a recurring topic and it has been discussed several times in
the mailing lists. If you ask me, the best answer is this one by Andrew
Morton, albeit a bit dated:

https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundation.=
org/

> For
> the CoCo VM scenario that I'm most interested in, being a VM implicitly
> reduces the set of drivers that are being used, and so it's not that hard
> to add the flag in the key drivers that generate most of the bounce
> buffer traffic.

Yes, that's my thinking as well.

> Then I was thinking about a slightly different usage for the flag than wh=
at
> you implemented in v2 of the series.   In the case where swiotlb_map()
> can't allocate slots because of the swiotlb pool being full (or mostly fu=
ll),
> kick the background thread (if it is not already awake) to allocate a
> dynamic pool and grow the total size of the swiotlb.  Then if
> SWIOTLB_MAY_SLEEP is *not* set, allocate a transient pool just as you
> have implemented in this v3 of the series.  But if SWIOTLB_MAY_SLEEP
> *is* set, swiotlb_map() should sleep until the background thread has
> completed the memory allocation and grown the size of the swiotlb.
> After the sleep, retry the slot allocation.  Maybe what I'm describing
> is what you mean by "allow blocking allocations".  :-)

Not really, but I like the idea. After all, the only reason to have
transient pools is when something is needed immediately while the
background allocation is running.

> This approach effectively throttles incoming swiotlb requests when space
> is exhausted, and gives the dynamic sizing mechanism a chance to catch
> up in an efficient fashion.  Limiting transient pools to requests that ca=
n't
> sleep will reduce the likelihood of exhausting the coherent memory
> pools.  And as you mentioned above, kicking the background thread at the
> 90% full mark (or some such heuristic) also helps the dynamic sizing
> mechanism keep up with demand.

FWIW I did some testing, and my systems were not able to survive a
sudden I/O peak without transient pools, no matter how low I set the
threshold for kicking a background. OTOH I always tested with the
smallest possible SWIOTLB (256 KiB * rounded up number of CPUs, e.g. 16
MiB on my VM with 48 CPUs). Other sizes may lead to different results.

As a matter of fact, the size of the initial SWIOTLB memory pool and the
size(s) of additional pool(s) sound like interesting tunable parameters
that I haven't explored in depth yet.

Petr T
