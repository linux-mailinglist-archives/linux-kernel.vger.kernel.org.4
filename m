Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328DB6E6AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjDRRRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjDRRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:17:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747EA26B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:17:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f7a7f9667bso1677153f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681838267; x=1684430267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi2l1IFP5mrz8GQJ7hLf0B4pdQ6HkkMS+3cH5HJ4cAI=;
        b=ajCU/xzhoS4z16YqqHR/ZNLIcpmqGdDt1Pe16Ah9zpCuOEkjMd/25w7dCfjCg3+c3Z
         bh8dNPADdxDNGjqSyO0e0AOclZ/QY/birlElvua4pVKaPNxjBWO/JgFeJF8FYtYEowTg
         ly3DYfXXF6kZUZ2pmBgl4ikTYkzhzkFS82+MUloioFOF6+aLh1ALx/mq1ySMVXSf2jXO
         6ywfH9fthxppwF+JOcXFci96w74/cKGHRFkaoGXGE1b+d2CnwEPmPpWouDGaexdXmoKa
         7XKETqjqI6Tb8dHZE3ANo+GyCD7lVpSDvuxp6ZyO+N0ISNgt1QB/ddq9e6zeK66tCVoy
         7bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838267; x=1684430267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi2l1IFP5mrz8GQJ7hLf0B4pdQ6HkkMS+3cH5HJ4cAI=;
        b=ihHpG1OB3ho18ZITkU+x1ewdvsOy569jssYpIFwjLkocY1nxHZ35Ld5UPKHHFSe4pw
         7zJ6gZuusOC9u7iv+Pa5RYHf2hPF1NG6+qzE0+YlZ9ftbv8BMSqMZWhVTS1dKyzXzfvm
         GXuA+gitldkihr+HYmWgQs0b9WqmYNYpTPJVoco1Sjyo59BpK0h9EdanJ4yOQD7tds5g
         htxXESAYUl2xyVu2tYaX7ZedW9/D6neSm64w3SoGwiXjgychvdrU63pLu2Mwrevxd3I9
         4CFf3ZHfyhM0DDGuW5TupYhk5CfVQDwNhAFNx0xb8tBYSjRlqKpPGYTwdut/5qLcclHZ
         c80A==
X-Gm-Message-State: AAQBX9e7/1hehHO3S2T+9qr7Xvm+GmXqgiQjdya9Xkg+xOGwD0xOgzDY
        XYA7mUoezDSetHId+t1+8Ay8laKFAC/bPKy4HV70tQ==
X-Google-Smtp-Source: AKy350bpC+2179a4iS4QE7SJGekbc1AdMviwe2WIOYBXhv0y8rJVWkdMfujaLS44ciSAoFq0VDfFKsuoIzyfXk1FO8w=
X-Received: by 2002:a5d:4ecd:0:b0:2f5:8e8b:572c with SMTP id
 s13-20020a5d4ecd000000b002f58e8b572cmr2457342wrv.49.1681838267464; Tue, 18
 Apr 2023 10:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org> <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org> <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org> <ZD6/805XpvfZde0Y@x1n>
In-Reply-To: <ZD6/805XpvfZde0Y@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Apr 2023 10:17:35 -0700
Message-ID: <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 9:06=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 18, 2023 at 04:08:58PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Apr 18, 2023 at 7:25=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > > > >     /*
> > > > > > > > -    * We don't do accounting for some specific faults:
> > > > > > > > -    *
> > > > > > > > -    * - Unsuccessful faults (e.g. when the address wasn't =
valid).  That
> > > > > > > > -    *   includes arch_vma_access_permitted() failing befor=
e reaching here.
> > > > > > > > -    *   So this is not a "this many hardware page faults" =
counter.  We
> > > > > > > > -    *   should use the hw profiling for that.
> > > > > > > > -    *
> > > > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will onl=
y be counted
> > > > > > > > -    *   once they're completed.
> > > > > > > > +    * Do not account for incomplete faults (VM_FAULT_RETRY=
). They will be
> > > > > > > > +    * counted upon completion.
> > > > > > > >      */
> > > > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > > > +           return;
> > > > > > > > +
> > > > > > > > +   /* Register both successful and failed faults in PGFAUL=
T counters. */
> > > > > > > > +   count_vm_event(PGFAULT);
> > > > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > > > >
> > > > > > > Is there reason on why vm events accountings need to be expli=
citly
> > > > > > > different from perf events right below on handling ERROR?
> > > > > >
> > > > > > I think so.  ERROR is quite different from RETRY.  If we are, f=
or
> > > > > > example, handling a SIGSEGV (perhaps a GC language?) that shoul=
d be
> > > > > > accounted.  If we can't handle a page fault right now, and need=
 to
> > > > > > retry within the kernel, that should not be accounted.
> > > > >
> > > > > IIUC, the question was about the differences in vm vs perf accoun=
ting
> > > > > for errors, not the difference between ERROR and RETRY cases. Mat=
thew,
> > > > > are you answering the right question or did I misunderstand your
> > > > > answer?
> > > >
> > > > Maybe I'm misunderstanding what you're proposing.  I thought the
> > > > proposal was to make neither ERROR nor RETRY increment the counters=
,
> > > > but if the proposal is to make ERROR increment the perf counters
> > > > instead, then that's cool with me.
> > >
> > > Oh, I think now I understand your answer. You were not highlighting
> > > the difference between the who but objecting to the proposal of not
> > > counting both ERROR and RETRY. Am I on the same page now?
> >
> > I think so.  Let's see your patch and then we can be sure we're talking
> > about the same thing ;-)
>
> IMHO if there's no explicit reason to differenciate the events, we should
> always account them the same way for vm,perf,... either with ERROR
> accounted or not.
>
> I am not sure whether accounting ERROR faults would matter for a mprotect=
()
> use case, because they shouldn't rely on the counter to work but the SIGB=
US
> itself to be generated on page accesses with the sighandler doing work.

For that example with GC, these are valid page faults IIUC and current
PGFAULT counters do register them. Do we want to change that and
potentially break assumptions about these counters?

>
> One trivial benefit of keep accounting ERROR is we only need to modify vm
> account ABI so both RETRY & ERROR will be adjusted to match perf,task
> counters.  OTOH we can also change all to take ERROR into account, but th=
en
> we're modifying ABI for all counters.

So, not accounting them in both vm and perf would be problematic for
that GC example and similar cases.
Are we left with only two viable options?:
1. skip RETRY for vm and skip ERROR for both vm and perf (this patch)
2. skip RETRY for both vm and perf, account ERROR for both

#2 would go against the comment in mm_account_fault() saying that we
don't account for unsuccessful faults. I guess there must have been
some reason we were not accounting for them (such as access to a
faulty address is neither major nor minor fault)?

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
