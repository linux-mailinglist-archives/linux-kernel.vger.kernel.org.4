Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017070E01D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjEWPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbjEWPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB2126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=neW8xWDF9dDcKsZp/aT07RgnmDTayd37jG9hz6hzonQ=; b=EmF0pl3GeWh750bwRO27xgDDcP
        6hwKFN8pdjjar3LqX5IyDTRbC8dckdXFqEw1oLFlhTQO6B1kHOmveNM9z6CYqvp570+f6fB37a7Wl
        jFBr06sVP4Uz2T686HXrHyiRKNb4WjcnLeIewSwA4Av2G1L13ek1buPJgJfMIwA776ME5Ky0Wvx93
        mHrdUJo3qK2BTUWIC7RVID9jdtIrYS7j4FDEhiJOxU0P4Ow4b/h6Gi3sWYq9P53mYP0/xF0obNEPT
        U9iiR0eHUPw+MSIj1HyfGgvDIEy9VC2/LGuRT9CCDVPnk53+vS36P+x5v4RWaqxUkrcfTKUWWh5Ws
        13UDhjLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Thr-00AbBM-0C;
        Tue, 23 May 2023 15:13:47 +0000
Date:   Tue, 23 May 2023 08:13:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/9] mm: vmalloc: Add a per-CPU-zone infrastructure
Message-ID: <ZGzYK4x6+anak3Ew@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-5-urezki@gmail.com>
 <ZGxYZlLoADBWktT8@infradead.org>
 <ZGzTZWq/hAYCE3DA@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzTZWq/hAYCE3DA@pc636>
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

On Tue, May 23, 2023 at 04:53:25PM +0200, Uladzislau Rezki wrote:
> > > +#define fbl_lock(z, i) spin_lock(&fbl(z, i, lock))
> > > +#define fbl_unlock(z, i) spin_unlock(&fbl(z, i, lock))
> > 
> > Even if it is just temporary, I don't think adding these wrappers
> > make much sense.
> > 
> If open-coded, it looks like:
> 
> spin_lock(&z->fbl[BUSY].lock);

Give the fbl structure a name and you can have a local variable for it,
which will make all this a lot more readable.  And then unless there is
a really good reason to iterate over this as an array just have three
of these structs embedded named free, busy and lazy.
