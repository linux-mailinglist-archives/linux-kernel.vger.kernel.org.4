Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61731748EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjGEUTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGEUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:19:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431E1985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5X1Mo95OcJGk9juiqAgblVpUBRzoZfAwW9LAATZelW0=; b=tfoiTQPDT77LX6QudJB8OS42kP
        wMr+kawy7eQM8q3KsiRfGfn2KVyDog4sNmVRxc8vD84DWvu8se6RqbknKTjrsF3VScvWOfsS4bNmN
        D72TDO2IJ3fbLzCMmK2HmhHc25lzo54S4rlXaNJ5NAXMlM2s15EAKgaPf7Sx2VVoETCDXKk7p5C4s
        mZnUSL83FJF+/oV2kylYAavLt4PDPdWSVYz5JQrcyt/Eq2N+6FlwgsCgzWxgg7Fxzx2gb3BH4U3K2
        c20GzBq7GBqLzdM3mi/gF5MVQjZr4mO9C5Z2YXIqT8rk6v/3osN4uL4jY3swuEwYVT0Dc+kJYmmRG
        /gYmC+zA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH8yK-00AOT6-In; Wed, 05 Jul 2023 20:19:32 +0000
Date:   Wed, 5 Jul 2023 21:19:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/4] mm/memory: convert do_shared_fault() to folios
Message-ID: <ZKXQVNHOB2Ddx4hN@casper.infradead.org>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-3-sidhartha.kumar@oracle.com>
 <ZKXO0/2sC3/dvLO7@casper.infradead.org>
 <b6e056d7-5b35-bcfa-4661-ebeb8cffd1c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e056d7-5b35-bcfa-4661-ebeb8cffd1c4@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:16:25PM -0700, Sidhartha Kumar wrote:
> On 7/5/23 1:13 PM, Matthew Wilcox wrote:
> > On Wed, Jul 05, 2023 at 12:43:34PM -0700, Sidhartha Kumar wrote:
> > >   	/*
> > >   	 * Check if the backing address space wants to know that the page is
> > >   	 * about to become writable
> > >   	 */
> > >   	if (vma->vm_ops->page_mkwrite) {
> > > -		unlock_page(vmf->page);
> > > +		folio_unlock(folio);
> > >   		tmp = do_page_mkwrite(vmf);
> > >   		if (unlikely(!tmp ||
> > >   				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> > > -			put_page(vmf->page);
> > > +			folio_put(folio);
> > 
> > This is _probably_ OK.  However, do_page_mkwrite() calls
> > vm_ops->page_mkwrite(), and I think it's theoretically possible for the
> > driver to replace vmf->page with a different one.  The chance of them
> > actually doing that is pretty low (particularly if they return error or
> > nopage!), but I'm going to flag it just in case it comes up.
> > 
> > Also, should we pass a folio to do_page_mkwrite() instead of having it
> > extract the folio from vmf->page?
> 
> I can take a look at doing this in a follow-up patch.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Did you mean for this to be reviewed-by?

Uh, yes.  Maybe I need to get more rest ...
