Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7276E70F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDSCIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDSCIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:08:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A02658E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:08:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id gb12so28841043qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681870096; x=1684462096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2i54J70P7BHws90mr0mZ0tSyG0lrFeeDQmHC/zLnk6E=;
        b=F+uP6RWjfrt7M5J+rVPxz+azqdWmSkNnUt8Rc9nzB0D8OBAvY2zC5YzLZHbP6CtrY0
         RI9UnC3Lsq9zr+GA+CXa5zK7tOxIGBhdMz8fCEj3WKIUL03JByPY1frjAXAaFa6sxi+q
         id4d3K1qRZHwO0m+JIjLX3DD4OcA+c0gp85eXj7oZeOEt2oeWNUQALi5aubsk1PTA0A4
         ywgK1FqREJm6t49JtmuZj1id4MS8kGBV7sdu62dPyWyWfVi0Q/M485OauQB2R4VVORzZ
         iAVBS/z37wTW5nXHsWqvtlX+NTDGe9LQED2QiIRCPqvA6WOfW4bLej0F1I2QtRaIFUOp
         KisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681870096; x=1684462096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i54J70P7BHws90mr0mZ0tSyG0lrFeeDQmHC/zLnk6E=;
        b=Dt+xnGXILXDh20/vFyx+Hzh9XSjAhP6PXEbyJXr0W3VhinuT7l7CmSJx1g4hWWbADA
         zfg/97nN7oc+8TSo7+zeOdJ3vC1/kOkyPE7/LvWINvArSOr7rivtml/0GKDS5cygnnI9
         w8ehJ9ER5UONk5H7A7kldmwlEnrxAPllOa3hvpy0cz/8Bsj9ODlTTPoBGTi56Muom1oc
         RbsUh28AklCKOnAlAotVPkt3NpmrJnoRcKGCOiWhcX23XpjqIcBtnRSqJtMAzBkRFJyT
         IuJOVuOOtYdSTn95YRz26v/cKwt5/T64Yx52JbDr5PRoeK3pBx9XzJYnfVpAHeMFNHl0
         xKnw==
X-Gm-Message-State: AAQBX9flslPaZIvwn00/kVZl08/L4sMFHPvrUZKWkorzl627pfB/iJdH
        4ulnZXjeLBLeUX2PAcmz/PX64g==
X-Google-Smtp-Source: AKy350Zb5g9QoBeP8dMxH/J5F1Lj3IrlRKoEL6OoEmZjYedwJVSJCUuA3wb1faeRrAklioPZUgmo3w==
X-Received: by 2002:a05:622a:1010:b0:3e6:55b2:35e with SMTP id d16-20020a05622a101000b003e655b2035emr4017850qte.26.1681870095830;
        Tue, 18 Apr 2023 19:08:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a0a8900b0074abe1e1457sm4333376qkg.76.2023.04.18.19.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 19:08:15 -0700 (PDT)
Date:   Tue, 18 Apr 2023 22:08:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Message-ID: <20230419020814.GA272256@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418235402.lq7mxrrre2kl6vsf@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418235402.lq7mxrrre2kl6vsf@box.shutemov.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill, thanks for taking a look so quickly.

On Wed, Apr 19, 2023 at 02:54:02AM +0300, Kirill A. Shutemov wrote:
> On Tue, Apr 18, 2023 at 03:12:47PM -0400, Johannes Weiner wrote:
> > This series proposes to make THP allocations reliable by enforcing
> > pageblock hygiene, and aligning the allocator, reclaim and compaction
> > on the pageblock as the base unit for managing free memory. All orders
> > up to and including the pageblock are made first-class requests that
> > (outside of OOM situations) are expected to succeed without
> > exceptional investment by the allocating thread.
> > 
> > A neutral pageblock type is introduced, MIGRATE_FREE. The first
> > allocation to be placed into such a block claims it exclusively for
> > the allocation's migratetype. Fallbacks from a different type are no
> > longer allowed, and the block is "kept open" for more allocations of
> > the same type to ensure tight grouping. A pageblock becomes neutral
> > again only once all its pages have been freed.
> 
> Sounds like this will cause earlier OOM, no?
> 
> I guess with 2M pageblock on 64G server it shouldn't matter much. But how
> about smaller machines?

Yes, it's a tradeoff.

It's not really possible to reduce external fragmentation and increase
contiguity, without also increasing the risk of internal fragmentation
to some extent. The tradeoff is slighly less but overall faster memory.

A 2M block size *seems* reasonable for most current setups. It's
actually still somewhat on the lower side, if you consider that we had
4k blocks when memory was a few megabytes. (4k pages for 4M RAM is the
same ratio as 2M pages for 2G RAM. My phone has 8G and my desktop 32G.
64G is unusually small for a datacenter server.)

I wouldn't be opposed to sticking this behind a separate config option
if there are setups that WOULD want to keep the current best-effort
compaction without the block hygiene. But obviously, from a
maintenance POV life would be much easier if we didn't have to.

FWIF, I have been doing tests in an environment constrained to 2G and
haven't had any issues with premature OOMs. But I'm happy to test
other situations and workloads that might be of interest to people.

> > Reclaim and compaction are changed from partial block reclaim to
> > producing whole neutral page blocks.
> 
> How does it affect allocation latencies? I see direct compact stall grew
> substantially. Hm?

Good question.

There are 260 more compact stalls but also 1,734 more successful THP
allocations. And 1,433 fewer allocation stalls. There seems to be much
less direct work performed per successful allocation.

But of course, that's not the whole story. Let me trace the actual
latencies.

Thanks for your thoughts!
Johannes
