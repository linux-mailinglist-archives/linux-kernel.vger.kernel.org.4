Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28B74FA80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGKWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:00:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2706D1992
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GR7Hgx/W3CR5RFAsNJV3TXtKYoyPG7TJfZgx5GEsN+M=; b=MidStUHHVj31VOhmkApv0W5rnq
        d+ljJoZBzxMyqfRDmlLz8J/eJ8Prwg/ymcCn7CbEIbfir0lq+u6xDOZlOSrJcPEu285RdV5ffbqzK
        T8Ty523zDSvIn/tgV8lv5ljlKk2kgG0WGgVQpQGLvlO04GL/ASU/qomZ9B2/qH8Ziuxc3gULoLjm+
        tDkExFYrI2+c3UmjtDns3RP0csPUx3hHxIS7lMFmYQtRkHiAxcTOGQf7tH+RnoWpbL8eJ3qDRpl0P
        5ch99DieeCY6heDJbhTN0pqDf8jJJX+FgcYwJ3R7Kwrd32nkApF/OPIFzAtu2z/sURYYiIhdBeqQx
        0CkQyXCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJLOi-00G5K6-W1; Tue, 11 Jul 2023 21:59:53 +0000
Date:   Tue, 11 Jul 2023 22:59:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Message-ID: <ZK3Q2CTUc9pPt4Br@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
 <ZK3FdyqlhIs5HRk8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK3FdyqlhIs5HRk8@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:11:19PM -0700, Luis Chamberlain wrote:
> On Fri, Jul 07, 2023 at 02:12:01PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
> > 
> > > Is swapping working as expected? zswap?
> > 
> > Suboptimally.  Swap will split folios in order to swap them.
> 
> Wouldn't that mean if high order folios are used a lot but swap is also
> used, until this is fixed you wouldn't get the expected reclaim gains
> for high order folios and we'd need compaction more then?

They're split in shrink_folio_list(), so they stay intact until
that point?

> > Somebody needs to fix that, but it should work.
> 
> As we look at shmem stuff it was on the path so something we have
> considered doing. Ie, it's on our team's list of items to help with
> but currently on a backburner.

Something I was thinking about is that you'll need to prohibit swap
devices or swap files being created on large block devices.  Until
we rewrite the entire swap subsystem ...
