Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067197106CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjEYH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEYH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:59:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15FE122;
        Thu, 25 May 2023 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1SbotI5SOBhG7bXBLx5uW2S/thCuqPvVS6nzOwu9CA8=; b=V58wO3BzmmE0SuFDyj/dG3wtLK
        lAzsAvB3ZVtK85AeH07/CJcxdL6YrVPVNDBjp1gDEQPt3y4PFxy1zANuqX7eVYeIgd3P7ogmbXOTU
        da9+kR0/TlSsh1y3pAg8cJlsO45ZGPvvuTYFq/fNI4L86nVhMdF9l0CdKYvln7GJza2VN0yD6cUMZ
        9AGBExT5R92fPahMcA7LeZjMrK7dkBLryYUAAfcvK7uRiSTSxKle8hlE9ag/8t3Jjq9Yn1IOJUZuo
        uX3hxlvo7360UC0O1DFIK/1Wbl7Y+nHItalF92A3t01qoCyYcTe7+nOpiFXaZa42gRD6g3h1sC3BR
        Yy6h2YmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q25sp-00Fu4N-2E;
        Thu, 25 May 2023 07:59:39 +0000
Date:   Thu, 25 May 2023 00:59:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <ZG8Va0hc67IC6Cuf@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
 <ZG3d1FUXiCk3QL3D@pc636>
 <ZG6IKE7yNEkJhge+@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG6IKE7yNEkJhge+@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 07:56:56AM +1000, Dave Chinner wrote:
> > It is up to community to decide. As i see XFS needs it also. Maybe in
> > the future it can be removed(who knows). If the vmalloc code itself can
> > deliver such performance as vm_map* APIs.
> 
> vm_map* APIs cannot be replaced with vmalloc, they cover a very
> different use case.  i.e.  vmalloc allocates mapped memory,
> vm_map_ram() maps allocated memory....
> 
> > vm_map_ram() and friends interface was added because of vmalloc drawbacks.
> 
> No. vm_map*() were scalability improvements added in 2009 to replace
> on vmap() and vunmap() to avoid global lock contention in the vmap
> allocator that XFS had been working around for years with it's own
> internal vmap cache....

All of that is true.  At the same time XFS could very much switch to
vmalloc for !XBF_UNMAPPED && size > PAGE_SIZE buffers IFF that provided
an advantage.  The need for vmap and then vm_map_* initially came from
the fact that we were using the page cache to back the xfs_buf (or
page_buf back then).  With your work on getting rid of the pagecache
usage we could just use vmalloc now if we wanted to and it improves
performance.  Or at some point we could even look into just using large
folios for that with the infrastructure for that improving a lot (but
I suspect we're not quite there yet).

But ther are other uses of vm_map_* that can't do that, and they will
benefit from the additional scalability as well even IFF just using
vmalloc was fine for XFS now (I don't know, I haven't actually looked
into it).
