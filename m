Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4874B18A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGNMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:12:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2676C1FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wFqH+7Ljt87dhV27Wcx4gWglYgjDuLdi+M0sLgvzXk4=; b=nAYdwiUTj5N+C2ndcrXIOg0NzR
        WgxCiFOP2iVzT08YnZ2DvkdKCcsuzkmwLFNZyNSRpRI8+WvxQlC9WBYmP44C+6AGeVqjql77XetW3
        stIXD8X2JRK8P1VBm98RpEWHXhV5VosQB5Jmp/Bj24p5Q8HsLIWls2YhnQ/zaECn92lZGEYyzbMkV
        c7I7WPtCQ+QQGIQBT0bvqSTcGvjYXgSXSTcLMC+97NqXFtyneSoi+IKhdyvw0JkysOHYAYJPirPg5
        Jy3ZsbWiifnqtPL+dfpsjtd0mPjbFoq53nlpAJeX/+dzpASGKox4pRSYzjifqPNyX5XiVQlcGhA+j
        MPL5FXAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHlFi-00C2ig-1Z; Fri, 07 Jul 2023 13:12:02 +0000
Date:   Fri, 7 Jul 2023 14:12:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
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
Message-ID: <ZKgPIXSrxqymWrsv@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
> On 06.07.23 10:02, Ryan Roberts wrote:
> But can you comment on the page migration part (IOW did you try it already)?
> 
> For example, memory hotunplug, CMA, MCE handling, compaction all rely on
> page migration of something that was allocated using GFP_MOVABLE to actually
> work.
> 
> Compaction seems to skip any higher-order folios, but the question is if the
> udnerlying migration itself works.
> 
> If it already works: great! If not, this really has to be tackled early,
> because otherwise we'll be breaking the GFP_MOVABLE semantics.

I have looked at this a bit.  _Migration_ should be fine.  _Compaction_
is not.

If you look at a function like folio_migrate_mapping(), it all seems
appropriately folio-ised.  There might be something in there that is
slightly wrong, but that would just be a bug to fix, not a huge
architectural problem.

The problem comes in the callers of migrate_pages().  They pass a
new_folio_t callback.  alloc_migration_target() is the usual one passed
and as far as I can tell is fine.  I've seen no problems reported with it.

compaction_alloc() is a disaster, and I don't know how to fix it.
The compaction code has its own allocator which is populated with order-0
folios.  How it populates that freelist is awful ... see split_map_pages()

> Is swapping working as expected? zswap?

Suboptimally.  Swap will split folios in order to swap them.  Somebody
needs to fix that, but it should work.
