Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164CB70EAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbjEXBba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbjEXBb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:31:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D82318D;
        Tue, 23 May 2023 18:31:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d44b198baso174205b3a.0;
        Tue, 23 May 2023 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684891886; x=1687483886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIKD5WaWkrfgSg8wtOaFTVEhKmxqSZ1EIRMkzpKdqEQ=;
        b=ToCKKP7NsVqbbGR8Fly0Xb5c3b9r8QDuNxQoIMR4ixWOucGmvp70ne6J/MZZHQm/J6
         vA0Al8Z8h3g7MUeS/uRe2LViAkz2vsquqvrLHFzxZFzMO7OyzGfI7xZigJoD+paJ7umE
         QQtjSSjaw35Lw0CqtNCQ02Pe67924rAq/a3X3upHOzT+6PzfBHxukrJEyumskwA2CLBL
         f/e9+0wQGFk5rTs7Jl//uz9Ze4Mv7PzlsXfD0JSgiLlLIM3o8wEvxVYkf16cA2BvryNP
         41ZCkX75IjFKl3PvDaW1YO4Ne88igW5MeN7T8xue2Cbv3PN/fjGVZA3UyUuTNeaRIbrA
         kn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684891886; x=1687483886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIKD5WaWkrfgSg8wtOaFTVEhKmxqSZ1EIRMkzpKdqEQ=;
        b=Z4emekVcwLcx8yHZUyJAfYBWi2kpGeFsbmg9HvXU2YnhqhJrhf4B/MqDAh2jDwNlO2
         luySZDncqByzq/FiIDLDH+bdq3uC9V1zMvRWufmZSwdxt77Bm/l0w6CiFMpyUN/+gt5n
         EWIQpmqk3+POjMLMIl1x6D5ZNmB4/CizAY6M81Zv/86cn1dHw4coZbjmGS8ciYyndbqz
         08DR1wE1GT1ngdkceGMZT/6TWZ0kbrdSBZU7YiVBllblaAtLUofGJ2oIHLUKU6QBh1Qu
         B1N3yk1EvOpzI1t8em4MYJn9UBv0CcVxtgDtHNxEK0OisMW+g8HmcvWyZNLJOSu+3hu4
         48Jg==
X-Gm-Message-State: AC+VfDy9K/TvE13wC0oM+2A+XtSgIRxRLQ7MYK+tRv7Hly+ZlmrWlpwk
        eIYzP3MYMQdSDqNy5VsA+u6LbIW8LfZPxoB1
X-Google-Smtp-Source: ACHHUZ7tAULbDowDVZ6ohTYz8RfKZ2TDB/BRq9U39zdrqfFhNXgrWcwroCYMOWo7KSh+PvPajyTJwQ==
X-Received: by 2002:a05:6a20:938e:b0:10b:60c1:2999 with SMTP id x14-20020a056a20938e00b0010b60c12999mr9842392pzh.22.1684891885793;
        Tue, 23 May 2023 18:31:25 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([168.188.236.124])
        by smtp.gmail.com with ESMTPSA id j12-20020aa78dcc000000b0062de9ef6915sm6303308pfr.216.2023.05.23.18.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 18:31:25 -0700 (PDT)
Date:   Wed, 24 May 2023 10:30:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <ZG1oxkEXDCfab8Ga@debian-BULLSEYE-live-builder-AMD64>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
 <ZG0zil5dpXUiuF5q@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG0zil5dpXUiuF5q@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:43:38AM +1000, Dave Chinner wrote:
> On Wed, May 24, 2023 at 03:04:28AM +0900, Hyeonggon Yoo wrote:
> > On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > > > > 2. Motivation.
> > > > > 
> > > > > - The vmap code is not scalled to number of CPUs and this should be fixed;
> > > > > - XFS folk has complained several times that vmalloc might be contented on
> > > > >   their workloads:
> > > > > 
> > > > > <snip>
> > > > > commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> > > > > Author: Dave Chinner <dchinner@redhat.com>
> > > > > Date:   Tue Jan 4 17:22:18 2022 -0800
> > > > > 
> > > > >     xfs: reduce kvmalloc overhead for CIL shadow buffers
> > > > >     
> > > > >     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
> > > > >     
> > > > >     The problem is when we are logging lots of large objects, we hit
> > > > >     kvmalloc really damn hard with costly order allocations, and
> > > > >     behaviour utterly sucks:
> > > > 
> > > > based on the commit I guess xfs should use vmalloc/kvmalloc is because
> > > > it allocates large buffers, how large could it be?
> > > > 
> > > They use kvmalloc(). When the page allocator is not able to serve a
> > > request they fallback to vmalloc. At least what i see, the sizes are:
> > > 
> > > from 73728 up to 1048576, i.e. 18 pages up to 256 pages.
> > > 
> > > > > 3. Test
> > > > > 
> > > > > On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> > > > > 
> > > > >     1-page     1-page-this-patch
> > > > > 1  0.576131   vs   0.555889
> > > > > 2   2.68376   vs    1.07895
> > > > > 3   4.26502   vs    1.01739
> > > > > 4   6.04306   vs    1.28924
> > > > > 5   8.04786   vs    1.57616
> > > > > 6   9.38844   vs    1.78142
> > > > 
> > > > <snip>
> > > > 
> > > > > 29    20.06   vs    3.59869
> > > > > 30  20.4353   vs     3.6991
> > > > > 31  20.9082   vs    3.73028
> > > > > 32  21.0865   vs    3.82904
> > > > > 
> > > > > 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> > > > > pair throughput.
> > > > 
> > > > I would be more interested in real numbers than synthetic benchmarks,
> > > > Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
> > > > with and without this patchset?
> > > > 
> > > I added Dave Chinner <david@fromorbit.com> to this thread.
> > 
> > Oh, I missed that, and it would be better to [+Cc linux-xfs]
> > 
> > > But. The contention exists.
> > 
> > I think "theoretically can be contended" doesn't necessarily mean it's actually
> > contended in the real world.
> 
> Did you not read the commit message for the XFS commit documented
> above? vmalloc lock contention most c0ertainly does exist in the
> real world and the profiles in commit 8dc9384b7d75  ("xfs: reduce
> kvmalloc overhead for CIL shadow buffers") document it clearly.
>
> > Also I find it difficult to imagine vmalloc being highly contended because it was
> > historically considered slow and thus discouraged when performance is important.
> 
> Read the above XFS commit.
> 
> We use vmalloc in critical high performance fast paths that cannot
> tolerate high order memory allocation failure. XFS runs this
> fast path millions of times a second, and will call into
> vmalloc() several hundred thousands times a second with machine wide
> concurrency under certain types of workloads.
>
> > IOW vmalloc would not be contended when allocation size is small because we have
> > kmalloc/buddy API, and therefore I wonder which workloads are allocating very large
> > buffers and at the same time allocating very frequently, thus performance-sensitive.
> >
> > I am not against this series, but wondering which workloads would benefit ;)
> 
> Yup, you need to read the XFS commit message. If you understand what
> is in that commit message, then you wouldn't be doubting that
> vmalloc contention is real and that it is used in high performance
> fast paths that are traversed millions of times a second....

Oh, I read the commit but seems slipped my mind while reading it - sorry for such a dumb
question, now I get it, and thank you so much. In any case didn't mean to offend,
I should've read and thought more before asking.

>
> > > Apart of that per-cpu-KVA allocator can go away if we make it generic instead.
> > 
> > Not sure I understand your point, can you elaborate please?
> > 
> > And I would like to ask some side questions:
> > 
> > 1. Is vm_[un]map_ram() API still worth with this patchset?
> 
> XFS also uses this interface for mapping multi-page buffers in the
> XFS buffer cache. These are the items that also require the high
> order costly kvmalloc allocations in the transaction commit path
> when they are modified.
> 
> So, yes, we need these mapping interfaces to scale just as well as
> vmalloc itself....

I mean, even before this series, vm_[un]map_ram() caches vmap_blocks
per CPU but it has limitation on size that can be cached per cpu.

But now that vmap() itself becomes scalable after this series, I wonder
they are still worth, why not replace it with v[un]map()?
> 
> > 2. How does this patchset deals with 32-bit machines where
> >    vmalloc address space is limited?
> 
> From the XFS side, we just don't care about 32 bit machines at all.
> XFS is aimed at server and HPC environments which have been entirely
> 64 bit for a long, long time now...

But Linux still supports 32 bit machines and is not going to drop
support for them anytime soon so I think there should be at least a way to
disable this feature.

Thanks!

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
