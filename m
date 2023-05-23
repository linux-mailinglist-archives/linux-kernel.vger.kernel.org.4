Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DE70E463
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbjEWSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEWSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:04:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E551B1;
        Tue, 23 May 2023 11:04:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae40dcdc18so54978995ad.2;
        Tue, 23 May 2023 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684865061; x=1687457061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G+6JAe83A/18uddV8Wr/e+zu8FEvMqf/FTgHFCweHM=;
        b=OjRBHmKyZVkTv8ipCSSjMC979Aa2g8Vef/qdvxWXNK7NfpzJNVJzYzTbPwBqOJYnIM
         vwYPxKbp7kt4/uzWVCrugRgi2qAog0S5e0N/D4KORZxxCcleybetuj0ZoVe1zrvhJuHs
         NPimC3YHLcXmNFW845z/8XZ99tVVoyiyvn0aNHlu7cELROsQq5Ejt0Mkg5qTC4q8O1P/
         RLk34aD+U5QHietxZJhXe+22UN+3njLRq4RA6mjnCw5zYbssPk5+vRPk9RiS2LDaRzdw
         TmjTW23dM/3zhjSzXiKomSO4Z95x93uk/fiaoRI2DOFOpAN7I0mtdv09iiB9T1/tOxaB
         NoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684865061; x=1687457061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G+6JAe83A/18uddV8Wr/e+zu8FEvMqf/FTgHFCweHM=;
        b=aSDKuImqSN0rrS76/RZfux3v/jnhz1PvAhdpsDRbaWdyf3s3YEGqjiKoy3d8Y3V6Hq
         iahjlH25dbO23HRv3U6NTOYUBMXzTI9iCcCkngDghVi08yP6BSJgVmvATuRF3VrPZ1hH
         CtI0iLvcZfjkxFhlvg58wKBqI++IbzZtUcKv5FnXyxOgoJljU66b395kTRArodD3w4PT
         pfU1gN5bCCIZgihi4tSSDttDb8t0cdNo67a2fxGeBSPywOe9FFMRy0+Z5JyKXZxjYi1/
         5aDX7ViraC0RGn6EexKMx9ZiMw2aoc9MIeN7SrWf/7Y5U4YI+vSNOjueEwGA72MCzXgM
         5oHg==
X-Gm-Message-State: AC+VfDxr3ASA+hSAdJeHHBmq0wdNj8pDr+En5PjxL+JTCEiLaYPJVmYc
        JEly6Aww7Mk6INU9dTfeB4w=
X-Google-Smtp-Source: ACHHUZ7Qj/je6b3i19kqNy7D3SzNF2pLpsy4V4UegPxSa9h9jg3U20AWBdyQoww8RgK0muN41BIKXA==
X-Received: by 2002:a17:902:ce91:b0:1af:c599:6a88 with SMTP id f17-20020a170902ce9100b001afc5996a88mr3866632plg.49.1684865060999;
        Tue, 23 May 2023 11:04:20 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([211.108.101.96])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170902850600b001a183ade911sm7080795plb.56.2023.05.23.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:04:20 -0700 (PDT)
Date:   Wed, 24 May 2023 03:04:28 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzX3vRMlGHIcYCe@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > > 2. Motivation.
> > > 
> > > - The vmap code is not scalled to number of CPUs and this should be fixed;
> > > - XFS folk has complained several times that vmalloc might be contented on
> > >   their workloads:
> > > 
> > > <snip>
> > > commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> > > Author: Dave Chinner <dchinner@redhat.com>
> > > Date:   Tue Jan 4 17:22:18 2022 -0800
> > > 
> > >     xfs: reduce kvmalloc overhead for CIL shadow buffers
> > >     
> > >     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
> > >     
> > >     The problem is when we are logging lots of large objects, we hit
> > >     kvmalloc really damn hard with costly order allocations, and
> > >     behaviour utterly sucks:
> > 
> > based on the commit I guess xfs should use vmalloc/kvmalloc is because
> > it allocates large buffers, how large could it be?
> > 
> They use kvmalloc(). When the page allocator is not able to serve a
> request they fallback to vmalloc. At least what i see, the sizes are:
> 
> from 73728 up to 1048576, i.e. 18 pages up to 256 pages.
> 
> > > 3. Test
> > > 
> > > On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> > > 
> > >     1-page     1-page-this-patch
> > > 1  0.576131   vs   0.555889
> > > 2   2.68376   vs    1.07895
> > > 3   4.26502   vs    1.01739
> > > 4   6.04306   vs    1.28924
> > > 5   8.04786   vs    1.57616
> > > 6   9.38844   vs    1.78142
> > 
> > <snip>
> > 
> > > 29    20.06   vs    3.59869
> > > 30  20.4353   vs     3.6991
> > > 31  20.9082   vs    3.73028
> > > 32  21.0865   vs    3.82904
> > > 
> > > 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> > > pair throughput.
> > 
> > I would be more interested in real numbers than synthetic benchmarks,
> > Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
> > with and without this patchset?
> > 
> I added Dave Chinner <david@fromorbit.com> to this thread.

Oh, I missed that, and it would be better to [+Cc linux-xfs]

> But. The contention exists.

I think "theoretically can be contended" doesn't necessarily mean it's actually
contended in the real world.

Also I find it difficult to imagine vmalloc being highly contended because it was
historically considered slow and thus discouraged when performance is important.

IOW vmalloc would not be contended when allocation size is small because we have
kmalloc/buddy API, and therefore I wonder which workloads are allocating very large
buffers and at the same time allocating very frequently, thus performance-sensitive.

I am not against this series, but wondering which workloads would benefit ;)

> Apart of that per-cpu-KVA allocator can go away if we make it generic instead.

Not sure I understand your point, can you elaborate please?

And I would like to ask some side questions:

1. Is vm_[un]map_ram() API still worth with this patchset?

2. How does this patchset deals with 32-bit machines where
   vmalloc address space is limited?

Thanks!

> > By the way looking at the commit, teaching __p?d_alloc() about gfp
> > context (that I'm _slowly_ working on...) could be nice for allowing
> > non-GFP_KERNEL kvmalloc allocations, as Matthew mentioned. [1]
> > 
> > Thanks!
> > 
> > [1] https://lore.kernel.org/linux-mm/Y%2FOHC33YLedMXTlD@casper.infradead.org
> > 

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
