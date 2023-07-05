Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57AB7483CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGEMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGEMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:09:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0CBCE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cy83JkJmnxLA9dztdWd+Q9yw3dWpEbujYErrO2HQQ3o=; b=p8H82thFSahW225r9+3bsg9+R5
        khUwiWnFyk2vYVOOTaW0KJfGwFKhQkIjgGcoYqH0MYWj3FUEFP6wWostiKFkLL3KEvGtB7JYad/av
        h94oZ+uHVAVAGo49iRthhgQbKA6PR8dcvOoc5d2oUr2TOcnyAq1LO6kdWU+n5MvZ5dXy0PUTY8mc3
        3gDzy7inaTP8oV3LAgZBl0VKKV2EcIQPCdlwF7lyQ/vU82wWLtiGAq8Fe7r6nOjczFL8AgG9C+ymJ
        GphtZwLoao0kPsDakcWlY9+L9UQCnBYIpHAvdfRpBHPaQx+C72MDReHs8ulba5SmrG5OdgyKeszNW
        leg0mZ5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH1JQ-00A3K5-Hy; Wed, 05 Jul 2023 12:08:48 +0000
Date:   Wed, 5 Jul 2023 13:08:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Message-ID: <ZKVdUDuwNWDUCWc5@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <6865a59e-9e40-282d-c434-b7c757388b65@intel.com>
 <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
 <ZKSx5Udt3Oh8Kr35@casper.infradead.org>
 <4ee6e325-30ea-f74c-7d73-10a5d1453d01@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee6e325-30ea-f74c-7d73-10a5d1453d01@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:54:30AM +0100, Ryan Roberts wrote:
> On 05/07/2023 00:57, Matthew Wilcox wrote:
> > The confusing thing is that we have counters for the number of THP
> > allocated (and number of THP mapped), and for those we always use
> > PMD-size folios.
> 
> OK fair point. I really don't have a strong opinion on the name - I changed it
> from LARGE_ANON_FOLIO because Yu was suggesting it should be tied to THP. So I'm
> happy to change it back to LARGE_ANON_FOLIO (or something else) if that's the
> concensus. But I expect I'll end up in a game of ping-pong. So I'm going to keep
> this name for now and focus on converging the actual implementation to something
> that is agreeable. Once we are there, we can argue about the name.

I didn't see Yu arguing for changing the name of the config options,
just having far fewer of them.

> > If we must have a config option, then this is ANON_LARGE_FOLIOS.
> > 
> > But why do we need a config option?  We don't have one for the
> > page cache, and we're better off for it.  Yes, it depends on
> > CONFIG_TRANSPARENT_HUGEPAGE today, but that's more of an accidental
> > heritage, and it'd be great to do away with that dependency eventually.
> > 
> > Hardware support isn't needed.  Large folios benefit us from a software
> > point of view.  if we need a chicken bit, we can edit the source code
> > to not create anon folios larger than order 0.
> 
> >From my PoV it's about managing risk; there are currently parts of the mm that
> will interact poorly with large pte-mapped folios (madvise, compaction, ...). We
> want to incrementally fix that stuff, but until it's all fixed, we can't deploy
> this as always-on. Further down the line when things are more complete and there
> is more test coverage, we could remove the Kconfig or default it to enabled.

We have to fix those places with the bad interactions, not merge a
Kconfig option that lets you turn it on to experiment.  That's how you
get a bad reputation and advice to disable a config option.  We had that
for years with CONFIG_TRANSPARENT_HUGEPAGE; people tried it out early on,
found the performance problems, and all these years later we still have
articles being published that say to turn it off.

By all means, we can have a golden patchset that we all agree is the
one to use for finding problems, and we can merge the pre-enabling work
"We don't have large anonymous folios yet, but when we do, this will
need to iterate over each page in the folio".
