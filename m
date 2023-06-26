Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39D73E067
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFZNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:19:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB9B9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1lIwl3IXt/Q2BlcHHaTxdvpn5Ox21y8UfooBHZkSajE=; b=K0c36mOHX6SJCWJPfezVusm6MV
        2iEzGAkU+cd0aS8rTCMxDX6mKsSV+y0RE6E8OHqde0YgSJK5xZIQZPOD9SIUfjjXPqEowS/ReggR6
        4zG1Qb5gd86rkAGhrNJQQpaBLMbc8j1TerHCIAXMYn/wyvjmN97cxWAG6lKnpIiOYv7eW5zY0sTHP
        fgg1yCVmyFEUmlXJyN0/nka82X4UHVCIcwrhpK/XYKiycfbeP799kiJ0su1NyXme3NRUGJ413OcgR
        huR19idds4/k753xtk3ZTiEY+WOeyVFEUtwVgSmy0r7FKbLukwz2kRd7R0cm7X9uSHL9u5Njus9uI
        LbbvNthQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDm7h-001kJr-9Z; Mon, 26 Jun 2023 13:19:17 +0000
Date:   Mon, 26 Jun 2023 14:19:17 +0100
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
Message-ID: <ZJmQVeiLtkFAGfW0@casper.infradead.org>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
> On the other hand, unless I miss something (and if so, please let me know),
> something is bogus with the API then.
> 
> While the documentation of the Advanced API of the maple tree explicitly
> claims that the user of the API is responsible for locking, this should be
> limited to the bounds set by the maple tree implementation. Which means, the
> user must decide for either the internal (spin-) lock or an external lock
> (which possibly goes away in the future) and acquire and release it
> according to the rules maple tree enforces through lockdep checks.
> 
> Let's say one picks the internal lock. How is one supposed to ensure the
> tree isn't modified using the internal lock with mas_preallocate()?
> 
> Besides that, I think the documentation should definitely mention this
> limitation and give some guidance for the locking.
> 
> Currently, from an API perspective, I can't see how anyone not familiar with
> the implementation details would be able to recognize this limitation.
> 
> In terms of the GPUVA manager, unfortunately, it seems like I need to drop
> the maple tree and go back to using a rb-tree, since it seems there is no
> sane way doing a worst-case pre-allocation that does not suffer from this
> limitation.

I haven't been paying much attention here (too many other things going
on), but something's wrong.

First, you shouldn't need to preallocate.  Preallocation is only there
for really gnarly cases.  The way this is *supposed* to work is that
the store walks down to the leaf, attempts to insert into that leaf
and tries to allocate new nodes with __GFP_NOWAIT.  If that fails,
it drops the spinlock, allocates with the gfp flags you've specified,
then rewalks the tree to retry the store, this time with allocated
nodes in its back pocket so that the store will succeed.
