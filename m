Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB76DAB50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjDGKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:16:01 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268F86A6;
        Fri,  7 Apr 2023 03:15:59 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 4239D14B818;
        Fri,  7 Apr 2023 12:15:56 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680862556; bh=PaIGonr5JMM+Z9od4ricOA/7Hr3fGMxSQp5ApjSQwqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DNqwBXXvCxQ8a7C2kJ5An/Ucg5U5OkUQ3Utahbqx2rhCY7B/Gw1j8zQS7oQO2PK4d
         OEOwIAQ+FoFE86ayjF16PfihXWG0zgOB4Onzs+jpTaLweXTG8jddQXY/W643jq8Ak3
         I6a/GBljeXX9H4JaINyEH9bxopBJdZZIQIMCSiw6OVk380au26T+8G9Nu4vfvnkCG/
         mxxDVVk5BljTm5rG82UshnUop9DV1ul8cVmZEDZkHYtvfmAAC93V0v2fRynBvT5HdQ
         MUCbpjgK/DaCkGrhD0k1y6u2xPBQbtVEZ/U/pRv0lVJLHos/u+rX3rhngO1X99kyVg
         M/NJ8vibVVIdw==
Date:   Fri, 7 Apr 2023 12:15:55 +0200
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
Message-ID: <20230407121555.4290a011@meshulam.tesarici.cz>
In-Reply-To: <20230407055704.GD6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
        <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
        <20230328040724.GB25506@lst.de>
        <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
        <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
        <20230407055704.GD6803@lst.de>
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

On Fri, 7 Apr 2023 07:57:04 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Mar 28, 2023 at 02:43:03PM +0200, Petr Tesarik wrote:
> > Oh, wait! I can do at least something for devices which do not use
> > swiotlb at all.
> > 
> > If a device does not use bounce buffers, it cannot pass an address
> > that belongs to the swiotlb. Consequently, the potentially
> > expensive check can be skipped. This avoids the dynamic lookup
> > penalty for devices which do not need the swiotlb.
> > 
> > Note that the counter always remains zero if dma_io_tlb_mem is
> > NULL, so the NULL check is not required.  
> 
> Hmm, that's yet another atomic for each map/unmap, and bloats
> struct device.

I'm not sure how bad it is to bloat struct device. It is already quite
large, e.g. in my x86 build it is 768 bytes (exact size depends on
config options), and nobody seems to be concerned...

Regarding the atomic operations, I am currently testing a slightly
different approach, which merely sets a flag if there are any
dynamically allocated bounce buffers. The atomic check changes to
smp_load_acquire(), and the atomic inc/dec to smp_store_release()
only if the flag changes. That said, if I hammer this path with heavy
parallel I/O, I can still see some performance cost for devices that
use swiotlb, but at least devices that do not need such bounce buffers
seem to be unaffected then.

> (Btw, in case anyone is interested, we really need to get started
> on moving the dma fields out of struct device into a sub-struct
> only allocated for DMA capable busses)

I like this idea. In fact, my WIP topic branch now moves the swiotlb
fields into a separate struct, but I can surely go further and move all
DMA-related fields. I doubt it is worth to allocate it separately,
though. We are talking about replacing some 100 bytes (in the worst
case) with a pointer to a dynamically allocated struct, but the
dynamic allocator adds some overhead. I believe it pays off only if the
vast majority of struct device instances do not need these DMA fields,
but is that really the case?

Petr T
