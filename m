Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B364B6E6E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjDRVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjDRVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:49:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E5172BD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:49:10 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-555bc7f6746so31948267b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681854550; x=1684446550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0caMjMTNLRVb5B71eXz6SyruGYjt/PXLO1p8S+PAzs=;
        b=lLRKUZZZhn34mOqNMLyVuFoJZ6lFIAcY+3oo1CyOrqxeXEcmFwKLCG1F4PljZO+SLH
         V7YeO3yghhuvAeYqGOBVUuRo6UGaFVC9XmCBJVbUNKtN5YOodZDrvhrsLZVo9Wg2iAqF
         NXzYskI9jVVCWy4Xo6b0JMwvMSGmRsVJn1QPcyG+utXSpiYBdFv2W8YOzGFFzeh/Ve1O
         w/mWhL8LqpFPkO13297rcnoB6sl2saU7Jb8kFDx+c1e3OeFNhZV6L5iA3H/tdMMsovJc
         OsvQBa9joGiBsCAXzpByOrJtC7suudMpbmyLnP7dOa++H3xh7UY+LI1tU7/3vfmfmgsJ
         cyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854550; x=1684446550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0caMjMTNLRVb5B71eXz6SyruGYjt/PXLO1p8S+PAzs=;
        b=b4EqiFrujEfvPSEtK2jGBmzio5OhtQswzCnjWBNV9OdI72BgeeR3L2E7N+Hosf0Uty
         h8NI7LLO15amFtq21I7A2uXZGxYzx7/ECHNlVfgPXAhnd1dyHbCUWhYxqU7JazqZF4yc
         MiMsiO9cNpUIJN9jeU3Dfhv0/z0FGCWhcGxBOJY10fo/6tQ9iuXyE0fi8lWoGuK4WRlx
         ZbgL3edxKG0CKf+oNG1I2lMzsvqr88NidLPOHGTh5d9LpNL1zMRsEeSnGnOYlExIeOmS
         WB04BQCP9l5kPTQkyV50KjpuPZdvIukOQ2mQ+qtddZKlYvzcER9Nt1IZVxJNKAqiS/F5
         OOoA==
X-Gm-Message-State: AAQBX9dhB9mdJkNiVZvDFO5LG8rq0MOYHaDADcOiJvImyvgo6XD7awou
        /9Xb3RAA2aaIXTv9/kLEL88RL6aBHH0TijM0E/UhoQ==
X-Google-Smtp-Source: AKy350Ybh3tGHfTHDnFslZANDLtloOBdFnmuSlARp0u119p4ENg3icAyy36YW5AFQ5BgcwSthM4EIFaHI/0IhQJylfI=
X-Received: by 2002:a81:650a:0:b0:533:8eac:77c8 with SMTP id
 z10-20020a81650a000000b005338eac77c8mr1512446ywb.2.1681854549772; Tue, 18 Apr
 2023 14:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org> <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org> <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org> <ZD6/805XpvfZde0Y@x1n> <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
In-Reply-To: <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Apr 2023 14:48:58 -0700
Message-ID: <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Apr 18, 2023 at 9:06=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Tue, Apr 18, 2023 at 04:08:58PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Apr 18, 2023 at 7:25=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > > > > >     /*
> > > > > > > > > -    * We don't do accounting for some specific faults:
> > > > > > > > > -    *
> > > > > > > > > -    * - Unsuccessful faults (e.g. when the address wasn'=
t valid).  That
> > > > > > > > > -    *   includes arch_vma_access_permitted() failing bef=
ore reaching here.
> > > > > > > > > -    *   So this is not a "this many hardware page faults=
" counter.  We
> > > > > > > > > -    *   should use the hw profiling for that.
> > > > > > > > > -    *
> > > > > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will o=
nly be counted
> > > > > > > > > -    *   once they're completed.
> > > > > > > > > +    * Do not account for incomplete faults (VM_FAULT_RET=
RY). They will be
> > > > > > > > > +    * counted upon completion.
> > > > > > > > >      */
> > > > > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > > > > +           return;
> > > > > > > > > +
> > > > > > > > > +   /* Register both successful and failed faults in PGFA=
ULT counters. */
> > > > > > > > > +   count_vm_event(PGFAULT);
> > > > > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > > > > >
> > > > > > > > Is there reason on why vm events accountings need to be exp=
licitly
> > > > > > > > different from perf events right below on handling ERROR?
> > > > > > >
> > > > > > > I think so.  ERROR is quite different from RETRY.  If we are,=
 for
> > > > > > > example, handling a SIGSEGV (perhaps a GC language?) that sho=
uld be
> > > > > > > accounted.  If we can't handle a page fault right now, and ne=
ed to
> > > > > > > retry within the kernel, that should not be accounted.
> > > > > >
> > > > > > IIUC, the question was about the differences in vm vs perf acco=
unting
> > > > > > for errors, not the difference between ERROR and RETRY cases. M=
atthew,
> > > > > > are you answering the right question or did I misunderstand you=
r
> > > > > > answer?
> > > > >
> > > > > Maybe I'm misunderstanding what you're proposing.  I thought the
> > > > > proposal was to make neither ERROR nor RETRY increment the counte=
rs,
> > > > > but if the proposal is to make ERROR increment the perf counters
> > > > > instead, then that's cool with me.
> > > >
> > > > Oh, I think now I understand your answer. You were not highlighting
> > > > the difference between the who but objecting to the proposal of not
> > > > counting both ERROR and RETRY. Am I on the same page now?
> > >
> > > I think so.  Let's see your patch and then we can be sure we're talki=
ng
> > > about the same thing ;-)
> >
> > IMHO if there's no explicit reason to differenciate the events, we shou=
ld
> > always account them the same way for vm,perf,... either with ERROR
> > accounted or not.
> >
> > I am not sure whether accounting ERROR faults would matter for a mprote=
ct()
> > use case, because they shouldn't rely on the counter to work but the SI=
GBUS
> > itself to be generated on page accesses with the sighandler doing work.
>
> For that example with GC, these are valid page faults IIUC and current
> PGFAULT counters do register them. Do we want to change that and
> potentially break assumptions about these counters?
>
> >
> > One trivial benefit of keep accounting ERROR is we only need to modify =
vm
> > account ABI so both RETRY & ERROR will be adjusted to match perf,task
> > counters.  OTOH we can also change all to take ERROR into account, but =
then
> > we're modifying ABI for all counters.
>
> So, not accounting them in both vm and perf would be problematic for
> that GC example and similar cases.
> Are we left with only two viable options?:
> 1. skip RETRY for vm and skip ERROR for both vm and perf (this patch)
> 2. skip RETRY for both vm and perf, account ERROR for both
>
> #2 would go against the comment in mm_account_fault() saying that we
> don't account for unsuccessful faults. I guess there must have been
> some reason we were not accounting for them (such as access to a
> faulty address is neither major nor minor fault)?

I did some digging in the history and looks like the check for ERROR
was added after this discussion:
https://lore.kernel.org/all/20200624203412.GB64004@xz-x1/ and IIUC the
reason was that previous code also skipped VM_FAULT_ERROR. Peter, is
that correct?

It seems this discussion is becoming longer than it should be. How
about we keep the behavior of all counters as they are to avoid
breaking any possible usecases and just fix the double-counting issue
for RETRY cases?

>
> >
> > --
> > Peter Xu
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
