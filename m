Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DEC6DA624
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjDFXi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDFXi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFB7EDC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2271F64B44
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04AC433EF;
        Thu,  6 Apr 2023 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680824303;
        bh=tW514L5hEk5UoZsNv5iuj5NM1Wiovb5lmuY845RFnBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1fs25dyW3xLIBBhxXao4Izy35sLuzQoQifUh9Gk8kYN98rzV9wPQRFgya3v6F+g2s
         tdkgj5m8taSgjxTailT0FGCt73QgU78jrCkG2YWHWa9l7H6SxPeXBND6BvhZHiCG8I
         srBDD75mvSRFDPlMiyI8K6+LdWZFffuGsRaewjaU=
Date:   Thu, 6 Apr 2023 16:38:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     John Stultz <jstultz@google.com>, jaewon31.kim@samsung.com,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Message-Id: <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
In-Reply-To: <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
        <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
        <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
        <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
        <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 16:27:28 -0700 "T.J. Mercier" <tjmercier@google.com> wrote:

> > When you say "decide what's the largest reasonable size", I think it
> > is difficult as with the variety of RAM sizes and buffer sizes I don't
> > think there's a fixed limit. Systems with more ram will use larger
> > buffers for image/video capture buffers.  And yes, you're right that
> > ram/2-1 in a single allocation is just as broken, but I'm not sure how
> > to establish a better guard rail.
> >
> > thanks
> > -john
> 
> I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
> WARN_ON. We know for sure that's an invalid request, and it's pretty
> cheap to check as opposed to trying a bunch of reclaim before failing.

Well, if some buggy caller has gone and requested eleventy bigabytes of
memory, doing a lot of reclaiming before failing isn't really a problem
- we don't want to optimize for this case!

> For buffers smaller than that I agree with John in that I'm not sure
> there's a definitive threshold.

Well...  why do we want to do _anything_ here?  Why cater for buggy
callers?  I think it's because "dma-buf behaves really badly with very
large allocation requests".  Again, can we fix that instead?

