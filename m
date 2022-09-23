Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB495E794D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiIWLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIWLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17562A7A8C;
        Fri, 23 Sep 2022 04:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A812062150;
        Fri, 23 Sep 2022 11:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15548C433D6;
        Fri, 23 Sep 2022 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663932008;
        bh=lzkcfA8lwY431cGoFaoDpZ054pCCOOU4vMeBaieOALo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFFgso3bs6An9nGUhg/DG6R6EN9niEPLr2bcvNvSIZeH5Ca/4zD5HH3MAQwNJ5mc9
         +Hc567HPd6/20p6YaNX/Zvv6xT/ckjT9jLPQvD/WGz8mFXi9wWGc+5xCpFYC4T4XZw
         J2QCchDnSDhacfqP44aIabXsMgDbC1DrzUvn9pDZ1hvVgL7+QgzJhX1ywAwW83QAff
         5tr++tEQUnIFI/6oMtIWKFC+RtQAUJUrpM3ED/pvVcV6Y/GAKzQaMKcRFEC7DztYOH
         Au8CuF0rW5ZOStR6byQQubKH+EDX0QcQvObkvdsoCIqJ2ivv7nIVDarHsRqR3Li0Ww
         tr6LGpBwCOQ2w==
Date:   Fri, 23 Sep 2022 14:19:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
Message-ID: <Yy2WUypD5qVmqB0k@kernel.org>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
 <02561695-df44-4df6-c486-1431bf152650@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02561695-df44-4df6-c486-1431bf152650@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

I only had time to skim through the patches and before diving in I'd like
to clarify a few things.

On Mon, Sep 19, 2022 at 06:03:55PM -0700, Doug Berger wrote:
> On 9/19/2022 2:00 AM, David Hildenbrand wrote:
> > 
> > How is this memory currently presented to the system?
>
> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two memory
> controllers (MEMCs). Each MEMC is capable of controlling up to 8GB of DRAM.
> An example 7278 system might have 1GB on each controller, so an arm64 kernel
> might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and 1GB on MEMC1 at
> 0x300000000-0x33FFFFFFF.
> 
> The base capability described in commits 7-15 of this V1 patch set is to
> allow a 'movablecore' block to be created at a particular base address
> rather than solely at the end of addressable memory.

I think this capability is only useful when there is non-uniform access to
different memory ranges. Otherwise it wouldn't matter where the movable
pages reside. The system you describe looks quite NUMA to me, with two
memory controllers, each for accessing a partial range of the available
memory.
 
> > > expressed the desire to locate ZONE_MOVABLE memory on each
> > > memory controller to allow user space intensive processing to
> > > make better use of the additional memory bandwidth.
> > 
> > Can you share some more how exactly ZONE_MOVABLE would help here to make
> > better use of the memory bandwidth?
>
> ZONE_MOVABLE memory is effectively unusable by the kernel. It can be used by
> user space applications through both the page allocator and the Hugetlbfs.
> If a large 'movablecore' allocation is defined and it can only be located at
> the end of addressable memory then it will always be located on MEMC1 of a
> 7278 system. This will create a tendency for user space accesses to consume
> more bandwidth on the MEMC1 memory controller and kernel space accesses to
> consume more bandwidth on MEMC0. A more even distribution of ZONE_MOVABLE
> memory between the available memory controllers in theory makes more memory
> bandwidth available to user space intensive loads.

The theory makes perfect sense, but is there any practical evidence of
improvement?
Some benchmark results that illustrate the difference would be nice.

> > > BACKGROUND:
> > > NUMA architectures support distributing movablecore memory
> > > across each node, but it is undesirable to introduce the
> > > overhead and complexities of NUMA on systems that don't have a
> > > Non-Uniform Memory Architecture.
> > 
> > How exactly would that look like? I think I am missing something :)
>
> The notion would be to consider each memory controller as a separate node,
> but as stated it is not desirable.

Why?

> Thanks for your consideration,
> Dough Baker ... I mean Doug Berger :).

-- 
Sincerely yours,
Mike.
