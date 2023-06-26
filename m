Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D573E285
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjFZOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFZOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:52:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520EC6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UFSCE21v5gU7lTurZrT+QlNS55eGUt7Z7/S6IMG3+Xg=; b=PULst19W/HF8uHCuP/1XYnryGp
        sF3mRSCqrqY6jVA38EgdWtr6Z40Im8BisMDa+LiO+T7lLydhVkPmJ6NJLl+9LZAClilQoeQ1pmg/j
        zkv8mYrV8sNkrgoTUpndFk9fI4KKeaKKO9O0Xfh3Qp3w+EIiye4ZVsnuAw9eXnVDREQzJajs8aklE
        cKnEnaX9ZMDTzO6NYBesic1Ek7gpPyWcx8By1XODaoN7yjQkqis5rgbaMvP7WJlhsWHZdm8eb2IDR
        oVJFd/AwYsbGA/DVOf6Le27MmvLVxWsxpAP90xn5f9RPE6R1ZsV0vrH5B9QvptcGKxvfZCBt2Yvg0
        r4UMm0FA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDnZU-001oc4-Ms; Mon, 26 Jun 2023 14:52:05 +0000
Date:   Mon, 26 Jun 2023 15:52:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Peng Zhang <perlyzhang@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Message-ID: <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:27:54PM +0200, Danilo Krummrich wrote:
> On 6/26/23 15:19, Matthew Wilcox wrote:
> > On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
> > > On the other hand, unless I miss something (and if so, please let me know),
> > > something is bogus with the API then.
> > > 
> > > While the documentation of the Advanced API of the maple tree explicitly
> > > claims that the user of the API is responsible for locking, this should be
> > > limited to the bounds set by the maple tree implementation. Which means, the
> > > user must decide for either the internal (spin-) lock or an external lock
> > > (which possibly goes away in the future) and acquire and release it
> > > according to the rules maple tree enforces through lockdep checks.
> > > 
> > > Let's say one picks the internal lock. How is one supposed to ensure the
> > > tree isn't modified using the internal lock with mas_preallocate()?
> > > 
> > > Besides that, I think the documentation should definitely mention this
> > > limitation and give some guidance for the locking.
> > > 
> > > Currently, from an API perspective, I can't see how anyone not familiar with
> > > the implementation details would be able to recognize this limitation.
> > > 
> > > In terms of the GPUVA manager, unfortunately, it seems like I need to drop
> > > the maple tree and go back to using a rb-tree, since it seems there is no
> > > sane way doing a worst-case pre-allocation that does not suffer from this
> > > limitation.
> > 
> > I haven't been paying much attention here (too many other things going
> > on), but something's wrong.
> > 
> > First, you shouldn't need to preallocate.  Preallocation is only there
> 
> Unfortunately, I think we really have a case where we have to. Typically GPU
> mappings are created in a dma-fence signalling critical path and that is
> where such mappings need to be added to the maple tree. Hence, we can't do
> any sleeping allocations there.

OK, so there are various ways to hadle this, depending on what's
appropriate for your case.

The simplest is to use GFP_ATOMIC.  Essentially, you're saying to the MM
layer "This is too hard, let me tap into the emergency reserves".  It's
mildly frowned upon, so let's see if we can do better.

If you know where the allocation needs to be stored, but want it to act as
NULL until the time is right, you can store a ZERO entry.  That will read
as NULL until you store to it.  A pure overwriting store will not cause
any memory allocation since all the implementation has to do is change
a pointer.  The XArray wraps this up nicely behind an xa_reserve() API.
As you're discovering, the Maple Tree API isn't fully baked yet.

