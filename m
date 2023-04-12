Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90D6DF97F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjDLPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDLPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:14:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBBC7EEA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l0xucI8HSm2rAbmozA4KK4Oskg2uJhGgLoTrZxLS5go=; b=XOLP+lIHcnCQmM6hCFjaSb6rTI
        7NYFAE1AyPDNlE0Ee/qPRKbHYFRwF7C41+PEjeAFtPFp4myX6Zb3gMwUZbRuNbZk3a0s8K6TW6olD
        NSS1hZUc0QIUAovWgGSsRWyOoiMEXnJ5tV5chsYrf454dY2hi6RW8smhKqGbj7b9yhRNdhEjov/7p
        v3PROueny297lJWTN6MXdDS6dfplewG3ow841KA29sRavbVGHShYjqymehKJrud+DsmgBzaU5SlSD
        5pf+fmw9mL6OWowX3P38uoT5lIkq8FXVlhFz2p+NmNVR735zdPf/0NTm8HmFGHkLiYLCbOkeqKhsh
        6+1KGDgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmcAz-006yX9-3p; Wed, 12 Apr 2023 15:14:25 +0000
Date:   Wed, 12 Apr 2023 16:14:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "xiaosong.ma" <Xiaosong.Ma@unisoc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        yuming.han@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH V2] fs: perform the check when page without mapping but
 page->mapping contains junk or random bitscribble
Message-ID: <ZDbK0Wr2uerk/7C5@casper.infradead.org>
References: <1681091102-31907-1-git-send-email-Xiaosong.Ma@unisoc.com>
 <ZDVPkljntjCr9/nX@casper.infradead.org>
 <20230411171536.2e53b4b7507304d5618aa24e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171536.2e53b4b7507304d5618aa24e@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:15:36PM -0700, Andrew Morton wrote:
> On Tue, 11 Apr 2023 13:16:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Apr 10, 2023 at 09:45:02AM +0800, xiaosong.ma wrote:
> > > perform the check in dump_mapping() to print warning info and avoid crash with invalid non-NULL page->mapping.
> > > For example, a panic with following backtraces show dump_page will show wrong info and panic when the bad page
> > > is non-NULL mapping and page->mapping is 0x80000000000.
> > > 
> > >     crash_arm64> bt
> > >     PID: 232    TASK: ffffff80e8c2c340  CPU: 0   COMMAND: "Binder:232_2"
> > >      #0 [ffffffc013e5b080] sysdump_panic_event$b2bce43a479f4f7762201bfee02d7889 at ffffffc0108d7c2c
> > >      #1 [ffffffc013e5b0c0] atomic_notifier_call_chain at ffffffc010300228
> > >      #2 [ffffffc013e5b2c0] panic at ffffffc0102c926c
> > >      #3 [ffffffc013e5b370] die at ffffffc010267670
> > >      #4 [ffffffc013e5b3a0] die_kernel_fault at ffffffc0102808a4
> > >      #5 [ffffffc013e5b3d0] __do_kernel_fault at ffffffc010280820
> > >      #6 [ffffffc013e5b410] do_bad_area at ffffffc01028059c
> > >      #7 [ffffffc013e5b440] do_translation_fault$4df5decbea5d08a63349aa36f07426b2 at ffffffc0111149c8
> > >      #8 [ffffffc013e5b470] do_mem_abort at ffffffc0100a4488
> > >      #9 [ffffffc013e5b5e0] el1_ia at ffffffc0100a6c00
> > >      #10 [ffffffc013e5b5f0] __dump_page at ffffffc0104beecc
> > 
> > This doesn't show a crash in dump_mapping(), it shows a crash in
> > __dump_page().
> 
> um, yes.
> 
> But if page->mapping is corrupted, where does __dump_page() dereference it?

I don't see anywhere that it does, so I'm suspicious that we have the
correct diagnosis here.

> The initial patch
> (https://lkml.kernel.org/r/1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com)
> prevented __dump_page() from calling dump_mapping() if page->mapping is
> bad, and that presumably fixed things.

Right, but doesn't the _existing_ get_kernel_nofault(host, &mapping->host)
already prevent us from blindly dereferencing a bad mapping pointer?

> > > -	if (get_kernel_nofault(host, &mapping->host) ||
> > > +	if (get_kernel_nofault(mapping, &mapping) ||
> > > +	    get_kernel_nofault(host, &mapping->host) ||
> > 
> > This patch makes no sense.  Essentially, you're saying
> > 	mapping = &mapping
> > which is obviously wrong.
> 
> We're checking for mapping==junk, so this could be 
> 
> 	get_kernel_nofault(tmp, mapping)

Why will that be better than get_kernel_nofault(host, &mapping->host)?
I see no tangible difference between get_kernel_nofault(0x8000'0000) and
get_kernel_nofault(0x8000'0084) (or whatever the offset is).

> or go direct to copy_from_kernel_nofault().  We used to have a
> probe_kernel_address() for this...
> 
> So confusion reigns.  I think making dump_mapping() tolerant of a wild
> mapping pointer makes sense, but I don't think we actually know why the
> reporter's kernel crashed.

In my mind dump_mapping() is already tolerant of a wild page->mapping
pointer.  I think the problem is something entirely different.
