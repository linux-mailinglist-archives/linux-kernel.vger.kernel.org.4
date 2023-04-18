Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7206E6F99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjDRWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F419A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681857943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rny7/IdykDsSisA51FPjfejtZJ1cCD5wOnVMPzuiZB0=;
        b=SYZWPwLg8iZc1GyKml5swJYN7yi1LAGjzUQmJZSXvmG5QOrMBia2lvXjWVm5QrmAt26HT+
        T/mEUoclLLFF7Yi1MAF+nboCHJ0Lpg4uCfTzfL6ZIUajcLw1blmt6GXD8gBIYZTdhV3dxC
        WcFoNdwOI0hRan9lqO4GiljTIyKfjw0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-5Gakqg--PJOqJd_BTWCASg-1; Tue, 18 Apr 2023 18:45:42 -0400
X-MC-Unique: 5Gakqg--PJOqJd_BTWCASg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74a90355636so102744985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857942; x=1684449942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rny7/IdykDsSisA51FPjfejtZJ1cCD5wOnVMPzuiZB0=;
        b=BkYjoOdMdA3w0rAqL9htvVP+5IQ0HGKwkgTrUb9sxhJZ0QuiYhWzZowxqrTi0a0TqX
         P4EyOmSNgVsrgV+s0J4l3tNbRZSiQljvyEm3f2WDBhNUMVKT1UAj3voTOKkOmv3t4rOf
         somwlhFtwxxNKfFMCoQZEnpVtYZ1Go2IBlzTn0/Ysary2iF4+9Th2vzonZtb0kQxGQFv
         f4h4uHuXNRAxl9kAeKSTpVzH9CZtH5vwlIbWpAcMyJ5SW10n9YbygXDV4Qbaz2JZO7+L
         6jg0u/UM/9ycLBgEPuEhjzODOgWpvwyCV091hp5Fb/QW7Nqkk7eXldNBeOZNPyWcM2+R
         s27g==
X-Gm-Message-State: AAQBX9eOFGpZCRpo8qV2za/CIX9UB+LhaGN0jcv4OfxoYHcRjnTZFB5L
        SA+ZogaQs1UdYcdsNmelusotuicmAetrt8o5ZLS7Wfq+m2XqrUcb1seJ7BNRGzMJUObP3pz5eKo
        Oa7vATKAkdvRkDXrpREId5v2o
X-Received: by 2002:a05:6214:4109:b0:5ac:325c:a28f with SMTP id kc9-20020a056214410900b005ac325ca28fmr24452921qvb.0.1681857941989;
        Tue, 18 Apr 2023 15:45:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350YThGSid/DuTDWFRNylgzhR7W4SKoj9l/AH0Htc2g0G7OGNK6dtrt0w6/zjnmshXEL55TUivA==
X-Received: by 2002:a05:6214:4109:b0:5ac:325c:a28f with SMTP id kc9-20020a056214410900b005ac325ca28fmr24452900qvb.0.1681857941654;
        Tue, 18 Apr 2023 15:45:41 -0700 (PDT)
Received: from x1n ([70.52.229.124])
        by smtp.gmail.com with ESMTPSA id ei18-20020ad45a12000000b005eac706d223sm4004767qvb.124.2023.04.18.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:45:41 -0700 (PDT)
Date:   Tue, 18 Apr 2023 18:45:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD8dj3Tk2b1TWVK5@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
 <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org>
 <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org>
 <ZD6/805XpvfZde0Y@x1n>
 <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
 <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:48:58PM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 18, 2023 at 10:17 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Apr 18, 2023 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 04:08:58PM +0100, Matthew Wilcox wrote:
> > > > On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrote:
> > > > > On Tue, Apr 18, 2023 at 7:25 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrote:
> > > > > > > On Mon, Apr 17, 2023 at 3:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > > > > > >     /*
> > > > > > > > > > -    * We don't do accounting for some specific faults:
> > > > > > > > > > -    *
> > > > > > > > > > -    * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> > > > > > > > > > -    *   includes arch_vma_access_permitted() failing before reaching here.
> > > > > > > > > > -    *   So this is not a "this many hardware page faults" counter.  We
> > > > > > > > > > -    *   should use the hw profiling for that.
> > > > > > > > > > -    *
> > > > > > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> > > > > > > > > > -    *   once they're completed.
> > > > > > > > > > +    * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> > > > > > > > > > +    * counted upon completion.
> > > > > > > > > >      */
> > > > > > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > > > > > +           return;
> > > > > > > > > > +
> > > > > > > > > > +   /* Register both successful and failed faults in PGFAULT counters. */
> > > > > > > > > > +   count_vm_event(PGFAULT);
> > > > > > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > > > > > >
> > > > > > > > > Is there reason on why vm events accountings need to be explicitly
> > > > > > > > > different from perf events right below on handling ERROR?
> > > > > > > >
> > > > > > > > I think so.  ERROR is quite different from RETRY.  If we are, for
> > > > > > > > example, handling a SIGSEGV (perhaps a GC language?) that should be
> > > > > > > > accounted.  If we can't handle a page fault right now, and need to
> > > > > > > > retry within the kernel, that should not be accounted.
> > > > > > >
> > > > > > > IIUC, the question was about the differences in vm vs perf accounting
> > > > > > > for errors, not the difference between ERROR and RETRY cases. Matthew,
> > > > > > > are you answering the right question or did I misunderstand your
> > > > > > > answer?
> > > > > >
> > > > > > Maybe I'm misunderstanding what you're proposing.  I thought the
> > > > > > proposal was to make neither ERROR nor RETRY increment the counters,
> > > > > > but if the proposal is to make ERROR increment the perf counters
> > > > > > instead, then that's cool with me.
> > > > >
> > > > > Oh, I think now I understand your answer. You were not highlighting
> > > > > the difference between the who but objecting to the proposal of not
> > > > > counting both ERROR and RETRY. Am I on the same page now?
> > > >
> > > > I think so.  Let's see your patch and then we can be sure we're talking
> > > > about the same thing ;-)
> > >
> > > IMHO if there's no explicit reason to differenciate the events, we should
> > > always account them the same way for vm,perf,... either with ERROR
> > > accounted or not.
> > >
> > > I am not sure whether accounting ERROR faults would matter for a mprotect()
> > > use case, because they shouldn't rely on the counter to work but the SIGBUS
> > > itself to be generated on page accesses with the sighandler doing work.
> >
> > For that example with GC, these are valid page faults IIUC and current
> > PGFAULT counters do register them. Do we want to change that and
> > potentially break assumptions about these counters?
> >
> > >
> > > One trivial benefit of keep accounting ERROR is we only need to modify vm
> > > account ABI so both RETRY & ERROR will be adjusted to match perf,task
> > > counters.  OTOH we can also change all to take ERROR into account, but then
> > > we're modifying ABI for all counters.
> >
> > So, not accounting them in both vm and perf would be problematic for
> > that GC example and similar cases.
> > Are we left with only two viable options?:
> > 1. skip RETRY for vm and skip ERROR for both vm and perf (this patch)
> > 2. skip RETRY for both vm and perf, account ERROR for both
> >
> > #2 would go against the comment in mm_account_fault() saying that we
> > don't account for unsuccessful faults. I guess there must have been
> > some reason we were not accounting for them (such as access to a
> > faulty address is neither major nor minor fault)?
> 
> I did some digging in the history and looks like the check for ERROR
> was added after this discussion:
> https://lore.kernel.org/all/20200624203412.GB64004@xz-x1/ and IIUC the
> reason was that previous code also skipped VM_FAULT_ERROR. Peter, is
> that correct?

I think so.

It's a few years ago, what I remember is that we did change some of the
counters at least on some archs, and I don't remember anything is broken
for real after that.

> 
> It seems this discussion is becoming longer than it should be. How
> about we keep the behavior of all counters as they are to avoid
> breaking any possible usecases and just fix the double-counting issue
> for RETRY cases?

Sure, though again I hope we can add some comment explaining, because the
outcome of the code can look a bit weird on handling different counters
differently.

IMHO it can be as simple as "we did accounting differently on different
types of counters for historical reasons, here just to make them compatible
with old kernels", maybe it will still help a bit when we read again on
this chunk of code?

Thanks,

-- 
Peter Xu

