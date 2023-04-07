Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3A6DAB99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDGKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDGKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:46:32 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540C8A6B;
        Fri,  7 Apr 2023 03:46:31 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 1092814C886;
        Fri,  7 Apr 2023 12:46:28 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680864389; bh=fwSxeONAMiIQulvFLbEmRpW+yUKJFrnFHkYYi44Vd7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=4sM1CUkjmwVelOaTnEWeo9CIORmocDgOnSm0PWyS3bTKcFjrsk3FFguLF/n3mLz/E
         3FoHV2DRuDICL7NYBgu8Ix0LvbyLUqJSmLyuyzj4H4Yy/7NQggJSL/YZLshclFDVkD
         P/4Jsb3ODIIc5bGUkHW2zYV644QtsGrzxmoKsn47ROm6bnfneRTtQU6TkIT0+OjH0z
         mzU6gVssjml8+15sN8QdeXwlMSr5YdeVfyNGqE0lvJWrnBAjwt4C3qk2Txo3w7ZqNh
         p5l2MT4qljaJSVYjPre2Ly1hog7j6GZDOapB+X486jTBzpSQlUK/VVPBrITo2W44fW
         sxVsi3ES64ziQ==
Date:   Fri, 7 Apr 2023 12:46:27 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230407124627.74528415@meshulam.tesarici.cz>
In-Reply-To: <20230407055548.GC6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
        <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
        <20230328040724.GB25506@lst.de>
        <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
        <20230407055548.GC6803@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 07:55:48 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Mar 28, 2023 at 09:54:35AM +0200, Petr Tesarik wrote:
> > I tend to agree here. However, it's the DMABUF design itself that causes
> > some trouble. The buffer is allocated by the v3d driver, which does not
> > have the restriction, so the DMA API typically allocates an address
> > somewhere near the 4G boundary. Userspace then exports the buffer, sends
> > it to another process as a file descriptor and imports it into the vc4
> > driver, which requires DMA below 1G. In the beginning, v3d had no idea
> > that the buffer would be exported to userspace, much less that it would
> > be later imported into vc4.  
> 
> Then we need to either:
> 
>  a) figure out a way to communicate these addressing limitations

AFAICS this would require a complete overhaul of the dma-buf userspace
API so that intended imports are communicated at export time. In other
words, it would be quite intrusive. Not my preferrence.

>  b) find a way to migrate a buffer into other memory, similar to
>     how page migration works for page cache

Let me express the idea in my own words to make sure I get it right.
When a DMA buffer is imported, but before it is ultimately pinned in
memory, the importing device driver checks whether the buffer meets its
DMA constraints. If not, it calls a function provided by the exporting
device driver to migrate the buffer. This makes sense, but:

  1) The operation must be implemented in the exporting driver; this
     will take some time.

  2) In theory, there may be no overlap between the exporting device
     and the importing device. OTOH I'm not aware of any real-world
     example, so we can probably return a suitable error code, and
     that's it.

Anyway, I have already written in another reply that my original use
case is moot, because a more recent distribution can do the job without
using dma-buf, so it has been fixed in user space, be it in GNOME,
pipewire, or Mesa (I don't really have to know).

At this point I would go with the assumption that large buffers
allocated by media subsystems will not hit swiotlb. Consequently, I
don't plan to spend more time on this branch of the story.

> > BTW my testing also suggests that the streaming DMA API is quite
> > inefficient, because UAS performance _improved_ with swiotlb=force.
> > Sure, this should probably be addressed in the UAS and/or xHCI driver,
> > but what I mean is that moving away from swiotlb may even cause
> > performance regressions, which is counter-intuitive. At least I would
> > _not_ have expected it.  
> 
> That is indeed very odd.  Are you running with a very slow iommu
> driver there?   Or what is the actual use case there in general?

This was on a Raspberry Pi 4, which does not have any IOMMU. IOW it
looks like copying data around can be faster than sending it straight
to the device. When I have some more time, I must investigate what is
really happening there, because it does not make any sense to me.

Petr T
