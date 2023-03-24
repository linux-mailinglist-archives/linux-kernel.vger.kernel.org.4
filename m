Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F66C7ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCXNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F512BF5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I28hRGirzN8hVkdWraPB+LlmHvIXHPkHvuCGx6fgbb8=; b=deQGo/FBs7ILMJ0dTmKsELounr
        HhBCEdzaOOzJt8I7mw3sUgiLBiPF1a/faXbaPe9hOnRg6AsE+Ca6CSKmj/+liTQCIp5z7W1h+hF6x
        j2RYseCqveDUtpXDWBlSlVvr8/UonyboXnqrgVFcHuvYfx+jGlm1qzm+LDtb4kro8Jn5iZg+fZzsS
        j66F4KffTxpsPLP9u0+DiRsoG7n9t0DQ3RrHSCDAg8CEGH4lB5FmiDtXStfTKlaiTcf4KW5/uoany
        j13FeTOwKqOO1O986xUNamcLQFsscNPleoYZRgbWN03DX5+8dRqNJWecu3geNZASyYrS2OIRcfbQC
        S6FZtW7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfhVf-004wTv-N3; Fri, 24 Mar 2023 13:31:11 +0000
Date:   Fri, 24 Mar 2023 13:31:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <songliubraving@meta.com>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <ZB2mH/XMj3vh1RrN@casper.infradead.org>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
 <ZBzK99dSmbPB7vjA@casper.infradead.org>
 <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
 <b49b118d-893c-c749-61f6-9441539418a5@google.com>
 <ZB0ZSqw1TTp3/ec3@casper.infradead.org>
 <6F9B0A6A-B7F1-4E25-AB15-8F3782D2EF83@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F9B0A6A-B7F1-4E25-AB15-8F3782D2EF83@fb.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 06:03:37AM +0000, Song Liu wrote:
> 
> 
> > On Mar 23, 2023, at 8:30 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> [...]
> 
> > 
> > The Uptodate flag check needs to be done by the caller; the
> > find_get_page() family return !uptodate pages.
> > 
> > But find_get_page() does not advertise itself as NMI-safe.  And I
> > think it's wrong to try to make it NMI-safe.  Most of the kernel is
> > not NMI-safe.  I think it's incumbent on the BPF people to get the
> > information they need ahead of taking the NMI.  NMI handlers are not
> > supposed to be doing a huge amount of work!  I don't really understand
> > why it needs to do work in NMI context; surely it can note the location of
> > the fault and queue work to be done later (eg on irq-enable, task-switch
> > or return-to-user)
> 
> The use case here is a profiler (similar to perf-record). Parsing the 
> build id in side the NMI makes the profiler a lot simpler. Otherwise, 
> we will need some post processing for each sample. 

Simpler for you, maybe.  But this is an NMI!  It's not supposed to
be doing printf-formatting or whatever, much less poking around
in the file cache.  Like perf, it should record a sample and then
convert that later.  Maybe it can defer to a tasklet, but i think
scheduling work is a better option.

> OTOH, it is totally fine if build_id_parse() fails some time, say < 5%. 
> The profiler output is still useful in such cases. 
> 
> I guess the next step is to replace find_get_page() with a NMI-safe
> version?

No, absolutely not.  Stop doing so much work in an NMI.
