Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF56F13DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjD1JHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345644AbjD1JHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:07:43 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6BD4696;
        Fri, 28 Apr 2023 02:07:40 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 35F29166B6C;
        Fri, 28 Apr 2023 11:07:36 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1682672856; bh=fSr4PauhzPiknlEm9f1x9jaf0EP4/nRRsNaPi7F6oq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1A8Aj6vFQ9OMmP4Cog+6T6QXa6fal+LKll7jPxBdWh6gTHb2NcCWIT2opzUFnClcm
         Za3pILziDiG1G2Q/pHQ3reYCGVThne+WvgK0/PjHdMoO7NngsBiq4CC4zmTYXRY1KQ
         cpEb/ECwMtXQjwn9MSSUQ8uefBRj5PZnuuHLwkdC7a/FDc70XAuIuxc5VdK6dIpADs
         HCDxS0hRuxWR+cbRkQHYSg02dDuJm0khJ5+iy7w2qU9Xoh2PeLY0UvhUfW0xWGolMD
         1wahwh0CIrIH0ErPk+m47YLjZlY2HM0Klgzmx87U/YnSF209NU+v8CL7UuRW8qkICN
         n3CH65zUiUaMQ==
Date:   Fri, 28 Apr 2023 11:07:35 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Muchun Song <muchun.song@linux.dev>,
        Ondrej Zary <linux@zary.sk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230428110735.4348511d@meshulam.tesarici.cz>
In-Reply-To: <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
        <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 09:53:38 +0100
Mike Lothian <mike@fireburn.co.uk> wrote:

> On Wed, 19 Apr 2023 at 11:05, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> >
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >
> > The goal of my work is to provide more flexibility in the sizing of
> > SWIOTLB.
> >
> > The software IO TLB was designed with these assumptions:
> >
> > 1. It would not be used much, especially on 64-bit systems.
> > 2. A small fixed memory area (64 MiB by default) is sufficient to
> >    handle the few cases which require a bounce buffer.
> > 3. 64 MiB is little enough that it has no impact on the rest of the
> >    system.
> >
> > First, if SEV is active, all DMA must be done through shared
> > unencrypted pages, and SWIOTLB is used to make this happen without
> > changing device drivers. The software IO TLB size is increased to
> > 6% of total memory in sev_setup_arch(), but that is more of an
> > approximation. The actual requirements may vary depending on the
> > amount of I/O and which drivers are used. These factors may not be
> > know at boot time, i.e. when SWIOTLB is allocated.
> >
> > Second, other colleagues have noticed that they can reliably get
> > rid of occasional OOM kills on an Arm embedded device by reducing
> > the SWIOTLB size. This can be achieved with a kernel parameter, but
> > determining the right value puts additional burden on pre-release
> > testing, which could be avoided if SWIOTLB is allocated small and
> > grows only when necessary.
> >
> > Changes from v1-devel-v7:
> > - Add comments to acquire/release barriers
> > - Fix whitespace issues reported by checkpatch.pl
> >
> > Changes from v1-devel-v6:
> > - Provide long description of functions
> > - Fix kernel-doc (Returns: to Return:)
> > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> >
> > Changes from RFC:
> > - Track dynamic buffers per device instead of per swiotlb
> > - Use a linked list instead of a maple tree
> > - Move initialization of swiotlb fields of struct device to a
> >   helper function
> > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> > - Introduce per-device flag if dynamic buffers are in use
> > - Add one more user of DMA_ATTR_MAY_SLEEP
> > - Add kernel-doc comments for new (and some old) code
> > - Properly escape '*' in dma-attributes.rst
> >
> > Petr Tesarik (7):
> >   swiotlb: Use a helper to initialize swiotlb fields in struct device
> >   swiotlb: Move code around in preparation for dynamic bounce buffers
> >   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
> >   swiotlb: Dynamically allocated bounce buffers
> >   swiotlb: Add a boot option to enable dynamic bounce buffers
> >   drm: Use DMA_ATTR_MAY_SLEEP from process context
> >   swiotlb: per-device flag if there are dynamically allocated buffers
> >
> >  .../admin-guide/kernel-parameters.txt         |   6 +-
> >  Documentation/core-api/dma-attributes.rst     |  10 +
> >  drivers/base/core.c                           |   4 +-
> >  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
> >  drivers/gpu/drm/drm_prime.c                   |   2 +-
> >  include/linux/device.h                        |  12 +
> >  include/linux/dma-mapping.h                   |   6 +
> >  include/linux/swiotlb.h                       |  54 ++-
> >  kernel/dma/swiotlb.c                          | 382 ++++++++++++++++--
> >  9 files changed, 443 insertions(+), 35 deletions(-)
> >
> > --
> > 2.25.1
> >  
> 
> Hi
> 
> Is this a potential fix for
> https://bugzilla.kernel.org/show_bug.cgi?id=217310 where I'm manually
> setting bigger buffers to keep my wifi working?

Yes. With these patches applied, your system should run just fine with
swiotlb=dynamic. However, keep in mind that this implementation adds a
bit of overhead. In short, it trades a bit of performance for not
having to figure out the optimal swiotlb size at boot time.

Petr T
