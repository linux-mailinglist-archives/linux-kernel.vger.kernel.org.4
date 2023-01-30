Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F706816D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjA3Qs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbjA3QsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:48:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A021126F0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T4ILDFjJ+N5Z/VCjE/6Pce9EAA4WzpnG71+rjVJTl28=; b=MZCFM3QPR0ztw590R1onLnwXqi
        Qk2GcULz0juuy1Bhy+QF9Avl28IFHU92EhZQLtLJ60RQtQUQpKcdDh7XL2g6CdN+vuKbDJ+Io4fgr
        2KublRHNRox3RIOJQxPsHa7K2TS1jyY4BiZfymD/AiCsve9Kvkd51zwgeNxtCSfjBGitFoY7MWE3C
        8L+g3DJCR9dfgefOqZn4g/AZTdtTHrG8DszanSFAra11kvgRZ6erXxjEpzVkyiQww1helbQpYEw3f
        Lkb+Ip9TErALZ7UCWEfOZqhelQ8k3Ow2lUBFb9ATF8+eHnCdc5SKzprQc7G45ZU/5xqIcdw4ktPP8
        4g4i7V9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMXJu-00AVpI-2k; Mon, 30 Jan 2023 16:47:50 +0000
Date:   Mon, 30 Jan 2023 16:47:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
Message-ID: <Y9f0tkiXUoQexGsS@casper.infradead.org>
References: <20230130130739.563628-1-arnd@kernel.org>
 <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:38:22PM +0100, Michal Hocko wrote:
> On Mon 30-01-23 14:07:26, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > After x86 has enabled support for KMSAN, it has become possible
> > to have larger 'struct page' than was expected when commit
> > 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> > architectures") was merged:
> > 
> > include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
> >         switch (sizeof(struct page)) {
> > 
> > Extend the maximum accordingly.
> > 
> > Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> > Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> I haven't really followed KMSAN development but I would have expected
> that it would, like other debugging tools, add its metadata to page_ext
> rather than page directly.

Yes, that would have been preferable.  Also, I don't understand why we
need an entire page to store whether each "bit" of a page is initialised.
There are no CPUs which have bit-granularity stores; either you initialise
an entire byte or not.  So that metadata can shrink from 4096 bytes
to 512.
