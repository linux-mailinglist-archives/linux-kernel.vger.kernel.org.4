Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C76E68F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDRQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDRQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39EAF32
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681833975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH0/n2gRXAMCivoDkGd8b9iwO+Yl9rZdWUvZzMLaiXM=;
        b=W+519f80bYyB9cFHeDD7oAh4cXfiBkLc+wbnoPwNnDO5KYTaxQLjaKOUgcOC0lCTQxgQi6
        wU3NqoL2spUgrsy6uzzP3szYk0NFaHvYzA+FlqPD+16lGTKnavpp2NO16itpXmSEp2Of0N
        Ag4giOsRgApYEhsnBSAuC+x8mnzZBnU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-KG49-jVtPOyAt0m3l9bfdw-1; Tue, 18 Apr 2023 12:06:14 -0400
X-MC-Unique: KG49-jVtPOyAt0m3l9bfdw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74deffa28efso14549685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833974; x=1684425974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH0/n2gRXAMCivoDkGd8b9iwO+Yl9rZdWUvZzMLaiXM=;
        b=L6YhdlcGpv3d1dNkA5cbMrwa9AklZtKLiErCO7HMii/Y6gYH3UBDNGqH+BVRG/BFug
         uVIMXrtyoPzBlzNre1Zzm65IZUuskD3UfagOzRqTKRGY4oz11KT/a1WOo2lUDdPqivmu
         xh0zvmSR6wJdl85kX9AGbVkg+nub8ZoXwIaF/m+ZIDUynX5cqD8i8pVzc2hF+4i9T19B
         kc48ctm0lXLsmHvG9vAnfdRtifz5M1e7jxPmLJUWxiTDpOzOO7oN+XUBmz6aUIpPqOty
         E5Oij4w8UuCW06My7l/0qEAetUyRtpk4jksBGp86uVS/2glh1NkQqxSGxnJ7RL3bIHfO
         wS5g==
X-Gm-Message-State: AAQBX9cUi79ePdDi0ACNZgPyfiPP3SVgK0x+zbsmOjHeFDMdgg33V9sL
        yC6KPdlgxEyksGgIv2URYmY1kBXNV67ms/34qkCD7vKCqHZzGlovXKRafl1SoCdMZr/okICYryX
        DvgQ03b+AMAvXwBnjfQBFcfUu
X-Received: by 2002:a05:6214:4002:b0:5aa:14b8:e935 with SMTP id kd2-20020a056214400200b005aa14b8e935mr21727595qvb.2.1681833973850;
        Tue, 18 Apr 2023 09:06:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350bDvo37hNrqe2q76IoGC5GeTPbTFWQEc2HzolNJM0oXlEltLJYo3iBGKgIMy77mY+7QV49Pyg==
X-Received: by 2002:a05:6214:4002:b0:5aa:14b8:e935 with SMTP id kd2-20020a056214400200b005aa14b8e935mr21727546qvb.2.1681833973468;
        Tue, 18 Apr 2023 09:06:13 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id f3-20020a05621400c300b005dd8b9345d3sm3786224qvs.107.2023.04.18.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:06:12 -0700 (PDT)
Date:   Tue, 18 Apr 2023 12:06:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD6/805XpvfZde0Y@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
 <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org>
 <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZD6yirD6Ob+1xG32@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 04:08:58PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Apr 18, 2023 at 7:25 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Apr 17, 2023 at 3:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > > >     /*
> > > > > > > -    * We don't do accounting for some specific faults:
> > > > > > > -    *
> > > > > > > -    * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> > > > > > > -    *   includes arch_vma_access_permitted() failing before reaching here.
> > > > > > > -    *   So this is not a "this many hardware page faults" counter.  We
> > > > > > > -    *   should use the hw profiling for that.
> > > > > > > -    *
> > > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> > > > > > > -    *   once they're completed.
> > > > > > > +    * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> > > > > > > +    * counted upon completion.
> > > > > > >      */
> > > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > > +           return;
> > > > > > > +
> > > > > > > +   /* Register both successful and failed faults in PGFAULT counters. */
> > > > > > > +   count_vm_event(PGFAULT);
> > > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > > >
> > > > > > Is there reason on why vm events accountings need to be explicitly
> > > > > > different from perf events right below on handling ERROR?
> > > > >
> > > > > I think so.  ERROR is quite different from RETRY.  If we are, for
> > > > > example, handling a SIGSEGV (perhaps a GC language?) that should be
> > > > > accounted.  If we can't handle a page fault right now, and need to
> > > > > retry within the kernel, that should not be accounted.
> > > >
> > > > IIUC, the question was about the differences in vm vs perf accounting
> > > > for errors, not the difference between ERROR and RETRY cases. Matthew,
> > > > are you answering the right question or did I misunderstand your
> > > > answer?
> > >
> > > Maybe I'm misunderstanding what you're proposing.  I thought the
> > > proposal was to make neither ERROR nor RETRY increment the counters,
> > > but if the proposal is to make ERROR increment the perf counters
> > > instead, then that's cool with me.
> > 
> > Oh, I think now I understand your answer. You were not highlighting
> > the difference between the who but objecting to the proposal of not
> > counting both ERROR and RETRY. Am I on the same page now?
> 
> I think so.  Let's see your patch and then we can be sure we're talking
> about the same thing ;-)

IMHO if there's no explicit reason to differenciate the events, we should
always account them the same way for vm,perf,... either with ERROR
accounted or not.

I am not sure whether accounting ERROR faults would matter for a mprotect()
use case, because they shouldn't rely on the counter to work but the SIGBUS
itself to be generated on page accesses with the sighandler doing work.

One trivial benefit of keep accounting ERROR is we only need to modify vm
account ABI so both RETRY & ERROR will be adjusted to match perf,task
counters.  OTOH we can also change all to take ERROR into account, but then
we're modifying ABI for all counters.

-- 
Peter Xu

