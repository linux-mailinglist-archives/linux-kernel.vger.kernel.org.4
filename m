Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6233A722E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjFESAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjFESAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:00:18 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD63A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:00:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6260e8a1424so36682446d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685988015; x=1688580015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atmUIuf4madsQMSFoM2m+ju84SBl9+3BxHPq0w7LBV0=;
        b=fqpYbXfWOeRgJWS7niLDVXs2l9xjdOdCK/oKo75QYVhi+C0Yvmvk6Pml+xTq2SAnsl
         3KSdJaVVqyVclxbnQ0kQd4VFL7xyl/84hvaLYsRdXNbHThDLgnu9UxDaVwiO1xjAf3RM
         uye5HUh8O3m1y6JTWbWuRCao4CeSpkqAMpWp16ycwe8gUeCyGdeY0+RBNfLZfxnnBJhO
         fPr14AvjxvsahlGXa0H2KqzX+AkO4fdUKMTklXbv00XjFRH0x7x672/KTZ4On5vcPD6o
         tZw7L3ymFGbohIGGWoU1dJcHhKwDaNH0gaDRVugfYuxsFz2Gft/1w/aSH7zRB/5ogLiU
         cuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988015; x=1688580015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atmUIuf4madsQMSFoM2m+ju84SBl9+3BxHPq0w7LBV0=;
        b=DHFLUVnDqBD3jIWwc041kcMjojJFiV/bzSXMTyBsVaq/olwV8Bp1JOdDVqvj+ZLkkf
         GegKbsibsLKmgufIqQOAQMm45sIzPpAM7swy1X6aQBPoxIJ5yMX4zc4HQIfgLTdMjJLe
         i1//GSbhP4xNDeANn8w6mkOcLT9RpjJG2kdWeqTn/SlwEWNQMLA4xtGCtgbU8GC7T6oP
         5Vso5zpARRfX2yyckOV+Ed1ijvnthyqeA7ilmbnJcMIdgorxx7+gQNAdYBi5hAzgH7nt
         Nj24FGUni3G3Iz6GiEqjukOvMAMNswNGUgszFlNxQbYitzn4VhxF58Gz/RXNuyXKC4Ey
         uAXA==
X-Gm-Message-State: AC+VfDx9+1uNdftvzdHYmMg+sD2dKRvYHJ8ocqx4rYj/xlEBgVgZ/mDN
        uYUJNZZltL0C9HAW2f9+tCx7Ag==
X-Google-Smtp-Source: ACHHUZ5+OBCi+kcx7kp7BzsHtKn/TNsomINF3G2kxCG0cidfnEi7nP0qdqk8SPvlPEKOrXGUqU5q4w==
X-Received: by 2002:a05:6214:c2d:b0:626:3375:6fea with SMTP id a13-20020a0562140c2d00b0062633756feamr8601246qvd.22.1685988015571;
        Mon, 05 Jun 2023 11:00:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id l2-20020a0ce842000000b006263281bd49sm4684662qvo.102.2023.06.05.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:00:14 -0700 (PDT)
Date:   Mon, 5 Jun 2023 14:00:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Message-ID: <20230605180013.GD221380@cmpxchg.org>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
 <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

On Thu, Jun 01, 2023 at 06:37:50PM +0530, Charan Teja Kalla wrote:
> Thanks Johannes for taking a look at it..
> 
> On 6/1/2023 3:49 AM, Johannes Weiner wrote:
> > On Wed, May 31, 2023 at 04:39:34PM +0530, Charan Teja Kalla wrote:
> >> This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
> >> mounted on zram which has 2GB of backingdev. The test case involved
> >> launching some memory hungry apps in an order and do the proactive
> >> reclaim for the app that went to background using madvise(MADV_PAGEOUT).
> >> We are seeing ~40% less total values of psi mem some and full when this
> >> patch is combined with [1].
> > Does that mean those pages are thrashing, but because you clear their
> > workingset it isn't detected and reported via psi?
> > 
> 
> Seems I didn't mention the usecase clearly and let me correct it. Say we
> have the Android apps A, B, C, ... H and launching of these apps goes
> like below.
> 
> 1) Launch app A.
> 2) Launch app B.
> 3) Launch app C. At this time, we consider the memory used by app A is
> no more in active use thus proactively reclaim them where we do issue
> MADV_PAGEOUT on anon regions only thus these pages goes to swap mounted
> on zram and subsequently into the backing dev attached to the zram.
> 4) Launch app D.. Proactively reclaim the anon regions of App B into
> swap and through to backing dev.
> 5) Now make the app A to foreground. This can read the pages from the
> swap + backing dev (because of the step 3)) that belongs to app A and
> also proactively reclaim anon regions of app C.
> 6) Launch E --> proactive reclaim of app D to zram swap + backing dev.
> 7) Make App B to foreground --> Read memory of app B from swap +
> backingdev and as well reclaim the anon regions of app A.
> 8) Like wise launches of apps F, C, G, D, H, E .....
> 
> If we look at steps 5, 7,..., we are just making the apps foreground
> which folios (if were marked as workingset) can contribute to PSI events
> through swap_readpage(). But in reality, these are not the real
> workingset folios (I think it is safe to say this), because it is the
> user who decided the reclaim of these pages by issuing the MADV_PAGEOUT
> which he knows that these are not going to be needed in the near future
> thus reclaim them.
> 
> I think the other way to look at the problem is the user can write a
> simple application where he can do  MADV_PAGEOUT and read them back in a
> loop. If at any point, folios user working on turns out to be a
> workingset( he can just be probabilistic here), the PSI events will be
> triggered though there may not be real memory pressure in the system.
>
> > I don't rally get why silencing the thrashing is an improvement.
> > 
> Agree that we shouldn't be really silence the thrashing. My point is we
> shouldn't be  considering the folios as thrashing If those were getting
> reclaim by the user him self through MADV_PAGEOUT under the assumption
> that __user knows they are not real working set__.  Please let me know
> if I am not making sense here.

I'm not sure I agree with this. I think it misses the point of what
the madvise is actually for.

The workingset is defined based on access frequency and available
memory. Thrashing is defined as having to read pages back shortly
after their eviction.

MADV_PAGEOUT is for the application to inform the kernel that it's
done accessing the pages, so that the kernel can accelerate their
eviction over other pages that may still be in use. This is ultimately
meant to REDUCE reclaim and paging.

However, in this case, the MADVISE_PAGEOUT evicts pages that are
reused after and then refault. It INCREASED reclaim and paging.

Surely that's a problem? And the system would have behaved better
without the madvise() in the first place?

In fact, I would argue that the pressure spike is a great signal for
detecting overzealous madvising. If you're redefining the workingset
from access frequency to "whatever the user is saying", that will take
away an important mechanism to detect advise bugs and unnecessary IO.
