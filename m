Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81BF6D8DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDFDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjDFDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E735119
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F126A62B81
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EAFC433EF;
        Thu,  6 Apr 2023 03:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680750564;
        bh=qmfN1/nZWFYxeYB8LHJmYXp/zoyQ9JZ4CGLm4sEKFQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hw3Jox4le087rkMSVEXUWHYw3A5AGUk8FE4Rf5JhrZBD1A33Hc4JEDG7/+pFbio56
         tkUykuJxMXDFbbyy5V40rf/CdWLMa/D90ZdQGHSdR4+l4Tph/lvSfF7Ao76rW7TkuK
         wchTJPzFkwEr021R2I7kxNpHowo/90buDdLNQoFc=
Date:   Wed, 5 Apr 2023 20:09:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     jaewon31.kim@samsung.com
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Message-Id: <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
In-Reply-To: <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
        <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
        <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 11:17:12 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> >> +       if (len / PAGE_SIZE > totalram_pages())
> >> +               return ERR_PTR(-ENOMEM);
> >
> >We're catering for a buggy caller here, aren't we?  Are such large
> >requests ever reasonable?
> >
> >How about we decide what's the largest reasonable size and do a
> >WARN_ON(larger-than-that), so the buggy caller gets fixed?
> 
> Yes we're considering a buggy caller. I thought even totalram_pages() / 2 in
> the old ion system is also unreasonable. To avoid the /2, I changed it to
> totalram_pages() though.
> 
> Because userspace can request that size repeately, I think WARN_ON() may be
> called to too often, so that it would fill the kernel log buffer.

Oh geeze.  I trust that userspace needs elevated privileges of some form?

If so, then spamming dmesg isn't an issue - root can do much worse than
that.

> Even we think WARN_ON_ONCE rather than WARN_ON, the buggy point is not kernel
> layer. Unlike page fault mechanism, this dma-buf system heap gets the size from 
> userspace, and it is allowing unlimited size. I think we can't fix the buggy
> user space with the kernel warning log. So I think warning is not enough,
> and we need a safeguard in kernel layer.

I really dislike that ram/2 thing - it's so arbitrary, hence is surely
wrong for all cases.  Is there something more thoughtful we can do?

I mean, top priority here is to inform userspace that it's buggy so
that it gets fixed (assuming this requires elevated privileges).  And
userspace which requests (totalram_pages()/2 - 1) bytes is still buggy,
but we did nothing to get the bug fixed.

