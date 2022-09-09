Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43985B4021
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIITro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiIITrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:47:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1514365570
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rH8i5H/nxQpLKKOPnacxADawuH/GKvEdLBuxVQE/TkA=; b=bBuCLNHCiqnCbkeypvuzqK0m/4
        xCnerWuTX7pxCLZYif6oH7y0Ax2Fydp7FmMCaXx9P4b4qFK4IqZ6Ioxqa5GRF5IGNrlFEA3ReAOAr
        ET5rxkRfapYRKBctnHI21OE5FzL2K+Xqg/7FlYR0HdBPcjRl9pp5SaSZed4Jlpv5oMtaz5mBrL+ID
        pcpl/p3DOYzhavrWV3BGIZOHyPF2HJB+brAgZ6Ko7khejIB7OHeoc4c10Cu3kgqKJDay9B993D4Ko
        MWF2l+S5KQD9sH09hRrUrBEsxZG/OYFYHRLp9BQBWRXvx8llRz9RM9UVjQaXtAp0rMJuoicvWYOo/
        kJNbEdWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWjvo-00DWK7-5c; Fri, 09 Sep 2022 19:44:52 +0000
Date:   Fri, 9 Sep 2022 20:44:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] mm/page_alloc: use helper macro SZ_1{K,M}
Message-ID: <YxuXtL83Z9NPj5uR@casper.infradead.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-13-linmiaohe@huawei.com>
 <f83025e2-d516-72f2-7053-4c5f9626dcf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83025e2-d516-72f2-7053-4c5f9626dcf0@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:34:52PM +0200, David Hildenbrand wrote:
> On 09.09.22 11:24, Miaohe Lin wrote:
> > @@ -9055,7 +9055,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >   		/* It isn't necessary when PAGE_SIZE >= 1MB */
> 
> Huh, how could we ever have that. Smells like dead code.
> 
> >   		if (PAGE_SHIFT < 20)
> 
> What about adjusting that as well? The it exactly matches the comment
> 
> if (PAGE_SIZE >= SZ_1M)
> 
> > -			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
> > +			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);

The git history provides some clues here.  See a7e833182a92.
But we do have an architecture which has ...

#ifdef CONFIG_PAGE_SIZE_1MB
#define PAGE_SHIFT 20
#define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
#endif

I don't think it's an especially common config.

