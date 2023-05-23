Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D461870E7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjEWVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjEWVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:49:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7527E7C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:48:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so292440a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684878513; x=1687470513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfzJTH/YS8p4/aFLXua1OpKUSEReEQjhxnkCdOPbEC8=;
        b=BnvRAfdLPHUoB25s74WCh7Ed7BfIUFS/s1bk26w0jQbs/ANLh3OodAduU2R/njA261
         FhzISYrI+ZVyI5RkRVBp1nm19R0O4H1ttBu2ve3cK51i7PeG86oL5fWo9ubRxuXWbguv
         PrA07QcmSn+MHDn/CK3DSHbIY5EM/lD5u2fpMJw7AgXxrTyVjirGpxF92/H4Ki5LSqbr
         B2fJoOigxfzraIpJ2WgIhA7Mrz6F/MfG2KuwXiXYcZAQIhwk5wv3IX5sgmovDlxzqPoe
         lu6n96KVwkBIi98EK/D/O0gsXoCVsD21hei3mxpGEY7RIM0LPEVf3uPDvAWV9RR3HdAV
         pJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878513; x=1687470513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfzJTH/YS8p4/aFLXua1OpKUSEReEQjhxnkCdOPbEC8=;
        b=FSVI/j/7e2di/fAXAd4dIHJokNHZY+ZfMdioVv3jWpH8b/tMO//V7E25ez6vxjoFjK
         YBXsgI+t4n+2zXpaoUfkQrkvAhuAY+DlMwHiZ982cfxxihtViAu6L1pETLFq3WqJyuw2
         eWo5bZXATpnQ+FmB+c39K+SUrCelDXl2jvRKXXQG2GRaCGhv/ALRFUdsfpEYaaLYjo/N
         q5TQQeg3AJWcWLcJCnfU5lUpSo1uE6hHNnL1JSp5EiK/TcjQh5LiPQ1wOCeAJ5dXA3bJ
         v2Cfh5zUW/cFWhsTxdQlHTho5qzItN8iBmDvczzj3YTemjQ2FX7lpOhLmpy6mNcQNb8f
         Fu1g==
X-Gm-Message-State: AC+VfDxzKnNoUifntVYLtuqiFQmWp50M5lg/f0vfCpnQpOs3ASJSMaNC
        p+YhlNBTY+EC38s0WRow+FsSlg==
X-Google-Smtp-Source: ACHHUZ4asKk+nhhwjMAeaek5vqjkxfvQAw8udpAW2PCEL4vtT1VHByKWLgE7DfNeLaWy3DBRi45QLg==
X-Received: by 2002:a17:902:b212:b0:1ae:6bb9:7dc4 with SMTP id t18-20020a170902b21200b001ae6bb97dc4mr12376153plr.1.1684878513234;
        Tue, 23 May 2023 14:48:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001a5fccab02dsm7293760plb.177.2023.05.23.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:48:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1Zn8-0035Oz-2S;
        Wed, 24 May 2023 07:43:38 +1000
Date:   Wed, 24 May 2023 07:43:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZG0zil5dpXUiuF5q@dread.disaster.area>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:04:28AM +0900, Hyeonggon Yoo wrote:
> On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > > > 2. Motivation.
> > > > 
> > > > - The vmap code is not scalled to number of CPUs and this should be fixed;
> > > > - XFS folk has complained several times that vmalloc might be contented on
> > > >   their workloads:
> > > > 
> > > > <snip>
> > > > commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> > > > Author: Dave Chinner <dchinner@redhat.com>
> > > > Date:   Tue Jan 4 17:22:18 2022 -0800
> > > > 
> > > >     xfs: reduce kvmalloc overhead for CIL shadow buffers
> > > >     
> > > >     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
> > > >     
> > > >     The problem is when we are logging lots of large objects, we hit
> > > >     kvmalloc really damn hard with costly order allocations, and
> > > >     behaviour utterly sucks:
> > > 
> > > based on the commit I guess xfs should use vmalloc/kvmalloc is because
> > > it allocates large buffers, how large could it be?
> > > 
> > They use kvmalloc(). When the page allocator is not able to serve a
> > request they fallback to vmalloc. At least what i see, the sizes are:
> > 
> > from 73728 up to 1048576, i.e. 18 pages up to 256 pages.
> > 
> > > > 3. Test
> > > > 
> > > > On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> > > > 
> > > >     1-page     1-page-this-patch
> > > > 1  0.576131   vs   0.555889
> > > > 2   2.68376   vs    1.07895
> > > > 3   4.26502   vs    1.01739
> > > > 4   6.04306   vs    1.28924
> > > > 5   8.04786   vs    1.57616
> > > > 6   9.38844   vs    1.78142
> > > 
> > > <snip>
> > > 
> > > > 29    20.06   vs    3.59869
> > > > 30  20.4353   vs     3.6991
> > > > 31  20.9082   vs    3.73028
> > > > 32  21.0865   vs    3.82904
> > > > 
> > > > 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> > > > pair throughput.
> > > 
> > > I would be more interested in real numbers than synthetic benchmarks,
> > > Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
> > > with and without this patchset?
> > > 
> > I added Dave Chinner <david@fromorbit.com> to this thread.
> 
> Oh, I missed that, and it would be better to [+Cc linux-xfs]
> 
> > But. The contention exists.
> 
> I think "theoretically can be contended" doesn't necessarily mean it's actually
> contended in the real world.

Did you not read the commit message for the XFS commit documented
above? vmalloc lock contention most c0ertainly does exist in the
real world and the profiles in commit 8dc9384b7d75  ("xfs: reduce
kvmalloc overhead for CIL shadow buffers") document it clearly.

> Also I find it difficult to imagine vmalloc being highly contended because it was
> historically considered slow and thus discouraged when performance is important.

Read the above XFS commit.

We use vmalloc in critical high performance fast paths that cannot
tolerate high order memory allocation failure. XFS runs this
fast path millions of times a second, and will call into
vmalloc() several hundred thousands times a second with machine wide
concurrency under certain types of workloads.

> IOW vmalloc would not be contended when allocation size is small because we have
> kmalloc/buddy API, and therefore I wonder which workloads are allocating very large
> buffers and at the same time allocating very frequently, thus performance-sensitive.
>
> I am not against this series, but wondering which workloads would benefit ;)

Yup, you need to read the XFS commit message. If you understand what
is in that commit message, then you wouldn't be doubting that
vmalloc contention is real and that it is used in high performance
fast paths that are traversed millions of times a second....

> > Apart of that per-cpu-KVA allocator can go away if we make it generic instead.
> 
> Not sure I understand your point, can you elaborate please?
> 
> And I would like to ask some side questions:
> 
> 1. Is vm_[un]map_ram() API still worth with this patchset?

XFS also uses this interface for mapping multi-page buffers in the
XFS buffer cache. These are the items that also require the high
order costly kvmalloc allocations in the transaction commit path
when they are modified.

So, yes, we need these mapping interfaces to scale just as well as
vmalloc itself....

> 2. How does this patchset deals with 32-bit machines where
>    vmalloc address space is limited?

From the XFS side, we just don't care about 32 bit machines at all.
XFS is aimed at server and HPC environments which have been entirely
64 bit for a long, long time now...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
