Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DAD6E6796
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDROys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDROyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:54:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1413C2A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:54:15 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u13so29515190ybu.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681829653; x=1684421653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfhwMvTdF+nxW4QIbzDKMW7E7O/7EuCgSfJoT4ktJKk=;
        b=V6daXsKy1PWZRcniSnjOMJGA+yng2Oy491YMI3OFPQGoQBhf81M+e6ihsqqDWd1xxv
         l3PU44fgRj6U8tOVtSQ8riMlwu1AHyEI3QvtZOiDSRERUbIJZgBuPobs5NqywDwEeTk7
         8O1x9yAlV0Ng3D7bY0KuYrTW7faDUJAOGBpJpsvsXl580kGvh7aH7dTZ3iVpswpSfrlJ
         A3E/u4sSyT6IAdHEsP7Y07TgbPMz2CAzZ0PQiDYF0CTY1JqVU5FvlGlE6TSmcP+eg3vD
         /VcOle5QjG2sGkhO274MhCCDuxIqPA5R9u/iqZ29wfIrdGpce0AKdXoFQ6EnWP7/4cLg
         AKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829653; x=1684421653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfhwMvTdF+nxW4QIbzDKMW7E7O/7EuCgSfJoT4ktJKk=;
        b=Sre1yFzVb4aNpceKdRiQrIDyE1ulB5eysCm0Dg+NxMfX+HxDEv23gGUstgs+RIufAt
         hqd81n12PjH5Bl6Xb3bnVlkn/O6bISY/0Wi2PZulplkzAXbeC97pFKTwRFE1ezuKBxxs
         2s/AaTwxEbso4V/f+rIWMkEOpxYKU2UxwC92KvFPH4nuhIMk8TofN18b/VaBUDju0fj7
         tCeyKOQZ5aEfVX/T8ISlnsBxuXCqjl4B/k7APeyDWoiFy67Mkuh0JVtFE+kSIohwtfxa
         EbuNVND9QqqI+W1px6kZqZgIOgQIBhdiESCejxOrfOSRpPx/DX9YhZcqzfOHOiyNLGK5
         B0ZA==
X-Gm-Message-State: AAQBX9eJNpvf1R2vG6lEuRlrO+jZ5icQAY0bzllvnW62vd6dMjy0RQ3H
        Ii4+OEWyBnH0IZpHFWjtlc7Fqp88B46HbDbmSxeCMA==
X-Google-Smtp-Source: AKy350ZgLB/WBc8GOyEDUDumrOQ+KvSYZQqa6oa0isslarGW+peOSaafPqoy5z25OTE2YBDofEZ/JnufNH0SWm/ucyE=
X-Received: by 2002:a25:d2d2:0:b0:b95:518b:4921 with SMTP id
 j201-20020a25d2d2000000b00b95518b4921mr1400083ybg.12.1681829652615; Tue, 18
 Apr 2023 07:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org> <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org>
In-Reply-To: <ZD6oVgIi/yY1+t1L@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Apr 2023 07:54:01 -0700
Message-ID: <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
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

On Tue, Apr 18, 2023 at 7:25=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > >     /*
> > > > > -    * We don't do accounting for some specific faults:
> > > > > -    *
> > > > > -    * - Unsuccessful faults (e.g. when the address wasn't valid)=
.  That
> > > > > -    *   includes arch_vma_access_permitted() failing before reac=
hing here.
> > > > > -    *   So this is not a "this many hardware page faults" counte=
r.  We
> > > > > -    *   should use the hw profiling for that.
> > > > > -    *
> > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will only be c=
ounted
> > > > > -    *   once they're completed.
> > > > > +    * Do not account for incomplete faults (VM_FAULT_RETRY). The=
y will be
> > > > > +    * counted upon completion.
> > > > >      */
> > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > +           return;
> > > > > +
> > > > > +   /* Register both successful and failed faults in PGFAULT coun=
ters. */
> > > > > +   count_vm_event(PGFAULT);
> > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > >
> > > > Is there reason on why vm events accountings need to be explicitly
> > > > different from perf events right below on handling ERROR?
> > >
> > > I think so.  ERROR is quite different from RETRY.  If we are, for
> > > example, handling a SIGSEGV (perhaps a GC language?) that should be
> > > accounted.  If we can't handle a page fault right now, and need to
> > > retry within the kernel, that should not be accounted.
> >
> > IIUC, the question was about the differences in vm vs perf accounting
> > for errors, not the difference between ERROR and RETRY cases. Matthew,
> > are you answering the right question or did I misunderstand your
> > answer?
>
> Maybe I'm misunderstanding what you're proposing.  I thought the
> proposal was to make neither ERROR nor RETRY increment the counters,
> but if the proposal is to make ERROR increment the perf counters
> instead, then that's cool with me.

Oh, I think now I understand your answer. You were not highlighting
the difference between the who but objecting to the proposal of not
counting both ERROR and RETRY. Am I on the same page now?
